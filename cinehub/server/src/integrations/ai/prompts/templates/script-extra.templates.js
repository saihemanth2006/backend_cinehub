/**
 * @module integrations/ai/prompts/templates/script-extra.templates
 * @description Additional script development templates not covered in the original registry.
 * (Story expansion, dialogue enhancement, character development, scene breakdown)
 */
const promptEngine = require('../prompt.engine');

// ── Story Expansion ─────────────────────────────────────
promptEngine.register({
  id: 'script.story-expansion',
  name: 'Story Expansion',
  version: '1.0.0',
  category: 'script',
  systemPrompt: `You are a master storyteller and development executive. Expand a brief concept into a comprehensive story outline with a three-act structure, character arcs, turning points, themes, and subplots.

Output valid JSON with: title, logline, threeActStructure (object with act1, act2, act3 each containing {summary, turningPoint, scenes (array)}), characters (array of {name, role, arc, motivation}), themes (array), subplots (array of {description, characters}), worldBuilding, estimatedRuntime, genre, tone.`,
  userPromptTemplate: `Expand this concept into a full story:

CONCEPT: {{concept}}
GENRE: {{genre}}
TONE: {{tone}}
TARGET FORMAT: {{targetLength}}`,
  requiredVariables: ['concept'],
  optionalVariables: ['genre', 'tone', 'targetLength'],
  defaults: { genre: 'drama', tone: 'cinematic', targetLength: 'feature' },
  generationConfig: { temperature: 0.8, maxTokens: 6144 },
});

// ── Dialogue Enhancement ────────────────────────────────
promptEngine.register({
  id: 'script.dialogue-enhancement',
  name: 'Dialogue Enhancement',
  version: '1.0.0',
  category: 'script',
  systemPrompt: `You are a dialogue specialist and script doctor. Refine and improve dialogue for authenticity, subtext, rhythm, and unique character voice. Make every line serve the story.

Output valid JSON with: enhancedDialogue (full revised text), changes (array of {original, revised, reason, technique}), characterVoiceNotes (array of {character, voiceDescription, speechPatterns}), subtextAnalysis (array), overallNotes, dialogueScore (before/after 0-100).`,
  userPromptTemplate: `Enhance this dialogue:

DIALOGUE: {{dialogue}}
GENRE: {{genre}}
CHARACTERS: {{characters}}
DIRECTION: {{direction}}`,
  requiredVariables: ['dialogue'],
  optionalVariables: ['genre', 'characters', 'direction'],
  defaults: { genre: '', characters: '', direction: 'natural and cinematic' },
  generationConfig: { temperature: 0.7, maxTokens: 4096 },
});

// ── Character Development ───────────────────────────────
promptEngine.register({
  id: 'script.character-development',
  name: 'Character Development',
  version: '1.0.0',
  category: 'script',
  systemPrompt: `You are a character psychologist and story architect. Create deeply layered character profiles with backstory, psychology, motivations, flaws, growth arc, relationships, and unique voice.

Output valid JSON with: profile (object with name, fullName, age, occupation, physicalDescription), psychology (fears, desires, wounds, beliefs, contradictions), backstory, motivation, flaw, arc (beginning, midpoint, end, transformation), relationships (array of {character, dynamic, evolution}), voice (speechStyle, vocabulary, quirks), symbolism, castingNotes.`,
  userPromptTemplate: `Develop this character:

CHARACTER: {{character}}
STORY CONTEXT: {{story}}
GENRE: {{genre}}
ROLE IN STORY: {{role}}`,
  requiredVariables: ['character'],
  optionalVariables: ['story', 'genre', 'role'],
  defaults: { story: '', genre: '', role: 'protagonist' },
  generationConfig: { temperature: 0.8, maxTokens: 4096 },
});

// ── Scene Breakdown ─────────────────────────────────────
promptEngine.register({
  id: 'script.scene-breakdown',
  name: 'Scene Breakdown',
  version: '1.0.0',
  category: 'script',
  systemPrompt: `You are a first assistant director specializing in script breakdowns. Analyze scripts and create detailed scene-by-scene breakdowns for production planning.

Output valid JSON with: scenes (array of {sceneNumber, slugline, intExt, dayNight, location, characters (array), extras, props (array), wardrobe (array), specialEffects (array), vehicles, animals, estimatedDuration, notes, pageCount}), totalScenes, uniqueLocations (array), castBreakdown, productionNotes.`,
  userPromptTemplate: `Break down this script:

SCRIPT: {{script}}
FORMAT: {{format}}`,
  requiredVariables: ['script'],
  optionalVariables: ['format'],
  defaults: { format: 'detailed' },
  generationConfig: { temperature: 0.3, maxTokens: 6144 },
});

// ── Genre Analysis ──────────────────────────────────────
promptEngine.register({
  id: 'script.genre-analysis',
  name: 'Genre Analysis',
  version: '1.0.0',
  category: 'script',
  systemPrompt: `You are a film genre analysis expert. Analyze scripts and story ideas to classify them accurately. Identify genre elements, comparable films, audience profiles, and market viability.

Output valid JSON with: primaryGenre, subGenres (array), genreConfidence (0-1), genreElements (array), comparableFilms (array), audienceProfile, marketViability, toneAnalysis.`,
  userPromptTemplate: `Analyze the genre classification for this story:

CONTENT: {{content}}
GENRE: {{genre}}`,
  requiredVariables: ['content'],
  optionalVariables: ['genre'],
  defaults: { genre: '' },
  generationConfig: { temperature: 0.5, maxTokens: 3072 },
});

module.exports = promptEngine;
