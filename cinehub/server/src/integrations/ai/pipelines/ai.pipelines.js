/**
 * @module integrations/ai/pipelines/ai.pipelines
 * @description Reusable AI Pipelines — pre-configured execution flows for common operations.
 * Each pipeline composes prompt compilation, AI execution, validation, and post-processing
 * into a single callable unit.
 *
 * Pipeline Types:
 * - Synchronous: execute() → immediate result
 * - Async: executeAsync() → job ID, poll for result
 * - Streaming: executeStream() → real-time chunks
 *
 * Pipelines are thin wrappers over the orchestrator, pre-filling templateId and
 * providing domain-specific input normalization and output transformation.
 */

class AIPipeline {
  /**
   * @param {import('../orchestrator/ai.orchestrator')} orchestrator
   */
  constructor(orchestrator) {
    this.orchestrator = orchestrator;
  }

  // ── Script Generation Pipeline ────────────────────────

  /**
   * Generates a complete script from a story premise.
   * @param {Object} input
   * @param {string} input.prompt - Story premise/description
   * @param {string} input.format - 'screenplay' | 'treatment' | 'outline' | 'beat_sheet' | 'logline'
   * @param {string} input.genre - Genre (drama, sci-fi, etc.)
   * @param {string} [input.tone] - Tonal direction
   * @param {string} [input.length] - 'short' | 'medium' | 'long'
   * @param {Array} [input.characters] - Pre-defined characters
   * @param {string} [input.additionalContext] - Extra instructions
   * @param {string} input.userId - Requesting user
   * @param {Object} [input.context] - User/project context
   * @param {string} [input.provider] - Preferred AI provider
   * @returns {Promise<Object>}
   */
  async generateScript(input) {
    const lengthGuide = {
      short: '5-10 pages (~5-10 min)',
      medium: '15-30 pages (~15-30 min)',
      long: '40-120 pages (~40-120 min)',
    };

    const characterSection = input.characters?.length > 0
      ? `CHARACTERS:\n${input.characters.map((c) => `- ${c.name}: ${c.description || 'To be developed'}`).join('\n')}`
      : '';

    return this.orchestrator.execute({
      templateId: 'script.generate',
      variables: {
        prompt: input.prompt,
        format: input.format || 'screenplay',
        genre: input.genre || 'drama',
        tone: input.tone || 'balanced',
        lengthGuide: lengthGuide[input.length] || lengthGuide.medium,
        characterSection,
        additionalContext: input.additionalContext
          ? `ADDITIONAL CONTEXT: ${input.additionalContext}`
          : '',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      context: input.context,
      generationConfig: { temperature: 0.8, maxTokens: 8192 },
    });
  }

  // ── Story Enhancement Pipeline ────────────────────────

  /**
   * Analyzes and enhances an existing script.
   * @param {Object} input
   * @param {string} input.content - Script content to analyze
   * @param {string} [input.logline] - Current logline
   * @param {string} [input.genre] - Script genre
   * @param {string[]} [input.focusAreas] - Specific areas to focus on
   * @param {string} input.userId
   * @returns {Promise<Object>}
   */
  async enhanceStory(input) {
    return this.orchestrator.execute({
      templateId: 'script.enhance',
      variables: {
        content: input.content,
        logline: input.logline,
        genre: input.genre,
        focusAreas: input.focusAreas
          ? `FOCUS AREAS: ${input.focusAreas.join(', ')}`
          : '',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      context: input.context,
      generationConfig: { temperature: 0.6, maxTokens: 4096 },
    });
  }

  // ── Genre Analysis Pipeline ───────────────────────────

  /**
   * Analyzes genre classification of a story.
   * @param {Object} input
   * @param {string} input.logline - Story logline
   * @param {string} [input.synopsis] - Story synopsis
   * @param {string} [input.content] - Script content (excerpt used)
   * @param {string} input.userId
   * @returns {Promise<Object>}
   */
  async analyzeGenre(input) {
    return this.orchestrator.execute({
      templateId: 'analysis.genre',
      variables: {
        logline: input.logline,
        synopsis: input.synopsis,
        contentExcerpt: input.content
          ? `SCRIPT CONTENT (excerpt):\n${input.content.substring(0, 3000)}`
          : '',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      context: input.context,
      generationConfig: { temperature: 0.5, maxTokens: 3072 },
    });
  }

  // ── Budget Estimation Pipeline ────────────────────────

  /**
   * Estimates production budget for a project.
   * @param {Object} input
   * @param {string} input.projectType - Type of project
   * @param {string} [input.location] - Filming location
   * @param {string} [input.duration] - Target duration
   * @param {Array|number} [input.scenes] - Scene count or array
   * @param {Array|number} [input.characters] - Character count or array
   * @param {string} [input.content] - Script content excerpt
   * @param {string} input.userId
   * @returns {Promise<Object>}
   */
  async estimateBudget(input) {
    return this.orchestrator.execute({
      templateId: 'production.budget',
      variables: {
        projectType: input.projectType || 'short_film',
        location: input.location,
        duration: input.duration,
        sceneCount: Array.isArray(input.scenes) ? input.scenes.length : (input.scenes || 'Unknown'),
        characterCount: Array.isArray(input.characters) ? input.characters.length : (input.characters || 'Unknown'),
        scriptExcerpt: input.content
          ? `SCRIPT EXCERPT:\n${input.content.substring(0, 2000)}`
          : '',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      context: input.context,
      generationConfig: { temperature: 0.4, maxTokens: 4096 },
    });
  }

  // ── Talent Recommendation Pipeline ────────────────────

  /**
   * Recommends ideal team composition for a project.
   * @param {Object} input
   * @param {string} input.projectType
   * @param {string} [input.genre]
   * @param {string} [input.budget]
   * @param {string} [input.scale]
   * @param {string} [input.requirements]
   * @param {string} input.userId
   * @returns {Promise<Object>}
   */
  async recommendTalent(input) {
    return this.orchestrator.execute({
      templateId: 'production.talent',
      variables: {
        projectType: input.projectType,
        genre: input.genre,
        budget: input.budget,
        scale: input.scale,
        requirements: input.requirements || '',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      context: input.context,
      generationConfig: { temperature: 0.5, maxTokens: 4096 },
    });
  }

  // ── Creative Assistant Pipeline ───────────────────────

  /**
   * Interactive creative assistant for filmmaking questions.
   * @param {Object} input
   * @param {string} input.query - User's question
   * @param {string} [input.projectContext] - Project context string
   * @param {string} [input.context] - Additional context
   * @param {string} input.userId
   * @returns {Promise<Object>}
   */
  async creativeAssist(input) {
    return this.orchestrator.execute({
      templateId: 'assistant.creative',
      variables: {
        query: input.query,
        projectContext: input.projectContext || '',
        context: input.context ? `ADDITIONAL CONTEXT: ${input.context}` : '',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      context: input.context,
      skipCache: true, // Conversational responses shouldn't be cached
      generationConfig: { temperature: 0.7, maxTokens: 2048 },
    });
  }

  /**
   * Streaming creative assistant for real-time typewriter UX.
   * @param {Object} input
   * @param {Function} input.onChunk
   * @param {string} input.query
   * @param {string} input.userId
   * @returns {Promise<Object>}
   */
  async creativeAssistStream(input) {
    return this.orchestrator.executeStream({
      templateId: 'assistant.creative',
      variables: {
        query: input.query,
        projectContext: input.projectContext || '',
        context: '',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      onChunk: input.onChunk,
    });
  }

  // ── Project Insights Pipeline ─────────────────────────

  /**
   * Generates AI insights for a project.
   * @param {Object} input
   * @param {Object} input.project - Project data
   * @param {Array} [input.scripts] - Project scripts
   * @param {Array} [input.team] - Team members
   * @param {string} [input.timeline]
   * @param {Object} [input.budget]
   * @param {string} input.userId
   * @returns {Promise<Object>}
   */
  async projectInsights(input) {
    return this.orchestrator.execute({
      templateId: 'insights.project',
      variables: {
        projectTitle: input.project?.title || 'Untitled',
        projectType: input.project?.type || 'film',
        projectStatus: input.project?.status || 'unknown',
        genre: input.project?.genre || 'Not specified',
        scriptCount: String(input.scripts?.length || 0),
        teamSize: String(input.team?.length || 0),
        timeline: input.timeline || 'Not specified',
        budget: input.budget ? JSON.stringify(input.budget) : 'Not specified',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      context: input.context,
      generationConfig: { temperature: 0.5, maxTokens: 3072 },
    });
  }

  // ── User Recommendations Pipeline ─────────────────────

  /**
   * Generates personalized recommendations for a user.
   * @param {Object} input
   * @param {Object} input.userProfile - User profile data
   * @param {string} input.userId
   * @returns {Promise<Object>}
   */
  async userRecommendations(input) {
    const profile = input.userProfile || {};

    return this.orchestrator.execute({
      templateId: 'recommendation.user',
      variables: {
        role: profile.role || 'creator',
        skills: (profile.skills || []).map((s) => s.name || s).join(', ') || 'general',
        interests: (profile.genres || profile.interests || []).join(', ') || 'filmmaking',
        experience: profile.experience?.length ? 'experienced' : 'emerging',
      },
      userId: input.userId,
      requestId: input.requestId,
      provider: input.provider,
      context: input.context,
      generationConfig: { temperature: 0.6, maxTokens: 2048 },
    });
  }
}

module.exports = AIPipeline;
