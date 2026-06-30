/**
 * @module events/listeners
 * @description Event listeners — react to domain events with side-effects.
 */
const emitter = require('./emitter');
const { logger } = require('../config');

function registerListeners() {
  // ── User Events ─────────────────────────────

  emitter.on('user:registered', async ({ userId, email }) => {
    logger.info(`[Listener] New user registered: ${email}`);
    // TODO: Send welcome email, trigger email verification
  });

  emitter.on('user:loggedIn', async ({ userId }) => {
    logger.debug(`[Listener] User logged in: ${userId}`);
    // TODO: Update analytics, last seen
  });

  emitter.on('user:followed', async ({ followerId, followedId }) => {
    logger.debug(`[Listener] User ${followerId} followed ${followedId}`);
    // TODO: Create notification for followed user
    try {
      const { notificationService } = require('../api/v1/notifications/notification.routes');
      await notificationService.createNotification({
        recipient: followedId,
        sender: followerId,
        type: 'follow',
        title: 'New Follower',
        message: 'Someone started following you',
        actionUrl: `/profile/${followerId}`,
      });
    } catch (err) {
      logger.error(`[Listener] Failed to create follow notification: ${err.message}`);
    }
  });

  emitter.on('user:forgotPassword', async ({ userId, email, resetToken }) => {
    logger.info(`[Listener] Password reset requested for: ${email}`);
    // TODO: Send password reset email with resetToken
  });

  emitter.on('user:passwordReset', async ({ userId }) => {
    logger.info(`[Listener] Password reset completed for user: ${userId}`);
  });

  // ── Project Events ──────────────────────────

  emitter.on('project:created', async ({ projectId, ownerId }) => {
    logger.info(`[Listener] New project created: ${projectId} by ${ownerId}`);
    // TODO: Update user's project count
  });

  emitter.on('project:deleted', async ({ projectId, ownerId }) => {
    logger.info(`[Listener] Project deleted: ${projectId}`);
  });

  // ── Team Events ─────────────────────────────

  emitter.on('team:memberInvited', async ({ teamId, invitedUserId, invitedBy }) => {
    logger.info(`[Listener] Team invite: ${invitedUserId} invited to team ${teamId}`);
    try {
      const { notificationService } = require('../api/v1/notifications/notification.routes');
      await notificationService.createNotification({
        recipient: invitedUserId,
        sender: invitedBy,
        type: 'project_invite',
        title: 'Team Invitation',
        message: 'You have been invited to join a project team',
        priority: 'high',
        data: { teamId },
      });
    } catch (err) {
      logger.error(`[Listener] Failed to create team invite notification: ${err.message}`);
    }
  });

  emitter.on('team:memberJoined', async ({ teamId, userId }) => {
    logger.info(`[Listener] Member joined team: ${userId} → ${teamId}`);
  });

  // ── Script Events ───────────────────────────

  emitter.on('script:aiGenerated', async ({ scriptId, userId, projectId }) => {
    logger.info(`[Listener] AI script generated: ${scriptId} for project ${projectId}`);
  });

  // ── Portfolio Events ────────────────────────

  emitter.on('portfolio:liked', async ({ portfolioId, userId }) => {
    logger.debug(`[Listener] Portfolio liked: ${portfolioId} by ${userId}`);
  });

  emitter.on('portfolio:commented', async ({ portfolioId, userId }) => {
    logger.debug(`[Listener] Portfolio commented: ${portfolioId} by ${userId}`);
  });

  logger.info('[Events] ✅ All event listeners registered');
}

module.exports = { registerListeners };
