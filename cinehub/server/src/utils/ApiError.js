/**
 * @module utils/ApiError
 * @description Operational error class for predictable API failures.
 * Distinguishes operational errors (invalid input, not found) from
 * programmer errors (bugs) — only operational errors reach the client.
 */
const httpStatus = require('http-status');

class ApiError extends Error {
  /**
   * @param {number} statusCode - HTTP status code
   * @param {string} message - Human-readable error message
   * @param {Object} [options]
   * @param {boolean} [options.isOperational=true] - Operational vs programmer error
   * @param {string} [options.code] - Machine-readable error code (e.g., 'AUTH_TOKEN_EXPIRED')
   * @param {Array} [options.errors] - Field-level validation errors
   * @param {string} [options.stack] - Stack trace override
   */
  constructor(statusCode, message, options = {}) {
    super(message);
    this.name = 'ApiError';
    this.statusCode = statusCode;
    this.isOperational = options.isOperational ?? true;
    this.code = options.code || null;
    this.errors = options.errors || [];

    if (options.stack) {
      this.stack = options.stack;
    } else {
      Error.captureStackTrace(this, this.constructor);
    }
  }

  // ── Factory Methods ─────────────────────────

  static badRequest(message = 'Bad Request', code, errors) {
    return new ApiError(httpStatus.BAD_REQUEST, message, { code, errors });
  }

  static unauthorized(message = 'Unauthorized', code) {
    return new ApiError(httpStatus.UNAUTHORIZED, message, { code });
  }

  static forbidden(message = 'Forbidden', code) {
    return new ApiError(httpStatus.FORBIDDEN, message, { code });
  }

  static notFound(message = 'Resource not found', code) {
    return new ApiError(httpStatus.NOT_FOUND, message, { code });
  }

  static conflict(message = 'Resource conflict', code) {
    return new ApiError(httpStatus.CONFLICT, message, { code });
  }

  static tooManyRequests(message = 'Too many requests', code) {
    return new ApiError(httpStatus.TOO_MANY_REQUESTS, message, { code });
  }

  static internal(message = 'Internal Server Error', code) {
    return new ApiError(httpStatus.INTERNAL_SERVER_ERROR, message, {
      code,
      isOperational: false,
    });
  }

  static serviceUnavailable(message = 'Service temporarily unavailable', code) {
    return new ApiError(httpStatus.SERVICE_UNAVAILABLE, message, { code });
  }

  /**
   * Serializes the error for API response.
   * Hides stack traces and internal details in production.
   */
  toJSON() {
    return {
      status: 'error',
      statusCode: this.statusCode,
      message: this.message,
      ...(this.code && { code: this.code }),
      ...(this.errors.length && { errors: this.errors }),
    };
  }
}

module.exports = ApiError;
