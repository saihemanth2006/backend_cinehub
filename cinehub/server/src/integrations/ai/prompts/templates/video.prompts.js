/**
 * @module integrations/ai/prompts/templates/video.prompts
 * @description Video Enhancement module prompt templates
 */
const promptEngine = require('../prompt.engine');

// ── Editing Suggestions ──────────────────────────────
promptEngine.register({
  id: 'video.editing',
  name: 'Editing Suggestions',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are an experienced film editor and pacing specialist. Provide editing suggestions that enhance storytelling, pacing, and emotional impact.

Output valid JSON with: suggestions (array of {scene, approach, rationale, alternatives, estimatedImpact}), pacingGuide (overall rhythm), transitions (recommendations), jumpCuts (usage guide), totalTime.`,
  userPromptTemplate: `Provide editing suggestions for:

CONTENT DESCRIPTION: {{description}}
GENRE: {{genre}}
DURATION: {{duration}}
STYLE: {{style}}
TARGET AUDIENCE: General viewers`,
  requiredVariables: ['description'],
  optionalVariables: ['genre', 'duration', 'style'],
  defaults: { style: 'cinematic', genre: '' },
  generationConfig: { temperature: 0.7, maxTokens: 2048 },
});

// ── Color Grading Recommendations ────────────────────
promptEngine.register({
  id: 'video.color-grading',
  name: 'Color Grading',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are a colorist and color grading specialist. Recommend color palettes, LUTs, grading approach, and color correction that enhance mood and storytelling.

Output valid JSON with: colorPalette (primary colors with hex codes), mood (description), lutRecommendations (array of suggested LUT styles), gradingApproach (step-by-step), toneMapping, contrastGuide, saturationGuide, emotionalImpact.`,
  userPromptTemplate: `Recommend color grading for:

DESCRIPTION: {{description}}
MOOD: {{mood}}
GENRE: {{genre}}
TONE: {{tone}}`,
  requiredVariables: ['description'],
  optionalVariables: ['mood', 'genre', 'tone'],
  defaults: { mood: 'neutral', tone: 'balanced' },
  generationConfig: { temperature: 0.7, maxTokens: 1536 },
});

// ── Subtitle Generation ──────────────────────────────
promptEngine.register({
  id: 'video.subtitles',
  name: 'Subtitle Generation',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are a professional subtitle editor and translator. Create clear, properly timed, and contextually accurate subtitles that enhance accessibility and comprehension.

Output valid JSON with: subtitles (array of {timecode, startMs, endMs, text, speakerInfo}), notes (special considerations), audioCues (music/sound effects if needed), readingPace, accuracy.`,
  userPromptTemplate: `Generate subtitles for:

CONTENT: {{content}}
LANGUAGE: {{language}}
TONE: {{tone}}
TARGET AUDIENCE: {{targetAudience}}`,
  requiredVariables: ['content'],
  optionalVariables: ['language', 'tone', 'targetAudience'],
  defaults: { language: 'English', tone: 'neutral' },
  generationConfig: { temperature: 0.3, maxTokens: 4096 },
});

// ── Scene Pacing Analysis ────────────────────────────
promptEngine.register({
  id: 'video.pacing',
  name: 'Pacing Analysis',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are a film pacing expert. Analyze scene timing, rhythms, and flow. Recommend pacing adjustments for optimal emotional impact and audience engagement.

Output valid JSON with: analysis (current pacing assessment), recommendations (array of {scene, current, recommended, rationale}), rhythmGraph (pacing chart), emotionalFlow, engagementPrediction.`,
  userPromptTemplate: `Analyze pacing for:

SCRIPT: {{script}}
DURATION: {{duration}}
GENRE: {{genre}}
TARGET AUDIENCE: {{targetAudience}}`,
  requiredVariables: ['script'],
  optionalVariables: ['duration', 'genre', 'targetAudience'],
  defaults: { genre: '' },
  generationConfig: { temperature: 0.6, maxTokens: 2048 },
});

// ── Cinematic Enhancement ────────────────────────────
promptEngine.register({
  id: 'video.cinematic',
  name: 'Cinematic Enhancement',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are a visual effects and cinematic specialist. Suggest techniques, effects, and enhancements that elevate production value and cinematic quality.

Output valid JSON with: suggestions (array of {type, description, purpose, difficulty, estimatedCost}), techniques (array of cinematic techniques), effectsRecommendations (array), postProductionNotes, qualityImpactEstimate.`,
  userPromptTemplate: `Suggest cinematic enhancements for:

DESCRIPTION: {{description}}
GENRE: {{genre}}
STYLE: {{style}}
BUDGET LEVEL: {{budgetLevel}}`,
  requiredVariables: ['description'],
  optionalVariables: ['genre', 'style', 'budgetLevel'],
  defaults: { style: 'cinematic', budgetLevel: 'medium' },
  generationConfig: { temperature: 0.8, maxTokens: 2048 },
});

module.exports = promptEngine;
