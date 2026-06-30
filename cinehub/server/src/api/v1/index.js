/**
 * @module api/v1
 * @description v1 API router — aggregates all module routes under /api/v1
 */
const express = require('express');
const { apiLimiter } = require('../../middleware');

const router = express.Router();

// Apply global rate limiter to all v1 routes
router.use(apiLimiter);

// ── Module Routes ───────────────────────────

router.use('/auth', require('./auth/auth.routes'));
router.use('/users', require('./users/user.routes'));
router.use('/projects', require('./projects/project.routes'));
router.use('/scripts', require('./scripts/script.routes'));
router.use('/teams', require('./teams/team.routes'));
router.use('/portfolios', require('./portfolios/portfolio.routes'));
router.use('/notifications', require('./notifications/notification.routes').router);
router.use('/discovery', require('./discovery/discovery.routes'));
router.use('/media', require('./media/media.routes'));
router.use('/ai', require('./ai/ai.routes'));

// ── Health Check ────────────────────────────

router.get('/health', (_req, res) => {
  const { getDatabaseStatus } = require('../../config');
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    database: getDatabaseStatus(),
    version: 'v1',
  });
});

module.exports = router;
