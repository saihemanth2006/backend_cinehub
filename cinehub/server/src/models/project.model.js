/**
 * @module models/project.model
 * @description Film project schema — the core entity of CineHub.
 * Projects represent film productions with metadata, team, budget, and timeline.
 */
const mongoose = require('mongoose');
const slugify = require('slugify');

const { PROJECT_STATUS, PROJECT_TYPES } = require('../utils/constants');
const toJSON = require('./plugins/toJSON.plugin');
const paginate = require('./plugins/paginate.plugin');
const softDelete = require('./plugins/softDelete.plugin');

const projectSchema = new mongoose.Schema(
  {
    // ── Core ────────────────────────────────────
    title: { type: String, required: true, trim: true, maxlength: 200 },
    slug: { type: String, unique: true, index: true },
    tagline: { type: String, maxlength: 300 },
    synopsis: { type: String, maxlength: 2000 },
    description: { type: String, maxlength: 5000 },

    // ── Classification ──────────────────────────
    type: {
      type: String,
      enum: Object.values(PROJECT_TYPES),
      required: true,
      index: true,
    },
    status: {
      type: String,
      enum: Object.values(PROJECT_STATUS),
      default: PROJECT_STATUS.DRAFT,
      index: true,
    },
    genres: [{ type: String, trim: true }],
    tags: [{ type: String, trim: true, index: true }],
    language: { type: String, default: 'English' },

    // ── Ownership ───────────────────────────────
    owner: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
      index: true,
    },

    // ── Media ───────────────────────────────────
    poster: { type: String },
    coverImage: { type: String },
    trailer: { type: String },
    gallery: [{ type: String }],

    // ── Production Details ──────────────────────
    budget: {
      estimated: { type: Number },
      currency: { type: String, default: 'USD' },
    },
    duration: {
      estimated: { type: Number }, // minutes
    },
    timeline: {
      startDate: { type: Date },
      endDate: { type: Date },
      milestones: [{
        title: String,
        date: Date,
        completed: { type: Boolean, default: false },
      }],
    },

    // ── Location ────────────────────────────────
    locations: [{
      name: String,
      address: String,
      coordinates: {
        type: { type: String, enum: ['Point'] },
        coordinates: [Number],
      },
    }],

    // ── Team Reference ──────────────────────────
    team: { type: mongoose.Schema.Types.ObjectId, ref: 'Team' },

    // ── Scripts Reference ───────────────────────
    scripts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Script' }],

    // ── Stats ───────────────────────────────────
    viewCount: { type: Number, default: 0 },
    likeCount: { type: Number, default: 0 },
    shareCount: { type: Number, default: 0 },

    // ── Settings ────────────────────────────────
    visibility: {
      type: String,
      enum: ['public', 'private', 'team_only'],
      default: 'private',
    },
    allowApplications: { type: Boolean, default: false },
  },
  {
    timestamps: true,
    collection: 'projects',
  },
);

// ── Indexes ─────────────────────────────────

projectSchema.index({ title: 'text', synopsis: 'text', tags: 'text' });
projectSchema.index({ owner: 1, status: 1 });
projectSchema.index({ type: 1, status: 1, visibility: 1 });
projectSchema.index({ createdAt: -1 });

// ── Plugins ─────────────────────────────────

projectSchema.plugin(toJSON);
projectSchema.plugin(paginate);
projectSchema.plugin(softDelete);

// ── Pre-save Hook ───────────────────────────

projectSchema.pre('save', function preSave(next) {
  if (this.isModified('title')) {
    this.slug = slugify(this.title, { lower: true, strict: true }) + '-' + this._id.toString().slice(-6);
  }
  next();
});

const Project = mongoose.model('Project', projectSchema);

module.exports = Project;
