/**
 * @module repositories/base.repository
 * @description Abstract base repository providing generic CRUD operations.
 * All domain repositories extend this class — DRY data access patterns.
 */
class BaseRepository {
  /**
   * @param {import('mongoose').Model} model - Mongoose model
   */
  constructor(model) {
    this.model = model;
  }

  async create(data) {
    const doc = await this.model.create(data);
    return doc;
  }

  async findById(id, options = {}) {
    let query = this.model.findById(id);
    if (options.populate) query = query.populate(options.populate);
    if (options.select) query = query.select(options.select);
    if (options.lean !== false) query = query.lean();
    return query;
  }

  async findOne(filter, options = {}) {
    let query = this.model.findOne(filter);
    if (options.populate) query = query.populate(options.populate);
    if (options.select) query = query.select(options.select);
    if (options.lean !== false) query = query.lean();
    return query;
  }

  async find(filter = {}, options = {}) {
    let query = this.model.find(filter);
    if (options.sort) query = query.sort(options.sort);
    if (options.skip) query = query.skip(options.skip);
    if (options.limit) query = query.limit(options.limit);
    if (options.populate) query = query.populate(options.populate);
    if (options.select) query = query.select(options.select);
    if (options.lean !== false) query = query.lean();
    return query;
  }

  async paginate(filter = {}, options = {}) {
    return this.model.paginate(filter, options);
  }

  async updateById(id, updateData) {
    return this.model.findByIdAndUpdate(id, updateData, { new: true, runValidators: true }).lean();
  }

  async updateOne(filter, updateData) {
    return this.model.findOneAndUpdate(filter, updateData, { new: true, runValidators: true }).lean();
  }

  async deleteById(id) {
    return this.model.findByIdAndDelete(id);
  }

  async softDeleteById(id, userId) {
    const doc = await this.model.findById(id);
    if (doc && doc.softDelete) return doc.softDelete(userId);
    return null;
  }

  async count(filter = {}) {
    return this.model.countDocuments(filter);
  }

  async exists(filter) {
    const doc = await this.model.exists(filter);
    return !!doc;
  }

  async aggregate(pipeline) {
    return this.model.aggregate(pipeline);
  }

  async bulkWrite(operations) {
    return this.model.bulkWrite(operations);
  }
}

module.exports = BaseRepository;
