/**
 * @module middleware/errorHandler
 * @description Global error handling middleware.
 * Normalizes all errors into consistent ApiError shape.
 * Handles Mongoose errors, JWT errors, Multer errors, and unknown errors.
 */
const httpStatus = require('http-status');
const mongoose = require('mongoose');

const { env, logger } = require('../config');
const ApiError = require('../utils/ApiError');

/**
 * Converts known error types into ApiError instances.
 * @param {Error} err
 * @returns {ApiError}
 */
function normalizeError(err) {
  // Already an ApiError
  if (err instanceof ApiError) return err;

  // Mongoose validation error
  if (err instanceof mongoose.Error.ValidationError) {
    const errors = Object.values(err.errors).map((e) => ({
      field: e.path,
      message: e.message,
      type: 'validation',
    }));
    return ApiError.badRequest('Validation failed', 'MONGOOSE_VALIDATION', errors);
  }

  // Mongoose cast error (invalid ObjectId, etc.)
  if (err instanceof mongoose.Error.CastError) {
    return ApiError.badRequest(`Invalid ${err.path}: ${err.value}`, 'INVALID_ID');
  }

  // MongoDB duplicate key error
  if (err.code === 11000) {
    const field = Object.keys(err.keyValue || {})[0];
    return ApiError.conflict(
      `Duplicate value for '${field}': '${err.keyValue?.[field]}'`,
      'DUPLICATE_KEY',
    );
  }

  // Multer file upload errors
  if (err.code === 'LIMIT_FILE_SIZE') {
    return ApiError.badRequest('File size exceeds the allowed limit', 'FILE_TOO_LARGE');
  }
  if (err.code === 'LIMIT_UNEXPECTED_FILE') {
    return ApiError.badRequest('Unexpected file field', 'UNEXPECTED_FILE');
  }

  // SyntaxError (malformed JSON body)
  if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
    return ApiError.badRequest('Malformed JSON in request body', 'INVALID_JSON');
  }

  // Unknown / programmer error
  return ApiError.internal(err.message || 'An unexpected error occurred');
}

/**
 * Express error-handling middleware (4 args signature).
 */
// eslint-disable-next-line no-unused-vars
const errorHandler = (err, req, res, _next) => {
  const apiError = normalizeError(err);

  // Log based on severity
  if (apiError.statusCode >= 500) {
    logger.error(`[${req.method}] ${req.originalUrl}`, {
      error: apiError.message,
      stack: err.stack,
      requestId: req.id,
      statusCode: apiError.statusCode,
    });
  } else {
    logger.warn(`[${req.method}] ${req.originalUrl}`, {
      error: apiError.message,
      requestId: req.id,
      statusCode: apiError.statusCode,
    });
  }

  const response = {
    ...apiError.toJSON(),
    ...(env.isDev && { stack: err.stack }),
  };

  res.status(apiError.statusCode).json(response);
};

/**
 * 404 handler for unmatched routes.
 */
const notFoundHandler = (req, _res, next) => {
  next(ApiError.notFound(`Route not found: ${req.method} ${req.originalUrl}`));
};

module.exports = { errorHandler, notFoundHandler };
