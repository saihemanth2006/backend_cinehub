/**
 * @module integrations/ai/workflows/workflow.registry
 * @description Centralized AI Workflow Registry — maps every module + task
 * combination to a prompt template, response parser, and metadata.
 *
 * This is the routing brain behind the unified POST /ai/generate endpoint.
 * Adding a new AI feature = registering one workflow entry here + a prompt template.
 *
 * Supported Modules:
 *  1. script-development     — Story, screenplay, dialogue, character, genre, scene
 *  2. trailer-concept        — Narration, sequencing, hooks, structure, music mood
 *  3. video-enhancement      — Editing, color grading, subtitles, pacing, cinematic
 *  4. cast-crew              — Role recs, talent matching, skill analysis, team comp
 *  5. production-intelligence— Budget, schedule, equipment, complexity
 *  6. distribution-promotion — Festival, audience, social, strategy, copywriting
 *  7. pre-visualization      — Shots, camera, moodboard, lighting, visual storytelling
 */
const { logger } = require('../../../config');

/**
 * @typedef {Object} WorkflowEntry
 * @property {string} templateId       — Registered prompt template ID
 * @property {string} module           — Parent module slug
 * @property {string} task             — Task slug within the module
 * @property {string} name             — Human-readable name
 * @property {string} description      — Short description
 * @property {string} category         — Template category
 * @property {Function} [inputMapper]  — (input) => variables for the template
 * @property {Function} [outputMapper] — (aiData) => formatted response data
 * @property {Object}  [configOverrides] — Override generation config
 * @property {boolean} [cacheable]     — Whether results should be cached (default: true)
 */

class WorkflowRegistry {
  constructor() {
    /** @type {Map<string, WorkflowEntry>} keyed by "module::task" */
    this._workflows = new Map();
  }

  /**
   * Generates the composite key for a workflow.
   * @param {string} module
   * @param {string} task
   * @returns {string}
   */
  _key(module, task) {
    return `${module}::${task}`;
  }

  /**
   * Registers a workflow entry.
   * @param {WorkflowEntry} entry
   */
  register(entry) {
    const key = this._key(entry.module, entry.task);
    if (this._workflows.has(key)) {
      logger.warn(`[WorkflowRegistry] Overwriting workflow: ${key}`);
    }
    this._workflows.set(key, {
      cacheable: true,
      inputMapper: (input) => input,
      outputMapper: (data) => data,
      configOverrides: {},
      ...entry,
    });
    logger.debug(`[WorkflowRegistry] Registered: ${key} → ${entry.templateId}`);
  }

  /**
   * Registers many workflows at once.
   * @param {WorkflowEntry[]} entries
   */
  registerBatch(entries) {
    entries.forEach((e) => this.register(e));
  }

  /**
   * Resolves a workflow by module + task.
   * @param {string} module
   * @param {string} task
   * @returns {WorkflowEntry|null}
   */
  resolve(module, task) {
    return this._workflows.get(this._key(module, task)) || null;
  }

  /**
   * Lists all workflows, optionally filtered by module.
   * @param {string} [module]
   * @returns {WorkflowEntry[]}
   */
  list(module) {
    const all = [...this._workflows.values()];
    return module ? all.filter((w) => w.module === module) : all;
  }

  /**
   * Lists all supported modules.
   * @returns {string[]}
   */
  listModules() {
    const modules = new Set();
    for (const entry of this._workflows.values()) {
      modules.add(entry.module);
    }
    return [...modules];
  }

  /**
   * Lists all tasks for a given module.
   * @param {string} module
   * @returns {{ task: string, name: string, description: string }[]}
   */
  listTasks(module) {
    return this.list(module).map((w) => ({
      task: w.task,
      name: w.name,
      description: w.description,
    }));
  }

  /**
   * Returns the total number of registered workflows.
   * @returns {number}
   */
  get size() {
    return this._workflows.size;
  }
}

// ── Singleton ──────────────────────────────────────
module.exports = new WorkflowRegistry();
