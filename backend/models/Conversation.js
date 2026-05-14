const mongoose = require('mongoose');

const ConversationSchema = new mongoose.Schema({
  participants: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }],
  lastMessage: { type: String },
  updatedAt: { type: Date, default: Date.now, index: true },
  createdAt: { type: Date, default: Date.now },
}, { collection: 'conversations' });

ConversationSchema.index({ participants: 1 });

module.exports = mongoose.models.Conversation || mongoose.model('Conversation', ConversationSchema);
