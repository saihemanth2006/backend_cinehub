/**
 * @module integrations/ai/prompts/templates/crew.templates
 * @description Prompt templates for the AI Cast & Crew Intelligence module.
 */
const promptEngine = require('../prompt.engine');

// ── Role Recommendations ─────────────────────────────
promptEngine.register({
  id: 'crew.role-recommendations',
  name: 'Role Recommendations',
  version: '1.0.0',
  category: 'crew',
  systemPrompt: `You are a production manager and crew coordinator. Recommend essential crew roles, positions, responsibilities, and experience levels needed for the production.

Output valid JSON with: roles (array of {role, department, responsibilities, requiredExperience, estimatedSalaryRange, priority}), structure (team hierarchy), justification.`,
  userPromptTemplate: `Recommend crew roles for:

PROJECT: {{project}}
BUDGET: {{budget}}
SCALE: {{scale}}
GENRE: {{genre}}`,
  requiredVariables: ['project'],
  optionalVariables: ['budget', 'scale', 'genre'],
  defaults: { budget: 'medium', scale: 'independent' },
  generationConfig: { temperature: 0.6, maxTokens: 2048 },
});

// ── Talent Matching ─────────────────────────────────────
promptEngine.register({
  id: 'crew.talent-matching',
  name: 'Talent Matching',
  version: '1.0.0',
  category: 'crew',
  systemPrompt: `You are a professional casting director and talent scout. Match character descriptions to ideal casting profiles including physical attributes, acting style, experience level, and comparable industry references.

Output valid JSON with: castingProfiles (array of {character, idealTraits, actingStyle, ageRange, physicalDescription, comparableActors (array), auditionNotes}), castingStrategy, chemistryNotes (array of character pair dynamics), diversityConsiderations.`,
  userPromptTemplate: `Match talent for these characters:

CHARACTERS: {{characters}}
GENRE: {{genre}}
BUDGET LEVEL: {{budget}}
PRODUCTION STYLE: {{style}}`,
  requiredVariables: ['characters'],
  optionalVariables: ['genre', 'budget', 'style'],
  defaults: { genre: '', budget: '', style: '' },
  generationConfig: { temperature: 0.6, maxTokens: 4096 },
});

// ── Skill Analysis ──────────────────────────────────────
promptEngine.register({
  id: 'crew.skill-analysis',
  name: 'Skill Analysis',
  version: '1.0.0',
  category: 'crew',
  systemPrompt: `You are a production management consultant specializing in crew skill assessment. Analyze production requirements and identify essential skills, skill gaps, and training needs.

Output valid JSON with: requiredSkills (array of {skill, department, importance, level}), skillGaps (array of {skill, impact, solution}), trainingRecommendations (array), departmentNeeds (object by department), priorityHires (array).`,
  userPromptTemplate: `Analyze skills needed for this production:

PROJECT: {{project}}
CURRENT TEAM: {{currentTeam}}
GENRE: {{genre}}`,
  requiredVariables: ['project'],
  optionalVariables: ['currentTeam', 'genre'],
  defaults: { currentTeam: 'Starting from scratch', genre: '' },
  generationConfig: { temperature: 0.5, maxTokens: 3072 },
});

// ── Team Composition ────────────────────────────────────
promptEngine.register({
  id: 'crew.team-composition',
  name: 'Team Composition Guidance',
  version: '1.0.0',
  category: 'crew',
  systemPrompt: `You are an executive producer and line producer with expertise in building optimal production teams. Design team structures with clear departments, hierarchy, responsibilities, and workflow.

Output valid JSON with: structure (object with departments, each containing {head, positions (array), headcount}), totalHeadcount, hierarchy (organizational chart description), workflowNotes, communicationPlan, budgetImpact, scalingAdvice.`,
  userPromptTemplate: `Design the team for:

PROJECT: {{project}}
SCALE: {{scale}}
BUDGET: {{budget}}
TIMELINE: {{timeline}}`,
  requiredVariables: ['project'],
  optionalVariables: ['scale', 'budget', 'timeline'],
  defaults: { scale: 'independent', budget: '', timeline: '' },
  generationConfig: { temperature: 0.5, maxTokens: 4096 },
});

module.exports = promptEngine;
