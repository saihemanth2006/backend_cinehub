/**
 * @module repositories/media.repository
 */
const BaseRepository = require('./base.repository');
const Media = require('../models/media.model');

class MediaRepository extends BaseRepository {
  constructor() { super(Media); }

  async findByUploader(userId, options = {}) {
    return this.paginate({ uploadedBy: userId }, options);
  }

  async findByProject(projectId, options = {}) {
    return this.paginate({ project: projectId }, options);
  }

  async findByType(type, options = {}) {
    return this.paginate({ type }, options);
  }

  async updateProcessingStatus(mediaId, status) {
    return this.updateById(mediaId, { processingStatus: status, isProcessed: status === 'completed' });
  }

  async getStorageUsage(userId) {
    const result = await this.aggregate([
      { $match: { uploadedBy: require('mongoose').Types.ObjectId(userId) } },
      { $group: { _id: '$type', totalSize: { $sum: '$size' }, count: { $sum: 1 } } },
    ]);
    return result;
  }
}

module.exports = new MediaRepository();
