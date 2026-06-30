/**
 * @module integrations/ai/orchestrator/workflow.executor
 * @description Workflow Executor — The orchestration layer that routes requests to workflows.
 *
 * Responsibilities:
 * - Resolve workflow from module + task
 * - Map input via inputMapper
 * - Execute prompt compilation + AI generation
 * - Parse and validate output via outputMapper
 * - Return structured response
 *
 * Usage:
 *   const executor = getWorkflowExecutor();
 *   const result = await executor.execute({
 *     module: 'script-development',
 *     task: 'generate-script',
 *     input: 'A detective...',
 *     userId: 'user123'
 *   });
 */
const { logger } = require('../../../config');
const workflowRegistry = require('../workflows/workflow.registry');
const ApiError = require('../../../utils/ApiError');

// Lazy import to avoid circular dependency
let getOrchestrator = null;
function getOrchestratorLazy() {
  if (!getOrchestrator) {
    const aiModule = require('../index');
    getOrchestrator = aiModule.getOrchestrator;
  }
  return getOrchestrator();
}

class WorkflowExecutor {
  /**
   * Main execution method.
   * @param {Object} params
   * @param {string} params.module - Module slug
   * @param {string} params.task - Task slug
   * @param {string|Object} params.input - Raw user input
   * @param {string} params.userId - User ID
   * @param {string} [params.requestId] - Correlation ID
   * @param {string} [params.provider] - AI provider override
   * @param {Object} [params.options] - Generation options
   * @returns {Promise<Object>} { success, module, task, data, meta }
   */
  async execute(params) {
    const { module, task, input, userId, requestId, provider, options = {} } = params;

    const startTime = Date.now();

    try {
      // 1. Resolve workflow
      const workflow = workflowRegistry.resolve(module, task);
      if (!workflow) {
        throw ApiError.badRequest(
          `Unknown module/task: ${module}/${task}`,
          'WORKFLOW_NOT_FOUND',
        );
      }

      logger.debug(`[WorkflowExecutor] Executing ${module}::${task} for user ${userId}`);

      // 2. Map input using workflow's inputMapper
      let mappedInput = input;
      if (workflow.inputMapper && typeof workflow.inputMapper === 'function') {
        mappedInput = workflow.inputMapper(input);
      }

      // 3. Get orchestrator and execute
      const orchestrator = getOrchestratorLazy();

      const aiResult = await orchestrator.execute({
        templateId: workflow.templateId,
        variables: mappedInput,
        userId,
        requestId,
        provider,
        generationConfig: workflow.configOverrides,
        cacheable: workflow.cacheable,
        skipValidation: options.skipValidation,
      });

      // 4. Parse output using workflow's outputMapper
      let mappedOutput = aiResult.data;
      if (workflow.outputMapper && typeof workflow.outputMapper === 'function') {
        mappedOutput = workflow.outputMapper(aiResult.data);
      }

      const executionTimeMs = Date.now() - startTime;

      // 5. Return structured response
      return {
        success: true,
        module,
        task,
        data: mappedOutput,
        meta: {
          provider: aiResult.meta?.provider,
          model: aiResult.meta?.model,
          tokensUsed: aiResult.meta?.tokensUsed,
          executionTimeMs,
          cached: aiResult.meta?.cached || false,
          requestId,
        },
      };
    } catch (error) {
      logger.error(`[WorkflowExecutor] Error in ${module}::${task}:`, error);
      throw error;
    }
  }

  /**
   * Get all capabilities.
   * @returns {Object} { modules: [...], tasksByModule: {...} }
   */
  listCapabilities() {
    const modules = workflowRegistry.listModules();
    const tasksByModule = {};

    modules.forEach((module) => {
      tasksByModule[module] = workflowRegistry.listTasks(module);
    });

    return {
      modules,
      tasksByModule,
      totalWorkflows: workflowRegistry.size,
    };
  }

  /**
   * Get tasks for a specific module.
   * @param {string} module
   * @returns {Array}
   */
  getModuleTasks(module) {
    return workflowRegistry.listTasks(module);
  }

  /**
   * Validate input against workflow requirements.
   * @param {string} module
   * @param {string} task
   * @param {Object} input
   * @returns {Object} { valid: boolean, errors: [] }
   */
  validateInput(module, task, input) {
    const workflow = workflowRegistry.resolve(module, task);
    if (!workflow) {
      return { valid: false, errors: [`Unknown workflow: ${module}/${task}`] };
    }

    const errors = [];

    // Check required fields
    if (workflow.requiredFields) {
      workflow.requiredFields.forEach((field) => {
        if (!(field in input)) {
          errors.push(`Missing required field: ${field}`);
        }
      });
    }

    return {
      valid: errors.length === 0,
      errors,
    };
  }
}

module.exports = new WorkflowExecutor();
