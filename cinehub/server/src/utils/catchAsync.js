/**
 * @module utils/catchAsync
 * @description Higher-order function that wraps async Express handlers,
 * catching rejected promises and forwarding them to Express error middleware.
 * Eliminates repetitive try/catch blocks in every controller.
 *
 * @example
 * router.get('/users', catchAsync(async (req, res) => {
 *   const users = await userService.getAll();
 *   ApiResponse.ok(users).send(res);
 * }));
 *
 * @param {Function} fn - Async Express route handler
 * @returns {Function} Express middleware
 */
const catchAsync = (fn) => (req, res, next) => {
  Promise.resolve(fn(req, res, next)).catch(next);
};

module.exports = catchAsync;
