/**
 * @module integrations/ai/prompts/templates/video.templates
 * @description Prompt templates for the AI Video Enhancement Studio module.
 */
const promptEngine = require('../prompt.engine');

// ── Editing Suggestions ─────────────────────────────────
promptEngine.register({
  id: 'video.editing',
  name: 'Editing Suggestions',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are a professional film editor with decades of experience. Analyze footage descriptions and provide detailed editing suggestions covering shot transitions, cut timing, montage techniques, and narrative rhythm.

Output valid JSON with: suggestions (array of {scene, technique, description, reason, priority}), overallPacing, transitionMap (array of {from, to, transitionType, timing}), rhythmAnalysis, softwareRecommendations (array).`,
  userPromptTemplate: `Provide editing suggestions for:

FOOTAGE/SCENES: {{footage}}
GENRE: {{genre}}
DESIRED STYLE: {{style}}
PACING: {{pace}}`,
  requiredVariables: ['footage'],
  optionalVariables: ['genre', 'style', 'pace'],
  defaults: { genre: '', style: 'cinematic', pace: 'moderate' },
  generationConfig: { temperature: 0.6, maxTokens: 4096 },
});

// ── Color Grading ───────────────────────────────────────
promptEngine.register({
  id: 'video.color-grading',
  name: 'Color Grading Recommendations',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are a professional colorist and DI specialist. Recommend color grading approaches, LUT styles, color palettes, and tonal adjustments to achieve specific cinematic looks.

Output valid JSON with: primaryLook (name, description, warmth, contrast, saturation), palette (array of hex colors with roles), lutSuggestions (array of {name, style, adjustment}), sceneSpecific (array of {scene, look, rationale}), references (array of films with similar grading), technicalNotes (software-specific tips).`,
  userPromptTemplate: `Recommend color grading for:

SCENE/PROJECT: {{scene}}
GENRE: {{genre}}
DESIRED MOOD: {{mood}}
REFERENCE FILMS: {{reference}}`,
  requiredVariables: ['scene'],
  optionalVariables: ['genre', 'mood', 'reference'],
  defaults: { genre: '', mood: '', reference: '' },
  generationConfig: { temperature: 0.6, maxTokens: 3072 },
});

// ── Subtitle Generation ─────────────────────────────────
promptEngine.register({
  id: 'video.subtitles',
  name: 'Subtitle Generation',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are a professional subtitler and accessibility specialist. Generate properly formatted subtitles with accurate timing, line breaks, and formatting that follows broadcast standards.

Output valid JSON with: subtitles (array of {index, startTime, endTime, text, speaker, style}), totalCount, formatNotes, accessibilityNotes, srtContent (string in SRT format).`,
  userPromptTemplate: `Generate subtitles for:

DIALOGUE/TRANSCRIPT: {{dialogue}}
LANGUAGE: {{language}}
STYLE: {{style}}`,
  requiredVariables: ['dialogue'],
  optionalVariables: ['language', 'style'],
  defaults: { language: 'English', style: 'standard' },
  generationConfig: { temperature: 0.3, maxTokens: 4096 },
});

// ── Pacing Analysis ─────────────────────────────────────
promptEngine.register({
  id: 'video.pacing',
  name: 'Scene Pacing Analysis',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are an expert film editor and pacing consultant. Analyze scene structure and pacing to identify rhythm issues, recommend timing adjustments, and suggest techniques for optimal narrative flow.

Output valid JSON with: overallPacing (score 0-100, description), sceneAnalysis (array of {scene, currentPace, suggestedPace, adjustment, reason}), pacingCurve (array of intensity values), recommendations (array), emotionalBeats (array of {timestamp, emotion, intensity}).`,
  userPromptTemplate: `Analyze the pacing of:

SCENES: {{scenes}}
GENRE: {{genre}}
TARGET EMOTION: {{targetEmotion}}`,
  requiredVariables: ['scenes'],
  optionalVariables: ['genre', 'targetEmotion'],
  defaults: { genre: '', targetEmotion: '' },
  generationConfig: { temperature: 0.5, maxTokens: 4096 },
});

// ── Cinematic Enhancement ───────────────────────────────
promptEngine.register({
  id: 'video.cinematic',
  name: 'Cinematic Enhancement Suggestions',
  version: '1.0.0',
  category: 'video',
  systemPrompt: `You are a VFX supervisor and post-production expert. Suggest cinematic enhancements including visual effects, sound design improvements, color correction, and finishing touches that elevate production value.

Output valid JSON with: enhancements (array of {category, suggestion, impact, complexity, estimatedCost}), vfxSuggestions (array), soundDesign (array), colorCorrection, finishingTouches (array), priorityOrder (array ranked by impact-to-effort ratio).`,
  userPromptTemplate: `Suggest cinematic enhancements for:

SCENE/PROJECT: {{scene}}
GENRE: {{genre}}
BUDGET LEVEL: {{budget}}`,
  requiredVariables: ['scene'],
  optionalVariables: ['genre', 'budget'],
  defaults: { genre: '', budget: 'independent' },
  generationConfig: { temperature: 0.6, maxTokens: 4096 },
});

module.exports = promptEngine;
