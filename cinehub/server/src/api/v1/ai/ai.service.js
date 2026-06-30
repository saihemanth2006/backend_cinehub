/**
 * @module api/v1/ai/ai.service
 * @description AI Service Layer — business logic between API controllers and AI orchestration.
 * Handles domain-specific transformations, persistence, and event emission.
 */
const { getPipelines, getOrchestrator, aiMonitor } = require('../../../integrations/ai');
const scriptService = require('../scripts/script.service');
const { logger } = require('../../../config');
const emitter = require('../../../events/emitter');

class AIService {
  /**
   * Generates a script using the AI pipeline and persists it.
   * @param {Object} params
   * @param {string} params.userId
   * @param {string} params.projectId
   * @param {Object} params.promptData - Script generation parameters
   * @param {string} [params.provider]
   * @param {string} [params.requestId]
   * @returns {Promise<Object>} Persisted script document
   */
  async generateScript({ userId, projectId, promptData, provider, requestId }) {
    const pipelines = getPipelines();

    const result = await pipelines.generateScript({
      ...promptData,
      userId,
      provider,
      requestId,
    });

    // Persist the generated script
    const script = await scriptService.saveAIGeneratedScript(userId, projectId, result.data, {
      provider: result.meta.provider,
      model: result.meta.model,
      prompt: promptData.prompt,
      parameters: promptData,
      generatedAt: new Date(),
      tokensUsed: result.meta.tokensUsed,
      generationTimeMs: result.meta.generationTimeMs,
      format: promptData.format,
    });

    // Emit event for real-time notification
    emitter.emit('ai:script:generated', {
      userId,
      projectId,
      scriptId: script._id || script.id,
      title: result.data.title,
    });

    return { script, aiMeta: result.meta };
  }

  /**
   * Enhances an existing script with AI analysis.
   * @param {Object} params
   * @returns {Promise<Object>}
   */
  async enhanceStory({ userId, content, logline, genre, focusAreas, provider, requestId }) {
    const pipelines = getPipelines();

    return pipelines.enhanceStory({
      content,
      logline,
      genre,
      focusAreas,
      userId,
      provider,
      requestId,
    });
  }

  /**
   * Analyzes genre classification of a script/story.
   * @param {Object} params
   * @returns {Promise<Object>}
   */
  async analyzeGenre({ userId, logline, synopsis, content, provider, requestId }) {
    const pipelines = getPipelines();

    return pipelines.analyzeGenre({
      logline,
      synopsis,
      content,
      userId,
      provider,
      requestId,
    });
  }

  /**
   * Estimates production budget.
   * @param {Object} params
   * @returns {Promise<Object>}
   */
  async estimateBudget({ userId, projectType, location, duration, scenes, characters, content, provider, requestId }) {
    const pipelines = getPipelines();

    return pipelines.estimateBudget({
      projectType,
      location,
      duration,
      scenes,
      characters,
      content,
      userId,
      provider,
      requestId,
    });
  }

  /**
   * Recommends talent/team composition.
   * @param {Object} params
   * @returns {Promise<Object>}
   */
  async recommendTalent({ userId, projectType, genre, budget, scale, requirements, provider, requestId }) {
    const pipelines = getPipelines();

    return pipelines.recommendTalent({
      projectType,
      genre,
      budget,
      scale,
      requirements,
      userId,
      provider,
      requestId,
    });
  }

  /**
   * Interactive creative assistant.
   * @param {Object} params
   * @returns {Promise<Object>}
   */
  async creativeAssist({ userId, query, projectContext, context, provider, requestId }) {
    const pipelines = getPipelines();

    return pipelines.creativeAssist({
      query,
      projectContext,
      context,
      userId,
      provider,
      requestId,
    });
  }

  /**
   * Generates project insights.
   * @param {Object} params
   * @returns {Promise<Object>}
   */
  async getProjectInsights({ userId, project, scripts, team, timeline, budget, provider, requestId }) {
    const pipelines = getPipelines();

    return pipelines.projectInsights({
      project,
      scripts,
      team,
      timeline,
      budget,
      userId,
      provider,
      requestId,
    });
  }

  /**
   * Generates personalized user recommendations.
   * @param {Object} params
   * @returns {Promise<Object>}
   */
  async getRecommendations({ userId, userProfile, provider, requestId }) {
    const pipelines = getPipelines();

    return pipelines.userRecommendations({
      userProfile,
      userId,
      provider,
      requestId,
    });
  }

  /**
   * Enqueues an AI job for async processing.
   * @param {Object} params
   * @returns {Promise<{ jobId: string, status: string }>}
   */
  async enqueueJob(params) {
    const orchestrator = getOrchestrator();
    return orchestrator.executeAsync(params);
  }

  /**
   * Gets the status of an async AI job.
   * @param {string} jobId
   * @returns {Promise<Object>}
   */
  async getJobStatus(jobId) {
    const orchestrator = getOrchestrator();
    return orchestrator.getJobStatus(jobId);
  }

  /**
   * Returns AI system health and metrics.
   * @returns {Object}
   */
  getSystemHealth() {
    const orchestrator = getOrchestrator();
    return orchestrator.getSystemHealth();
  }

  /**
   * Returns AI dashboard data.
   * @returns {Object}
   */
  getDashboard() {
    return aiMonitor.getDashboard();
  }

  /**
   * Returns usage stats for a user.
   * @param {string} userId
   * @returns {Object}
   */
  getUserUsage(userId) {
    return aiMonitor.getUserStats(userId);
  }

  /**
   * Returns recent AI interaction logs.
   * @param {Object} filters
   * @returns {Object[]}
   */
  getRecentLogs(filters) {
    return aiMonitor.getRecentLogs(filters);
  }
}

// Singleton
module.exports = new AIService();
