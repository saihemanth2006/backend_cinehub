/**
 * @module integrations/ai/workflows/index
 * @description Barrel export for the workflow subsystem.
 */
const workflowRegistry = require('./workflow.registry');
const WorkflowExecutor = require('./workflow.executor');

module.exports = {
  workflowRegistry,
  WorkflowExecutor,
};
