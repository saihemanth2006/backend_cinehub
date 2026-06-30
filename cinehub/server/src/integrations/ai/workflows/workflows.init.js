/**
 * @module integrations/ai/workflows/workflows.init
 * @description Complete Workflow Registration — initializes all 7 modules with 30+ tasks.
 *
 * This file defines the complete routing table for the unified AI system.
 * Each entry maps (module, task) → templateId + optional input/output transformers.
 */

const workflowRegistry = require('./workflow.registry');
const { logger } = require('../../../config');

/**
 * INPUT MAPPERS — Transform raw user input into template variables
 */
const inputMappers = {
  // Script Development
  scriptGenerate: (input) => ({
    concept: typeof input === 'string' ? input : input.concept,
    genre: input.genre || 'drama',
    tone: input.tone || 'cinematic',
    targetFormat: input.targetFormat || 'screenplay',
    additionalContext: input.additionalContext || '',
  }),

  screenplayGenerate: (input) => ({
    prompt: typeof input === 'string' ? input : input.prompt,
    format: input.format || 'screenplay',
    genre: input.genre || 'drama',
    length: input.length || 'feature',
  }),

  dialogueEnhance: (input) => ({
    dialogue: typeof input === 'string' ? input : input.dialogue,
    characters: input.characters || '',
    genre: input.genre || '',
    direction: input.direction || 'natural',
  }),

  characterDevelop: (input) => ({
    character: typeof input === 'string' ? input : input.character,
    story: input.story || '',
    genre: input.genre || '',
    role: input.role || 'protagonist',
  }),

  sceneBreakdown: (input) => ({
    script: typeof input === 'string' ? input : input.script,
    format: input.format || 'detailed',
  }),

  genreAnalyze: (input) => ({
    content: typeof input === 'string' ? input : input.content,
    genre: input.genre || '',
  }),

  // Trailer Concept
  trailerNarration: (input) => ({
    premise: typeof input === 'string' ? input : input.premise,
    tone: input.tone || 'epic',
    duration: input.duration || '60seconds',
    style: input.style || 'dramatic',
  }),

  trailerSequence: (input) => ({
    story: typeof input === 'string' ? input : input.story,
    keyBeats: input.keyBeats || [],
    duration: input.duration || '90seconds',
    targetAudience: input.targetAudience || 'general',
  }),

  hookGeneration: (input) => ({
    premise: typeof input === 'string' ? input : input.premise,
    genre: input.genre || '',
    targetAudience: input.targetAudience || 'general',
  }),

  musicMood: (input) => ({
    story: typeof input === 'string' ? input : input.story,
    genre: input.genre || '',
    mood: input.mood || 'dramatic',
    pacing: input.pacing || 'moderate',
  }),

  // Video Enhancement
  editingPlan: (input) => ({
    content: typeof input === 'string' ? input : input.content,
    genre: input.genre || '',
    duration: input.duration || '',
    style: input.style || 'cinematic',
  }),

  colorGrading: (input) => ({
    description: typeof input === 'string' ? input : input.description,
    mood: input.mood || 'neutral',
    genre: input.genre || '',
    tone: input.tone || 'balanced',
  }),

  subtitleGeneration: (input) => ({
    content: typeof input === 'string' ? input : input.content,
    language: input.language || 'English',
    tone: input.tone || 'neutral',
  }),

  pacingAnalysis: (input) => ({
    script: typeof input === 'string' ? input : input.script,
    duration: input.duration || '',
    genre: input.genre || '',
  }),

  // Cast & Crew
  crewRoleRecommendation: (input) => ({
    project: typeof input === 'string' ? input : input.project,
    budget: input.budget || 'medium',
    scale: input.scale || 'independent',
    genre: input.genre || '',
  }),

  talentMatching: (input) => ({
    role: typeof input === 'string' ? input : input.role,
    genre: input.genre || '',
    budget: input.budget || 'medium',
    requirements: input.requirements || [],
  }),

  teamComposition: (input) => ({
    project: typeof input === 'string' ? input : input.project,
    scale: input.scale || 'medium',
    budget: input.budget || 'medium',
    requirements: input.requirements || [],
  }),

  // Production Intelligence
  budgetEstimate: (input) => ({
    projectType: typeof input === 'string' ? input : input.projectType,
    scale: input.scale || 'independent',
    duration: input.duration || '30min',
    locations: input.locations || 1,
    specialEffects: input.specialEffects || false,
    additionalContext: input.additionalContext || '',
  }),

  scheduleRecommendation: (input) => ({
    project: typeof input === 'string' ? input : input.project,
    scale: input.scale || 'medium',
    resources: input.resources || [],
    constraints: input.constraints || [],
  }),

  equipmentSuggestion: (input) => ({
    projectType: typeof input === 'string' ? input : input.projectType,
    genre: input.genre || '',
    budget: input.budget || 'medium',
    requirements: input.requirements || [],
  }),

  complexityAnalysis: (input) => ({
    project: typeof input === 'string' ? input : input.project,
    budget: input.budget || 'medium',
    timeline: input.timeline || '',
    resources: input.resources || [],
  }),

  // Distribution & Promotion
  festivalRecommendation: (input) => ({
    project: typeof input === 'string' ? input : input.project,
    genre: input.genre || '',
    duration: input.duration || '',
    theme: input.theme || '',
  }),

  audienceTargeting: (input) => ({
    project: typeof input === 'string' ? input : input.project,
    genre: input.genre || '',
    demographics: input.demographics || [],
    platforms: input.platforms || [],
  }),

  socialCaption: (input) => ({
    content: typeof input === 'string' ? input : input.content,
    platform: input.platform || 'instagram',
    tone: input.tone || 'engaging',
  }),

  promotionStrategy: (input) => ({
    project: typeof input === 'string' ? input : input.project,
    genre: input.genre || '',
    targetAudience: input.targetAudience || 'general',
    budget: input.budget || 'medium',
  }),

  copywriting: (input) => ({
    project: typeof input === 'string' ? input : input.project,
    asset: input.asset || 'poster',
    genre: input.genre || '',
    tone: input.tone || 'engaging',
  }),

  // Pre-Visualization
  shotSuggestions: (input) => ({
    scene: typeof input === 'string' ? input : input.scene,
    mood: input.mood || 'neutral',
    genre: input.genre || '',
    style: input.style || 'cinematic',
  }),

  cameraAngle: (input) => ({
    description: typeof input === 'string' ? input : input.description,
    mood: input.mood || 'neutral',
    genre: input.genre || '',
  }),

  moodboardPrompt: (input) => ({
    scene: typeof input === 'string' ? input : input.scene,
    mood: input.mood || 'neutral',
    genre: input.genre || '',
    style: input.style || 'cinematic',
  }),

  lightingStyle: (input) => ({
    description: typeof input === 'string' ? input : input.description,
    mood: input.mood || 'neutral',
    genre: input.genre || '',
  }),

  visualStorytelling: (input) => ({
    story: typeof input === 'string' ? input : input.story,
    genre: input.genre || '',
    tone: input.tone || 'balanced',
    style: input.style || 'cinematic',
  }),
};

/**
 * OUTPUT MAPPERS — Transform AI response into normalized format
 */
const outputMappers = {
  // Parse JSON responses or extract structured data
  jsonParse: (data) => {
    if (typeof data === 'string') {
      try {
        return JSON.parse(data);
      } catch (e) {
        return { raw: data };
      }
    }
    return data;
  },

  // Ensure array response
  ensureArray: (data) => {
    if (typeof data === 'string') {
      try {
        const parsed = JSON.parse(data);
        return Array.isArray(parsed) ? parsed : [parsed];
      } catch (e) {
        return [{ raw: data }];
      }
    }
    return Array.isArray(data) ? data : [data];
  },

  // Ensure object response
  ensureObject: (data) => {
    if (typeof data === 'string') {
      try {
        return JSON.parse(data);
      } catch (e) {
        return { content: data };
      }
    }
    return data;
  },
};

/**
 * Register all workflows
 */
function initializeWorkflows() {
  logger.info('[Workflow Registry] Initializing 7 AI modules with 30+ tasks...');

  // ═════════════════════════════════════════════════════════════
  // 1. SCRIPT DEVELOPMENT (6 tasks)
  // ═════════════════════════════════════════════════════════════

  workflowRegistry.registerBatch([
    {
      module: 'script-development',
      task: 'generate-script',
      templateId: 'script.generate',
      name: 'Generate Script',
      description: 'Generate a complete screenplay from a premise',
      inputMapper: inputMappers.screenplayGenerate,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.8, maxTokens: 8192 },
      cacheable: true,
    },
    {
      module: 'script-development',
      task: 'story-expansion',
      templateId: 'script.story-expansion',
      name: 'Story Expansion',
      description: 'Expand a concept into a complete story outline',
      inputMapper: inputMappers.scriptGenerate,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.8, maxTokens: 6144 },
      cacheable: true,
    },
    {
      module: 'script-development',
      task: 'enhance-dialogue',
      templateId: 'script.dialogue-enhancement',
      name: 'Enhance Dialogue',
      description: 'Improve dialogue for authenticity and character voice',
      inputMapper: inputMappers.dialogueEnhance,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.7, maxTokens: 4096 },
      cacheable: true,
    },
    {
      module: 'script-development',
      task: 'develop-character',
      templateId: 'script.character-development',
      name: 'Develop Character',
      description: 'Create a deep character profile with arc and psychology',
      inputMapper: inputMappers.characterDevelop,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.8, maxTokens: 4096 },
      cacheable: true,
    },
    {
      module: 'script-development',
      task: 'analyze-genre',
      templateId: 'script.genre-analysis',
      name: 'Analyze Genre',
      description: 'Analyze genre and provide market insights',
      inputMapper: inputMappers.genreAnalyze,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.6, maxTokens: 3096 },
      cacheable: true,
    },
    {
      module: 'script-development',
      task: 'breakdown-scenes',
      templateId: 'script.scene-breakdown',
      name: 'Scene Breakdown',
      description: 'Create detailed scene-by-scene production breakdown',
      inputMapper: inputMappers.sceneBreakdown,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.3, maxTokens: 6144 },
      cacheable: true,
    },
  ]);

  // ═════════════════════════════════════════════════════════════
  // 2. TRAILER CONCEPT (5 tasks)
  // ═════════════════════════════════════════════════════════════

  workflowRegistry.registerBatch([
    {
      module: 'trailer-concept',
      task: 'generate-narration',
      templateId: 'trailer.narration',
      name: 'Generate Narration',
      description: 'Create compelling trailer narration',
      inputMapper: inputMappers.trailerNarration,
      outputMapper: outputMappers.ensureObject,
      configOverrides: { temperature: 0.8, maxTokens: 1024 },
      cacheable: true,
    },
    {
      module: 'trailer-concept',
      task: 'sequence-concept',
      templateId: 'trailer.sequencing',
      name: 'Sequence Concept',
      description: 'Design trailer beat sequence and flow',
      inputMapper: inputMappers.trailerSequence,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.7, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'trailer-concept',
      task: 'generate-hook',
      templateId: 'trailer.hook',
      name: 'Generate Hook',
      description: 'Create attention-grabbing opening hooks',
      inputMapper: inputMappers.hookGeneration,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.8, maxTokens: 512 },
      cacheable: true,
    },
    {
      module: 'trailer-concept',
      task: 'structure-trailer',
      templateId: 'trailer.structure',
      name: 'Structure Trailer',
      description: 'Define trailer structure and pacing',
      inputMapper: inputMappers.trailerSequence,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.6, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'trailer-concept',
      task: 'suggest-music-mood',
      templateId: 'trailer.music-mood',
      name: 'Suggest Music Mood',
      description: 'Recommend music moods and genres',
      inputMapper: inputMappers.musicMood,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.7, maxTokens: 1024 },
      cacheable: true,
    },
  ]);

  // ═════════════════════════════════════════════════════════════
  // 3. VIDEO ENHANCEMENT (5 tasks)
  // ═════════════════════════════════════════════════════════════

  workflowRegistry.registerBatch([
    {
      module: 'video-enhancement',
      task: 'editing-suggestions',
      templateId: 'video.editing',
      name: 'Editing Suggestions',
      description: 'Provide editing and pacing recommendations',
      inputMapper: inputMappers.editingPlan,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.7, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'video-enhancement',
      task: 'color-grading',
      templateId: 'video.color-grading',
      name: 'Color Grading',
      description: 'Recommend color grading approach',
      inputMapper: inputMappers.colorGrading,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.7, maxTokens: 1536 },
      cacheable: true,
    },
    {
      module: 'video-enhancement',
      task: 'generate-subtitles',
      templateId: 'video.subtitles',
      name: 'Generate Subtitles',
      description: 'Create and optimize subtitles',
      inputMapper: inputMappers.subtitleGeneration,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.3, maxTokens: 4096 },
      cacheable: true,
    },
    {
      module: 'video-enhancement',
      task: 'analyze-pacing',
      templateId: 'video.pacing',
      name: 'Analyze Pacing',
      description: 'Analyze and optimize scene pacing',
      inputMapper: inputMappers.pacingAnalysis,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.6, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'video-enhancement',
      task: 'cinematic-enhancement',
      templateId: 'video.cinematic',
      name: 'Cinematic Enhancement',
      description: 'Suggest cinematic techniques and effects',
      inputMapper: inputMappers.editingPlan,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.8, maxTokens: 2048 },
      cacheable: true,
    },
  ]);

  // ═════════════════════════════════════════════════════════════
  // 4. CAST & CREW (4 tasks)
  // ═════════════════════════════════════════════════════════════

  workflowRegistry.registerBatch([
    {
      module: 'cast-crew',
      task: 'recommend-roles',
      templateId: 'crew.role-recommendations',
      name: 'Recommend Roles',
      description: 'Recommend crew roles and positions needed',
      inputMapper: inputMappers.crewRoleRecommendation,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.6, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'cast-crew',
      task: 'talent-matching',
      templateId: 'crew.talent-matching',
      name: 'Talent Matching',
      description: 'Match talent to roles based on requirements',
      inputMapper: inputMappers.talentMatching,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.7, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'cast-crew',
      task: 'skill-analysis',
      templateId: 'crew.skill-analysis',
      name: 'Skill Analysis',
      description: 'Analyze required skills and experience levels',
      inputMapper: inputMappers.talentMatching,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.6, maxTokens: 1536 },
      cacheable: true,
    },
    {
      module: 'cast-crew',
      task: 'team-composition',
      templateId: 'crew.team-composition',
      name: 'Team Composition',
      description: 'Suggest optimal team composition and structure',
      inputMapper: inputMappers.teamComposition,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.7, maxTokens: 2048 },
      cacheable: true,
    },
  ]);

  // ═════════════════════════════════════════════════════════════
  // 5. PRODUCTION INTELLIGENCE (4 tasks)
  // ═════════════════════════════════════════════════════════════

  workflowRegistry.registerBatch([
    {
      module: 'production-intelligence',
      task: 'estimate-budget',
      templateId: 'production.budget-estimation',
      name: 'Estimate Budget',
      description: 'Estimate production budget breakdown',
      inputMapper: inputMappers.budgetEstimate,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.6, maxTokens: 2048 },
      cacheable: false, // Prices change
    },
    {
      module: 'production-intelligence',
      task: 'schedule-recommendations',
      templateId: 'production.schedule',
      name: 'Schedule Recommendations',
      description: 'Recommend shooting schedule and timeline',
      inputMapper: inputMappers.scheduleRecommendation,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.6, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'production-intelligence',
      task: 'equipment-suggestions',
      templateId: 'production.equipment',
      name: 'Equipment Suggestions',
      description: 'Recommend equipment and technical setup',
      inputMapper: inputMappers.equipmentSuggestion,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.6, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'production-intelligence',
      task: 'complexity-analysis',
      templateId: 'production.complexity',
      name: 'Complexity Analysis',
      description: 'Analyze production complexity and risk factors',
      inputMapper: inputMappers.complexityAnalysis,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.6, maxTokens: 1536 },
      cacheable: true,
    },
  ]);

  // ═════════════════════════════════════════════════════════════
  // 6. DISTRIBUTION & PROMOTION (5 tasks)
  // ═════════════════════════════════════════════════════════════

  workflowRegistry.registerBatch([
    {
      module: 'distribution-promotion',
      task: 'recommend-festivals',
      templateId: 'distribution.festival-recommendations',
      name: 'Recommend Festivals',
      description: 'Recommend festivals based on project profile',
      inputMapper: inputMappers.festivalRecommendation,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.7, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'distribution-promotion',
      task: 'target-audience',
      templateId: 'distribution.audience-targeting',
      name: 'Target Audience',
      description: 'Define target audience and demographics',
      inputMapper: inputMappers.audienceTargeting,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.7, maxTokens: 1536 },
      cacheable: true,
    },
    {
      module: 'distribution-promotion',
      task: 'social-captions',
      templateId: 'distribution.social-captions',
      name: 'Social Captions',
      description: 'Generate social media captions',
      inputMapper: inputMappers.socialCaption,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.8, maxTokens: 1024 },
      cacheable: false, // Should be unique each time
    },
    {
      module: 'distribution-promotion',
      task: 'promotion-strategy',
      templateId: 'distribution.promotion-strategy',
      name: 'Promotion Strategy',
      description: 'Create comprehensive promotion strategy',
      inputMapper: inputMappers.promotionStrategy,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.7, maxTokens: 3096 },
      cacheable: true,
    },
    {
      module: 'distribution-promotion',
      task: 'generate-copywriting',
      templateId: 'distribution.copywriting',
      name: 'Generate Copywriting',
      description: 'Generate marketing copy for various assets',
      inputMapper: inputMappers.copywriting,
      outputMapper: outputMappers.ensureObject,
      configOverrides: { temperature: 0.8, maxTokens: 1024 },
      cacheable: false, // Should be unique
    },
  ]);

  // ═════════════════════════════════════════════════════════════
  // 7. PRE-VISUALIZATION (5 tasks)
  // ═════════════════════════════════════════════════════════════

  workflowRegistry.registerBatch([
    {
      module: 'pre-visualization',
      task: 'suggest-shots',
      templateId: 'previz.shot-suggestions',
      name: 'Suggest Shots',
      description: 'Suggest camera shots and compositions',
      inputMapper: inputMappers.shotSuggestions,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.8, maxTokens: 2048 },
      cacheable: true,
    },
    {
      module: 'pre-visualization',
      task: 'camera-angles',
      templateId: 'previz.camera-angles',
      name: 'Camera Angles',
      description: 'Recommend camera angles and movements',
      inputMapper: inputMappers.cameraAngle,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.8, maxTokens: 1536 },
      cacheable: true,
    },
    {
      module: 'pre-visualization',
      task: 'moodboard-prompts',
      templateId: 'previz.moodboard',
      name: 'Moodboard Prompts',
      description: 'Generate image prompts for moodboards',
      inputMapper: inputMappers.moodboardPrompt,
      outputMapper: outputMappers.ensureArray,
      configOverrides: { temperature: 0.8, maxTokens: 2048 },
      cacheable: false, // Should vary
    },
    {
      module: 'pre-visualization',
      task: 'lighting-style',
      templateId: 'previz.lighting',
      name: 'Lighting Style',
      description: 'Recommend lighting style and setup',
      inputMapper: inputMappers.lightingStyle,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.7, maxTokens: 1536 },
      cacheable: true,
    },
    {
      module: 'pre-visualization',
      task: 'visual-storytelling',
      templateId: 'previz.visual-storytelling',
      name: 'Visual Storytelling',
      description: 'Enhance visual storytelling techniques',
      inputMapper: inputMappers.visualStorytelling,
      outputMapper: outputMappers.jsonParse,
      configOverrides: { temperature: 0.8, maxTokens: 2048 },
      cacheable: true,
    },
  ]);

  logger.info(`[Workflow Registry] ✅ Registered ${workflowRegistry.size} workflows across 7 modules`);
}

module.exports = { initializeWorkflows };
