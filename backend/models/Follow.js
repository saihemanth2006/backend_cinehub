const mongoose = require('mongoose');

const FollowSchema = new mongoose.Schema({
  follower: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true, index: true },
  followee: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true, index: true },
  createdAt: { type: Date, default: Date.now },
}, { collection: 'follows' });

FollowSchema.index({ follower: 1, followee: 1 }, { unique: true });

module.exports = mongoose.models.Follow || mongoose.model('Follow', FollowSchema);
