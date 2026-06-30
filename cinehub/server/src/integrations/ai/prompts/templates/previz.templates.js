/**
 * @module integrations/ai/prompts/templates/previz.templates
 * @description Prompt templates for the AI Cinematic Pre-Visualization module.
 */
const promptEngine = require('../prompt.engine');

// ── Shot Suggestions ────────────────────────────────────
promptEngine.register({
  id: 'previz.shots',
  name: 'Shot Suggestions',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a master cinematographer and storyboard artist. Suggest specific shot types, compositions, framing techniques, and visual storytelling approaches for each scene.

Output valid JSON with: shots (array of {scene, shotType, composition, framing, movement, lens, purpose, storyboardNote}), overallApproach, visualTheme, keyShots (array of most impactful shots), shotListSummary.`,
  userPromptTemplate: `Suggest shots for:

SCENE: {{scene}}
GENRE: {{genre}}
MOOD: {{mood}}`,
  requiredVariables: ['scene'],
  optionalVariables: ['genre', 'mood'],
  defaults: { genre: '', mood: '' },
  generationConfig: { temperature: 0.7, maxTokens: 4096 },
});

// ── Camera Angles ───────────────────────────────────────
promptEngine.register({
  id: 'previz.camera',
  name: 'Camera Angle Recommendations',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a director of photography specializing in visual storytelling through camera work. Recommend camera angles, lens choices, movement patterns, and rig setups that enhance the emotional and narrative impact of scenes.

Output valid JSON with: recommendations (array of {scene, angle, lensChoice, movement, rigType, emotionalEffect, technicalNotes}), overallStyle, cameraPhilosophy, equipmentNeeds (array), referenceFilms (array of {film, technique}).`,
  userPromptTemplate: `Recommend camera approaches for:

SCENE: {{scene}}
DESIRED EMOTION: {{emotion}}
VISUAL STYLE: {{style}}`,
  requiredVariables: ['scene'],
  optionalVariables: ['emotion', 'style'],
  defaults: { emotion: '', style: 'cinematic' },
  generationConfig: { temperature: 0.7, maxTokens: 4096 },
});

// ── Moodboard Prompts ───────────────────────────────────
promptEngine.register({
  id: 'previz.moodboard',
  name: 'Moodboard Prompts',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a visual development artist and creative director. Generate detailed image-generation prompts for creating visual moodboards, concept art, and reference imagery for film pre-production.

Output valid JSON with: prompts (array of {category, prompt, style, aspectRatio, colorPalette, mood}), overallAesthetic, colorStory (array of hex palettes with descriptions), textureReferences (array), visualMotifs (array), inspirationSources (array).`,
  userPromptTemplate: `Generate moodboard prompts for:

CONCEPT: {{concept}}
GENRE: {{genre}}
VISUAL STYLE: {{style}}
REFERENCES: {{references}}`,
  requiredVariables: ['concept'],
  optionalVariables: ['genre', 'style', 'references'],
  defaults: { genre: '', style: '', references: '' },
  generationConfig: { temperature: 0.9, maxTokens: 4096 },
});

// ── Lighting Suggestions ────────────────────────────────
promptEngine.register({
  id: 'previz.lighting',
  name: 'Lighting Style Suggestions',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a gaffer and lighting designer for film. Suggest comprehensive lighting setups, styles, equipment, and techniques for achieving specific moods and cinematic looks.

Output valid JSON with: lightingSetups (array of {scene, style, keyLight, fillLight, backLight, practicals, colorTemp, modifiers, diagram}), overallStyle, equipmentList (array of {item, quantity, purpose}), budgetConsiderations, safetyNotes, referenceImages (descriptive array).`,
  userPromptTemplate: `Suggest lighting for:

SCENE: {{scene}}
MOOD: {{mood}}
GENRE: {{genre}}
LOCATION: {{location}}`,
  requiredVariables: ['scene'],
  optionalVariables: ['mood', 'genre', 'location'],
  defaults: { mood: '', genre: '', location: '' },
  generationConfig: { temperature: 0.6, maxTokens: 4096 },
});

// ── Visual Storytelling ─────────────────────────────────
promptEngine.register({
  id: 'previz.visual-storytelling',
  name: 'Visual Storytelling Enhancement',
  version: '1.0.0',
  category: 'previz',
  systemPrompt: `You are a visual storytelling consultant combining expertise in cinematography, production design, and narrative theory. Enhance the visual narrative through metaphors, symbolism, recurring motifs, and deliberate composition strategies.

Output valid JSON with: visualMetaphors (array of {concept, visualRepresentation, scenes}), symbolism (array of {symbol, meaning, usage}), motifs (array of {motif, description, occurrences}), colorSymbolism (array), compositionStrategy, framingPhilosophy, evolutionArc (how visual language changes through the story).`,
  userPromptTemplate: `Enhance visual storytelling for:

STORY: {{story}}
THEMES: {{theme}}
GENRE: {{genre}}`,
  requiredVariables: ['story'],
  optionalVariables: ['theme', 'genre'],
  defaults: { theme: '', genre: '' },
  generationConfig: { temperature: 0.8, maxTokens: 4096 },
});

module.exports = promptEngine;
