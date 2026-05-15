const mongoose = require('../db');
const { Schema } = require('mongoose');

const UserSchema = new Schema({
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  display_name: { type: String },
  avatar: { type: String },
  created_at: { type: Date, default: Date.now }
});

module.exports = mongoose.model('User', UserSchema);
