/**
 * @module integrations/ai/cache/ai.cache
 * @description AI Response Caching Layer — Redis-backed semantic cache for AI outputs.
 *
 * Caching Strategy:
 * 1. Cache Key = hash(templateId + variables + provider + model)
 * 2. TTL varies by content type (scripts: 24h, analysis: 12h, insights: 1h)
 * 3. Cache invalidation on related data changes
 * 4. LRU eviction handled by Redis memory policy
 *
 * ┌──────────────┐    ┌───────────────┐    ┌──────────────┐
 * │  AI Request   │───▶│  Cache Check  │───▶│  Cache Hit?  │
 * └──────────────┘    └───────────────┘    └──────┬───────┘
 *                                                 │
 *                              ┌──────────────────┤
 *                              │ Yes              │ No
 *                              ▼                  ▼
 *                    ┌──────────────┐    ┌──────────────┐
 *                    │  Return      │    │  Execute AI  │
 *                    │  Cached      │    │  → Store     │
 *                    └──────────────┘    └──────────────┘
 */
const crypto = require('crypto');
const { logger } = require('../../../config');

/** TTL per category in seconds */
const CACHE_TTL = {
  script: 86400,         // 24 hours — generated scripts rarely re-requested with same params
  analysis: 43200,       // 12 hours — genre/story analysis
  production: 21600,     // 6 hours — budget estimates, talent recs
  recommendation: 3600,  // 1 hour — recommendations should stay fresh
  insights: 1800,        // 30 minutes — project insights change frequently
  assistant: 0,          // No caching — conversational responses are unique
  default: 7200,         // 2 hours — fallback
};

class AICache {
  /**
   * @param {import('ioredis')} redisClient
   */
  constructor(redisClient) {
    this.redis = redisClient;
    this.prefix = 'ai:cache:';
    this.statsPrefix = 'ai:cache:stats:';
    this._hits = 0;
    this._misses = 0;
  }

  /**
   * Generates a deterministic cache key from request parameters.
   * @param {Object} params
   * @param {string} params.templateId
   * @param {Object} params.variables
   * @param {string} [params.provider]
   * @param {string} [params.model]
   * @returns {string}
   */
  generateKey({ templateId, variables, provider, model }) {
    const payload = JSON.stringify({
      t: templateId,
      v: variables,
      p: provider || 'default',
      m: model || 'default',
    });
    const hash = crypto.createHash('sha256').update(payload).digest('hex').substring(0, 16);
    return `${this.prefix}${templateId}:${hash}`;
  }

  /**
   * Gets a cached AI response.
   * @param {string} key
   * @returns {Promise<Object|null>}
   */
  async get(key) {
    try {
      if (!this.redis) return null;

      const cached = await this.redis.get(key);
      if (cached) {
        this._hits++;
        const data = JSON.parse(cached);
        logger.debug(`[AI Cache] HIT: ${key}`);
        return { ...data, _cached: true, _cachedAt: data._cachedAt };
      }

      this._misses++;
      logger.debug(`[AI Cache] MISS: ${key}`);
      return null;
    } catch (err) {
      logger.error(`[AI Cache] Get error: ${err.message}`);
      return null;
    }
  }

  /**
   * Stores an AI response in cache.
   * @param {string} key
   * @param {Object} data - AI response data
   * @param {string} [category] - Template category for TTL selection
   * @param {number} [customTtl] - Override TTL in seconds
   * @returns {Promise<void>}
   */
  async set(key, data, category = 'default', customTtl) {
    try {
      if (!this.redis) return;

      const ttl = customTtl || CACHE_TTL[category] || CACHE_TTL.default;
      if (ttl === 0) return; // No caching for this category

      const payload = JSON.stringify({
        ...data,
        _cachedAt: new Date().toISOString(),
        _category: category,
      });

      await this.redis.setex(key, ttl, payload);
      logger.debug(`[AI Cache] SET: ${key} (TTL: ${ttl}s)`);
    } catch (err) {
      logger.error(`[AI Cache] Set error: ${err.message}`);
    }
  }

  /**
   * Invalidates a specific cache entry.
   * @param {string} key
   * @returns {Promise<void>}
   */
  async invalidate(key) {
    try {
      if (!this.redis) return;
      await this.redis.del(key);
      logger.debug(`[AI Cache] INVALIDATED: ${key}`);
    } catch (err) {
      logger.error(`[AI Cache] Invalidate error: ${err.message}`);
    }
  }

  /**
   * Invalidates all cache entries for a template.
   * @param {string} templateId
   * @returns {Promise<number>} Number of keys deleted
   */
  async invalidateByTemplate(templateId) {
    try {
      if (!this.redis) return 0;

      const pattern = `${this.prefix}${templateId}:*`;
      const keys = await this.redis.keys(pattern);
      if (keys.length === 0) return 0;

      const deleted = await this.redis.del(...keys);
      logger.info(`[AI Cache] Invalidated ${deleted} entries for template: ${templateId}`);
      return deleted;
    } catch (err) {
      logger.error(`[AI Cache] Bulk invalidate error: ${err.message}`);
      return 0;
    }
  }

  /**
   * Clears the entire AI cache.
   * @returns {Promise<number>}
   */
  async flush() {
    try {
      if (!this.redis) return 0;

      const keys = await this.redis.keys(`${this.prefix}*`);
      if (keys.length === 0) return 0;

      const deleted = await this.redis.del(...keys);
      logger.info(`[AI Cache] Flushed ${deleted} cache entries`);
      return deleted;
    } catch (err) {
      logger.error(`[AI Cache] Flush error: ${err.message}`);
      return 0;
    }
  }

  /**
   * Returns cache performance statistics.
   * @returns {{ hits: number, misses: number, hitRate: number }}
   */
  getStats() {
    const total = this._hits + this._misses;
    return {
      hits: this._hits,
      misses: this._misses,
      total,
      hitRate: total > 0 ? (this._hits / total * 100).toFixed(1) + '%' : '0%',
    };
  }
}

module.exports = { AICache, CACHE_TTL };
