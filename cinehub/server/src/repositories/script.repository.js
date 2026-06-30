/**
 * @module repositories/script.repository
 */
const BaseRepository = require('./base.repository');
const Script = require('../models/script.model');

class ScriptRepository extends BaseRepository {
  constructor() { super(Script); }

  async findByProject(projectId, options = {}) {
    return this.paginate({ project: projectId }, { ...options, populate: 'author' });
  }

  async findByAuthor(authorId, options = {}) {
    return this.paginate({ author: authorId }, { ...options, sort: { updatedAt: -1 } });
  }

  async findLatestVersion(scriptId) {
    return this.findById(scriptId, { populate: 'author project', lean: false });
  }

  async addVersion(scriptId, versionData) {
    return this.model.findByIdAndUpdate(scriptId, {
      $push: { versions: versionData },
      $inc: { version: 1 },
      content: versionData.content,
    }, { new: true });
  }
}

module.exports = new ScriptRepository();
