/**
 * @module integrations/ai/workflows/workflow.definitions
 * @description Registers ALL 30+ AI workflow definitions across 7 CineHub modules.
 *
 * Import this at startup to populate the WorkflowRegistry.
 * Each definition wires: module + task → templateId + I/O mappers.
 */
const workflowRegistry = require('./workflow.registry');

// ╔════════════════════════════════════════════════════════════════╗
// ║  MODULE 1: SCRIPT DEVELOPMENT STUDIO                          ║
// ╚════════════════════════════════════════════════════════════════╝

workflowRegistry.registerBatch([
  {
    module: 'script-development',
    task: 'story-expansion',
    templateId: 'script.story-expansion',
    name: 'Story Expansion',
    description: 'Expand a brief concept into a full story outline with acts, turning points, and character arcs.',
    category: 'script',
    inputMapper: (input) => ({
      concept: input.input || input.concept || '',
      genre: input.genre || 'drama',
      tone: input.tone || 'cinematic',
      targetLength: input.targetLength || 'feature',
    }),
  },
  {
    module: 'script-development',
    task: 'generate-screenplay',
    templateId: 'script.generate',
    name: 'Screenplay Generation',
    description: 'Generate a fully formatted screenplay from a premise.',
    category: 'script',
    inputMapper: (input) => ({
      prompt: input.input || input.prompt || '',
      format: input.format || 'screenplay',
      genre: input.genre || 'drama',
      tone: input.tone || 'balanced',
      lengthGuide: input.lengthGuide || '15-30 pages',
      characterSection: input.characters
        ? `CHARACTERS:\n${input.characters.map((c) => `- ${c.name}: ${c.description || 'To be developed'}`).join('\n')}`
        : '',
      additionalContext: input.additionalContext || '',
    }),
  },
  {
    module: 'script-development',
    task: 'dialogue-enhancement',
    templateId: 'script.dialogue-enhancement',
    name: 'Dialogue Enhancement',
    description: 'Refine and improve dialogue for authenticity, subtext, and character voice.',
    category: 'script',
    inputMapper: (input) => ({
      dialogue: input.input || input.dialogue || '',
      genre: input.genre || '',
      characters: input.characters || '',
      direction: input.direction || 'natural and cinematic',
    }),
  },
  {
    module: 'script-development',
    task: 'character-development',
    templateId: 'script.character-development',
    name: 'Character Development',
    description: 'Create deep character profiles with backstory, motivations, arc, and relationships.',
    category: 'script',
    inputMapper: (input) => ({
      character: input.input || input.character || '',
      story: input.story || '',
      genre: input.genre || '',
      role: input.role || 'protagonist',
    }),
  },
  {
    module: 'script-development',
    task: 'genre-analysis',
    templateId: 'analysis.genre',
    name: 'Genre Analysis',
    description: 'Classify genre with market analysis, comparable films, and audience profile.',
    category: 'analysis',
    inputMapper: (input) => ({
      logline: input.input || input.logline || '',
      synopsis: input.synopsis || '',
      contentExcerpt: input.content
        ? `SCRIPT CONTENT (excerpt):\n${input.content.substring(0, 3000)}`
        : '',
    }),
  },
  {
    module: 'script-development',
    task: 'scene-breakdown',
    templateId: 'script.scene-breakdown',
    name: 'Scene Breakdown',
    description: 'Break down a script into detailed scene-by-scene analysis with locations, props, and requirements.',
    category: 'script',
    inputMapper: (input) => ({
      script: input.input || input.script || '',
      format: input.format || 'detailed',
    }),
  },
]);

// ╔════════════════════════════════════════════════════════════════╗
// ║  MODULE 2: TRAILER CONCEPT GENERATOR                          ║
// ╚════════════════════════════════════════════════════════════════╝

workflowRegistry.registerBatch([
  {
    module: 'trailer-concept',
    task: 'trailer-narration',
    templateId: 'trailer.narration',
    name: 'Trailer Narration',
    description: 'Write compelling voiceover narration for a trailer.',
    category: 'trailer',
    inputMapper: (input) => ({
      story: input.input || input.story || '',
      genre: input.genre || '',
      tone: input.tone || 'epic and dramatic',
      duration: input.duration || '90 seconds',
    }),
  },
  {
    module: 'trailer-concept',
    task: 'trailer-sequencing',
    templateId: 'trailer.sequencing',
    name: 'Trailer Sequencing',
    description: 'Design the visual sequence and shot order for a trailer.',
    category: 'trailer',
    inputMapper: (input) => ({
      story: input.input || input.story || '',
      genre: input.genre || '',
      keyMoments: input.keyMoments || '',
      duration: input.duration || '120 seconds',
    }),
  },
  {
    module: 'trailer-concept',
    task: 'hook-generation',
    templateId: 'trailer.hooks',
    name: 'Hook Generation',
    description: 'Generate attention-grabbing opening hooks and taglines for trailers.',
    category: 'trailer',
    inputMapper: (input) => ({
      story: input.input || input.story || '',
      genre: input.genre || '',
      audience: input.audience || 'general',
    }),
  },
  {
    module: 'trailer-concept',
    task: 'trailer-structure',
    templateId: 'trailer.structure',
    name: 'Cinematic Trailer Structure',
    description: 'Design a complete 3-act trailer structure with pacing and beat map.',
    category: 'trailer',
    inputMapper: (input) => ({
      story: input.input || input.story || '',
      genre: input.genre || '',
      style: input.style || 'classic three-act',
    }),
  },
  {
    module: 'trailer-concept',
    task: 'music-mood',
    templateId: 'trailer.music-mood',
    name: 'Music Mood Suggestions',
    description: 'Suggest music styles, moods, and specific track recommendations for each trailer segment.',
    category: 'trailer',
    inputMapper: (input) => ({
      story: input.input || input.story || '',
      genre: input.genre || '',
      trailerTone: input.tone || '',
    }),
  },
]);

// ╔════════════════════════════════════════════════════════════════╗
// ║  MODULE 3: VIDEO ENHANCEMENT STUDIO                           ║
// ╚════════════════════════════════════════════════════════════════╝

workflowRegistry.registerBatch([
  {
    module: 'video-enhancement',
    task: 'editing-suggestions',
    templateId: 'video.editing',
    name: 'Editing Suggestions',
    description: 'Provide professional editing suggestions for shot transitions, cuts, and rhythm.',
    category: 'video',
    inputMapper: (input) => ({
      footage: input.input || input.footage || '',
      genre: input.genre || '',
      style: input.style || 'cinematic',
      pace: input.pace || 'moderate',
    }),
  },
  {
    module: 'video-enhancement',
    task: 'color-grading',
    templateId: 'video.color-grading',
    name: 'Color Grading Recommendations',
    description: 'Recommend color grading LUTs, palettes, and tonal adjustments for cinematic look.',
    category: 'video',
    inputMapper: (input) => ({
      scene: input.input || input.scene || '',
      genre: input.genre || '',
      mood: input.mood || '',
      reference: input.reference || '',
    }),
  },
  {
    module: 'video-enhancement',
    task: 'subtitle-generation',
    templateId: 'video.subtitles',
    name: 'Subtitle Generation',
    description: 'Generate subtitles or closed captions with timing and formatting.',
    category: 'video',
    inputMapper: (input) => ({
      dialogue: input.input || input.dialogue || '',
      language: input.language || 'English',
      style: input.style || 'standard',
    }),
  },
  {
    module: 'video-enhancement',
    task: 'pacing-analysis',
    templateId: 'video.pacing',
    name: 'Scene Pacing Analysis',
    description: 'Analyze scene pacing and recommend adjustments for optimal narrative flow.',
    category: 'video',
    inputMapper: (input) => ({
      scenes: input.input || input.scenes || '',
      genre: input.genre || '',
      targetEmotion: input.targetEmotion || '',
    }),
  },
  {
    module: 'video-enhancement',
    task: 'cinematic-enhancement',
    templateId: 'video.cinematic',
    name: 'Cinematic Enhancement Suggestions',
    description: 'Suggest cinematic techniques for VFX, sound design, and visual polish.',
    category: 'video',
    inputMapper: (input) => ({
      scene: input.input || input.scene || '',
      genre: input.genre || '',
      budget: input.budget || 'independent',
    }),
  },
]);

// ╔════════════════════════════════════════════════════════════════╗
// ║  MODULE 4: CAST & CREW INTELLIGENCE                           ║
// ╚════════════════════════════════════════════════════════════════╝

workflowRegistry.registerBatch([
  {
    module: 'cast-crew',
    task: 'crew-recommendations',
    templateId: 'production.talent',
    name: 'Crew Role Recommendations',
    description: 'Recommend ideal crew roles and team size for a project.',
    category: 'production',
    inputMapper: (input) => ({
      projectType: input.projectType || 'short_film',
      genre: input.genre || 'drama',
      budget: input.budget || 'Not specified',
      scale: input.scale || 'independent',
      requirements: input.input || input.requirements || '',
    }),
  },
  {
    module: 'cast-crew',
    task: 'talent-matching',
    templateId: 'crew.talent-matching',
    name: 'Talent Matching',
    description: 'Match character requirements to ideal casting profiles.',
    category: 'crew',
    inputMapper: (input) => ({
      characters: input.input || input.characters || '',
      genre: input.genre || '',
      budget: input.budget || '',
      style: input.style || '',
    }),
  },
  {
    module: 'cast-crew',
    task: 'skill-analysis',
    templateId: 'crew.skill-analysis',
    name: 'Skill Analysis',
    description: 'Analyze required skills for a production and identify gaps.',
    category: 'crew',
    inputMapper: (input) => ({
      project: input.input || input.project || '',
      currentTeam: input.currentTeam || '',
      genre: input.genre || '',
    }),
  },
  {
    module: 'cast-crew',
    task: 'team-composition',
    templateId: 'crew.team-composition',
    name: 'Team Composition Guidance',
    description: 'Design optimal team structure with departments, hierarchy, and workflow.',
    category: 'crew',
    inputMapper: (input) => ({
      project: input.input || input.project || '',
      scale: input.scale || 'independent',
      budget: input.budget || '',
      timeline: input.timeline || '',
    }),
  },
]);

// ╔════════════════════════════════════════════════════════════════╗
// ║  MODULE 5: PRODUCTION INTELLIGENCE                            ║
// ╚════════════════════════════════════════════════════════════════╝

workflowRegistry.registerBatch([
  {
    module: 'production-intelligence',
    task: 'budget-estimation',
    templateId: 'production.budget',
    name: 'Budget Estimation',
    description: 'Estimate detailed production budget with line items and contingency.',
    category: 'production',
    inputMapper: (input) => ({
      projectType: input.projectType || 'short_film',
      location: input.location || 'Not specified',
      duration: input.duration || 'Not specified',
      sceneCount: input.scenes || 'Unknown',
      characterCount: input.characters || 'Unknown',
      scriptExcerpt: input.input
        ? `PROJECT DETAILS:\n${input.input}`
        : '',
    }),
  },
  {
    module: 'production-intelligence',
    task: 'shooting-schedule',
    templateId: 'production.schedule',
    name: 'Shooting Schedule',
    description: 'Generate an optimized shooting schedule based on script and logistics.',
    category: 'production',
    inputMapper: (input) => ({
      script: input.input || input.script || '',
      locations: input.locations || '',
      castAvailability: input.castAvailability || '',
      totalDays: input.totalDays || 'flexible',
    }),
  },
  {
    module: 'production-intelligence',
    task: 'equipment-suggestions',
    templateId: 'production.equipment',
    name: 'Equipment Suggestions',
    description: 'Recommend camera, lighting, audio, and grip equipment for the production.',
    category: 'production',
    inputMapper: (input) => ({
      project: input.input || input.project || '',
      budget: input.budget || 'independent',
      genre: input.genre || '',
      style: input.style || 'cinematic',
    }),
  },
  {
    module: 'production-intelligence',
    task: 'complexity-analysis',
    templateId: 'production.complexity',
    name: 'Production Complexity Analysis',
    description: 'Analyze the overall complexity of a production with risk factors.',
    category: 'production',
    inputMapper: (input) => ({
      script: input.input || input.script || '',
      budget: input.budget || '',
      locations: input.locations || '',
    }),
  },
]);

// ╔════════════════════════════════════════════════════════════════╗
// ║  MODULE 6: DISTRIBUTION & PROMOTION ENGINE                    ║
// ╚════════════════════════════════════════════════════════════════╝

workflowRegistry.registerBatch([
  {
    module: 'distribution-promotion',
    task: 'festival-recommendations',
    templateId: 'distribution.festivals',
    name: 'Festival Recommendations',
    description: 'Recommend film festivals based on genre, length, theme, and premiere status.',
    category: 'distribution',
    inputMapper: (input) => ({
      film: input.input || input.film || '',
      genre: input.genre || '',
      length: input.length || '',
      budget: input.budget || '',
      region: input.region || 'global',
    }),
  },
  {
    module: 'distribution-promotion',
    task: 'audience-targeting',
    templateId: 'distribution.audience',
    name: 'Audience Targeting',
    description: 'Identify target audience demographics, psychographics, and distribution channels.',
    category: 'distribution',
    inputMapper: (input) => ({
      film: input.input || input.film || '',
      genre: input.genre || '',
      logline: input.logline || '',
    }),
  },
  {
    module: 'distribution-promotion',
    task: 'social-media-captions',
    templateId: 'distribution.social',
    name: 'Social Media Captions',
    description: 'Generate platform-specific social media captions, hashtags, and posting strategy.',
    category: 'distribution',
    inputMapper: (input) => ({
      film: input.input || input.film || '',
      platform: input.platform || 'all',
      tone: input.tone || 'engaging',
      audience: input.audience || '',
    }),
  },
  {
    module: 'distribution-promotion',
    task: 'promotion-strategy',
    templateId: 'distribution.strategy',
    name: 'Promotion Strategy',
    description: 'Design a comprehensive film promotion and marketing strategy.',
    category: 'distribution',
    inputMapper: (input) => ({
      film: input.input || input.film || '',
      budget: input.budget || 'low',
      genre: input.genre || '',
      timeline: input.timeline || '',
    }),
  },
  {
    module: 'distribution-promotion',
    task: 'copywriting',
    templateId: 'distribution.copywriting',
    name: 'Trailer/Poster Copywriting',
    description: 'Write taglines, poster copy, press releases, and promotional text.',
    category: 'distribution',
    inputMapper: (input) => ({
      film: input.input || input.film || '',
      genre: input.genre || '',
      tone: input.tone || '',
      format: input.format || 'all',
    }),
  },
]);

// ╔════════════════════════════════════════════════════════════════╗
// ║  MODULE 7: CINEMATIC PRE-VISUALIZATION                        ║
// ╚════════════════════════════════════════════════════════════════╝

workflowRegistry.registerBatch([
  {
    module: 'pre-visualization',
    task: 'shot-suggestions',
    templateId: 'previz.shots',
    name: 'Shot Suggestions',
    description: 'Suggest shot types, compositions, and visual storytelling techniques per scene.',
    category: 'previz',
    inputMapper: (input) => ({
      scene: input.input || input.scene || '',
      genre: input.genre || '',
      mood: input.mood || '',
    }),
  },
  {
    module: 'pre-visualization',
    task: 'camera-angles',
    templateId: 'previz.camera',
    name: 'Camera Angle Recommendations',
    description: 'Recommend camera angles, lens choices, and movement patterns for scenes.',
    category: 'previz',
    inputMapper: (input) => ({
      scene: input.input || input.scene || '',
      emotion: input.emotion || '',
      style: input.style || 'cinematic',
    }),
  },
  {
    module: 'pre-visualization',
    task: 'moodboard-prompts',
    templateId: 'previz.moodboard',
    name: 'Moodboard Prompts',
    description: 'Generate image generation prompts for creating visual moodboards.',
    category: 'previz',
    inputMapper: (input) => ({
      concept: input.input || input.concept || '',
      genre: input.genre || '',
      style: input.style || '',
      references: input.references || '',
    }),
  },
  {
    module: 'pre-visualization',
    task: 'lighting-suggestions',
    templateId: 'previz.lighting',
    name: 'Lighting Style Suggestions',
    description: 'Suggest lighting setups, styles, and equipment for each scene.',
    category: 'previz',
    inputMapper: (input) => ({
      scene: input.input || input.scene || '',
      mood: input.mood || '',
      genre: input.genre || '',
      location: input.location || '',
    }),
  },
  {
    module: 'pre-visualization',
    task: 'visual-storytelling',
    templateId: 'previz.visual-storytelling',
    name: 'Visual Storytelling Enhancement',
    description: 'Enhance narrative through visual metaphors, symbolism, and composition strategy.',
    category: 'previz',
    inputMapper: (input) => ({
      story: input.input || input.story || '',
      theme: input.theme || '',
      genre: input.genre || '',
    }),
  },
]);

module.exports = workflowRegistry;
