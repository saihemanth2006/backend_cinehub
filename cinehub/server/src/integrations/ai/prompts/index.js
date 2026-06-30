/**
 * @module integrations/ai/prompts/index
 * @description Prompt system barrel export.
 */
const promptEngine = require('./prompt.engine');
const templateRegistry = require('./template.registry');
const scriptPrompts = require('./script.prompts');

module.exports = {
  promptEngine,
  templateRegistry,
  ...scriptPrompts,
};
