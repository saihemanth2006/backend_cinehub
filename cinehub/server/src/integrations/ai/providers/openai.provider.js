/**
 * @module integrations/ai/providers/openai.provider
 * @description OpenAI provider implementation — supports completions, structured output,
 * streaming, embeddings, and function calling via GPT-4 family models.
 */
const OpenAI = require('openai');
const { env, logger } = require('../../../config');
const BaseAIProvider = require('./base.provider');

class OpenAIProvider extends BaseAIProvider {
  constructor() {
    super('OpenAI', {
      streaming: true,
      structuredOutput: true,
      embeddings: true,
      functionCalling: true,
      vision: true,
    });
    this.client = new OpenAI({ apiKey: env.ai.openai.apiKey });
    this.model = env.ai.openai.model;
    this.maxTokens = env.ai.openai.maxTokens;
  }

  async generateCompletion(prompt, options = {}) {
    const startTime = Date.now();
    try {
      const response = await this.client.chat.completions.create({
        model: options.model || this.model,
        messages: [
          { role: 'system', content: options.systemPrompt || 'You are a professional AI assistant for a filmmaking platform.' },
          ...(options.conversationHistory || []),
          { role: 'user', content: prompt },
        ],
        max_tokens: options.maxTokens || this.maxTokens,
        temperature: options.temperature ?? 0.7,
        top_p: options.topP ?? 1,
        frequency_penalty: options.frequencyPenalty ?? 0,
        presence_penalty: options.presencePenalty ?? 0,
        ...(options.stop && { stop: options.stop }),
      });

      const message = response.choices[0]?.message?.content || '';
      const tokensUsed = response.usage?.total_tokens || 0;
      this.recordUsage(tokensUsed);
      this.markHealthy();

      return {
        content: message,
        tokensUsed,
        promptTokens: response.usage?.prompt_tokens || 0,
        completionTokens: response.usage?.completion_tokens || 0,
        model: response.model,
        finishReason: response.choices[0]?.finish_reason,
        generationTimeMs: Date.now() - startTime,
      };
    } catch (err) {
      this.markUnhealthy(err);
      logger.error(`[OpenAI] Generation failed: ${err.message}`, { error: err.code });
      throw err;
    }
  }

  async generateStructured(systemPrompt, userPrompt, options = {}) {
    const startTime = Date.now();
    try {
      const response = await this.client.chat.completions.create({
        model: options.model || this.model,
        response_format: { type: 'json_object' },
        messages: [
          { role: 'system', content: systemPrompt },
          ...(options.conversationHistory || []),
          { role: 'user', content: userPrompt },
        ],
        max_tokens: options.maxTokens || this.maxTokens,
        temperature: options.temperature ?? 0.7,
      });

      const content = response.choices[0]?.message?.content || '{}';
      const tokensUsed = response.usage?.total_tokens || 0;
      this.recordUsage(tokensUsed);
      this.markHealthy();

      return {
        data: JSON.parse(content),
        tokensUsed,
        promptTokens: response.usage?.prompt_tokens || 0,
        completionTokens: response.usage?.completion_tokens || 0,
        model: response.model,
        generationTimeMs: Date.now() - startTime,
      };
    } catch (err) {
      this.markUnhealthy(err);
      logger.error(`[OpenAI] Structured generation failed: ${err.message}`);
      throw err;
    }
  }

  async streamCompletion(prompt, options = {}, onChunk) {
    const startTime = Date.now();
    try {
      const stream = await this.client.chat.completions.create({
        model: options.model || this.model,
        messages: [
          { role: 'system', content: options.systemPrompt || 'You are a professional AI assistant.' },
          ...(options.conversationHistory || []),
          { role: 'user', content: prompt },
        ],
        max_tokens: options.maxTokens || this.maxTokens,
        temperature: options.temperature ?? 0.7,
        stream: true,
      });

      let fullContent = '';
      for await (const chunk of stream) {
        const delta = chunk.choices[0]?.delta?.content || '';
        const done = chunk.choices[0]?.finish_reason !== null;
        fullContent += delta;
        if (onChunk) onChunk(delta, done);
      }

      const estimatedTokens = this.estimateTokens(fullContent);
      this.recordUsage(estimatedTokens);
      this.markHealthy();

      return {
        content: fullContent,
        tokensUsed: estimatedTokens,
        model: options.model || this.model,
        generationTimeMs: Date.now() - startTime,
      };
    } catch (err) {
      this.markUnhealthy(err);
      logger.error(`[OpenAI] Stream failed: ${err.message}`);
      throw err;
    }
  }

  async generateEmbeddings(input, options = {}) {
    try {
      const inputs = Array.isArray(input) ? input : [input];
      const response = await this.client.embeddings.create({
        model: options.embeddingModel || 'text-embedding-3-small',
        input: inputs,
      });

      const tokensUsed = response.usage?.total_tokens || 0;
      this.recordUsage(tokensUsed);

      return {
        embeddings: response.data.map((d) => d.embedding),
        model: response.model,
        tokensUsed,
      };
    } catch (err) {
      logger.error(`[OpenAI] Embeddings failed: ${err.message}`);
      throw err;
    }
  }

  estimateTokens(text) {
    // GPT tokenization: ~1 token per ~4 chars for English
    return Math.ceil((text || '').length / 4);
  }
}

module.exports = OpenAIProvider;
