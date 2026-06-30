/**
 * @module middleware/requestId
 * @description Attaches a unique request ID to every incoming request.
 * Used for distributed tracing, log correlation, and debugging.
 */
const { v4: uuidv4 } = require('uuid');

const requestId = (req, res, next) => {
  req.id = req.headers['x-request-id'] || uuidv4();
  res.setHeader('X-Request-Id', req.id);
  next();
};

module.exports = { requestId };
