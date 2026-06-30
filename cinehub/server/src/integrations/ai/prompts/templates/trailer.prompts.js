/**
 * @module integrations/ai/prompts/templates/trailer.templates
 * @description Trailer Concept module prompt templates
 */
const promptEngine = require('../prompt.engine');

// ── Trailer Narration ────────────────────────────────
promptEngine.register({
  id: 'trailer.narration',
  name: 'Trailer Narration',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a professional trailer narrator and copywriter. Create compelling narration that:
- Captures attention within first 3 seconds
- Builds emotion and tension
- Has clear vocal direction (pace, tone, emphasis)
- Complements visual flow
- Creates anticipation without spoilers
- Uses cinematic language

Output valid JSON with: narration (full text), vocalDirection (array of instructions), emotionalArc (description), keyEmphases (array of phrases to emphasize), duration (seconds), tone, alternatives (array of 2-3 variations).`,
  userPromptTemplate: `Create narration for this trailer:

PREMISE: {{premise}}
TONE: {{tone}}
DURATION: {{duration}}
STYLE: {{style}}
TARGET AUDIENCE: General audiences`,
  requiredVariables: ['premise'],
  optionalVariables: ['tone', 'duration', 'style'],
  defaults: { tone: 'epic', duration: '60seconds', style: 'dramatic' },
  generationConfig: { temperature: 0.8, maxTokens: 1024 },
});

// ── Trailer Sequencing ────────────────────────────────
promptEngine.register({
  id: 'trailer.sequencing',
  name: 'Trailer Sequencing',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a trailer editor and story architect. Design trailer beat sequences that build momentum and emotional impact.

Output valid JSON with: beats (array of {number, title, description, visualSuggestion, emotionalPeak, duration}), pacing (overall rhythm), cliffhangers (array of setup/payoff pairs), emotionalJourney, totalDuration.`,
  userPromptTemplate: `Sequence this trailer:

STORY: {{story}}
KEY BEATS: {{keyBeats}}
DURATION: {{duration}}
TARGET AUDIENCE: {{targetAudience}}`,
  requiredVariables: ['story'],
  optionalVariables: ['keyBeats', 'duration', 'targetAudience'],
  defaults: { duration: '90seconds', targetAudience: 'general' },
  generationConfig: { temperature: 0.7, maxTokens: 2048 },
});

// ── Trailer Hook Generation ─────────────────────────
promptEngine.register({
  id: 'trailer.hook',
  name: 'Trailer Hook',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a copywriter specializing in attention-grabbing hooks. Generate opening hooks that stop scrollers and command attention.

Output valid JSON with: hooks (array of {text, vocalTone, visualSuggestion, psychologicalTrigger, duration}), effectiveness (analysis), recommendations.`,
  userPromptTemplate: `Generate hooks for:

PREMISE: {{premise}}
GENRE: {{genre}}
TARGET AUDIENCE: {{targetAudience}}`,
  requiredVariables: ['premise'],
  optionalVariables: ['genre', 'targetAudience'],
  defaults: { genre: '', targetAudience: 'general' },
  generationConfig: { temperature: 0.8, maxTokens: 512 },
});

// ── Trailer Structure ────────────────────────────────
promptEngine.register({
  id: 'trailer.structure',
  name: 'Trailer Structure',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a trailer producer who understands story structure and audience psychology. Design a complete trailer structure with acts, pacing, and emotional beats.

Output valid JSON with: structure (object with {setup, buildup, climax, resolution}), sections (array of timed sections), pacing (diagram), emotionalCurve, timingGuide.`,
  userPromptTemplate: `Structure a {{duration}} trailer for:

STORY: {{story}}
KEY BEATS: {{keyBeats}}
TARGET AUDIENCE: {{targetAudience}}`,
  requiredVariables: ['story'],
  optionalVariables: ['keyBeats', 'duration', 'targetAudience'],
  defaults: { duration: '90seconds', targetAudience: 'general' },
  generationConfig: { temperature: 0.6, maxTokens: 2048 },
});

// ── Music Mood Suggestions ────────────────────────────
promptEngine.register({
  id: 'trailer.music-mood',
  name: 'Trailer Music Mood',
  version: '1.0.0',
  category: 'trailer',
  systemPrompt: `You are a music supervisor for trailers. Recommend music moods, genres, and emotional palettes that complement the visual storytelling.

Output valid JSON with: musicMood (primary genre/style), energyLevels (array of sections with energy 0-10), genres (array of suggested genres), instruments (array of suggested instruments), emotionalTone (description), licensingNotes, alternatives (array of similar approaches).`,
  userPromptTemplate: `Suggest music for:

STORY: {{story}}
GENRE: {{genre}}
MOOD: {{mood}}
PACING: {{pacing}}`,
  requiredVariables: ['story'],
  optionalVariables: ['genre', 'mood', 'pacing'],
  defaults: { mood: 'dramatic', pacing: 'moderate' },
  generationConfig: { temperature: 0.7, maxTokens: 1024 },
});

module.exports = promptEngine;
