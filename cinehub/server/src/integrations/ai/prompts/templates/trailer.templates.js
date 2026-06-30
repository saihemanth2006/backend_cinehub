/**
 * @module integrations/ai/prompts/templates/trailer.templates
 * @description Prompt templates for the AI Trailer Concept Generator module.
 */
const promptEngine = require('../prompt.engine');

// ── Trailer Narration ───────────────────────────────────
promptEngine.register({
  id: 'trailer.narration',
  name: 'Trailer Narration',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are an award-winning trailer narrator and copywriter. Write compelling, cinematic voiceover narration for film trailers. Your narrations build tension, emotion, and intrigue. Match the tone to the genre.

Output valid JSON with: narration (full text with timing cues), segments (array of {text, timing, emotion, intensity}), tagline, alternateVersions (array of shorter versions), voiceDirection (tone/style notes for the narrator).`,
  userPromptTemplate: `Write trailer narration for this film:

STORY: {{story}}
GENRE: {{genre}}
TONE: {{tone}}
TARGET DURATION: {{duration}}`,
  requiredVariables: ['story'],
  optionalVariables: ['genre', 'tone', 'duration'],
  defaults: { genre: 'drama', tone: 'epic and dramatic', duration: '90 seconds' },
  generationConfig: { temperature: 0.8, maxTokens: 3072 },
});

// ── Trailer Sequencing ──────────────────────────────────
promptEngine.register({
  id: 'trailer.sequencing',
  name: 'Trailer Sequencing',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a master trailer editor. Design the visual sequence and shot order for film trailers. Consider pacing, reveals, emotional beats, and audience engagement.

Output valid JSON with: sequence (array of {shotNumber, description, duration, visualType, audioNote, emotionalBeat}), totalDuration, pacingNotes, transitionSuggestions (array), musicCues (array).`,
  userPromptTemplate: `Design the trailer sequence for:

STORY: {{story}}
GENRE: {{genre}}
KEY MOMENTS: {{keyMoments}}
TARGET DURATION: {{duration}}`,
  requiredVariables: ['story'],
  optionalVariables: ['genre', 'keyMoments', 'duration'],
  defaults: { genre: '', keyMoments: '', duration: '120 seconds' },
  generationConfig: { temperature: 0.7, maxTokens: 4096 },
});

// ── Hook Generation ─────────────────────────────────────
promptEngine.register({
  id: 'trailer.hooks',
  name: 'Trailer Hooks',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a viral marketing expert specializing in film trailers. Generate attention-grabbing opening hooks, taglines, and text cards that make viewers unable to look away.

Output valid JSON with: openingHooks (array of {text, type, targetEmotion}), taglines (array of {text, style}), textCards (array of {text, placement, duration}), socialHooks (array for social media teasers).`,
  userPromptTemplate: `Generate trailer hooks for:

STORY: {{story}}
GENRE: {{genre}}
TARGET AUDIENCE: {{audience}}`,
  requiredVariables: ['story'],
  optionalVariables: ['genre', 'audience'],
  defaults: { genre: '', audience: 'general' },
  generationConfig: { temperature: 0.9, maxTokens: 2048 },
});

// ── Trailer Structure ───────────────────────────────────
promptEngine.register({
  id: 'trailer.structure',
  name: 'Cinematic Trailer Structure',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a cinematic trailer architect. Design complete trailer structures with acts, beats, pacing curves, and emotional arcs. Consider industry best practices for maximum impact.

Output valid JSON with: structure (object with acts array, each containing {actNumber, name, duration, beats (array), emotionalArc, pacingLevel}), overallArc, climaxMoment, revelationOrder (array), musicStructure, editingRhythm.`,
  userPromptTemplate: `Design a trailer structure for:

STORY: {{story}}
GENRE: {{genre}}
STYLE: {{style}}`,
  requiredVariables: ['story'],
  optionalVariables: ['genre', 'style'],
  defaults: { genre: '', style: 'classic three-act' },
  generationConfig: { temperature: 0.7, maxTokens: 4096 },
});

// ── Music Mood Suggestions ──────────────────────────────
promptEngine.register({
  id: 'trailer.music-mood',
  name: 'Music Mood Suggestions',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a film music supervisor and composer consultant. Suggest music styles, moods, instruments, tempo, and reference tracks for trailer segments. Consider emotional progression and industry trends.

Output valid JSON with: overallMood, segments (array of {section, mood, tempo, instruments, energyLevel, referenceStyle}), transitions (array), soundDesign (array of effects/stingers), licensingSuggestions (genres/libraries to explore), spotifyMoodKeywords (array).`,
  userPromptTemplate: `Suggest trailer music for:

STORY: {{story}}
GENRE: {{genre}}
TRAILER TONE: {{trailerTone}}`,
  requiredVariables: ['story'],
  optionalVariables: ['genre', 'trailerTone'],
  defaults: { genre: '', trailerTone: '' },
  generationConfig: { temperature: 0.7, maxTokens: 3072 },
});

module.exports = promptEngine;
