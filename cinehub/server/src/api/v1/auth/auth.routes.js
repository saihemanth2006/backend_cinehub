/**
 * @module api/v1/auth/auth.routes
 */
const express = require('express');
const { validate } = require('../../../middleware');
const { authenticate } = require('../../../middleware');
const { authLimiter, sensitiveOpLimiter } = require('../../../middleware');
const authController = require('./auth.controller');
const authValidation = require('./auth.validation');

const router = express.Router();

router.post('/register', authLimiter, validate(authValidation.register), authController.register);
router.post('/login', authLimiter, validate(authValidation.login), authController.login);
router.post('/refresh-tokens', validate(authValidation.refreshTokens), authController.refreshTokens);
router.post('/logout', authenticate(), authController.logout);
router.post('/forgot-password', sensitiveOpLimiter, validate(authValidation.forgotPassword), authController.forgotPassword);
router.post('/reset-password', sensitiveOpLimiter, validate(authValidation.resetPassword), authController.resetPassword);
router.post('/change-password', authenticate(), validate(authValidation.changePassword), authController.changePassword);
router.get('/verify-email', validate(authValidation.verifyEmail), authController.verifyEmail);
router.get('/me', authenticate(), authController.getMe);

module.exports = router;
