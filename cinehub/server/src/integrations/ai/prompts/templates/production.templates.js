/**
 * @module integrations/ai/prompts/templates/production.templates
 * @description Additional prompt templates for the Production Intelligence module.
 * (Budget and Talent templates already exist in template.registry.js)
 */
const promptEngine = require('../prompt.engine');

// ── Shooting Schedule ───────────────────────────────────
promptEngine.register({
  id: 'production.schedule',
  name: 'Shooting Schedule',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a seasoned assistant director and production planner. Generate optimized shooting schedules that account for location moves, actor availability, day/night requirements, and production efficiency.

Output valid JSON with: schedule (array of {day, date, scenes (array), location, callTime, wrapTime, notes, castRequired (array)}), totalDays, locationGroups (array), weatherConsiderations, contingencyPlan, dailyEstimatedCost.`,
  userPromptTemplate: `Create a shooting schedule for:

SCRIPT/SCENES: {{script}}
LOCATIONS: {{locations}}
CAST AVAILABILITY: {{castAvailability}}
TOTAL DAYS AVAILABLE: {{totalDays}}`,
  requiredVariables: ['script'],
  optionalVariables: ['locations', 'castAvailability', 'totalDays'],
  defaults: { locations: '', castAvailability: '', totalDays: 'flexible' },
  generationConfig: { temperature: 0.4, maxTokens: 4096 },
});

// ── Equipment Suggestions ───────────────────────────────
promptEngine.register({
  id: 'production.equipment',
  name: 'Equipment Suggestions',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a technical production consultant and equipment specialist. Recommend camera systems, lenses, lighting, audio equipment, grip gear, and accessories for film productions based on budget and requirements.

Output valid JSON with: camera (array of {model, reason, priceRange}), lenses (array of {type, focalLength, reason}), lighting (array of {item, purpose, quantity}), audio (array of {item, purpose}), grip (array), accessories (array), totalEstimatedCost, rentalVsBuy, packageDeals (array).`,
  userPromptTemplate: `Recommend equipment for:

PROJECT: {{project}}
BUDGET LEVEL: {{budget}}
GENRE: {{genre}}
VISUAL STYLE: {{style}}`,
  requiredVariables: ['project'],
  optionalVariables: ['budget', 'genre', 'style'],
  defaults: { budget: 'independent', genre: '', style: 'cinematic' },
  generationConfig: { temperature: 0.5, maxTokens: 4096 },
});

// ── Production Complexity ───────────────────────────────
promptEngine.register({
  id: 'production.complexity',
  name: 'Production Complexity Analysis',
  version: '1.0.0',
  category: 'production',
  systemPrompt: `You are a production analytics expert. Analyze the overall complexity of a film production considering logistics, technical requirements, cast, locations, VFX needs, and potential risks.

Output valid JSON with: complexityScore (0-100), complexityLevel (low/medium/high/extreme), factors (array of {category, complexity, description, mitigation}), riskMatrix (array of {risk, probability, impact, mitigation}), simplificationSuggestions (array), comparisonBenchmark.`,
  userPromptTemplate: `Analyze production complexity for:

SCRIPT/PROJECT: {{script}}
ESTIMATED BUDGET: {{budget}}
LOCATIONS: {{locations}}`,
  requiredVariables: ['script'],
  optionalVariables: ['budget', 'locations'],
  defaults: { budget: '', locations: '' },
  generationConfig: { temperature: 0.4, maxTokens: 3072 },
});

module.exports = promptEngine;
