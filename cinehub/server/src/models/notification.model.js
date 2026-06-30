/**
 * @module models/notification.model
 * @description Notification schema for real-time and persistent notifications.
 */
const mongoose = require('mongoose');
const { NOTIFICATION_TYPES, NOTIFICATION_PRIORITY } = require('../utils/constants');
const toJSON = require('./plugins/toJSON.plugin');
const paginate = require('./plugins/paginate.plugin');

const notificationSchema = new mongoose.Schema({
  recipient: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true, index: true },
  sender: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  type: { type: String, enum: Object.values(NOTIFICATION_TYPES), required: true, index: true },
  priority: { type: String, enum: Object.values(NOTIFICATION_PRIORITY), default: NOTIFICATION_PRIORITY.MEDIUM },
  title: { type: String, required: true, maxlength: 200 },
  message: { type: String, required: true, maxlength: 500 },
  data: { type: mongoose.Schema.Types.Mixed },
  actionUrl: String,
  isRead: { type: Boolean, default: false, index: true },
  readAt: Date,
  expiresAt: Date,
}, { timestamps: true, collection: 'notifications' });

notificationSchema.index({ recipient: 1, isRead: 1, createdAt: -1 });
notificationSchema.index({ expiresAt: 1 }, { expireAfterSeconds: 0 });

notificationSchema.plugin(toJSON);
notificationSchema.plugin(paginate);

const Notification = mongoose.model('Notification', notificationSchema);
module.exports = Notification;
