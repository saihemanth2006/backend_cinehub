/**
 * @module api/v1/projects/project.controller
 */
const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const pick = require('../../../utils/pick');
const projectService = require('./project.service');

const create = catchAsync(async (req, res) => {
  const project = await projectService.createProject(req.user._id, req.body);
  ApiResponse.created(project, 'Project created').send(res);
});

const getById = catchAsync(async (req, res) => {
  const project = await projectService.getProjectById(req.params.id);
  ApiResponse.ok(project).send(res);
});

const getBySlug = catchAsync(async (req, res) => {
  const project = await projectService.getProjectBySlug(req.params.slug);
  ApiResponse.ok(project).send(res);
});

const update = catchAsync(async (req, res) => {
  const project = await projectService.updateProject(req.params.id, req.user._id, req.body);
  ApiResponse.ok(project, 'Project updated').send(res);
});

const remove = catchAsync(async (req, res) => {
  await projectService.deleteProject(req.params.id, req.user._id);
  ApiResponse.ok(null, 'Project deleted').send(res);
});

const list = catchAsync(async (req, res) => {
  const filter = pick(req.query, ['search', 'type', 'status', 'genre']);
  const options = pick(req.query, ['page', 'limit', 'sortBy']);
  const result = await projectService.listProjects(filter, options);
  ApiResponse.paginated(result.docs, result.pagination).send(res);
});

const myProjects = catchAsync(async (req, res) => {
  const options = pick(req.query, ['page', 'limit', 'sortBy']);
  const result = await projectService.getMyProjects(req.user._id, options);
  ApiResponse.paginated(result.docs, result.pagination).send(res);
});

module.exports = { create, getById, getBySlug, update, remove, list, myProjects };
