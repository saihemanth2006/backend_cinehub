/**
 * @module utils/pagination
 * @description Standardized pagination utilities for list endpoints.
 * Supports cursor-based and offset-based pagination patterns.
 */

const DEFAULT_PAGE = 1;
const DEFAULT_LIMIT = 20;
const MAX_LIMIT = 100;

/**
 * Parses and normalizes pagination parameters from query string.
 * @param {Object} query - Express req.query
 * @returns {{ page: number, limit: number, skip: number, sort: Object }}
 */
function parsePaginationParams(query) {
  const page = Math.max(1, parseInt(query.page, 10) || DEFAULT_PAGE);
  const limit = Math.min(MAX_LIMIT, Math.max(1, parseInt(query.limit, 10) || DEFAULT_LIMIT));
  const skip = (page - 1) * limit;

  // Sort parsing: "createdAt:desc,name:asc" → { createdAt: -1, name: 1 }
  const sort = {};
  if (query.sortBy) {
    query.sortBy.split(',').forEach((field) => {
      const [key, order] = field.split(':');
      sort[key] = order === 'desc' ? -1 : 1;
    });
  } else {
    sort.createdAt = -1; // Default: newest first
  }

  return { page, limit, skip, sort };
}

/**
 * Builds the pagination metadata object for API responses.
 * @param {number} totalDocs - Total matching documents
 * @param {number} page - Current page
 * @param {number} limit - Items per page
 * @returns {Object} Pagination metadata
 */
function buildPaginationMeta(totalDocs, page, limit) {
  const totalPages = Math.ceil(totalDocs / limit);

  return {
    totalDocs,
    totalPages,
    page,
    limit,
    hasNextPage: page < totalPages,
    hasPrevPage: page > 1,
    nextPage: page < totalPages ? page + 1 : null,
    prevPage: page > 1 ? page - 1 : null,
  };
}

module.exports = {
  parsePaginationParams,
  buildPaginationMeta,
  DEFAULT_PAGE,
  DEFAULT_LIMIT,
  MAX_LIMIT,
};
