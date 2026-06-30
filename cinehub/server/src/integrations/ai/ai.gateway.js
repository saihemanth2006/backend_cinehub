/**
 * @module integrations/ai/ai.gateway
 * @description AI Provider Gateway — the foundational abstraction layer for multi-model AI.
 *
 * Architecture:
 * ┌─────────────┐    ┌──────────────┐    ┌──────────────┐
 * │  AI Gateway  │───▶│  OpenAI      │───▶│  GPT-4       │
 * │  (singleton) │    │  Provider    │    │  GPT-4o      │
 * │              │    └──────────────┘    └──────────────┘
 * │  - fallback  │    ┌──────────────┐    ┌──────────────┐
 * │  - routing   │───▶│  Gemini      │───▶│  Gemini Pro  │
 * │  - health    │    │  Provider    │    │  Gemini Flash │
 * └─────────────┘    └──────────────┘    └──────────────┘
 *
 * Responsibilities:
 * - Provider instantiation & lifecycle management
 * - Smart routing with automatic fallback
 * - Health-check aware provider selection
 * - Usage aggregation & metrics
 * - Circuit-breaker pattern for degraded providers
 */
const { env, logger } = require('../../config');
const OpenAIProvider = require('./providers/openai.provider');
const GeminiProvider = require('./providers/gemini.provider');
const ApiError = require('../../utils/ApiError');

class AIGateway {
  constructor() {
    /** @type {Map<string, import('./providers/base.provider')>} */
    this.providers = new Map();

    /** Circuit breaker state per provider */
    this._circuitBreakers = new Map();

    this._initProviders();
  }

  // ── Initialization ────────────────────────────────────

  _initProviders() {
    if (env.ai.openai.apiKey) {
      this.providers.set('openai', new OpenAIProvider());
      this._circuitBreakers.set('openai', { failures: 0, lastFailure: null, state: 'closed' });
      logger.info('[AI Gateway] ✅ OpenAI provider initialized');
    }
    if (env.ai.gemini.apiKey) {
      this.providers.set('gemini', new GeminiProvider());
      this._circuitBreakers.set('gemini', { failures: 0, lastFailure: null, state: 'closed' });
      logger.info('[AI Gateway] ✅ Gemini provider initialized');
    }

    if (this.providers.size === 0) {
      logger.warn('[AI Gateway] ⚠️  No AI providers configured');
    }
  }

  // ── Provider Access ───────────────────────────────────

  /**
   * Returns the requested or default provider.
   * Respects circuit breaker state.
   * @param {string} [providerName] - 'openai' or 'gemini'
   * @returns {import('./providers/base.provider')}
   */
  getProvider(providerName) {
    const name = providerName || env.ai.defaultProvider;
    const provider = this.providers.get(name);

    if (!provider) {
      throw ApiError.serviceUnavailable(
        `AI provider '${name}' is not configured`,
        'AI_PROVIDER_UNAVAILABLE',
      );
    }

    // Check circuit breaker
    const breaker = this._circuitBreakers.get(name);
    if (breaker && breaker.state === 'open') {
      // Check if enough time has passed for half-open
      const cooldownMs = 60000; // 1 minute cooldown
      if (Date.now() - breaker.lastFailure > cooldownMs) {
        breaker.state = 'half-open';
        logger.info(`[AI Gateway] Circuit breaker half-open for ${name}`);
      } else {
        throw ApiError.serviceUnavailable(
          `AI provider '${name}' is temporarily unavailable (circuit open)`,
          'AI_CIRCUIT_OPEN',
        );
      }
    }

    return provider;
  }

  /**
   * Selects the best available provider based on health and preference.
   * @param {string} [preferred] - Preferred provider name
   * @returns {{ provider: import('./providers/base.provider'), name: string }}
   */
  selectProvider(preferred) {
    const order = preferred
      ? [preferred, ...[...this.providers.keys()].filter((k) => k !== preferred)]
      : [...this.providers.keys()];

    for (const name of order) {
      const provider = this.providers.get(name);
      const breaker = this._circuitBreakers.get(name);
      if (provider && provider.isHealthy() && breaker?.state !== 'open') {
        return { provider, name };
      }
    }

    // Last resort: return any provider
    const [firstName] = this.providers.keys();
    if (firstName) {
      return { provider: this.providers.get(firstName), name: firstName };
    }

    throw ApiError.serviceUnavailable('No AI providers available', 'AI_NO_PROVIDERS');
  }

  // ── Smart Execution ───────────────────────────────────

  /**
   * Generates completion with automatic fallback to secondary provider.
   * Includes circuit-breaker logic and retry on transient errors.
   * @param {string} prompt
   * @param {Object} options
   * @returns {Promise<Object>}
   */
  async generateWithFallback(prompt, options = {}) {
    const providerOrder = this._getProviderOrder(options.provider);

    for (let i = 0; i < providerOrder.length; i++) {
      const name = providerOrder[i];
      const provider = this.providers.get(name);
      if (!provider) continue;

      try {
        const result = await provider.generateCompletion(prompt, options);
        this._onProviderSuccess(name);
        return { ...result, providerUsed: name };
      } catch (err) {
        this._onProviderFailure(name, err);
        if (i < providerOrder.length - 1) {
          logger.warn(`[AI Gateway] Provider ${name} failed, falling back to ${providerOrder[i + 1]}`);
        } else {
          throw err;
        }
      }
    }

    throw ApiError.serviceUnavailable('All AI providers failed', 'AI_ALL_PROVIDERS_FAILED');
  }

  /**
   * Generates structured (JSON) output with fallback.
   * @param {string} systemPrompt
   * @param {string} userPrompt
   * @param {Object} options
   * @returns {Promise<Object>}
   */
  async generateStructuredWithFallback(systemPrompt, userPrompt, options = {}) {
    const providerOrder = this._getProviderOrder(options.provider);

    for (let i = 0; i < providerOrder.length; i++) {
      const name = providerOrder[i];
      const provider = this.providers.get(name);
      if (!provider) continue;

      try {
        const result = await provider.generateStructured(systemPrompt, userPrompt, options);
        this._onProviderSuccess(name);
        return { ...result, providerUsed: name };
      } catch (err) {
        this._onProviderFailure(name, err);
        if (i < providerOrder.length - 1) {
          logger.warn(`[AI Gateway] Provider ${name} failed structured gen, falling back`);
        } else {
          throw err;
        }
      }
    }

    throw ApiError.serviceUnavailable('All AI providers failed', 'AI_ALL_PROVIDERS_FAILED');
  }

  /**
   * Streams a completion from the best available provider.
   * @param {string} prompt
   * @param {Object} options
   * @param {Function} onChunk
   * @returns {Promise<Object>}
   */
  async streamWithFallback(prompt, options = {}, onChunk) {
    const { provider, name } = this.selectProvider(options.provider);

    if (!provider.capabilities.streaming) {
      throw ApiError.badRequest(`Provider ${name} does not support streaming`, 'AI_NO_STREAMING');
    }

    try {
      const result = await provider.streamCompletion(prompt, options, onChunk);
      this._onProviderSuccess(name);
      return { ...result, providerUsed: name };
    } catch (err) {
      this._onProviderFailure(name, err);
      throw err;
    }
  }

  // ── Circuit Breaker Logic ─────────────────────────────

  _getProviderOrder(preferred) {
    const primary = preferred || env.ai.defaultProvider;
    const others = [...this.providers.keys()].filter((k) => k !== primary);
    return [primary, ...others];
  }

  _onProviderSuccess(name) {
    const breaker = this._circuitBreakers.get(name);
    if (breaker) {
      breaker.failures = 0;
      breaker.state = 'closed';
    }
  }

  _onProviderFailure(name, error) {
    const breaker = this._circuitBreakers.get(name);
    if (!breaker) return;

    breaker.failures++;
    breaker.lastFailure = Date.now();

    const threshold = 5; // Open circuit after 5 consecutive failures
    if (breaker.failures >= threshold) {
      breaker.state = 'open';
      logger.error(`[AI Gateway] Circuit breaker OPEN for ${name} after ${threshold} failures`, {
        error: error.message,
      });
    }
  }

  // ── Observability ─────────────────────────────────────

  /**
   * Returns list of available provider names.
   * @returns {string[]}
   */
  getAvailableProviders() {
    return [...this.providers.keys()];
  }

  /**
   * Returns detailed health & metrics for all providers.
   * @returns {Object}
   */
  getHealthReport() {
    const report = {};
    for (const [name, provider] of this.providers) {
      report[name] = {
        ...provider.getStats(),
        circuitBreaker: this._circuitBreakers.get(name),
      };
    }
    return report;
  }
}

// Singleton — single gateway instance for the application lifecycle
module.exports = new AIGateway();
