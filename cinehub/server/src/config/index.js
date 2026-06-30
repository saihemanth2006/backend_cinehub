/**
 * @module config
 * @description Central configuration aggregator.
 * Single import for all config across the application.
 */
const env = require('./env');
const logger = require('./logger');
const { connectDatabase, disconnectDatabase, getDatabaseStatus } = require('./database');
const { getRedisClient, disconnectRedis } = require('./redis');

module.exports = {
  env,
  logger,
  connectDatabase,
  disconnectDatabase,
  getDatabaseStatus,
  getRedisClient,
  disconnectRedis,
};
