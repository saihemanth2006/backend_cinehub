/**
 * @module models/user.model
 * @description User schema — authentication, profile, skills, and social graph.
 */
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const { env } = require('../config');
const { USER_ROLES, SKILL_CATEGORIES } = require('../utils/constants');
const toJSON = require('./plugins/toJSON.plugin');
const paginate = require('./plugins/paginate.plugin');
const softDelete = require('./plugins/softDelete.plugin');

const userSchema = new mongoose.Schema(
  {
    // ── Authentication ──────────────────────────
    email: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      lowercase: true,
      index: true,
    },
    password: {
      type: String,
      required: true,
      minlength: 8,
      private: true, // Excluded from toJSON
    },
    role: {
      type: String,
      enum: Object.values(USER_ROLES),
      default: USER_ROLES.USER,
      index: true,
    },
    isActive: { type: Boolean, default: true },
    isEmailVerified: { type: Boolean, default: false },
    lastLoginAt: { type: Date },

    // ── Profile ─────────────────────────────────
    firstName: { type: String, required: true, trim: true, maxlength: 50 },
    lastName: { type: String, required: true, trim: true, maxlength: 50 },
    displayName: { type: String, trim: true, maxlength: 100 },
    slug: { type: String, unique: true, index: true },
    bio: { type: String, maxlength: 500 },
    headline: { type: String, maxlength: 150 }, // e.g., "Director | Cinematographer"
    avatar: { type: String },
    coverImage: { type: String },

    // ── Professional Info ────────────────────────
    skills: [{
      name: { type: String, required: true },
      category: { type: String, enum: Object.values(SKILL_CATEGORIES) },
      proficiency: { type: Number, min: 1, max: 5, default: 3 },
    }],
    experience: [{
      title: String,
      company: String,
      description: String,
      startDate: Date,
      endDate: Date,
      isCurrent: { type: Boolean, default: false },
    }],
    awards: [{
      title: String,
      organization: String,
      year: Number,
      description: String,
    }],

    // ── Location ────────────────────────────────
    location: {
      city: String,
      state: String,
      country: String,
      coordinates: {
        type: { type: String, enum: ['Point'] },
        coordinates: [Number], // [longitude, latitude]
      },
    },

    // ── Social & Stats ──────────────────────────
    followers: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    following: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    followerCount: { type: Number, default: 0, index: true },
    followingCount: { type: Number, default: 0 },
    projectCount: { type: Number, default: 0 },
    portfolioViewCount: { type: Number, default: 0 },

    // ── Preferences ─────────────────────────────
    preferences: {
      emailNotifications: { type: Boolean, default: true },
      pushNotifications: { type: Boolean, default: true },
      profileVisibility: { type: String, enum: ['public', 'private', 'connections'], default: 'public' },
      language: { type: String, default: 'en' },
    },

    // ── External Links ──────────────────────────
    socialLinks: {
      website: String,
      imdb: String,
      linkedin: String,
      instagram: String,
      youtube: String,
      vimeo: String,
      twitter: String,
    },

    // ── Refresh Token (hashed) ──────────────────
    refreshToken: { type: String, private: true },
  },
  {
    timestamps: true,
    collection: 'users',
  },
);

// ── Indexes ─────────────────────────────────

userSchema.index({ firstName: 'text', lastName: 'text', headline: 'text', bio: 'text' });
userSchema.index({ 'location.coordinates': '2dsphere' });
userSchema.index({ 'skills.name': 1 });
userSchema.index({ role: 1, isActive: 1 });

// ── Plugins ─────────────────────────────────

userSchema.plugin(toJSON);
userSchema.plugin(paginate);
userSchema.plugin(softDelete);

// ── Virtuals ────────────────────────────────

userSchema.virtual('fullName').get(function getFullName() {
  return `${this.firstName} ${this.lastName}`;
});

userSchema.virtual('projects', {
  ref: 'Project',
  localField: '_id',
  foreignField: 'owner',
});

// ── Pre-save Hooks ──────────────────────────

userSchema.pre('save', async function preSave(next) {
  // Hash password on change
  if (this.isModified('password')) {
    this.password = await bcrypt.hash(this.password, env.bcrypt.saltRounds);
  }

  // Generate display name
  if (this.isModified('firstName') || this.isModified('lastName')) {
    this.displayName = this.displayName || `${this.firstName} ${this.lastName}`;
  }

  next();
});

// ── Instance Methods ────────────────────────

/**
 * Compares a candidate password against the hashed password.
 * @param {string} candidatePassword
 * @returns {Promise<boolean>}
 */
userSchema.methods.comparePassword = async function comparePassword(candidatePassword) {
  return bcrypt.compare(candidatePassword, this.password);
};

/**
 * Checks if the user has a specific role.
 * @param {string} role
 * @returns {boolean}
 */
userSchema.methods.hasRole = function hasRole(role) {
  return this.role === role;
};

// ── Static Methods ──────────────────────────

/**
 * Checks if an email is already taken.
 * @param {string} email
 * @param {string} [excludeUserId] - User ID to exclude (for updates)
 * @returns {Promise<boolean>}
 */
userSchema.statics.isEmailTaken = async function isEmailTaken(email, excludeUserId) {
  const user = await this.findOne({ email, _id: { $ne: excludeUserId } });
  return !!user;
};

const User = mongoose.model('User', userSchema);

module.exports = User;
