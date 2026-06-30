/**
 * @module integrations/ai/orchestrator/ai.orchestrator
 * @description AI Orchestrator — the central brain of the CineHub AI system.
 *
 * This is the single entry point for ALL AI operations. It coordinates:
 * - Prompt compilation via PromptEngine
 * - Cache lookup/storage via AICache
 * - Provider selection via AIGateway
 * - Output validation via AIValidator
 * - Monitoring via AIMonitor
 * - Async processing via AIQueue
 *
 * Architecture:
 * ┌─────────────────────────────────────────────────────────────────┐
 * │                     AI ORCHESTRATOR                             │
 * │                                                                 │
 * │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────────┐  │
 * │  │  Prompt   │  │  Cache   │  │  Gateway │  │  Validation  │  │
 * │  │  Engine   │  │  Layer   │  │  (LLMs)  │  │  Layer       │  │
 * │  └────┬─────┘  └────┬─────┘  └────┬─────┘  └─────┬────────┘  │
 * │       │              │             │               │           │
 * │       └──────────────┴──────┬──────┴───────────────┘           │
 * │                             │                                   │
 * │                     ┌───────▼───────┐                          │
 * │                     │   Pipeline    │                          │
 * │                     │   Executor    │                          │
 * │                     └───────┬───────┘                          │
 * │                             │                                   │
 * │  ┌──────────┐  ┌───────────▼───────────┐  ┌──────────────┐   │
 * │  │  Queue   │  │    Monitor / Logger   │  │  Rate        │   │
 * │  │  (async) │  │    (observability)    │  │  Limiter     │   │
 * │  └──────────┘  └──────────────────────┘  └──────────────┘   │
 * └─────────────────────────────────────────────────────────────────┘
 *
 * Execution Flow:
 * 1. Receive request with templateId + variables
 * 2. Check user rate limits / quotas
 * 3. Compile prompt from template registry
 * 4. Check cache for identical request
 * 5. If cache miss → route to AI provider via gateway
 * 6. Validate AI response against schema
 * 7. Store in cache (if cacheable)
 * 8. Log to monitor
 * 9. Return formatted response
 */
const { logger } = require('../../../config');
const aiGateway = require('../ai.gateway');
const promptEngine = require('../prompts/prompt.engine');
const { AIValidator } = require('../validation/ai.validator');
const aiMonitor = require('../monitoring/ai.monitor');
const { AICache } = require('../cache/ai.cache');
const { AIQueue } = require('../queue/ai.queue');
const ApiError = require('../../../utils/ApiError');

class AIOrchestrator {
  /**
   * @param {Object} options
   * @param {import('ioredis')} [options.redisClient] - Redis client for caching and queueing
   */
  constructor(options = {}) {
    this.gateway = aiGateway;
    this.promptEngine = promptEngine;
    this.validator = AIValidator;
    this.monitor = aiMonitor;

    // Initialize cache if Redis available
    this.cache = options.redisClient
      ? new AICache(options.redisClient)
      : new AICache(null);

    // Initialize queue if Redis available
    this.queue = new AIQueue(options.redisClient);

    // Per-user request tracking for rate limiting
    this._userRequestCounts = new Map();
    this._userRequestWindow = 3600000; // 1 hour window
    this._maxRequestsPerUser = 50;
  }

  // ── Main Execution Methods ────────────────────────────

  /**
   * Executes an AI pipeline synchronously.
   * This is the primary method for all AI operations.
   *
   * @param {Object} params
   * @param {string} params.templateId - Registered template ID
   * @param {Object} params.variables - Template variables
   * @param {string} params.userId - Requesting user ID
   * @param {string} [params.requestId] - Correlation ID for tracing
   * @param {string} [params.provider] - Preferred AI provider override
   * @param {Object} [params.generationConfig] - Override generation parameters
   * @param {Object} [params.context] - Additional context (user, project data)
   * @param {boolean} [params.skipCache=false] - Force bypass cache
   * @param {boolean} [params.skipValidation=false] - Skip output validation
   * @returns {Promise<Object>} Validated, formatted AI response
   */
  async execute(params) {
    const {
      templateId,
      variables,
      userId,
      requestId,
      provider,
      generationConfig,
      context,
      skipCache = false,
      skipValidation = false,
    } = params;

    const startTime = Date.now();

    try {
      // Step 1: Rate limit check
      this._checkUserQuota(userId);

      // Step 2: Compile prompt from template
      const compiled = this.promptEngine.compile(templateId, variables, context);

      // Step 3: Check cache
      if (!skipCache) {
        const cacheKey = this.cache.generateKey({ templateId, variables, provider });
        const cached = await this.cache.get(cacheKey);

        if (cached) {
          this.monitor.logCacheEvent('hit', templateId);
          this.monitor.log({
            requestId,
            userId,
            templateId,
            provider: cached.providerUsed || 'cache',
            model: cached.model || 'cached',
            promptTokens: 0,
            completionTokens: 0,
            totalTokens: 0,
            latencyMs: Date.now() - startTime,
            cached: true,
            success: true,
          });

          return this._formatResponse(cached, { templateId, cached: true, startTime });
        }
        this.monitor.logCacheEvent('miss', templateId);
      }

      // Step 4: Execute AI generation via gateway
      const mergedConfig = { ...compiled.generationConfig, ...generationConfig };
      const result = await this.gateway.generateStructuredWithFallback(
        compiled.systemPrompt,
        compiled.userPrompt,
        {
          ...mergedConfig,
          provider,
        },
      );

      // Step 5: Validate output
      let validatedData = result.data;
      let validationWarnings = [];

      if (!skipValidation) {
        const validation = this.validator.validate(templateId, result.data);
        if (!validation.valid) {
          logger.warn(`[AI Orchestrator] Validation failed for ${templateId}`, {
            errors: validation.errors,
          });

          // Retry once with explicit instruction to fix formatting
          const retryResult = await this._retryWithValidationHints(
            compiled,
            mergedConfig,
            provider,
            validation.errors,
          );

          if (retryResult) {
            validatedData = retryResult.data;
            validationWarnings = ['Response required validation retry'];
          } else {
            // Use raw data with warning — better than failing entirely
            validatedData = result.data;
            validationWarnings = [`Validation failed: ${validation.errors.join('; ')}`];
          }
        } else {
          validatedData = validation.data;
          validationWarnings = validation.warnings;
        }
      }

      // Step 6: Store in cache
      if (!skipCache) {
        const template = this.promptEngine.getTemplate(templateId);
        const cacheKey = this.cache.generateKey({ templateId, variables, provider });
        await this.cache.set(
          cacheKey,
          { data: validatedData, ...result, providerUsed: result.providerUsed },
          template?.category || 'default',
        );
      }

      // Step 7: Log to monitor
      this.monitor.log({
        requestId,
        userId,
        templateId,
        provider: result.providerUsed,
        model: result.model,
        promptTokens: result.promptTokens || 0,
        completionTokens: result.completionTokens || 0,
        totalTokens: result.tokensUsed || 0,
        latencyMs: Date.now() - startTime,
        cached: false,
        success: true,
      });

      // Step 8: Track user usage
      this._recordUserRequest(userId);

      return this._formatResponse(
        { data: validatedData, ...result },
        { templateId, cached: false, startTime, validationWarnings },
      );
    } catch (err) {
      // Log error
      this.monitor.log({
        requestId,
        userId,
        templateId,
        provider: provider || 'unknown',
        model: 'unknown',
        promptTokens: 0,
        completionTokens: 0,
        totalTokens: 0,
        latencyMs: Date.now() - startTime,
        cached: false,
        success: false,
        error: err.message,
        errorCode: err.code,
      });

      // Re-throw operational errors; wrap unexpected ones
      if (err instanceof ApiError) throw err;
      throw ApiError.internal(
        `AI generation failed: ${err.message}`,
        'AI_ORCHESTRATION_ERROR',
      );
    }
  }

  /**
   * Executes an AI pipeline asynchronously via the job queue.
   * Returns immediately with a job ID; poll for results.
   *
   * @param {Object} params - Same as execute() params
   * @returns {Promise<{ jobId: string, status: string }>}
   */
  async executeAsync(params) {
    return this.queue.enqueue(params);
  }

  /**
   * Streams an AI response chunk-by-chunk.
   * For real-time UX (typewriter effect in the UI).
   *
   * @param {Object} params
   * @param {string} params.templateId
   * @param {Object} params.variables
   * @param {string} params.userId
   * @param {Function} params.onChunk - (chunk: string, done: boolean) => void
   * @param {Object} [params.context]
   * @param {string} [params.provider]
   * @returns {Promise<Object>}
   */
  async executeStream(params) {
    const { templateId, variables, userId, onChunk, context, provider } = params;
    const startTime = Date.now();

    this._checkUserQuota(userId);

    const compiled = this.promptEngine.compile(templateId, variables, context);

    const result = await this.gateway.streamWithFallback(
      `${compiled.systemPrompt}\n\n${compiled.userPrompt}`,
      { ...compiled.generationConfig, provider },
      onChunk,
    );

    this.monitor.log({
      requestId: params.requestId,
      userId,
      templateId,
      provider: result.providerUsed,
      model: result.model,
      promptTokens: 0,
      completionTokens: result.tokensUsed || 0,
      totalTokens: result.tokensUsed || 0,
      latencyMs: Date.now() - startTime,
      cached: false,
      success: true,
      metadata: { streaming: true },
    });

    this._recordUserRequest(userId);
    return result;
  }

  /**
   * Executes a raw (non-templated) AI completion.
   * For one-off or dynamic prompts that don't fit a template.
   *
   * @param {Object} params
   * @param {string} params.systemPrompt
   * @param {string} params.userPrompt
   * @param {string} params.userId
   * @param {Object} [params.options] - Generation options
   * @param {string} [params.provider]
   * @returns {Promise<Object>}
   */
  async executeRaw(params) {
    const { systemPrompt, userPrompt, userId, options, provider } = params;
    const startTime = Date.now();

    this._checkUserQuota(userId);

    const result = await this.gateway.generateStructuredWithFallback(
      systemPrompt,
      userPrompt,
      { ...options, provider },
    );

    this.monitor.log({
      requestId: params.requestId,
      userId,
      templateId: 'raw',
      provider: result.providerUsed,
      model: result.model,
      promptTokens: result.promptTokens || 0,
      completionTokens: result.completionTokens || 0,
      totalTokens: result.tokensUsed || 0,
      latencyMs: Date.now() - startTime,
      cached: false,
      success: true,
    });

    this._recordUserRequest(userId);
    return result;
  }

  // ── Queue Management ──────────────────────────────────

  /**
   * Initializes the async queue with the orchestrator as processor.
   */
  initializeQueue() {
    this.queue.initialize(async (jobData) => {
      return this.execute(jobData);
    });

    logger.info('[AI Orchestrator] Queue processor registered');
  }

  /**
   * Gets the status of an async AI job.
   * @param {string} jobId
   * @returns {Promise<Object>}
   */
  async getJobStatus(jobId) {
    return this.queue.getJobStatus(jobId);
  }

  // ── Observability ─────────────────────────────────────

  /**
   * Returns comprehensive system health and metrics.
   * @returns {Object}
   */
  getSystemHealth() {
    return {
      gateway: this.gateway.getHealthReport(),
      monitor: this.monitor.getStats(),
      cache: this.cache.getStats(),
      templates: this.promptEngine.listTemplates().map((t) => ({
        id: t.id,
        name: t.name,
        version: t.version,
        category: t.category,
      })),
    };
  }

  /**
   * Returns the AI dashboard data for frontend consumption.
   * @returns {Object}
   */
  getDashboard() {
    return this.monitor.getDashboard();
  }

  // ── Internal Methods ──────────────────────────────────

  /**
   * Retries a generation with explicit validation hints to fix output format.
   */
  async _retryWithValidationHints(compiled, config, provider, errors) {
    try {
      const fixPrompt = `${compiled.userPrompt}\n\nIMPORTANT: Your previous response had formatting issues: ${errors.join(', ')}. Please ensure your response is valid JSON with all required fields.`;

      const result = await this.gateway.generateStructuredWithFallback(
        compiled.systemPrompt,
        fixPrompt,
        { ...config, provider, temperature: Math.max(0.3, (config.temperature || 0.7) - 0.2) },
      );

      const validation = this.validator.validate(compiled.templateId, result.data);
      return validation.valid ? { data: validation.data, ...result } : null;
    } catch {
      return null;
    }
  }

  /**
   * Formats the final response envelope.
   */
  _formatResponse(result, meta) {
    return {
      data: result.data,
      meta: {
        templateId: meta.templateId,
        provider: result.providerUsed || 'unknown',
        model: result.model || 'unknown',
        tokensUsed: result.tokensUsed || 0,
        generationTimeMs: result.generationTimeMs || (Date.now() - meta.startTime),
        cached: meta.cached || false,
        ...(meta.validationWarnings?.length > 0 && { warnings: meta.validationWarnings }),
      },
    };
  }

  /**
   * Checks user-level rate quota.
   */
  _checkUserQuota(userId) {
    if (!userId) return;

    const key = `${userId}`;
    const now = Date.now();
    const record = this._userRequestCounts.get(key);

    if (record) {
      // Clean expired entries
      if (now - record.windowStart > this._userRequestWindow) {
        this._userRequestCounts.set(key, { count: 0, windowStart: now });
        return;
      }
      if (record.count >= this._maxRequestsPerUser) {
        throw ApiError.tooManyRequests(
          `AI request quota exceeded. Maximum ${this._maxRequestsPerUser} requests per hour.`,
          'AI_QUOTA_EXCEEDED',
        );
      }
    }
  }

  /**
   * Records a user request for quota tracking.
   */
  _recordUserRequest(userId) {
    if (!userId) return;

    const key = `${userId}`;
    const record = this._userRequestCounts.get(key);
    if (record) {
      record.count++;
    } else {
      this._userRequestCounts.set(key, { count: 1, windowStart: Date.now() });
    }
  }

  /**
   * Graceful shutdown of all AI subsystems.
   */
  async shutdown() {
    await this.queue.shutdown();
    logger.info('[AI Orchestrator] Shut down gracefully');
  }
}

module.exports = AIOrchestrator;
