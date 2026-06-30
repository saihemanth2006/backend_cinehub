/**
 * @module integrations/ai/prompts/templates/previz.prompts
 * @description Pre-Visualization module prompt templates
 */
const promptEngine = require('../prompt.engine');

// ── Shot Suggestions ─────────────────────────────────
promptEngine.register({
  id: 'previz.shot-suggestions',
  name: 'Shot Suggestions',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a cinematographer and visual director. Suggest camera shots and compositions that enhance storytelling, emotion, and visual impact.

Output valid JSON with: shots (array of {number, type, composition, rationale, mood, duration, alternatives}), shootingGuide, visualTechniques, emotionalImpact.`,
  userPromptTemplate: `Suggest shots for:

SCENE: {{scene}}
MOOD: {{mood}}
GENRE: {{genre}}
STYLE: {{style}}`,
  requiredVariables: ['scene'],
  optionalVariables: ['mood', 'genre', 'style'],
  defaults: { style: 'cinematic', mood: 'neutral' },
  generationConfig: { temperature: 0.8, maxTokens: 2048 },
});

// ── Camera Angles ────────────────────────────────────
promptEngine.register({
  id: 'previz.camera-angles',
  name: 'Camera Angles',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a visual effects director specializing in camera work. Recommend camera angles, movements, and positioning that amplify emotional resonance and visual storytelling.

Output valid JSON with: angles (array of {angle, type, description, psychologicalEffect, duration, notes}), movements (array of camera movements), positioning, emotionalGuidance.`,
  userPromptTemplate: `Recommend camera angles for:

DESCRIPTION: {{description}}
MOOD: {{mood}}
GENRE: {{genre}}
DURATION: {{duration}}`,
  requiredVariables: ['description'],
  optionalVariables: ['mood', 'genre', 'duration'],
  defaults: { mood: 'neutral' },
  generationConfig: { temperature: 0.8, maxTokens: 1536 },
});

// ── Moodboard Prompts ────────────────────────────────
promptEngine.register({
  id: 'previz.moodboard',
  name: 'Moodboard Prompts',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a visual designer creating moodboards. Generate detailed image prompts for AI image generation that capture the visual aesthetic, color, mood, and style of scenes.

Output valid JSON with: prompts (array of {number, description, style, colorPalette, mood, reference (optional), technique}), styleGuide, palette, inspirationNotes.`,
  userPromptTemplate: `Generate moodboard prompts for:

SCENE: {{scene}}
MOOD: {{mood}}
GENRE: {{genre}}
STYLE: {{style}}`,
  requiredVariables: ['scene'],
  optionalVariables: ['mood', 'genre', 'style'],
  defaults: { style: 'cinematic', mood: 'neutral' },
  generationConfig: { temperature: 0.8, maxTokens: 2048 },
});

// ── Lighting Style ───────────────────────────────────
promptEngine.register({
  id: 'previz.lighting',
  name: 'Lighting Style',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a lighting director and gaffer. Recommend lighting styles, setups, color temperatures, and techniques that enhance mood and cinematography.

Output valid JSON with: lightingStyle (description), setup (array of {type, position, intensity, color, purpose}), techniques (array), equipment, colorTemperature, motivations, emotionalImpact.`,
  userPromptTemplate: `Recommend lighting for:

DESCRIPTION: {{description}}
MOOD: {{mood}}
GENRE: {{genre}}
PURPOSE: {{purpose}}`,
  requiredVariables: ['description'],
  optionalVariables: ['mood', 'genre', 'purpose'],
  defaults: { mood: 'neutral' },
  generationConfig: { temperature: 0.7, maxTokens: 1536 },
});

// ── Visual Storytelling ──────────────────────────────
promptEngine.register({
  id: 'previz.visual-storytelling',
  name: 'Visual Storytelling',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a visual storytelling expert and narrative designer. Enhance visual storytelling techniques using composition, symbolism, color theory, and cinematic language.

Output valid JSON with: techniques (array of {technique, description, visualization, psychologicalEffect}), symbolism (array), colorTheory (guidance), composition, recommendations, emotionalArc.`,
  userPromptTemplate: `Enhance visual storytelling for:

STORY: {{story}}
GENRE: {{genre}}
TONE: {{tone}}
STYLE: {{style}}`,
  requiredVariables: ['story'],
  optionalVariables: ['genre', 'tone', 'style'],
  defaults: { style: 'cinematic', tone: 'balanced' },
  generationConfig: { temperature: 0.8, maxTokens: 2048 },
});

module.exports = promptEngine;
