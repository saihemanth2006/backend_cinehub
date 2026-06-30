/**
 * @module app
 * @description Express application setup — middleware stack and route mounting.
 * Separated from server to enable testing without starting HTTP server.
 */
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const morgan = require('morgan');
const mongoSanitize = require('express-mongo-sanitize');
const hpp = require('hpp');
const path = require('path');

const { env, logger } = require('./config');
const { requestId, errorHandler, notFoundHandler } = require('./middleware');

const app = express();

// ── Security Headers ────────────────────────
app.use(helmet({
  contentSecurityPolicy: env.isProd ? undefined : false,
  crossOriginEmbedderPolicy: false,
}));

// ── CORS ────────────────────────────────────
app.use(cors({
  origin: env.clientUrl,
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'X-Request-Id'],
  exposedHeaders: ['X-Request-Id'],
}));

// ── Request Parsing ─────────────────────────
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// ── Security Sanitization ───────────────────
app.use(mongoSanitize());  // Prevent NoSQL injection
app.use(hpp());             // Prevent HTTP parameter pollution

// ── Compression ─────────────────────────────
app.use(compression());

// ── Request ID ──────────────────────────────
app.use(requestId);

// ── HTTP Logging ────────────────────────────
if (!env.isTest) {
  app.use(morgan('short', { stream: logger.stream }));
}

// ── Static Files ────────────────────────────
app.use('/uploads', express.static(path.join(__dirname, '..', 'uploads')));

// ── Trust Proxy (for rate limiter behind reverse proxy) ──
if (env.isProd) {
  app.set('trust proxy', 1);
}

// ── API Routes ──────────────────────────────
app.use(`${env.apiPrefix}/v1`, require('./api/v1'));

// ── Root ────────────────────────────────────
app.get('/', (_req, res) => {
  res.json({
    name: env.appName,
    version: '1.0.0',
    status: 'running',
    docs: `${env.appUrl}${env.apiPrefix}/v1/docs`,
  });
});

// ── Error Handling ──────────────────────────
app.use(notFoundHandler);
app.use(errorHandler);

module.exports = app;
