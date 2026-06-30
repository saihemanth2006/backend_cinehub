/**
 * @module api/v1/scripts/script.service
 */
const ApiError = require('../../../utils/ApiError');
const scriptRepo = require('../../../repositories/script.repository');
const projectRepo = require('../../../repositories/project.repository');
const eventEmitter = require('../../../events/emitter');

class ScriptService {
  async createScript(userId, data) {
    const project = await projectRepo.findById(data.projectId);
    if (!project) throw ApiError.notFound('Project not found');
    if (project.owner.toString() !== userId.toString()) {
      throw ApiError.forbidden('You do not have access to this project');
    }

    const script = await scriptRepo.create({
      title: data.title,
      format: data.format,
      content: data.content || '',
      logline: data.logline,
      synopsis: data.synopsis,
      project: data.projectId,
      author: userId,
      versions: [{ version: 1, content: data.content || '', createdBy: userId, changelog: 'Initial version' }],
    });

    await projectRepo.updateById(data.projectId, { $push: { scripts: script._id } });
    return script;
  }

  async getScriptById(id) {
    const script = await scriptRepo.findById(id, { populate: 'author project' });
    if (!script) throw ApiError.notFound('Script not found');
    return script;
  }

  async updateScript(scriptId, userId, updateData) {
    const script = await scriptRepo.findById(scriptId);
    if (!script) throw ApiError.notFound('Script not found');
    if (script.author.toString() !== userId.toString()) {
      throw ApiError.forbidden('Only the author can update this script');
    }

    // If content changed, create a new version
    if (updateData.content && updateData.content !== script.content) {
      await scriptRepo.addVersion(scriptId, {
        version: (script.version || 1) + 1,
        content: updateData.content,
        createdBy: userId,
        changelog: updateData.changelog || `Version ${(script.version || 1) + 1}`,
      });
      delete updateData.changelog;
    }

    return scriptRepo.updateById(scriptId, updateData);
  }

  async deleteScript(scriptId, userId) {
    const script = await scriptRepo.findById(scriptId);
    if (!script) throw ApiError.notFound('Script not found');
    if (script.author.toString() !== userId.toString()) {
      throw ApiError.forbidden('Only the author can delete this script');
    }
    await scriptRepo.softDeleteById(scriptId, userId);
    await projectRepo.updateById(script.project, { $pull: { scripts: scriptId } });
  }

  async getProjectScripts(projectId, options) {
    return scriptRepo.findByProject(projectId, options);
  }

  async getMyScripts(userId, options) {
    return scriptRepo.findByAuthor(userId, options);
  }

  async saveAIGeneratedScript(userId, projectId, aiResult, metadata) {
    const script = await scriptRepo.create({
      title: aiResult.title || 'AI Generated Script',
      format: metadata.format,
      content: aiResult.content,
      logline: aiResult.logline,
      synopsis: aiResult.synopsis,
      project: projectId,
      author: userId,
      aiGenerated: true,
      aiMetadata: metadata,
      status: 'draft',
      versions: [{ version: 1, content: aiResult.content, createdBy: userId, changelog: 'AI generated' }],
    });

    await projectRepo.updateById(projectId, { $push: { scripts: script._id } });
    eventEmitter.emit('script:aiGenerated', { scriptId: script._id, userId, projectId });
    return script;
  }
}

module.exports = new ScriptService();
