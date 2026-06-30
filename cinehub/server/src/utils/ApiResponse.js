/**
 * @module utils/ApiResponse
 * @description Standardized API response envelope.
 * Every successful response follows the same shape for consistent client parsing.
 *
 * Shape: { status, statusCode, message, data, meta? }
 */
const httpStatus = require('http-status');

class ApiResponse {
  /**
   * @param {number} statusCode
   * @param {string} message
   * @param {*} data
   * @param {Object} [meta] - Pagination, counts, etc.
   */
  constructor(statusCode, message, data = null, meta = null) {
    this.status = 'success';
    this.statusCode = statusCode;
    this.message = message;
    this.data = data;
    if (meta) this.meta = meta;
  }

  /**
   * Sends the response via Express res object.
   * @param {import('express').Response} res
   */
  send(res) {
    return res.status(this.statusCode).json(this);
  }

  // ── Factory Methods ─────────────────────────

  static ok(data, message = 'Success', meta) {
    return new ApiResponse(httpStatus.OK, message, data, meta);
  }

  static created(data, message = 'Resource created') {
    return new ApiResponse(httpStatus.CREATED, message, data);
  }

  static noContent(message = 'No content') {
    return new ApiResponse(httpStatus.NO_CONTENT, message);
  }

  static paginated(data, pagination, message = 'Success') {
    return new ApiResponse(httpStatus.OK, message, data, { pagination });
  }
}

module.exports = ApiResponse;
