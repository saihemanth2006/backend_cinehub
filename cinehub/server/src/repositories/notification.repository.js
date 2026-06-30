/**
 * @module repositories/notification.repository
 */
const BaseRepository = require('./base.repository');
const Notification = require('../models/notification.model');

class NotificationRepository extends BaseRepository {
  constructor() { super(Notification); }

  async findByRecipient(recipientId, options = {}) {
    return this.paginate({ recipient: recipientId }, { ...options, sort: { createdAt: -1 }, populate: 'sender' });
  }

  async getUnreadCount(recipientId) {
    return this.count({ recipient: recipientId, isRead: false });
  }

  async markAsRead(notificationId) {
    return this.updateById(notificationId, { isRead: true, readAt: new Date() });
  }

  async markAllAsRead(recipientId) {
    return this.model.updateMany({ recipient: recipientId, isRead: false }, { isRead: true, readAt: new Date() });
  }

  async deleteOlderThan(days) {
    const cutoff = new Date(Date.now() - days * 24 * 60 * 60 * 1000);
    return this.model.deleteMany({ createdAt: { $lt: cutoff }, isRead: true });
  }
}

module.exports = new NotificationRepository();
