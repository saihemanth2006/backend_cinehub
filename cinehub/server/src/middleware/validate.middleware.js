/**
 * @module middleware/validate
 * @description Request validation middleware using Joi schemas.
 * Validates body, query, and params separately with detailed error messages.
 *
 * @example
 * router.post('/users', validate(userValidation.create), controller.create);
 */
const Joi = require('joi');

const ApiError = require('../utils/ApiError');

/**
 * Creates validation middleware from a Joi schema definition.
 * @param {Object} schema - Object with optional body, query, params Joi schemas
 * @returns {Function} Express middleware
 */
const validate = (schema) => (req, _res, next) => {
  const validSchema = {};
  const validFields = ['params', 'query', 'body'];

  validFields.forEach((field) => {
    if (schema[field]) {
      validSchema[field] = schema[field];
    }
  });

  const objectToValidate = {};
  Object.keys(validSchema).forEach((field) => {
    objectToValidate[field] = req[field];
  });

  const { error, value } = Joi.object(validSchema)
    .prefs({ errors: { label: 'key' }, abortEarly: false })
    .validate(objectToValidate);

  if (error) {
    const errors = error.details.map((detail) => ({
      field: detail.path.join('.'),
      message: detail.message.replace(/"/g, ''),
      type: detail.type,
    }));

    return next(ApiError.badRequest('Validation failed', 'VALIDATION_ERROR', errors));
  }

  // Replace req fields with validated (and sanitized) values
  Object.keys(value).forEach((field) => {
    req[field] = value[field];
  });

  next();
};

module.exports = { validate };
