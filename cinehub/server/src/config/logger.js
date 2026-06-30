/**
 * @module config/logger
 * @description Production-grade structured logging with Winston.
 * - Console transport with colorized output in development
 * - Daily-rotated file transports in production
 * - Request-level correlation via requestId
 */
const path = require('path');

const winston = require('winston');
const DailyRotateFile = require('winston-daily-rotate-file');

const env = require('./env');

const LOG_DIR = path.resolve(__dirname, '../../', env.logging.dir);

// ── Custom Format ───────────────────────────

const structuredFormat = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss.SSS' }),
  winston.format.errors({ stack: true }),
  winston.format.printf(({ timestamp, level, message, stack, requestId, ...meta }) => {
    const rid = requestId ? ` [${requestId}]` : '';
    const metaStr = Object.keys(meta).length ? ` ${JSON.stringify(meta)}` : '';
    const stackStr = stack ? `\n${stack}` : '';
    return `${timestamp} [${level.toUpperCase()}]${rid} ${message}${metaStr}${stackStr}`;
  }),
);

const jsonFormat = winston.format.combine(
  winston.format.timestamp(),
  winston.format.errors({ stack: true }),
  winston.format.json(),
);

// ── Transports ──────────────────────────────

const transports = [];

// Console — always available
transports.push(
  new winston.transports.Console({
    format: env.isDev
      ? winston.format.combine(winston.format.colorize(), structuredFormat)
      : jsonFormat,
    stderrLevels: ['error'],
  }),
);

// File transports — production / staging only
if (env.isProd || env.nodeEnv === 'staging') {
  // Combined log
  transports.push(
    new DailyRotateFile({
      filename: path.join(LOG_DIR, 'combined-%DATE%.log'),
      datePattern: 'YYYY-MM-DD',
      maxSize: '20m',
      maxFiles: '30d',
      format: jsonFormat,
      zippedArchive: true,
    }),
  );

  // Error-only log
  transports.push(
    new DailyRotateFile({
      filename: path.join(LOG_DIR, 'error-%DATE%.log'),
      datePattern: 'YYYY-MM-DD',
      level: 'error',
      maxSize: '20m',
      maxFiles: '60d',
      format: jsonFormat,
      zippedArchive: true,
    }),
  );
}

// ── Logger Instance ─────────────────────────

const logger = winston.createLogger({
  level: env.logging.level,
  levels: winston.config.npm.levels,
  transports,
  exitOnError: false,
  // Prevent unhandled exceptions from crashing without logging
  exceptionHandlers: [
    new winston.transports.Console(),
  ],
  rejectionHandlers: [
    new winston.transports.Console(),
  ],
});

// ── Stream for Morgan HTTP logger integration ──
logger.stream = {
  write: (message) => {
    logger.http(message.trim());
  },
};

module.exports = logger;
