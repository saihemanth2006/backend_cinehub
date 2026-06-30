/**
 * @module integrations/ai/prompts/templates/production.prompts
 * @description Production Intelligence module prompt templates
 */
const promptEngine = require('../prompt.engine');

// ── Budget Estimation ────────────────────────────────
promptEngine.register({
  id: 'production.budget-estimation',
  name: 'Budget Estimation',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a line producer and production accountant. Estimate detailed production budgets with category breakdowns, contingencies, and market-based rates.

Output valid JSON with: totalBudget, currencyCode, breakdown (array of {category, amount, percentage, notes}), contingency, notes, assumptions, alternatives (low/mid/high estimates), notes.`,
  userPromptTemplate: `Estimate production budget for:

PROJECT TYPE: {{projectType}}
SCALE: {{scale}}
DURATION: {{duration}}
LOCATIONS: {{locations}}
SPECIAL EFFECTS: {{specialEffects}}
CONTEXT: {{additionalContext}}`,
  requiredVariables: ['projectType'],
  optionalVariables: ['scale', 'duration', 'locations', 'specialEffects', 'additionalContext'],
  defaults: { scale: 'independent', duration: '30min', locations: 1, specialEffects: false },
  generationConfig: { temperature: 0.6, maxTokens: 2048 },
});

// ── Schedule Recommendations ─────────────────────────
promptEngine.register({
  id: 'production.schedule',
  name: 'Schedule Recommendations',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a production manager and scheduling expert. Create realistic production schedules with day-by-day breakdowns, resource allocation, and contingency planning.

Output valid JSON with: timeline (array of {day, activities, resources, contingencies}), preProduction, production, postProduction, criticalPath, riskFactors.`,
  userPromptTemplate: `Recommend schedule for:

PROJECT: {{project}}
SCALE: {{scale}}
RESOURCES: {{resources}}
CONSTRAINTS: {{constraints}}`,
  requiredVariables: ['project'],
  optionalVariables: ['scale', 'resources', 'constraints'],
  defaults: { scale: 'medium' },
  generationConfig: { temperature: 0.6, maxTokens: 2048 },
});

// ── Equipment Suggestions ────────────────────────────
promptEngine.register({
  id: 'production.equipment',
  name: 'Equipment Suggestions',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a technical production specialist and equipment rental coordinator. Recommend cameras, lenses, lighting, audio, and support equipment appropriate for the project.

Output valid JSON with: equipment (array of {type, model, specifications, rationale, alternatives, rentalCost}), setup (description), budget, supplier (recommendations).`,
  userPromptTemplate: `Suggest equipment for:

PROJECT TYPE: {{projectType}}
GENRE: {{genre}}
BUDGET: {{budget}}
REQUIREMENTS: {{requirements}}`,
  requiredVariables: ['projectType'],
  optionalVariables: ['genre', 'budget', 'requirements'],
  defaults: { budget: 'medium' },
  generationConfig: { temperature: 0.6, maxTokens: 2048 },
});

// ── Complexity Analysis ──────────────────────────────
promptEngine.register({
  id: 'production.complexity',
  name: 'Complexity Analysis',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a production consultant specializing in risk assessment and complexity evaluation. Analyze production complexity, identify risk factors, and suggest mitigation strategies.

Output valid JSON with: complexityScore (0-100), riskFactors (array of {factor, severity, mitigation}), recommendations, timeline, budget, resources, contingencies.`,
  userPromptTemplate: `Analyze production complexity:

PROJECT: {{project}}
BUDGET: {{budget}}
TIMELINE: {{timeline}}
RESOURCES: {{resources}}`,
  requiredVariables: ['project'],
  optionalVariables: ['budget', 'timeline', 'resources'],
  defaults: {},
  generationConfig: { temperature: 0.6, maxTokens: 1536 },
});

module.exports = promptEngine;
