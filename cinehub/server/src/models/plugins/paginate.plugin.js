/**
 * @module models/plugins/paginate
 * @description Mongoose plugin adding a static `paginate` method to models.
 * Supports filtering, sorting, population, field selection, and pagination.
 *
 * @example
 * const result = await User.paginate(
 *   { role: 'creator' },
 *   { page: 2, limit: 10, sort: { createdAt: -1 }, populate: 'projects' }
 * );
 */
const paginate = (schema) => {
  /**
   * @param {Object} filter - Mongoose filter object
   * @param {Object} options
   * @param {number} [options.page=1]
   * @param {number} [options.limit=20]
   * @param {Object} [options.sort]
   * @param {string|Object} [options.populate]
   * @param {string} [options.select]
   * @returns {Promise<{ docs: Array, pagination: Object }>}
   */
  schema.statics.paginate = async function paginateQuery(filter = {}, options = {}) {
    const page = Math.max(1, parseInt(options.page, 10) || 1);
    const limit = Math.min(100, Math.max(1, parseInt(options.limit, 10) || 20));
    const skip = (page - 1) * limit;
    const sort = options.sort || { createdAt: -1 };

    const [docs, totalDocs] = await Promise.all([
      this.find(filter)
        .sort(sort)
        .skip(skip)
        .limit(limit)
        .select(options.select || '')
        .populate(options.populate || '')
        .lean(),
      this.countDocuments(filter),
    ]);

    const totalPages = Math.ceil(totalDocs / limit);

    return {
      docs,
      pagination: {
        totalDocs,
        totalPages,
        page,
        limit,
        hasNextPage: page < totalPages,
        hasPrevPage: page > 1,
        nextPage: page < totalPages ? page + 1 : null,
        prevPage: page > 1 ? page - 1 : null,
      },
    };
  };
};

module.exports = paginate;
