/**
 * @module api/v1/users/user.controller
 */
const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const pick = require('../../../utils/pick');
const userService = require('./user.service');

const getUser = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.params.id);
  ApiResponse.ok(user).send(res);
});

const updateProfile = catchAsync(async (req, res) => {
  const user = await userService.updateProfile(req.user._id, req.body);
  ApiResponse.ok(user, 'Profile updated').send(res);
});

const listUsers = catchAsync(async (req, res) => {
  const filter = pick(req.query, ['search', 'role', 'skill']);
  const options = pick(req.query, ['page', 'limit', 'sortBy']);
  const result = await userService.listUsers(filter, options);
  ApiResponse.paginated(result.docs, result.pagination).send(res);
});

const followUser = catchAsync(async (req, res) => {
  await userService.followUser(req.user._id.toString(), req.params.id);
  ApiResponse.ok(null, 'User followed').send(res);
});

const unfollowUser = catchAsync(async (req, res) => {
  await userService.unfollowUser(req.user._id.toString(), req.params.id);
  ApiResponse.ok(null, 'User unfollowed').send(res);
});

const getFollowers = catchAsync(async (req, res) => {
  const options = pick(req.query, ['page', 'limit']);
  const result = await userService.getFollowers(req.params.id, options);
  ApiResponse.paginated(result.docs, result.pagination).send(res);
});

const getFollowing = catchAsync(async (req, res) => {
  const options = pick(req.query, ['page', 'limit']);
  const result = await userService.getFollowing(req.params.id, options);
  ApiResponse.paginated(result.docs, result.pagination).send(res);
});

module.exports = { getUser, updateProfile, listUsers, followUser, unfollowUser, getFollowers, getFollowing };
