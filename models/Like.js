const mongoose = require('../db');
const { Schema } = require('mongoose');

const LikeSchema = new Schema({
  user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  post: { type: Schema.Types.ObjectId, ref: 'Post', required: true },
  created_at: { type: Date, default: Date.now }
});

LikeSchema.index({ user: 1, post: 1 }, { unique: true });

module.exports = mongoose.model('Like', LikeSchema);
