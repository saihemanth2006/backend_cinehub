/**
 * @module config/env
 * @description Centralized environment variable validation and access.
 * Fails fast on missing required variables — no silent misconfiguration.
 */
const dotenv = require('dotenv');
const path = require('path');
const Joi = require('joi');

// Load .env from project root
dotenv.config({ path: path.resolve(__dirname, '../../.env') });

const envSchema = Joi.object({
  // ── Application ───────────────────────────
  NODE_ENV: Joi.string().valid('development', 'production', 'test', 'staging').required(),
  PORT: Joi.number().default(5000),
  API_PREFIX: Joi.string().default('/api'),
  APP_NAME: Joi.string().default('CineHub'),
  APP_URL: Joi.string().uri().required(),
  CLIENT_URL: Joi.string().uri().required(),

  // ── Database ──────────────────────────────
  MONGODB_URI: Joi.string().required().description('MongoDB connection URI'),
  MONGODB_URI_TEST: Joi.string().optional(),

  // ── Redis ─────────────────────────────────
  REDIS_HOST: Joi.string().default('127.0.0.1'),
  REDIS_PORT: Joi.number().default(6379),
  REDIS_PASSWORD: Joi.string().allow('').default(''),
  REDIS_DB: Joi.number().default(0),

  // ── JWT ───────────────────────────────────
  JWT_ACCESS_SECRET: Joi.string().min(32).required(),
  JWT_REFRESH_SECRET: Joi.string().min(32).required(),
  JWT_ACCESS_EXPIRATION: Joi.string().default('15m'),
  JWT_REFRESH_EXPIRATION: Joi.string().default('7d'),
  JWT_RESET_PASSWORD_EXPIRATION: Joi.string().default('10m'),
  JWT_VERIFY_EMAIL_EXPIRATION: Joi.string().default('24h'),

  // ── Bcrypt ────────────────────────────────
  BCRYPT_SALT_ROUNDS: Joi.number().default(12),

  // ── Rate Limiting ─────────────────────────
  RATE_LIMIT_WINDOW_MS: Joi.number().default(900000),
  RATE_LIMIT_MAX_REQUESTS: Joi.number().default(100),

  // ── AI ────────────────────────────────────
  OPENAI_API_KEY: Joi.string().allow('').default(''),
  OPENAI_MODEL: Joi.string().default('gpt-4-turbo'),
  OPENAI_MAX_TOKENS: Joi.number().default(4096),
  GEMINI_API_KEY: Joi.string().allow('').default(''),
  GEMINI_MODEL: Joi.string().default('gemini-1.5-pro'),
  AI_DEFAULT_PROVIDER: Joi.string().valid('openai', 'gemini').default('gemini'),

  // ── AWS / Storage ─────────────────────────
  AWS_ACCESS_KEY_ID: Joi.string().allow('').default(''),
  AWS_SECRET_ACCESS_KEY: Joi.string().allow('').default(''),
  AWS_REGION: Joi.string().default('us-east-1'),
  AWS_S3_BUCKET: Joi.string().default('cinehub-media'),
  STORAGE_PROVIDER: Joi.string().valid('local', 's3').default('local'),

  // ── Email ─────────────────────────────────
  SMTP_HOST: Joi.string().allow('').default(''),
  SMTP_PORT: Joi.number().default(587),
  SMTP_SECURE: Joi.boolean().default(false),
  SMTP_USER: Joi.string().allow('').default(''),
  SMTP_PASS: Joi.string().allow('').default(''),
  EMAIL_FROM: Joi.string().default('CineHub <noreply@cinehub.ai>'),

  // ── Logging ───────────────────────────────
  LOG_LEVEL: Joi.string().valid('error', 'warn', 'info', 'http', 'debug').default('info'),
  LOG_DIR: Joi.string().default('logs'),

  // ── Uploads ───────────────────────────────
  MAX_FILE_SIZE: Joi.number().default(52428800), // 50MB
  UPLOAD_DIR: Joi.string().default('uploads'),
  ALLOWED_IMAGE_TYPES: Joi.string().default('image/jpeg,image/png,image/webp,image/gif'),
  ALLOWED_VIDEO_TYPES: Joi.string().default('video/mp4,video/webm,video/quicktime'),

  // ── Socket ────────────────────────────────
  SOCKET_CORS_ORIGIN: Joi.string().default('http://localhost:3000'),
})
  .unknown() // Allow other env vars (PATH, etc.)
  .required();

const { error, value: envVars } = envSchema.validate(process.env, {
  abortEarly: false,
  stripUnknown: false,
});

if (error) {
  const missing = error.details.map((d) => `  ✗ ${d.message}`).join('\n');
  console.error(`\n⛔ Environment validation failed:\n${missing}\n`);
  process.exit(1);
}

/** @type {Readonly<Record<string, any>>} Validated, frozen configuration object */
const env = Object.freeze({
  nodeEnv: envVars.NODE_ENV,
  port: envVars.PORT,
  apiPrefix: envVars.API_PREFIX,
  appName: envVars.APP_NAME,
  appUrl: envVars.APP_URL,
  clientUrl: envVars.CLIENT_URL,
  isDev: envVars.NODE_ENV === 'development',
  isProd: envVars.NODE_ENV === 'production',
  isTest: envVars.NODE_ENV === 'test',

  db: {
    uri: envVars.NODE_ENV === 'test' ? envVars.MONGODB_URI_TEST : envVars.MONGODB_URI,
  },

  redis: {
    host: envVars.REDIS_HOST,
    port: envVars.REDIS_PORT,
    password: envVars.REDIS_PASSWORD,
    db: envVars.REDIS_DB,
  },

  jwt: {
    accessSecret: envVars.JWT_ACCESS_SECRET,
    refreshSecret: envVars.JWT_REFRESH_SECRET,
    accessExpiration: envVars.JWT_ACCESS_EXPIRATION,
    refreshExpiration: envVars.JWT_REFRESH_EXPIRATION,
    resetPasswordExpiration: envVars.JWT_RESET_PASSWORD_EXPIRATION,
    verifyEmailExpiration: envVars.JWT_VERIFY_EMAIL_EXPIRATION,
  },

  bcrypt: {
    saltRounds: envVars.BCRYPT_SALT_ROUNDS,
  },

  rateLimit: {
    windowMs: envVars.RATE_LIMIT_WINDOW_MS,
    maxRequests: envVars.RATE_LIMIT_MAX_REQUESTS,
  },

  ai: {
    defaultProvider: envVars.AI_DEFAULT_PROVIDER,
    openai: {
      apiKey: envVars.OPENAI_API_KEY,
      model: envVars.OPENAI_MODEL,
      maxTokens: envVars.OPENAI_MAX_TOKENS,
    },
    gemini: {
      apiKey: envVars.GEMINI_API_KEY,
      model: envVars.GEMINI_MODEL,
    },
  },

  aws: {
    accessKeyId: envVars.AWS_ACCESS_KEY_ID,
    secretAccessKey: envVars.AWS_SECRET_ACCESS_KEY,
    region: envVars.AWS_REGION,
    s3Bucket: envVars.AWS_S3_BUCKET,
  },

  storage: {
    provider: envVars.STORAGE_PROVIDER,
  },

  email: {
    smtp: {
      host: envVars.SMTP_HOST,
      port: envVars.SMTP_PORT,
      secure: envVars.SMTP_SECURE,
      auth: {
        user: envVars.SMTP_USER,
        pass: envVars.SMTP_PASS,
      },
    },
    from: envVars.EMAIL_FROM,
  },

  logging: {
    level: envVars.LOG_LEVEL,
    dir: envVars.LOG_DIR,
  },

  upload: {
    maxFileSize: envVars.MAX_FILE_SIZE,
    dir: envVars.UPLOAD_DIR,
    allowedImageTypes: envVars.ALLOWED_IMAGE_TYPES.split(','),
    allowedVideoTypes: envVars.ALLOWED_VIDEO_TYPES.split(','),
  },

  socket: {
    corsOrigin: envVars.SOCKET_CORS_ORIGIN,
  },
});

module.exports = env;
