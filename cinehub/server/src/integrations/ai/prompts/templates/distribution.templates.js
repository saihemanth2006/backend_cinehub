/**
 * @module integrations/ai/prompts/templates/distribution.templates
 * @description Prompt templates for the AI Distribution & Promotion Engine module.
 */
const promptEngine = require('../prompt.engine');

// ── Festival Recommendations ────────────────────────────
promptEngine.register({
  id: 'distribution.festivals',
  name: 'Festival Recommendations',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a film festival strategy consultant with deep knowledge of the global festival circuit. Recommend appropriate festivals based on film genre, length, budget, and premiere status.

Output valid JSON with: festivals (array of {name, location, deadline, tier, fit (0-100), reason, category, premierStatus, submissionFee, website}), submissionStrategy, premierePlan, timeline, budgetForSubmissions.`,
  userPromptTemplate: `Recommend festivals for:

FILM: {{film}}
GENRE: {{genre}}
LENGTH: {{length}}
BUDGET: {{budget}}
PREFERRED REGION: {{region}}`,
  requiredVariables: ['film'],
  optionalVariables: ['genre', 'length', 'budget', 'region'],
  defaults: { genre: '', length: '', budget: '', region: 'global' },
  generationConfig: { temperature: 0.5, maxTokens: 4096 },
});

// ── Audience Targeting ──────────────────────────────────
promptEngine.register({
  id: 'distribution.audience',
  name: 'Audience Targeting',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a film marketing and distribution strategist. Identify target audience demographics, psychographics, viewing habits, and optimal distribution channels.

Output valid JSON with: primaryAudience (demographics, psychographics, size), secondaryAudiences (array), viewingHabits, platformRecommendations (array of {platform, fit, reason}), marketingChannels (array), comparableFilmAudiences (array), engagementStrategy.`,
  userPromptTemplate: `Identify the target audience for:

FILM: {{film}}
GENRE: {{genre}}
LOGLINE: {{logline}}`,
  requiredVariables: ['film'],
  optionalVariables: ['genre', 'logline'],
  defaults: { genre: '', logline: '' },
  generationConfig: { temperature: 0.6, maxTokens: 3072 },
});

// ── Social Media Captions ───────────────────────────────
promptEngine.register({
  id: 'distribution.social',
  name: 'Social Media Captions',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a social media strategist specializing in film promotion. Create platform-specific content including captions, hashtags, posting schedules, and engagement strategies for Instagram, TikTok, X/Twitter, YouTube, and Facebook.

Output valid JSON with: instagram (array of {caption, hashtags, contentType, bestTime}), tiktok (array of {caption, hashtags, hookIdea, soundSuggestion}), twitter (array of {tweet, hashtags}), youtube (array of {title, description, tags}), contentCalendar (array of {day, platform, contentType, caption}), overallStrategy.`,
  userPromptTemplate: `Create social media content for:

FILM: {{film}}
PLATFORM FOCUS: {{platform}}
TONE: {{tone}}
TARGET AUDIENCE: {{audience}}`,
  requiredVariables: ['film'],
  optionalVariables: ['platform', 'tone', 'audience'],
  defaults: { platform: 'all', tone: 'engaging', audience: '' },
  generationConfig: { temperature: 0.8, maxTokens: 4096 },
});

// ── Promotion Strategy ──────────────────────────────────
promptEngine.register({
  id: 'distribution.strategy',
  name: 'Promotion Strategy',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a film marketing executive. Design comprehensive promotional campaigns including pre-release, release, and post-release strategies across digital and traditional channels.

Output valid JSON with: phases (array of {phase, duration, activities (array), budget, kpis}), channels (array of {channel, strategy, budget}), timeline, totalBudget, keyMessages (array), pressStrategy, communityBuilding, metrics.`,
  userPromptTemplate: `Design a promotion strategy for:

FILM: {{film}}
MARKETING BUDGET: {{budget}}
GENRE: {{genre}}
TIMELINE: {{timeline}}`,
  requiredVariables: ['film'],
  optionalVariables: ['budget', 'genre', 'timeline'],
  defaults: { budget: 'low', genre: '', timeline: '' },
  generationConfig: { temperature: 0.6, maxTokens: 4096 },
});

// ── Copywriting ─────────────────────────────────────────
promptEngine.register({
  id: 'distribution.copywriting',
  name: 'Trailer/Poster Copywriting',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a film copywriter and creative director. Write compelling taglines, poster text, press releases, synopsis variations, and promotional copy that captures the essence of a film.

Output valid JSON with: taglines (array of {text, style, usage}), posterCopy (array of {headline, subline, bodyText}), pressRelease (full formatted text), synopsis (short/medium/long versions), elevatorPitch, socialBios (object by platform), emailBlurb.`,
  userPromptTemplate: `Write promotional copy for:

FILM: {{film}}
GENRE: {{genre}}
TONE: {{tone}}
FORMAT FOCUS: {{format}}`,
  requiredVariables: ['film'],
  optionalVariables: ['genre', 'tone', 'format'],
  defaults: { genre: '', tone: '', format: 'all' },
  generationConfig: { temperature: 0.8, maxTokens: 4096 },
});

module.exports = promptEngine;
