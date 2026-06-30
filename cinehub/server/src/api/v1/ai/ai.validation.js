/**
 * @module api/v1/ai/ai.validation
 * @description Request validation schemas for AI API endpoints.
 * Includes both the unified /ai/generate schema and legacy endpoint schemas.
 */
const Joi = require('joi');

// ═══════════════════════════════════════════════════════════
// ═  UNIFIED GENERATE VALIDATION
// ═══════════════════════════════════════════════════════════

const VALID_MODULES = [
  'script-development',
  'trailer-concept',
  'video-enhancement',
  'cast-crew',
  'production-intelligence',
  'distribution-promotion',
  'pre-visualization',
];

const unifiedGenerate = {
  body: Joi.object({
    module: Joi.string().required().valid(...VALID_MODULES)
      .messages({
        'any.only': `Module must be one of: ${VALID_MODULES.join(', ')}`,
      }),
    task: Joi.string().required().trim().min(2).max(100),
    input: Joi.alternatives().try(
      Joi.string().min(3).max(50000).trim(),
      Joi.object(),
    ).required()
      .messages({
        'alternatives.match': 'Input must be a string prompt or an object with structured data',
      }),
    options: Joi.object({
      genre: Joi.string().max(100).trim(),
      tone: Joi.string().max(100).trim(),
      format: Joi.string().max(100).trim(),
      style: Joi.string().max(100).trim(),
      mood: Joi.string().max(100).trim(),
      duration: Joi.string().max(100).trim(),
      budget: Joi.string().max(200).trim(),
      platform: Joi.string().max(50).trim(),
      audience: Joi.string().max(200).trim(),
      language: Joi.string().max(50).trim(),
      location: Joi.string().max(200).trim(),
      scale: Joi.string().valid('student', 'independent', 'mid-budget', 'studio'),
      projectType: Joi.string().valid(
        'short_film', 'feature_film', 'documentary', 'web_series',
        'music_video', 'commercial', 'animation',
      ),
      characters: Joi.alternatives().try(
        Joi.string().max(5000),
        Joi.array().items(Joi.object()),
      ),
      provider: Joi.string().valid('openai', 'gemini'),
      // Allow arbitrary extra options for flexibility
    }).unknown(true).default({}),
  }),
};

// ═══════════════════════════════════════════════════════════
// ═  LEGACY ENDPOINT VALIDATIONS
// ═══════════════════════════════════════════════════════════

const generateScript = {
  body: Joi.object({
    projectId: Joi.string().required().trim(),
    format: Joi.string().valid('screenplay', 'treatment', 'outline', 'beat_sheet', 'logline', 'synopsis').required(),
    prompt: Joi.string().required().min(10).max(5000).trim(),
    genre: Joi.string().max(50).trim(),
    tone: Joi.string().max(100).trim(),
    length: Joi.string().valid('short', 'medium', 'long').default('medium'),
    characters: Joi.array().items(
      Joi.object({
        name: Joi.string().required().trim(),
        description: Joi.string().max(500).trim(),
      }),
    ).max(20),
    additionalContext: Joi.string().max(2000).trim(),
    provider: Joi.string().valid('openai', 'gemini'),
  }),
};

const enhanceStory = {
  body: Joi.object({
    content: Joi.string().required().min(50).max(50000).trim(),
    logline: Joi.string().max(500).trim(),
    genre: Joi.string().max(50).trim(),
    focusAreas: Joi.array().items(
      Joi.string().valid('structure', 'character', 'dialogue', 'pacing', 'theme', 'conflict', 'world-building'),
    ),
    provider: Joi.string().valid('openai', 'gemini'),
  }),
};

const analyzeGenre = {
  body: Joi.object({
    logline: Joi.string().required().min(5).max(500).trim(),
    synopsis: Joi.string().max(3000).trim(),
    content: Joi.string().max(50000).trim(),
    provider: Joi.string().valid('openai', 'gemini'),
  }),
};

const estimateBudget = {
  body: Joi.object({
    projectType: Joi.string().required().valid(
      'short_film', 'feature_film', 'documentary', 'web_series',
      'music_video', 'commercial', 'animation',
    ),
    location: Joi.string().max(200).trim(),
    duration: Joi.string().max(100).trim(),
    scenes: Joi.alternatives().try(
      Joi.number().integer().min(1).max(500),
      Joi.array().items(Joi.object()),
    ),
    characters: Joi.alternatives().try(
      Joi.number().integer().min(1).max(100),
      Joi.array().items(Joi.object()),
    ),
    content: Joi.string().max(50000).trim(),
    provider: Joi.string().valid('openai', 'gemini'),
  }),
};

const recommendTalent = {
  body: Joi.object({
    projectType: Joi.string().required().valid(
      'short_film', 'feature_film', 'documentary', 'web_series',
      'music_video', 'commercial', 'animation',
    ),
    genre: Joi.string().max(50).trim(),
    budget: Joi.string().max(200).trim(),
    scale: Joi.string().valid('student', 'independent', 'mid-budget', 'studio').default('independent'),
    requirements: Joi.string().max(2000).trim(),
    provider: Joi.string().valid('openai', 'gemini'),
  }),
};

const creativeAssist = {
  body: Joi.object({
    query: Joi.string().required().min(3).max(5000).trim(),
    projectContext: Joi.string().max(2000).trim(),
    context: Joi.string().max(2000).trim(),
    provider: Joi.string().valid('openai', 'gemini'),
  }),
};

const projectInsights = {
  body: Joi.object({
    projectId: Joi.string().required().trim(),
    provider: Joi.string().valid('openai', 'gemini'),
  }),
};

const getJobStatus = {
  params: Joi.object({
    jobId: Joi.string().required().trim(),
  }),
};

module.exports = {
  // Unified
  unifiedGenerate,
  // Legacy
  generateScript,
  enhanceStory,
  analyzeGenre,
  estimateBudget,
  recommendTalent,
  creativeAssist,
  projectInsights,
  getJobStatus,
};
