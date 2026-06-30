/**
 * @module utils/token
 * @description JWT token generation and verification utilities.
 * Handles access tokens, refresh tokens, and special-purpose tokens
 * (password reset, email verification).
 */
const jwt = require('jsonwebtoken');

const { env } = require('../config');
const ApiError = require('./ApiError');

/** Token types for identification in payloads */
const TOKEN_TYPES = Object.freeze({
  ACCESS: 'access',
  REFRESH: 'refresh',
  RESET_PASSWORD: 'resetPassword',
  VERIFY_EMAIL: 'verifyEmail',
});

/**
 * Generates a signed JWT token.
 * @param {Object} payload - Data to encode
 * @param {string} secret - Signing secret
 * @param {string} expiresIn - Expiration string (e.g., '15m', '7d')
 * @returns {string} Signed JWT
 */
function generateToken(payload, secret, expiresIn) {
  return jwt.sign(payload, secret, {
    expiresIn,
    issuer: env.appName,
    audience: env.appUrl,
  });
}

/**
 * Verifies and decodes a JWT token.
 * @param {string} token
 * @param {string} secret
 * @returns {Object} Decoded payload
 * @throws {ApiError} If token is invalid or expired
 */
function verifyToken(token, secret) {
  try {
    return jwt.verify(token, secret, {
      issuer: env.appName,
      audience: env.appUrl,
    });
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      throw ApiError.unauthorized('Token has expired', 'AUTH_TOKEN_EXPIRED');
    }
    if (err.name === 'JsonWebTokenError') {
      throw ApiError.unauthorized('Invalid token', 'AUTH_TOKEN_INVALID');
    }
    throw ApiError.unauthorized('Token verification failed', 'AUTH_TOKEN_FAILED');
  }
}

/**
 * Generates the full auth token pair (access + refresh).
 * @param {Object} user - User document (must have _id and role)
 * @returns {{ accessToken: string, refreshToken: string, expiresIn: string }}
 */
function generateAuthTokens(user) {
  const payload = {
    sub: user._id,
    role: user.role,
    type: TOKEN_TYPES.ACCESS,
  };

  const accessToken = generateToken(
    { ...payload, type: TOKEN_TYPES.ACCESS },
    env.jwt.accessSecret,
    env.jwt.accessExpiration,
  );

  const refreshToken = generateToken(
    { sub: user._id, type: TOKEN_TYPES.REFRESH },
    env.jwt.refreshSecret,
    env.jwt.refreshExpiration,
  );

  return {
    accessToken,
    refreshToken,
    expiresIn: env.jwt.accessExpiration,
  };
}

/**
 * Generates a password reset token.
 * @param {string} userId
 * @returns {string}
 */
function generateResetPasswordToken(userId) {
  return generateToken(
    { sub: userId, type: TOKEN_TYPES.RESET_PASSWORD },
    env.jwt.accessSecret,
    env.jwt.resetPasswordExpiration,
  );
}

/**
 * Generates an email verification token.
 * @param {string} userId
 * @returns {string}
 */
function generateVerifyEmailToken(userId) {
  return generateToken(
    { sub: userId, type: TOKEN_TYPES.VERIFY_EMAIL },
    env.jwt.accessSecret,
    env.jwt.verifyEmailExpiration,
  );
}

module.exports = {
  TOKEN_TYPES,
  generateToken,
  verifyToken,
  generateAuthTokens,
  generateResetPasswordToken,
  generateVerifyEmailToken,
};
