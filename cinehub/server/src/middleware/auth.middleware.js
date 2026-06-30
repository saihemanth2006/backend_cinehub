/**
 * @module middleware/auth
 * @description JWT authentication middleware.
 * Extracts Bearer token, verifies it, attaches user to req.user.
 * Supports optional authentication for public-with-bonus endpoints.
 */
const httpStatus = require('http-status');

const { env } = require('../config');
const ApiError = require('../utils/ApiError');
const { verifyToken, TOKEN_TYPES } = require('../utils/token');
const User = require('../models/user.model');

/**
 * Middleware factory for JWT authentication.
 * @param {Object} [options]
 * @param {boolean} [options.optional=false] - If true, continues without user if no token
 * @returns {Function} Express middleware
 */
const authenticate = (options = {}) => async (req, _res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      if (options.optional) {
        req.user = null;
        return next();
      }
      throw ApiError.unauthorized('Access token is required', 'AUTH_NO_TOKEN');
    }

    const token = authHeader.split(' ')[1];
    const decoded = verifyToken(token, env.jwt.accessSecret);

    if (decoded.type !== TOKEN_TYPES.ACCESS) {
      throw ApiError.unauthorized('Invalid token type', 'AUTH_WRONG_TOKEN_TYPE');
    }

    const user = await User.findById(decoded.sub).select('-password');
    if (!user) {
      throw ApiError.unauthorized('User not found', 'AUTH_USER_NOT_FOUND');
    }

    if (!user.isActive) {
      throw ApiError.forbidden('Account is deactivated', 'AUTH_ACCOUNT_DEACTIVATED');
    }

    req.user = user;
    req.tokenPayload = decoded;
    next();
  } catch (err) {
    next(err instanceof ApiError ? err : ApiError.unauthorized(err.message));
  }
};

module.exports = { authenticate };
