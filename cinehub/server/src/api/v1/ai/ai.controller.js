/**
 * @module api/v1/ai/ai.controller
 * @description Centralized AI controller — handles the unified POST /ai/generate endpoint.
 * All AI features route through this single controller using workflow orchestration.
 */
const { getWorkflowExecutor, workflowRegistry } = require('../../../integrations/ai');
const { logger } = require('../../../config');

class AIController {
  /**
   * POST /ai/generate
   * Unified AI generation endpoint.
   *
   * Request: { module, task, input, options? }
   * Response: { success, module, task, data, meta }
   */
  async generate(req) {
    const { module, task, input, options = {} } = req.body;

    const executor = getWorkflowExecutor();

    const result = await executor.execute({
      module,
      task,
      input,
      userId: req.user._id.toString(),
      requestId: req.requestId,
      provider: options.provider,
      options,
    });

    return result;
  }

  /**
   * GET /ai/capabilities
   * Returns all available modules and their tasks.
   */
  getCapabilities() {
    const executor = getWorkflowExecutor();
    return executor.listCapabilities();
  }

  /**
   * GET /ai/modules
   * Returns the list of available modules.
   */
  getModules() {
    return workflowRegistry.listModules();
  }

  /**
   * GET /ai/modules/:module/tasks
   * Returns all tasks for a given module.
   */
  getModuleTasks(module) {
    return workflowRegistry.listTasks(module);
  }
}

// Singleton
module.exports = new AIController();
