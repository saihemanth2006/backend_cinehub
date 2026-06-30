/**
 * @module integrations/ai/validation/ai.validator
 * @description AI Output Validation Layer — ensures AI responses conform to expected
 * schemas before reaching the application layer. Handles malformed JSON, missing fields,
 * content safety, and response quality checks.
 *
 * Validation Pipeline:
 * ┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
 * │  Parse JSON  │───▶│  Schema      │───▶│  Content     │───▶│  Quality     │
 * │  Recovery    │    │  Validation  │    │  Safety      │    │  Checks      │
 * └──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
 */
const { logger } = require('../../../config');

/**
 * Schema definitions for each AI response type.
 * Each schema defines required fields, types, and constraints.
 */
const RESPONSE_SCHEMAS = {
  'script.generate': {
    required: ['title', 'content'],
    optional: ['logline', 'synopsis', 'characters', 'scenes', 'themes', 'estimatedRuntime'],
    types: {
      title: 'string',
      logline: 'string',
      synopsis: 'string',
      content: 'string',
      characters: 'array',
      scenes: 'array',
      themes: 'array',
      estimatedRuntime: 'number',
    },
    defaults: {
      logline: '',
      synopsis: '',
      characters: [],
      scenes: [],
      themes: [],
      estimatedRuntime: 0,
    },
  },

  'script.enhance': {
    required: ['overallScore', 'suggestions'],
    optional: ['strengths', 'weaknesses', 'enhancedLogline', 'paceAnalysis', 'characterNotes'],
    types: {
      overallScore: 'number',
      strengths: 'array',
      weaknesses: 'array',
      suggestions: 'array',
      enhancedLogline: 'string',
      paceAnalysis: 'object',
      characterNotes: 'array',
    },
    defaults: {
      strengths: [],
      weaknesses: [],
      enhancedLogline: '',
      paceAnalysis: {},
      characterNotes: [],
    },
    constraints: {
      overallScore: { min: 0, max: 100 },
    },
  },

  'analysis.genre': {
    required: ['primaryGenre'],
    optional: ['subGenres', 'genreConfidence', 'genreElements', 'comparableFilms', 'audienceProfile', 'marketViability', 'toneAnalysis'],
    types: {
      primaryGenre: 'string',
      subGenres: 'array',
      genreConfidence: 'number',
      genreElements: 'array',
      comparableFilms: 'array',
      audienceProfile: 'object',
      marketViability: 'object',
      toneAnalysis: 'object',
    },
    defaults: {
      subGenres: [],
      genreConfidence: 0,
      genreElements: [],
      comparableFilms: [],
      audienceProfile: {},
      marketViability: {},
      toneAnalysis: {},
    },
    constraints: {
      genreConfidence: { min: 0, max: 1 },
    },
  },

  'production.budget': {
    required: ['totalEstimate', 'breakdown'],
    optional: ['assumptions', 'costDrivers', 'savingOpportunities', 'productionSchedule', 'riskFactors'],
    types: {
      totalEstimate: 'object',
      breakdown: 'array',
      assumptions: 'array',
      costDrivers: 'array',
      savingOpportunities: 'array',
      productionSchedule: 'object',
      riskFactors: 'array',
    },
    defaults: {
      assumptions: [],
      costDrivers: [],
      savingOpportunities: [],
      productionSchedule: {},
      riskFactors: [],
    },
  },

  'production.talent': {
    required: ['roles'],
    optional: ['teamSize', 'departmentBreakdown', 'hiringTimeline', 'budgetConsiderations'],
    types: {
      roles: 'array',
      teamSize: 'object',
      departmentBreakdown: 'array',
      hiringTimeline: 'string',
      budgetConsiderations: 'string',
    },
    defaults: {
      teamSize: { minimum: 0, recommended: 0, full: 0 },
      departmentBreakdown: [],
      hiringTimeline: '',
      budgetConsiderations: '',
    },
  },

  'assistant.creative': {
    required: ['response'],
    optional: ['suggestions', 'references', 'nextSteps', 'relatedTopics'],
    types: {
      response: 'string',
      suggestions: 'array',
      references: 'array',
      nextSteps: 'array',
      relatedTopics: 'array',
    },
    defaults: {
      suggestions: [],
      references: [],
      nextSteps: [],
      relatedTopics: [],
    },
  },

  'insights.project': {
    required: ['projectHealth', 'insights'],
    optional: ['predictions', 'benchmarks'],
    types: {
      projectHealth: 'object',
      insights: 'array',
      predictions: 'object',
      benchmarks: 'object',
    },
    defaults: {
      predictions: {},
      benchmarks: {},
    },
  },

  'recommendation.user': {
    required: [],
    optional: ['suggestedCreators', 'suggestedProjects', 'suggestedSkills'],
    types: {
      suggestedCreators: 'array',
      suggestedProjects: 'array',
      suggestedSkills: 'array',
    },
    defaults: {
      suggestedCreators: [],
      suggestedProjects: [],
      suggestedSkills: [],
    },
  },
};

class AIValidator {
  /**
   * Validates and sanitizes an AI response against its expected schema.
   * @param {string} templateId - The template that generated this response
   * @param {*} rawData - Raw data from AI provider (may be string or parsed object)
   * @returns {{ valid: boolean, data: Object, errors: string[], warnings: string[] }}
   */
  validate(templateId, rawData) {
    const errors = [];
    const warnings = [];
    const schema = RESPONSE_SCHEMAS[templateId];

    if (!schema) {
      // No schema defined — pass through with warning
      warnings.push(`No validation schema for template: ${templateId}`);
      const data = typeof rawData === 'string' ? this._safeParseJSON(rawData) : rawData;
      return { valid: true, data: data || rawData, errors, warnings };
    }

    // Step 1: Parse JSON if needed
    let data;
    if (typeof rawData === 'string') {
      data = this._safeParseJSON(rawData);
      if (!data) {
        // Attempt JSON extraction from markdown code blocks
        data = this._extractJSON(rawData);
        if (data) {
          warnings.push('JSON extracted from code block wrapper');
        }
      }
      if (!data) {
        errors.push('Failed to parse AI response as JSON');
        return { valid: false, data: null, errors, warnings };
      }
    } else {
      data = rawData;
    }

    // Step 2: Schema validation — check required fields
    for (const field of schema.required) {
      if (data[field] === undefined || data[field] === null) {
        if (schema.defaults && schema.defaults[field] !== undefined) {
          data[field] = schema.defaults[field];
          warnings.push(`Required field '${field}' missing, using default`);
        } else {
          errors.push(`Required field '${field}' missing from AI response`);
        }
      }
    }

    // Step 3: Type validation
    for (const [field, expectedType] of Object.entries(schema.types)) {
      if (data[field] !== undefined && data[field] !== null) {
        const actualType = Array.isArray(data[field]) ? 'array' : typeof data[field];
        if (actualType !== expectedType) {
          // Try type coercion
          const coerced = this._coerceType(data[field], expectedType);
          if (coerced !== null) {
            data[field] = coerced;
            warnings.push(`Field '${field}' coerced from ${actualType} to ${expectedType}`);
          } else {
            warnings.push(`Field '${field}' expected ${expectedType}, got ${actualType}`);
          }
        }
      }
    }

    // Step 4: Apply defaults for missing optional fields
    for (const field of (schema.optional || [])) {
      if (data[field] === undefined && schema.defaults && schema.defaults[field] !== undefined) {
        data[field] = schema.defaults[field];
      }
    }

    // Step 5: Constraint validation
    if (schema.constraints) {
      for (const [field, constraints] of Object.entries(schema.constraints)) {
        if (data[field] !== undefined && typeof data[field] === 'number') {
          if (constraints.min !== undefined && data[field] < constraints.min) {
            data[field] = constraints.min;
            warnings.push(`Field '${field}' clamped to minimum: ${constraints.min}`);
          }
          if (constraints.max !== undefined && data[field] > constraints.max) {
            data[field] = constraints.max;
            warnings.push(`Field '${field}' clamped to maximum: ${constraints.max}`);
          }
        }
      }
    }

    // Step 6: Content safety check
    const safetyResult = this._contentSafetyCheck(data);
    if (safetyResult.flagged) {
      warnings.push(`Content safety flag: ${safetyResult.reason}`);
    }

    const valid = errors.length === 0;
    if (!valid) {
      logger.warn(`[AI Validator] Validation failed for ${templateId}`, { errors, warnings });
    } else if (warnings.length > 0) {
      logger.debug(`[AI Validator] ${templateId} validated with warnings`, { warnings });
    }

    return { valid, data, errors, warnings };
  }

  // ── Internal Helpers ──────────────────────────────────

  /**
   * Safely parses JSON with error recovery.
   */
  _safeParseJSON(str) {
    try {
      return JSON.parse(str);
    } catch {
      // Try fixing common issues
      try {
        // Remove trailing commas
        const fixed = str.replace(/,\s*([}\]])/g, '$1');
        return JSON.parse(fixed);
      } catch {
        return null;
      }
    }
  }

  /**
   * Extracts JSON from markdown code block wrappers.
   */
  _extractJSON(str) {
    const jsonBlockRegex = /```(?:json)?\s*\n?([\s\S]*?)\n?\s*```/;
    const match = str.match(jsonBlockRegex);
    if (match) {
      return this._safeParseJSON(match[1].trim());
    }
    return null;
  }

  /**
   * Attempts to coerce a value to the expected type.
   */
  _coerceType(value, expectedType) {
    try {
      switch (expectedType) {
        case 'string':
          return String(value);
        case 'number':
          const num = Number(value);
          return isNaN(num) ? null : num;
        case 'array':
          return Array.isArray(value) ? value : [value];
        case 'object':
          return typeof value === 'object' ? value : null;
        default:
          return null;
      }
    } catch {
      return null;
    }
  }

  /**
   * Basic content safety check — flags potentially problematic content.
   */
  _contentSafetyCheck(data) {
    // Lightweight check — production systems should use dedicated moderation APIs
    const textContent = JSON.stringify(data).toLowerCase();
    const flags = [];

    // Check for common issues in generated content
    if (textContent.includes('as an ai language model') || textContent.includes('i cannot')) {
      flags.push('AI refusal detected in output');
    }

    return {
      flagged: flags.length > 0,
      reason: flags.join('; '),
    };
  }
}

// Singleton
module.exports = { AIValidator: new AIValidator(), RESPONSE_SCHEMAS };
