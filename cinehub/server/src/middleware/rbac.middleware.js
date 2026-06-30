/**
 * @module middleware/rbac
 * @description Role-Based Access Control middleware.
 * Restricts route access to users with specific roles.
 * Must be placed AFTER auth middleware in the chain.
 *
 * @example
 * router.delete('/users/:id', authenticate(), authorize('admin', 'superAdmin'), controller.delete);
 */
const ApiError = require('../utils/ApiError');

/**
 * Creates authorization middleware that checks user roles.
 * @param {...string} allowedRoles - Roles permitted to access the route
 * @returns {Function} Express middleware
 */
const authorize = (...allowedRoles) => (req, _res, next) => {
  if (!req.user) {
    return next(ApiError.unauthorized('Authentication required', 'AUTH_REQUIRED'));
  }

  if (!allowedRoles.includes(req.user.role)) {
    return next(
      ApiError.forbidden(
        `Role '${req.user.role}' is not authorized to access this resource`,
        'AUTH_INSUFFICIENT_ROLE',
      ),
    );
  }

  next();
};

/**
 * Middleware that restricts access to the resource owner or admins.
 * Compares req.params.id (or a custom field) against req.user._id.
 * @param {string} [paramField='id'] - The req.params field containing the owner ID
 * @returns {Function} Express middleware
 */
const authorizeOwnerOrAdmin = (paramField = 'id') => (req, _res, next) => {
  if (!req.user) {
    return next(ApiError.unauthorized('Authentication required'));
  }

  const isOwner = req.params[paramField] === req.user._id.toString();
  const isAdmin = ['admin', 'superAdmin'].includes(req.user.role);

  if (!isOwner && !isAdmin) {
    return next(ApiError.forbidden('You can only access your own resources', 'AUTH_NOT_OWNER'));
  }

  next();
};

module.exports = { authorize, authorizeOwnerOrAdmin };
