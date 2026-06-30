/**
 * @module api/v1/notifications
 * @description Notification service + controller + routes
 */
const ApiError = require('../../../utils/ApiError');
const notificationRepo = require('../../../repositories/notification.repository');
const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const pick = require('../../../utils/pick');

class NotificationService {
  async createNotification(data) {
    return notificationRepo.create(data);
  }

  async createBulk(notifications) {
    return notificationRepo.model.insertMany(notifications);
  }

  async getUserNotifications(userId, options) {
    return notificationRepo.findByRecipient(userId, options);
  }

  async getUnreadCount(userId) {
    return notificationRepo.getUnreadCount(userId);
  }

  async markAsRead(notificationId, userId) {
    const notification = await notificationRepo.findById(notificationId);
    if (!notification) throw ApiError.notFound('Notification not found');
    if (notification.recipient.toString() !== userId.toString()) {
      throw ApiError.forbidden('Not your notification');
    }
    return notificationRepo.markAsRead(notificationId);
  }

  async markAllAsRead(userId) {
    return notificationRepo.markAllAsRead(userId);
  }

  async deleteNotification(notificationId, userId) {
    const notification = await notificationRepo.findById(notificationId);
    if (!notification) throw ApiError.notFound('Notification not found');
    if (notification.recipient.toString() !== userId.toString()) {
      throw ApiError.forbidden('Not your notification');
    }
    return notificationRepo.deleteById(notificationId);
  }
}

const service = new NotificationService();

// Export service for internal use by other modules
module.exports.notificationService = service;

const controller = {
  list: catchAsync(async (req, res) => {
    const options = pick(req.query, ['page', 'limit']);
    const result = await service.getUserNotifications(req.user._id, options);
    ApiResponse.paginated(result.docs, result.pagination).send(res);
  }),
  unreadCount: catchAsync(async (req, res) => {
    const count = await service.getUnreadCount(req.user._id);
    ApiResponse.ok({ unreadCount: count }).send(res);
  }),
  markAsRead: catchAsync(async (req, res) => {
    await service.markAsRead(req.params.id, req.user._id);
    ApiResponse.ok(null, 'Marked as read').send(res);
  }),
  markAllAsRead: catchAsync(async (req, res) => {
    await service.markAllAsRead(req.user._id);
    ApiResponse.ok(null, 'All notifications marked as read').send(res);
  }),
  remove: catchAsync(async (req, res) => {
    await service.deleteNotification(req.params.id, req.user._id);
    ApiResponse.ok(null, 'Notification deleted').send(res);
  }),
};

const express = require('express');
const { authenticate } = require('../../../middleware');
const router = express.Router();

router.get('/', authenticate(), controller.list);
router.get('/unread-count', authenticate(), controller.unreadCount);
router.patch('/:id/read', authenticate(), controller.markAsRead);
router.patch('/read-all', authenticate(), controller.markAllAsRead);
router.delete('/:id', authenticate(), controller.remove);

module.exports.router = router;
