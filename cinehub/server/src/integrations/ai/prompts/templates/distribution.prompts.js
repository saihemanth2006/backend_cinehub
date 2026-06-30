/**
 * @module integrations/ai/prompts/templates/distribution.prompts
 * @description Distribution & Promotion module prompt templates
 */
const promptEngine = require('../prompt.engine');

// ── Festival Recommendations ─────────────────────────
promptEngine.register({
  id: 'distribution.festival-recommendations',
  name: 'Festival Recommendations',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a festival consultant and distribution strategist. Recommend festivals, competitions, and platforms that match the project profile and maximize exposure.

Output valid JSON with: festivals (array of {name, tier (Tier1/Tier2/Tier3), fit (%), deadlines, benefits, notes}), strategy (submission timeline), alternatives (by region/genre).`,
  userPromptTemplate: `Recommend festivals for:

PROJECT: {{project}}
GENRE: {{genre}}
DURATION: {{duration}}
THEME: {{theme}}`,
  requiredVariables: ['project'],
  optionalVariables: ['genre', 'duration', 'theme'],
  defaults: {},
  generationConfig: { temperature: 0.7, maxTokens: 2048 },
});

// ── Audience Targeting ────────────────────────────────
promptEngine.register({
  id: 'distribution.audience-targeting',
  name: 'Audience Targeting',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a marketing strategist specializing in film audience segmentation. Define target audiences, demographics, psychographics, and platform strategies.

Output valid JSON with: audiences (array of {segment, demographics, psychographics, interests, platforms, messaging}), primaryAudience, secondaryAudiences, platformStrategy, budget.`,
  userPromptTemplate: `Target audiences for:

PROJECT: {{project}}
GENRE: {{genre}}
DEMOGRAPHICS: {{demographics}}
PLATFORMS: {{platforms}}`,
  requiredVariables: ['project'],
  optionalVariables: ['genre', 'demographics', 'platforms'],
  defaults: {},
  generationConfig: { temperature: 0.7, maxTokens: 1536 },
});

// ── Social Media Captions ────────────────────────────
promptEngine.register({
  id: 'distribution.social-captions',
  name: 'Social Media Captions',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a social media strategist and copywriter. Generate engaging captions optimized for each platform with hooks, CTAs, and hashtag strategies.

Output valid JSON with: captions (array of {platform, caption, characterCount, hashtags, emoji, cta (call-to-action), bestTimeToPost}), performance (estimated engagement).`,
  userPromptTemplate: `Generate captions for {{platform}}:

CONTENT: {{content}}
PLATFORM: {{platform}}
TONE: {{tone}}
TARGET AUDIENCE: General audience`,
  requiredVariables: ['content'],
  optionalVariables: ['platform', 'tone'],
  defaults: { platform: 'instagram', tone: 'engaging' },
  generationConfig: { temperature: 0.8, maxTokens: 1024 },
});

// ── Promotion Strategy ───────────────────────────────
promptEngine.register({
  id: 'distribution.promotion-strategy',
  name: 'Promotion Strategy',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a film marketing director. Create comprehensive promotion strategies spanning pre-release, release, and post-release phases with multi-channel approaches.

Output valid JSON with: strategy (phases), channels (array of {channel, timeline, activities, budget, expectedReach}), timeline (calendar), budget, kpis, alternatives.`,
  userPromptTemplate: `Create promotion strategy for:

PROJECT: {{project}}
GENRE: {{genre}}
TARGET AUDIENCE: {{targetAudience}}
BUDGET: {{budget}}`,
  requiredVariables: ['project'],
  optionalVariables: ['genre', 'targetAudience', 'budget'],
  defaults: { budget: 'medium' },
  generationConfig: { temperature: 0.7, maxTokens: 3096 },
});

// ── Copywriting ──────────────────────────────────────
promptEngine.register({
  id: 'distribution.copywriting',
  name: 'Copywriting',
  version: '1.0.0',
  category: 'distribution',
  systemPrompt: `You are a film marketing copywriter. Generate compelling marketing copy for various assets (posters, trailers, social, press kits) that captures essence and drives interest.

Output valid JSON with: copy (main text), alternatives (array of variations), keyPoints (array of selling points), emotionalAngle, callToAction, targetAudience.`,
  userPromptTemplate: `Generate {{asset}} copy for:

PROJECT: {{project}}
GENRE: {{genre}}
TONE: {{tone}}
ASSET TYPE: {{asset}}`,
  requiredVariables: ['project'],
  optionalVariables: ['genre', 'tone', 'asset'],
  defaults: { asset: 'poster', tone: 'engaging' },
  generationConfig: { temperature: 0.8, maxTokens: 1024 },
});

module.exports = promptEngine;
