/**
 * @module integrations/ai/prompts/prompt.engine
 * @description Centralized prompt engineering engine — template compilation,
 * variable interpolation, context injection, and version management.
 *
 * Architecture:
 * ┌──────────────────┐
 * │  Prompt Engine    │
 * │  ┌─────────────┐ │
 * │  │  Templates   │ │  ← Registered prompt templates
 * │  │  Registry    │ │
 * │  └──────┬──────┘ │
 * │         │        │
 * │  ┌──────▼──────┐ │
 * │  │  Compiler    │ │  ← Variable interpolation + context injection
 * │  │  Pipeline    │ │
 * │  └──────┬──────┘ │
 * │         │        │
 * │  ┌──────▼──────┐ │
 * │  │  Validators  │ │  ← Token limits, required vars, output schema
 * │  └─────────────┘ │
 * └──────────────────┘
 */
const { logger } = require('../../../config');

/**
 * @typedef {Object} PromptTemplate
 * @property {string} id - Unique template identifier
 * @property {string} name - Human-readable name
 * @property {string} version - Template version (semver)
 * @property {string} category - Template category (script, analysis, recommendation, etc.)
 * @property {string} systemPrompt - System-level instruction template
 * @property {string} userPromptTemplate - User prompt template with {{variable}} placeholders
 * @property {string[]} requiredVariables - Variables that must be provided
 * @property {string[]} [optionalVariables] - Optional variables with defaults
 * @property {Object} [defaults] - Default values for optional variables
 * @property {Object} [outputSchema] - Expected output JSON schema description
 * @property {Object} [generationConfig] - Default generation parameters
 * @property {number} [estimatedTokens] - Estimated token usage
 */

class PromptEngine {
  constructor() {
    /** @type {Map<string, PromptTemplate>} */
    this.templates = new Map();

    /** @type {Map<string, Function>} */
    this.preprocessors = new Map();

    /** @type {Map<string, Function>} */
    this.postprocessors = new Map();
  }

  // ── Template Registration ─────────────────────────────

  /**
   * Registers a prompt template.
   * @param {PromptTemplate} template
   */
  register(template) {
    if (!template.id || !template.systemPrompt || !template.userPromptTemplate) {
      throw new Error(`Invalid template: missing required fields (id, systemPrompt, userPromptTemplate)`);
    }

    if (this.templates.has(template.id)) {
      logger.warn(`[PromptEngine] Overwriting existing template: ${template.id}`);
    }

    this.templates.set(template.id, {
      ...template,
      requiredVariables: template.requiredVariables || [],
      optionalVariables: template.optionalVariables || [],
      defaults: template.defaults || {},
      generationConfig: template.generationConfig || {},
      registeredAt: new Date(),
    });

    logger.debug(`[PromptEngine] Registered template: ${template.id} v${template.version || '1.0.0'}`);
  }

  /**
   * Registers a batch of templates.
   * @param {PromptTemplate[]} templates
   */
  registerBatch(templates) {
    templates.forEach((t) => this.register(t));
  }

  // ── Preprocessor / Postprocessor Hooks ────────────────

  /**
   * Registers a preprocessor that transforms variables before template compilation.
   * @param {string} templateId
   * @param {Function} fn - (variables: Object) => Object
   */
  addPreprocessor(templateId, fn) {
    this.preprocessors.set(templateId, fn);
  }

  /**
   * Registers a postprocessor that transforms the compiled prompt.
   * @param {string} templateId
   * @param {Function} fn - (compiledPrompt: string) => string
   */
  addPostprocessor(templateId, fn) {
    this.postprocessors.set(templateId, fn);
  }

  // ── Prompt Compilation ────────────────────────────────

  /**
   * Compiles a registered template with provided variables.
   * @param {string} templateId
   * @param {Object} variables - Template variables
   * @param {Object} [context] - Additional context (user info, project data, etc.)
   * @returns {{ systemPrompt: string, userPrompt: string, generationConfig: Object }}
   */
  compile(templateId, variables = {}, context = {}) {
    const template = this.templates.get(templateId);
    if (!template) {
      throw new Error(`Template '${templateId}' not found. Available: ${[...this.templates.keys()].join(', ')}`);
    }

    // Validate required variables
    this._validateVariables(template, variables);

    // Merge defaults with provided variables
    let mergedVars = { ...template.defaults, ...variables };

    // Apply preprocessor if registered
    const preprocessor = this.preprocessors.get(templateId);
    if (preprocessor) {
      mergedVars = preprocessor(mergedVars);
    }

    // Inject context
    if (context.user) {
      mergedVars._userName = context.user.displayName || context.user.name || 'User';
      mergedVars._userRole = context.user.role || 'creator';
    }
    if (context.project) {
      mergedVars._projectTitle = context.project.title || 'Untitled Project';
      mergedVars._projectType = context.project.type || 'film';
    }

    // Compile templates
    let systemPrompt = this._interpolate(template.systemPrompt, mergedVars);
    let userPrompt = this._interpolate(template.userPromptTemplate, mergedVars);

    // Apply postprocessor if registered
    const postprocessor = this.postprocessors.get(templateId);
    if (postprocessor) {
      userPrompt = postprocessor(userPrompt);
    }

    return {
      systemPrompt,
      userPrompt,
      generationConfig: { ...template.generationConfig, ...(variables.generationConfig || {}) },
      templateId: template.id,
      templateVersion: template.version || '1.0.0',
    };
  }

  /**
   * Compiles a prompt from raw template strings (no registration needed).
   * Useful for one-off dynamic prompts.
   * @param {string} systemTemplate
   * @param {string} userTemplate
   * @param {Object} variables
   * @returns {{ systemPrompt: string, userPrompt: string }}
   */
  compileRaw(systemTemplate, userTemplate, variables = {}) {
    return {
      systemPrompt: this._interpolate(systemTemplate, variables),
      userPrompt: this._interpolate(userTemplate, variables),
    };
  }

  // ── Template Query ────────────────────────────────────

  /**
   * Gets a template by ID.
   * @param {string} templateId
   * @returns {PromptTemplate|undefined}
   */
  getTemplate(templateId) {
    return this.templates.get(templateId);
  }

  /**
   * Lists all templates, optionally filtered by category.
   * @param {string} [category]
   * @returns {PromptTemplate[]}
   */
  listTemplates(category) {
    const all = [...this.templates.values()];
    return category ? all.filter((t) => t.category === category) : all;
  }

  // ── Internal ──────────────────────────────────────────

  /**
   * Interpolates {{variable}} placeholders in a template string.
   * Supports nested access like {{user.name}} and conditional blocks.
   * @param {string} template
   * @param {Object} variables
   * @returns {string}
   */
  _interpolate(template, variables) {
    return template.replace(/\{\{(\w+(?:\.\w+)*)\}\}/g, (match, path) => {
      const value = this._getNestedValue(variables, path);
      if (value === undefined || value === null) return '';

      // Arrays get joined with commas
      if (Array.isArray(value)) return value.join(', ');

      return String(value);
    });
  }

  /**
   * Accesses a nested value via dot-notation path.
   * @param {Object} obj
   * @param {string} path - e.g., "user.name"
   * @returns {*}
   */
  _getNestedValue(obj, path) {
    return path.split('.').reduce((current, key) => {
      return current && current[key] !== undefined ? current[key] : undefined;
    }, obj);
  }

  /**
   * Validates that all required variables are present.
   * @param {PromptTemplate} template
   * @param {Object} variables
   */
  _validateVariables(template, variables) {
    const missing = template.requiredVariables.filter((v) => {
      const val = variables[v];
      return val === undefined || val === null || val === '';
    });

    if (missing.length > 0) {
      throw new Error(
        `Template '${template.id}' missing required variables: ${missing.join(', ')}`
      );
    }
  }
}

// Singleton
module.exports = new PromptEngine();
