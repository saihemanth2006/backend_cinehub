/**
 * @module api/v1/auth/auth.controller
 * @description Auth controller — thin layer delegating to AuthService.
 */
const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const authService = require('./auth.service');

const register = catchAsync(async (req, res) => {
  const result = await authService.register(req.body);
  ApiResponse.created(result, 'Registration successful').send(res);
});

const login = catchAsync(async (req, res) => {
  const { email, password } = req.body;
  const result = await authService.login(email, password);
  ApiResponse.ok(result, 'Login successful').send(res);
});

const refreshTokens = catchAsync(async (req, res) => {
  const tokens = await authService.refreshTokens(req.body.refreshToken);
  ApiResponse.ok(tokens, 'Tokens refreshed').send(res);
});

const logout = catchAsync(async (req, res) => {
  await authService.logout(req.user._id);
  ApiResponse.ok(null, 'Logged out successfully').send(res);
});

const forgotPassword = catchAsync(async (req, res) => {
  await authService.forgotPassword(req.body.email);
  ApiResponse.ok(null, 'If the email exists, a reset link has been sent').send(res);
});

const resetPassword = catchAsync(async (req, res) => {
  await authService.resetPassword(req.body.token, req.body.password);
  ApiResponse.ok(null, 'Password reset successful').send(res);
});

const changePassword = catchAsync(async (req, res) => {
  await authService.changePassword(req.user._id, req.body.currentPassword, req.body.newPassword);
  ApiResponse.ok(null, 'Password changed successfully').send(res);
});

const verifyEmail = catchAsync(async (req, res) => {
  await authService.verifyEmail(req.query.token);
  ApiResponse.ok(null, 'Email verified successfully').send(res);
});

const getMe = catchAsync(async (req, res) => {
  ApiResponse.ok(req.user, 'Current user retrieved').send(res);
});

module.exports = { register, login, refreshTokens, logout, forgotPassword, resetPassword, changePassword, verifyEmail, getMe };
