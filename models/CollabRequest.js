const mongoose = require('mongoose');

const collabRequestSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  role: { type: String, required: true },
  skills: { type: [String], default: [] },
  location: { type: String, default: 'Remote' },
  type: { type: String, default: 'Collaborative' },
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('CollabRequest', collabRequestSchema);
