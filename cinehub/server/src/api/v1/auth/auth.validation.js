/**
 * @module api/v1/auth/auth.validation
 * @description Joi validation schemas for authentication endpoints.
 */
const Joi = require('joi');

const register = {
  body: Joi.object({
    email: Joi.string().email().required(),
    password: Joi.string().min(8).max(128).required()
      .pattern(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/)
      .message('Password must contain at least one uppercase, one lowercase, and one number'),
    firstName: Joi.string().trim().max(50).required(),
    lastName: Joi.string().trim().max(50).required(),
    role: Joi.string().valid('user', 'creator', 'producer'),
  }),
};

const login = {
  body: Joi.object({
    email: Joi.string().email().required(),
    password: Joi.string().required(),
  }),
};

const refreshTokens = {
  body: Joi.object({
    refreshToken: Joi.string().required(),
  }),
};

const forgotPassword = {
  body: Joi.object({
    email: Joi.string().email().required(),
  }),
};

const resetPassword = {
  body: Joi.object({
    token: Joi.string().required(),
    password: Joi.string().min(8).max(128).required(),
  }),
};

const verifyEmail = {
  query: Joi.object({
    token: Joi.string().required(),
  }),
};

const changePassword = {
  body: Joi.object({
    currentPassword: Joi.string().required(),
    newPassword: Joi.string().min(8).max(128).required()
      .disallow(Joi.ref('currentPassword'))
      .messages({ 'any.invalid': 'New password must be different from current password' }),
  }),
};

module.exports = { register, login, refreshTokens, forgotPassword, resetPassword, verifyEmail, changePassword };
