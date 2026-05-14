const mongoose = require('mongoose');

const CommentSchema = new mongoose.Schema({
  post: { type: mongoose.Schema.Types.ObjectId, ref: 'Post', required: true, index: true },
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true, index: true },
  text: { type: String, required: true },
  createdAt: { type: Date, default: Date.now },
}, { collection: 'comments' });

module.exports = mongoose.models.Comment || mongoose.model('Comment', CommentSchema);
