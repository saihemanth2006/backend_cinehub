const mongoose = require('../db');
const { Schema } = require('mongoose');

const PostSchema = new Schema({
  user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  content: { type: String },
  media: { type: String },
  created_at: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Post', PostSchema);
