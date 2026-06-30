const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const pick = require('../../../utils/pick');
const teamService = require('./team.service');

const getByProject = catchAsync(async (req, res) => {
  const team = await teamService.getTeamByProject(req.params.projectId);
  ApiResponse.ok(team).send(res);
});

const myTeams = catchAsync(async (req, res) => {
  const options = pick(req.query, ['page', 'limit']);
  const result = await teamService.getMyTeams(req.user._id, options);
  ApiResponse.paginated(result.docs, result.pagination).send(res);
});

const inviteMember = catchAsync(async (req, res) => {
  const team = await teamService.inviteMember(req.params.id, req.user._id, req.body);
  ApiResponse.ok(team, 'Member invited').send(res);
});

const respondToInvite = catchAsync(async (req, res) => {
  const team = await teamService.respondToInvite(req.params.id, req.user._id, req.body.accept);
  ApiResponse.ok(team, req.body.accept ? 'Invitation accepted' : 'Invitation declined').send(res);
});

const removeMember = catchAsync(async (req, res) => {
  const team = await teamService.removeMember(req.params.id, req.user._id, req.params.userId);
  ApiResponse.ok(team, 'Member removed').send(res);
});

module.exports = { getByProject, myTeams, inviteMember, respondToInvite, removeMember };
