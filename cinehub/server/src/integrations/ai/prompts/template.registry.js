/**
 * @module integrations/ai/prompts/template.registry
 * @description Pre-registers all CineHub prompt templates with the PromptEngine.
 * Import this module at startup to make all templates available.
 */
const promptEngine = require('./prompt.engine');

// ── Script Generation Template ──────────────────────────

promptEngine.register({
  id: 'script.generate',
  name: 'Script Generation',
  version: '2.0.0',
  category: 'script',
  systemPrompt: `You are a world-class screenwriter specializing in {{genre}} {{format}} scripts. You produce industry-standard scripts following proper formatting conventions.

Output must be valid JSON with: title, logline, synopsis, content (full screenplay format), characters (array), scenes (array), themes (array), estimatedRuntime (number).`,
  userPromptTemplate: `Generate a {{format}} in the {{genre}} genre.

PREMISE: {{prompt}}
TARGET LENGTH: {{lengthGuide}}
TONE: {{tone}}
{{characterSection}}
{{additionalContext}}`,
  requiredVariables: ['prompt', 'format', 'genre'],
  optionalVariables: ['tone', 'lengthGuide', 'characterSection', 'additionalContext'],
  defaults: {
    tone: 'balanced',
    lengthGuide: '15-30 pages',
    characterSection: '',
    additionalContext: '',
  },
  generationConfig: {
    temperature: 0.8,
    maxTokens: 8192,
  },
  estimatedTokens: 6000,
});

// ── Story Enhancement Template ──────────────────────────

promptEngine.register({
  id: 'script.enhance',
  name: 'Story Enhancement',
  version: '1.0.0',
  category: 'script',
  systemPrompt: `You are an expert story consultant and script doctor. Analyze the script for structural weaknesses, character depth, dialogue quality, pacing issues, and thematic coherence. Provide specific, actionable feedback.

Output valid JSON with: overallScore (0-100), strengths (array), weaknesses (array), suggestions (array of objects with area, severity, description, example), enhancedLogline, paceAnalysis, characterNotes.`,
  userPromptTemplate: `Analyze and enhance this {{genre}} script:

LOGLINE: {{logline}}

SCRIPT:
{{content}}

{{focusAreas}}`,
  requiredVariables: ['content'],
  optionalVariables: ['logline', 'genre', 'focusAreas'],
  defaults: { logline: 'Not provided', genre: '', focusAreas: '' },
  generationConfig: {
    temperature: 0.6,
    maxTokens: 4096,
  },
});

// ── Genre Analysis Template ─────────────────────────────

promptEngine.register({
  id: 'analysis.genre',
  name: 'Genre Analysis',
  version: '1.0.0',
  category: 'analysis',
  systemPrompt: `You are a film genre analysis expert. Analyze scripts and story ideas to classify them accurately. Identify genre elements, comparable films, audience profiles, and market viability.

Output valid JSON with: primaryGenre, subGenres (array), genreConfidence (0-1), genreElements (array), comparableFilms (array), audienceProfile, marketViability, toneAnalysis.`,
  userPromptTemplate: `Analyze the genre classification for this story:

LOGLINE: {{logline}}
SYNOPSIS: {{synopsis}}

{{contentExcerpt}}`,
  requiredVariables: ['logline'],
  optionalVariables: ['synopsis', 'contentExcerpt'],
  defaults: { synopsis: 'Not provided', contentExcerpt: '' },
  generationConfig: {
    temperature: 0.5,
    maxTokens: 3072,
  },
});

// ── Budget Estimation Template ──────────────────────────

promptEngine.register({
  id: 'production.budget',
  name: 'Budget Estimation',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a professional film production budget analyst. Analyze scripts and project parameters to generate realistic budget estimates. Factor in cast, locations, effects, equipment, crew, post-production, and contingency.

Output valid JSON with: totalEstimate (low/mid/high/currency), breakdown (array of category objects), assumptions (array), costDrivers (array), savingOpportunities (array), productionSchedule, riskFactors (array).`,
  userPromptTemplate: `Estimate the production budget:

PROJECT TYPE: {{projectType}}
LOCATION: {{location}}
TARGET DURATION: {{duration}}
SCENES: {{sceneCount}}
CHARACTERS: {{characterCount}}

{{scriptExcerpt}}`,
  requiredVariables: ['projectType'],
  optionalVariables: ['location', 'duration', 'sceneCount', 'characterCount', 'scriptExcerpt'],
  defaults: {
    location: 'Not specified',
    duration: 'Not specified',
    sceneCount: 'Unknown',
    characterCount: 'Unknown',
    scriptExcerpt: '',
  },
  generationConfig: {
    temperature: 0.4,
    maxTokens: 4096,
  },
});

// ── Talent Recommendation Template ──────────────────────

promptEngine.register({
  id: 'production.talent',
  name: 'Talent Recommendation',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a film industry casting and crew placement expert. Recommend ideal team compositions based on project requirements, considering genre, scale, budget, and timeline.

Output valid JSON with: roles (array of detailed role objects), teamSize (minimum/recommended/full), departmentBreakdown (array), hiringTimeline, budgetConsiderations.`,
  userPromptTemplate: `Recommend the ideal team composition:

PROJECT TYPE: {{projectType}}
GENRE: {{genre}}
BUDGET RANGE: {{budget}}
SCALE: {{scale}}

{{requirements}}`,
  requiredVariables: ['projectType'],
  optionalVariables: ['genre', 'budget', 'scale', 'requirements'],
  defaults: { genre: 'drama', budget: 'Not specified', scale: 'independent', requirements: '' },
  generationConfig: {
    temperature: 0.5,
    maxTokens: 4096,
  },
});

// ── Creative Assistant Template ─────────────────────────

promptEngine.register({
  id: 'assistant.creative',
  name: 'Creative Assistant',
  version: '1.0.0',
  category: 'assistant',
  systemPrompt: `You are a creative filmmaking AI assistant with expertise across all aspects of production — writing, directing, cinematography, editing, sound design, and marketing. Help filmmakers brainstorm, solve problems, and refine their vision. Be collaborative, specific, and actionable.

Output valid JSON with: response (detailed text), suggestions (array), references (array of objects), nextSteps (array), relatedTopics (array).`,
  userPromptTemplate: `{{projectContext}}

QUESTION: {{query}}

{{context}}`,
  requiredVariables: ['query'],
  optionalVariables: ['projectContext', 'context'],
  defaults: { projectContext: '', context: '' },
  generationConfig: {
    temperature: 0.7,
    maxTokens: 2048,
  },
});

// ── Project Insights Template ───────────────────────────

promptEngine.register({
  id: 'insights.project',
  name: 'Project Insights',
  version: '1.0.0',
  category: 'insights',
  systemPrompt: `You are an AI film production analytics engine. Given project data, generate actionable insights, risk assessments, and optimization recommendations.

Output valid JSON with: projectHealth (score/status), insights (array of typed insight objects), predictions (completionDate, budgetUtilization, qualityIndicators), benchmarks (scheduleAdherence, budgetAdherence, scopeCompletion).`,
  userPromptTemplate: `Analyze this film project:

PROJECT: {{projectTitle}} ({{projectType}})
STATUS: {{projectStatus}}
GENRE: {{genre}}
SCRIPTS: {{scriptCount}} script(s)
TEAM: {{teamSize}} member(s)
TIMELINE: {{timeline}}
BUDGET: {{budget}}`,
  requiredVariables: ['projectTitle'],
  optionalVariables: ['projectType', 'projectStatus', 'genre', 'scriptCount', 'teamSize', 'timeline', 'budget'],
  defaults: {
    projectType: 'film',
    projectStatus: 'unknown',
    genre: 'Not specified',
    scriptCount: '0',
    teamSize: '0',
    timeline: 'Not specified',
    budget: 'Not specified',
  },
  generationConfig: {
    temperature: 0.5,
    maxTokens: 3072,
  },
});

// ── Recommendation Template ─────────────────────────────

promptEngine.register({
  id: 'recommendation.user',
  name: 'User Recommendations',
  version: '1.0.0',
  category: 'recommendation',
  systemPrompt: `You are a film industry recommendation engine. Suggest relevant creators, projects, and skills based on user profiles.

Output valid JSON with: suggestedCreators (array of objects with type, reason), suggestedProjects (array of objects), suggestedSkills (array of objects with skill, reason, resources).`,
  userPromptTemplate: `Generate personalized recommendations:

SKILLS: {{skills}}
ROLE: {{role}}
INTERESTS: {{interests}}
EXPERIENCE: {{experience}}`,
  requiredVariables: ['role'],
  optionalVariables: ['skills', 'interests', 'experience'],
  defaults: { skills: 'general', interests: 'filmmaking', experience: 'emerging' },
  generationConfig: {
    temperature: 0.6,
    maxTokens: 2048,
  },
});

// ── Load Extended Templates ─────────────────────────────
// Each module file self-registers its templates with the singleton promptEngine.
require('./templates/script-extra.templates');
require('./templates/trailer.prompts');
require('./templates/video.prompts');
require('./templates/crew.templates');
require('./templates/production.prompts');
require('./templates/distribution.prompts');
require('./templates/previz.prompts');

module.exports = promptEngine;
