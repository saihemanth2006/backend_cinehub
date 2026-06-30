/**
 * @module repositories/project.repository
 */
const BaseRepository = require('./base.repository');
const Project = require('../models/project.model');

class ProjectRepository extends BaseRepository {
  constructor() { super(Project); }

  async findByOwner(ownerId, options = {}) {
    return this.paginate({ owner: ownerId }, { ...options, populate: 'owner team' });
  }

  async findPublicProjects(options = {}) {
    return this.paginate({ visibility: 'public', status: { $ne: 'archived' } }, { ...options, populate: 'owner' });
  }

  async findBySlug(slug) {
    return this.findOne({ slug }, { populate: 'owner team scripts' });
  }

  async searchProjects(query, options = {}) {
    return this.paginate({ $text: { $search: query }, visibility: 'public' }, options);
  }

  async findByGenres(genres, options = {}) {
    return this.paginate({ genres: { $in: genres }, visibility: 'public' }, options);
  }

  async incrementViewCount(projectId) {
    return this.model.findByIdAndUpdate(projectId, { $inc: { viewCount: 1 } });
  }

  async getProjectStats(ownerId) {
    return this.aggregate([
      { $match: { owner: require('mongoose').Types.ObjectId(ownerId) } },
      { $group: { _id: '$status', count: { $sum: 1 }, totalViews: { $sum: '$viewCount' } } },
    ]);
  }
}

module.exports = new ProjectRepository();
