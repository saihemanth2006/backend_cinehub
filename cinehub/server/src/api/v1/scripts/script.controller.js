/**
 * @module api/v1/scripts/script.controller
 */
const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const pick = require('../../../utils/pick');
const scriptService = require('./script.service');

const create = catchAsync(async (req, res) => {
  const script = await scriptService.createScript(req.user._id, req.body);
  ApiResponse.created(script, 'Script created').send(res);
});

const getById = catchAsync(async (req, res) => {
  const script = await scriptService.getScriptById(req.params.id);
  ApiResponse.ok(script).send(res);
});

const update = catchAsync(async (req, res) => {
  const script = await scriptService.updateScript(req.params.id, req.user._id, req.body);
  ApiResponse.ok(script, 'Script updated').send(res);
});

const remove = catchAsync(async (req, res) => {
  await scriptService.deleteScript(req.params.id, req.user._id);
  ApiResponse.ok(null, 'Script deleted').send(res);
});

const getProjectScripts = catchAsync(async (req, res) => {
  const options = pick(req.query, ['page', 'limit']);
  const result = await scriptService.getProjectScripts(req.params.projectId, options);
  ApiResponse.paginated(result.docs, result.pagination).send(res);
});

const myScripts = catchAsync(async (req, res) => {
  const options = pick(req.query, ['page', 'limit']);
  const result = await scriptService.getMyScripts(req.user._id, options);
  ApiResponse.paginated(result.docs, result.pagination).send(res);
});

module.exports = { create, getById, update, remove, getProjectScripts, myScripts };
