/**
 * @module config/redis
 * @description Redis client singleton with connection management.
 * Used for caching, session storage, and BullMQ job queues.
 */
const Redis = require('ioredis');

const env = require('./env');
const logger = require('./logger');

/** @type {Redis | null} */
let client = null;

/**
 * Returns the singleton Redis client instance.
 * Creates the connection on first call.
 * @returns {Redis}
 */
function getRedisClient() {
  if (client) return client;

  client = new Redis({
    host: env.redis.host,
    port: env.redis.port,
    password: env.redis.password || undefined,
    db: env.redis.db,
    maxRetriesPerRequest: null, // Required for BullMQ
    enableReadyCheck: true,
    retryStrategy(times) {
      const delay = Math.min(times * 200, 5000);
      logger.warn(`[Redis] Reconnect attempt ${times}, retrying in ${delay}ms`);
      return delay;
    },
    reconnectOnError(err) {
      const targetErrors = ['READONLY', 'ECONNRESET', 'ETIMEDOUT'];
      return targetErrors.some((e) => err.message.includes(e));
    },
  });

  client.on('connect', () => logger.info('[Redis] ✅ Connected'));
  client.on('ready', () => logger.info('[Redis] Ready to accept commands'));
  client.on('error', (err) => logger.error(`[Redis] Error: ${err.message}`));
  client.on('close', () => logger.warn('[Redis] Connection closed'));

  return client;
}

/**
 * Gracefully disconnects the Redis client.
 * @returns {Promise<void>}
 */
async function disconnectRedis() {
  if (client) {
    await client.quit();
    client = null;
    logger.info('[Redis] 🔌 Disconnected gracefully');
  }
}

module.exports = { getRedisClient, disconnectRedis };
