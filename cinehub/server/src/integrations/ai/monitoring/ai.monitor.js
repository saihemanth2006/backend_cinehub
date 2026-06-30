/**
 * @module integrations/ai/monitoring/ai.monitor
 * @description AI Logging, Monitoring, and Analytics — tracks every AI interaction
 * for observability, cost tracking, performance analysis, and debugging.
 *
 * Monitors:
 * - Request/response latency per provider and template
 * - Token usage and estimated cost
 * - Error rates and types
 * - Cache hit rates
 * - Provider health status
 * - Per-user usage quotas
 */
const { logger } = require('../../../config');

/** Approximate cost per 1K tokens (USD) — update as pricing changes */
const TOKEN_COSTS = {
  'gpt-4-turbo': { input: 0.01, output: 0.03 },
  'gpt-4o': { input: 0.005, output: 0.015 },
  'gpt-4o-mini': { input: 0.00015, output: 0.0006 },
  'gemini-1.5-pro': { input: 0.00125, output: 0.005 },
  'gemini-1.5-flash': { input: 0.000075, output: 0.0003 },
  default: { input: 0.005, output: 0.015 },
};

class AIMonitor {
  constructor() {
    /** @type {Array<Object>} In-memory log buffer (flushed periodically in production) */
    this._logs = [];

    /** Aggregated stats */
    this._stats = {
      totalRequests: 0,
      totalTokens: 0,
      totalCost: 0,
      totalLatencyMs: 0,
      errors: 0,
      cacheHits: 0,
      cacheMisses: 0,
      byProvider: {},
      byTemplate: {},
      byUser: {},
    };

    /** Max in-memory log entries before rotation */
    this._maxLogEntries = 10000;
  }

  /**
   * Logs an AI request/response cycle.
   * @param {Object} entry
   * @param {string} entry.requestId - Correlation ID
   * @param {string} entry.userId - Requesting user
   * @param {string} entry.templateId - Prompt template used
   * @param {string} entry.provider - AI provider used
   * @param {string} entry.model - Model used
   * @param {number} entry.promptTokens - Input tokens
   * @param {number} entry.completionTokens - Output tokens
   * @param {number} entry.totalTokens - Total tokens
   * @param {number} entry.latencyMs - Response time in ms
   * @param {boolean} entry.cached - Whether response was from cache
   * @param {boolean} entry.success - Whether request succeeded
   * @param {string} [entry.error] - Error message if failed
   * @param {string} [entry.errorCode] - Error code if failed
   * @param {Object} [entry.metadata] - Additional metadata
   */
  log(entry) {
    const record = {
      ...entry,
      timestamp: new Date().toISOString(),
      cost: this._estimateCost(entry.model, entry.promptTokens, entry.completionTokens),
    };

    // Store in buffer
    this._logs.push(record);
    if (this._logs.length > this._maxLogEntries) {
      this._logs = this._logs.slice(-this._maxLogEntries / 2);
    }

    // Update aggregated stats
    this._updateStats(record);

    // Structured logging
    const logLevel = entry.success ? 'info' : 'error';
    logger[logLevel](`[AI Monitor] ${entry.templateId} via ${entry.provider}/${entry.model}`, {
      requestId: entry.requestId,
      userId: entry.userId,
      tokens: entry.totalTokens,
      latencyMs: entry.latencyMs,
      cached: entry.cached,
      cost: record.cost,
      ...(entry.error && { error: entry.error }),
    });
  }

  /**
   * Records a cache event.
   * @param {'hit'|'miss'} type
   * @param {string} templateId
   */
  logCacheEvent(type, templateId) {
    if (type === 'hit') {
      this._stats.cacheHits++;
    } else {
      this._stats.cacheMisses++;
    }
  }

  // ── Stats & Reporting ─────────────────────────────────

  /**
   * Returns comprehensive AI usage statistics.
   * @returns {Object}
   */
  getStats() {
    const cacheTotal = this._stats.cacheHits + this._stats.cacheMisses;
    return {
      ...this._stats,
      averageLatencyMs: this._stats.totalRequests > 0
        ? Math.round(this._stats.totalLatencyMs / this._stats.totalRequests)
        : 0,
      errorRate: this._stats.totalRequests > 0
        ? ((this._stats.errors / this._stats.totalRequests) * 100).toFixed(1) + '%'
        : '0%',
      cacheHitRate: cacheTotal > 0
        ? ((this._stats.cacheHits / cacheTotal) * 100).toFixed(1) + '%'
        : '0%',
    };
  }

  /**
   * Returns usage stats for a specific user.
   * @param {string} userId
   * @returns {Object}
   */
  getUserStats(userId) {
    return this._stats.byUser[userId] || {
      requests: 0,
      tokens: 0,
      cost: 0,
    };
  }

  /**
   * Returns recent AI interaction logs.
   * @param {Object} filters
   * @param {string} [filters.userId]
   * @param {string} [filters.templateId]
   * @param {string} [filters.provider]
   * @param {boolean} [filters.errorsOnly]
   * @param {number} [filters.limit=50]
   * @returns {Object[]}
   */
  getRecentLogs(filters = {}) {
    let logs = [...this._logs];

    if (filters.userId) logs = logs.filter((l) => l.userId === filters.userId);
    if (filters.templateId) logs = logs.filter((l) => l.templateId === filters.templateId);
    if (filters.provider) logs = logs.filter((l) => l.provider === filters.provider);
    if (filters.errorsOnly) logs = logs.filter((l) => !l.success);

    return logs.slice(-(filters.limit || 50)).reverse();
  }

  /**
   * Returns a dashboard-friendly summary.
   * @returns {Object}
   */
  getDashboard() {
    const stats = this.getStats();
    return {
      overview: {
        totalRequests: stats.totalRequests,
        totalTokens: stats.totalTokens,
        totalCost: `$${stats.totalCost.toFixed(4)}`,
        averageLatency: `${stats.averageLatencyMs}ms`,
        errorRate: stats.errorRate,
        cacheHitRate: stats.cacheHitRate,
      },
      providers: stats.byProvider,
      templates: stats.byTemplate,
      recentErrors: this.getRecentLogs({ errorsOnly: true, limit: 10 }),
    };
  }

  // ── Internal ──────────────────────────────────────────

  _updateStats(record) {
    this._stats.totalRequests++;
    this._stats.totalTokens += record.totalTokens || 0;
    this._stats.totalCost += record.cost || 0;
    this._stats.totalLatencyMs += record.latencyMs || 0;

    if (!record.success) this._stats.errors++;

    // By provider
    if (!this._stats.byProvider[record.provider]) {
      this._stats.byProvider[record.provider] = { requests: 0, tokens: 0, cost: 0, errors: 0 };
    }
    const provStats = this._stats.byProvider[record.provider];
    provStats.requests++;
    provStats.tokens += record.totalTokens || 0;
    provStats.cost += record.cost || 0;
    if (!record.success) provStats.errors++;

    // By template
    if (!this._stats.byTemplate[record.templateId]) {
      this._stats.byTemplate[record.templateId] = { requests: 0, tokens: 0, avgLatencyMs: 0 };
    }
    const tplStats = this._stats.byTemplate[record.templateId];
    tplStats.requests++;
    tplStats.tokens += record.totalTokens || 0;
    tplStats.avgLatencyMs = Math.round(
      ((tplStats.avgLatencyMs * (tplStats.requests - 1)) + (record.latencyMs || 0)) / tplStats.requests,
    );

    // By user
    if (record.userId) {
      if (!this._stats.byUser[record.userId]) {
        this._stats.byUser[record.userId] = { requests: 0, tokens: 0, cost: 0 };
      }
      const userStats = this._stats.byUser[record.userId];
      userStats.requests++;
      userStats.tokens += record.totalTokens || 0;
      userStats.cost += record.cost || 0;
    }
  }

  _estimateCost(model, promptTokens = 0, completionTokens = 0) {
    const pricing = TOKEN_COSTS[model] || TOKEN_COSTS.default;
    return (promptTokens / 1000) * pricing.input + (completionTokens / 1000) * pricing.output;
  }

  /**
   * Resets all statistics (for testing).
   */
  reset() {
    this._logs = [];
    this._stats = {
      totalRequests: 0,
      totalTokens: 0,
      totalCost: 0,
      totalLatencyMs: 0,
      errors: 0,
      cacheHits: 0,
      cacheMisses: 0,
      byProvider: {},
      byTemplate: {},
      byUser: {},
    };
  }
}

// Singleton
module.exports = new AIMonitor();
