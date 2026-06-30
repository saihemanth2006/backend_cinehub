/**
 * @module middleware
 * @description Middleware barrel export.
 */
const { authenticate } = require('./auth.middleware');
const { authorize, authorizeOwnerOrAdmin } = require('./rbac.middleware');
const { validate } = require('./validate.middleware');
const { errorHandler, notFoundHandler } = require('./errorHandler.middleware');
const { apiLimiter, authLimiter, sensitiveOpLimiter, aiLimiter } = require('./rateLimiter.middleware');
const { requestId } = require('./requestId.middleware');
const { uploadImage, uploadVideo, uploadMedia, uploadToMemory } = require('./upload.middleware');

module.exports = {
  authenticate,
  authorize,
  authorizeOwnerOrAdmin,
  validate,
  errorHandler,
  notFoundHandler,
  apiLimiter,
  authLimiter,
  sensitiveOpLimiter,
  aiLimiter,
  requestId,
  uploadImage,
  uploadVideo,
  uploadMedia,
  uploadToMemory,
};
