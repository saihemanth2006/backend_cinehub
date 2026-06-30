/**
 * @module integrations/ai/providers/gemini.provider
 * @description Google Gemini provider implementation — supports completions,
 * structured JSON output, streaming, and embeddings via Gemini Pro models.
 */
const { GoogleGenerativeAI } = require('@google/generative-ai');
const { env, logger } = require('../../../config');
const BaseAIProvider = require('./base.provider');

class GeminiProvider extends BaseAIProvider {
  constructor() {
    super('Gemini', {
      streaming: true,
      structuredOutput: true,
      embeddings: true,
      functionCalling: true,
      vision: true,
    });
    this.genAI = new GoogleGenerativeAI(env.ai.gemini.apiKey);
    this.model = env.ai.gemini.model;
  }

  async generateCompletion(prompt, options = {}) {
    const startTime = Date.now();
    try {
      const model = this.genAI.getGenerativeModel({
        model: options.model || this.model,
        generationConfig: {
          maxOutputTokens: options.maxTokens || 4096,
          temperature: options.temperature ?? 0.7,
          topP: options.topP ?? 0.95,
          topK: options.topK ?? 40,
          ...(options.stop && { stopSequences: options.stop }),
        },
      });

      const fullPrompt = options.systemPrompt
        ? `${options.systemPrompt}\n\n${prompt}`
        : prompt;

      // Build chat history if provided
      let result;
      if (options.conversationHistory && options.conversationHistory.length > 0) {
        const chat = model.startChat({
          history: options.conversationHistory.map((msg) => ({
            role: msg.role === 'assistant' ? 'model' : msg.role,
            parts: [{ text: msg.content }],
          })),
        });
        result = await chat.sendMessage(fullPrompt);
      } else {
        result = await model.generateContent(fullPrompt);
      }

      const response = await result.response;
      const text = response.text();
      const tokensUsed = response.usageMetadata?.totalTokenCount || this.estimateTokens(text);
      this.recordUsage(tokensUsed);
      this.markHealthy();

      return {
        content: text,
        tokensUsed,
        promptTokens: response.usageMetadata?.promptTokenCount || 0,
        completionTokens: response.usageMetadata?.candidatesTokenCount || 0,
        model: options.model || this.model,
        finishReason: response.candidates?.[0]?.finishReason || 'STOP',
        generationTimeMs: Date.now() - startTime,
      };
    } catch (err) {
      this.markUnhealthy(err);
      logger.error(`[Gemini] Generation failed: ${err.message}`);
      throw err;
    }
  }

  async generateStructured(systemPrompt, userPrompt, options = {}) {
    const startTime = Date.now();
    try {
      const model = this.genAI.getGenerativeModel({
        model: options.model || this.model,
        generationConfig: {
          responseMimeType: 'application/json',
          maxOutputTokens: options.maxTokens || 4096,
          temperature: options.temperature ?? 0.7,
        },
      });

      const result = await model.generateContent(`${systemPrompt}\n\n${userPrompt}`);
      const response = await result.response;
      const text = response.text();
      const tokensUsed = response.usageMetadata?.totalTokenCount || this.estimateTokens(text);
      this.recordUsage(tokensUsed);
      this.markHealthy();

      return {
        data: JSON.parse(text),
        tokensUsed,
        promptTokens: response.usageMetadata?.promptTokenCount || 0,
        completionTokens: response.usageMetadata?.candidatesTokenCount || 0,
        model: options.model || this.model,
        generationTimeMs: Date.now() - startTime,
      };
    } catch (err) {
      this.markUnhealthy(err);
      logger.error(`[Gemini] Structured generation failed: ${err.message}`);
      throw err;
    }
  }

  async streamCompletion(prompt, options = {}, onChunk) {
    const startTime = Date.now();
    try {
      const model = this.genAI.getGenerativeModel({
        model: options.model || this.model,
        generationConfig: {
          maxOutputTokens: options.maxTokens || 4096,
          temperature: options.temperature ?? 0.7,
        },
      });

      const fullPrompt = options.systemPrompt
        ? `${options.systemPrompt}\n\n${prompt}`
        : prompt;

      const result = await model.generateContentStream(fullPrompt);

      let fullContent = '';
      for await (const chunk of result.stream) {
        const text = chunk.text();
        fullContent += text;
        if (onChunk) onChunk(text, false);
      }
      if (onChunk) onChunk('', true);

      const tokensUsed = this.estimateTokens(fullContent);
      this.recordUsage(tokensUsed);
      this.markHealthy();

      return {
        content: fullContent,
        tokensUsed,
        model: options.model || this.model,
        generationTimeMs: Date.now() - startTime,
      };
    } catch (err) {
      this.markUnhealthy(err);
      logger.error(`[Gemini] Stream failed: ${err.message}`);
      throw err;
    }
  }

  async generateEmbeddings(input, options = {}) {
    try {
      const model = this.genAI.getGenerativeModel({
        model: options.embeddingModel || 'text-embedding-004',
      });

      const inputs = Array.isArray(input) ? input : [input];
      const embeddings = [];

      for (const text of inputs) {
        const result = await model.embedContent(text);
        embeddings.push(result.embedding.values);
      }

      return {
        embeddings,
        model: options.embeddingModel || 'text-embedding-004',
        tokensUsed: inputs.reduce((sum, t) => sum + this.estimateTokens(t), 0),
      };
    } catch (err) {
      logger.error(`[Gemini] Embeddings failed: ${err.message}`);
      throw err;
    }
  }

  estimateTokens(text) {
    // Gemini tokenization: roughly ~1 token per 4 chars
    return Math.ceil((text || '').length / 4);
  }
}

module.exports = GeminiProvider;
