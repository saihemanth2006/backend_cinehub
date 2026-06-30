/**
 * @module api/v1/projects/project.service
 */
const ApiError = require('../../../utils/ApiError');
const projectRepo = require('../../../repositories/project.repository');
const teamRepo = require('../../../repositories/team.repository');
const eventEmitter = require('../../../events/emitter');

class ProjectService {
  async createProject(userId, data) {
    const project = await projectRepo.create({ ...data, owner: userId });

    // Auto-create team for the project
    const team = await teamRepo.create({
      name: `${project.title} Team`,
      project: project._id,
      owner: userId,
      members: [{ user: userId, role: 'owner', status: 'active', joinedAt: new Date() }],
    });

    await projectRepo.updateById(project._id, { team: team._id });
    eventEmitter.emit('project:created', { projectId: project._id, ownerId: userId });

    return { ...project.toJSON ? project.toJSON() : project, team: team._id };
  }

  async getProjectById(id) {
    const project = await projectRepo.findById(id, { populate: 'owner team' });
    if (!project) throw ApiError.notFound('Project not found');
    return project;
  }

  async getProjectBySlug(slug) {
    const project = await projectRepo.findBySlug(slug);
    if (!project) throw ApiError.notFound('Project not found');
    await projectRepo.incrementViewCount(project._id);
    return project;
  }

  async updateProject(projectId, userId, updateData) {
    const project = await projectRepo.findById(projectId);
    if (!project) throw ApiError.notFound('Project not found');
    if (project.owner.toString() !== userId.toString()) {
      throw ApiError.forbidden('Only the project owner can update this project');
    }
    return projectRepo.updateById(projectId, updateData);
  }

  async deleteProject(projectId, userId) {
    const project = await projectRepo.findById(projectId);
    if (!project) throw ApiError.notFound('Project not found');
    if (project.owner.toString() !== userId.toString()) {
      throw ApiError.forbidden('Only the project owner can delete this project');
    }
    await projectRepo.softDeleteById(projectId, userId);
    eventEmitter.emit('project:deleted', { projectId, ownerId: userId });
  }

  async listProjects(filter, options) {
    const query = { visibility: 'public' };
    if (filter.type) query.type = filter.type;
    if (filter.status) query.status = filter.status;
    if (filter.genre) query.genres = { $in: [filter.genre] };
    if (filter.search) query.$text = { $search: filter.search };
    return projectRepo.paginate(query, { ...options, populate: 'owner' });
  }

  async getMyProjects(userId, options) {
    return projectRepo.findByOwner(userId, options);
  }

  async getProjectStats(userId) {
    return projectRepo.getProjectStats(userId);
  }
}

module.exports = new ProjectService();
