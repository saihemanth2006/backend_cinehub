/**
 * @module integrations/ai/workflows/workflow.executor
 * @description Unified AI Workflow Executor — the single execution engine
 * behind POST /ai/generate. Resolves module+task → template → AI → response.
 *
 * Flow:
 *  1. Resolve workflow from registry
 *  2. Map user input to template variables via inputMapper
 *  3. Delegate to the orchestrator (which handles cache, provider, validation)
 *  4. Map AI output via outputMapper
 *  5. Return unified response envelope
 */
const { logger } = require('../../../config');
const workflowRegistry = require('./workflow.registry');
const ApiError = require('../../../utils/ApiError');

class WorkflowExecutor {
  /**
   * @param {import('../orchestrator/ai.orchestrator')} orchestrator
   */
  constructor(orchestrator) {
    this.orchestrator = orchestrator;
  }

  /**
   * Executes a unified AI generation request.
   * This is the SINGLE method powering POST /ai/generate.
   *
   * @param {Object} params
   * @param {string} params.module   — Module slug (e.g., 'script-development')
   * @param {string} params.task     — Task slug (e.g., 'generate-screenplay')
   * @param {string|Object} params.input — User input (string prompt or structured data)
   * @param {string} params.userId   — Authenticated user ID
   * @param {string} [params.requestId] — Correlation ID
   * @param {string} [params.provider] — Provider override
   * @param {Object} [params.options] — Additional options (genre, tone, format, etc.)
   * @returns {Promise<Object>} Unified response envelope
   */
  async execute({ module, task, input, userId, requestId, provider, options = {} }) {
    const startTime = Date.now();

    // 1. Resolve workflow
    const workflow = workflowRegistry.resolve(module, task);
    if (!workflow) {
      const availableModules = workflowRegistry.listModules().join(', ');
      throw ApiError.badRequest(
        `Unknown workflow: module="${module}", task="${task}". Available modules: ${availableModules}`,
        'AI_UNKNOWN_WORKFLOW',
      );
    }

    logger.info(`[WorkflowExecutor] Executing ${module}::${task} for user ${userId}`, {
      requestId,
      templateId: workflow.templateId,
    });

    try {
      // 2. Map input → template variables
      const mergedInput = typeof input === 'string'
        ? { input, ...options }
        : { ...input, ...options };

      const variables = workflow.inputMapper(mergedInput);

      // 3. Execute via orchestrator
      const result = await this.orchestrator.execute({
        templateId: workflow.templateId,
        variables,
        userId,
        requestId,
        provider,
        skipCache: !workflow.cacheable,
        generationConfig: workflow.configOverrides,
      });

      // 4. Map output
      const outputData = workflow.outputMapper(result.data);

      // 5. Return unified envelope
      return {
        success: true,
        module,
        task,
        data: outputData,
        meta: {
          ...result.meta,
          workflowName: workflow.name,
          executionTimeMs: Date.now() - startTime,
        },
      };
    } catch (err) {
      logger.error(`[WorkflowExecutor] Failed: ${module}::${task} — ${err.message}`, {
        requestId,
        userId,
      });

      if (err instanceof ApiError) throw err;
      throw ApiError.internal(
        `AI workflow execution failed: ${err.message}`,
        'AI_WORKFLOW_ERROR',
      );
    }
  }

  /**
   * Lists all available modules and their tasks.
   * Useful for the frontend to discover capabilities.
   * @returns {Object}
   */
  listCapabilities() {
    const modules = workflowRegistry.listModules();
    return modules.map((mod) => ({
      module: mod,
      tasks: workflowRegistry.listTasks(mod),
    }));
  }
}

module.exports = WorkflowExecutor;
