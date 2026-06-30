/**
 * @module integrations/ai/providers/base.provider
 * @description Abstract AI provider interface — the contract every provider must implement.
 * Supports text completions, structured JSON responses, streaming, embeddings,
 * and token estimation. All providers (OpenAI, Gemini, Anthropic, etc.) extend this.
 */

class BaseAIProvider {
  /**
   * @param {string} name - Human-readable provider name
   * @param {Object} capabilities - Feature flags for this provider
   */
  constructor(name, capabilities = {}) {
    if (new.target === BaseAIProvider) {
      throw new Error('BaseAIProvider is abstract and cannot be instantiated directly');
    }
    this.name = name;
    this.capabilities = {
      streaming: false,
      structuredOutput: false,
      embeddings: false,
      functionCalling: false,
      vision: false,
      ...capabilities,
    };
    this._healthy = true;
    this._lastError = null;
    this._requestCount = 0;
    this._totalTokens = 0;
  }

  // ── Core Methods (must implement) ─────────────────────

  /**
   * Generates a text completion from a prompt.
   * @param {string} prompt - User prompt
   * @param {Object} options - Generation options (model, temperature, maxTokens, systemPrompt)
   * @returns {Promise<{ content: string, tokensUsed: number, model: string, generationTimeMs: number }>}
   */
  async generateCompletion(_prompt, _options) {
    throw new Error(`${this.name}: generateCompletion() not implemented`);
  }

  /**
   * Generates a structured JSON response.
   * @param {string} systemPrompt - System-level instructions
   * @param {string} userPrompt - User request
   * @param {Object} options - Generation options including optional JSON schema
   * @returns {Promise<{ data: Object, tokensUsed: number, model: string, generationTimeMs: number }>}
   */
  async generateStructured(_systemPrompt, _userPrompt, _options) {
    throw new Error(`${this.name}: generateStructured() not implemented`);
  }

  // ── Optional Methods (override if supported) ──────────

  /**
   * Streams a completion, yielding chunks via callback.
   * @param {string} prompt
   * @param {Object} options
   * @param {Function} onChunk - Called with each text chunk: (chunk: string, done: boolean) => void
   * @returns {Promise<{ tokensUsed: number, model: string, generationTimeMs: number }>}
   */
  async streamCompletion(_prompt, _options, _onChunk) {
    throw new Error(`${this.name}: streamCompletion() not supported`);
  }

  /**
   * Generates vector embeddings for text.
   * @param {string|string[]} input - Text(s) to embed
   * @param {Object} options
   * @returns {Promise<{ embeddings: number[][], model: string, tokensUsed: number }>}
   */
  async generateEmbeddings(_input, _options) {
    throw new Error(`${this.name}: generateEmbeddings() not supported`);
  }

  /**
   * Estimates token count for given text (provider-specific tokenization).
   * @param {string} text
   * @returns {number} Estimated token count
   */
  estimateTokens(text) {
    // Rough heuristic: ~4 chars per token. Providers should override.
    return Math.ceil((text || '').length / 4);
  }

  // ── Health & Metrics ──────────────────────────────────

  /** @returns {boolean} Whether the provider is currently healthy */
  isHealthy() {
    return this._healthy;
  }

  /** Mark provider as unhealthy with an error */
  markUnhealthy(error) {
    this._healthy = false;
    this._lastError = { message: error.message, timestamp: new Date() };
  }

  /** Mark provider as recovered */
  markHealthy() {
    this._healthy = true;
    this._lastError = null;
  }

  /** Record usage metrics after a successful call */
  recordUsage(tokensUsed) {
    this._requestCount++;
    this._totalTokens += tokensUsed || 0;
  }

  /** Get provider stats */
  getStats() {
    return {
      name: this.name,
      healthy: this._healthy,
      lastError: this._lastError,
      requestCount: this._requestCount,
      totalTokens: this._totalTokens,
      capabilities: this.capabilities,
    };
  }
}

module.exports = BaseAIProvider;
