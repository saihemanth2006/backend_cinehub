/**
 * @module middleware/rateLimiter
 * @description Rate limiting middleware with tiered limits.
 * Provides different rate limits for public, authenticated, and sensitive endpoints.
 */
const rateLimit = require('express-rate-limit');

const { env } = require('../config');
const ApiError = require('../utils/ApiError');

const createLimiter = (windowMs, max, message) => rateLimit({
  windowMs,
  max,
  standardHeaders: true,
  legacyHeaders: false,
  skipSuccessfulRequests: false,
  handler: (_req, _res, next) => {
    next(ApiError.tooManyRequests(message, 'RATE_LIMIT_EXCEEDED'));
  },
  // Use user ID for authenticated requests, IP for anonymous
  keyGenerator: (req) => (req.user ? `user:${req.user._id}` : req.ip),
});

/** Default API rate limiter */
const apiLimiter = createLimiter(
  env.rateLimit.windowMs,
  env.rateLimit.maxRequests,
  'Too many requests. Please try again later.',
);

/** Stricter limiter for authentication endpoints (login, register) */
const authLimiter = createLimiter(
  15 * 60 * 1000, // 15 minutes
  20,             // 20 attempts
  'Too many authentication attempts. Please wait 15 minutes.',
);

/** Aggressive limiter for password reset / OTP */
const sensitiveOpLimiter = createLimiter(
  60 * 60 * 1000, // 1 hour
  5,              // 5 attempts
  'Too many sensitive operation attempts. Please wait 1 hour.',
);

/** Relaxed limiter for AI generation endpoints (expensive ops) */
const aiLimiter = createLimiter(
  60 * 60 * 1000, // 1 hour
  30,             // 30 generations per hour
  'AI generation limit reached. Please wait before generating more.',
);

module.exports = {
  apiLimiter,
  authLimiter,
  sensitiveOpLimiter,
  aiLimiter,
};
