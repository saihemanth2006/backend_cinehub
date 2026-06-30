/**
 * @module models/script.model
 * @description AI-generated script schema with versioning, feedback, and collaboration.
 */
const mongoose = require('mongoose');

const { SCRIPT_STATUS, SCRIPT_FORMATS, AI_PROVIDERS } = require('../utils/constants');
const toJSON = require('./plugins/toJSON.plugin');
const paginate = require('./plugins/paginate.plugin');
const softDelete = require('./plugins/softDelete.plugin');

const scriptSchema = new mongoose.Schema(
  {
    // ── Core ────────────────────────────────────
    title: { type: String, required: true, trim: true, maxlength: 300 },
    format: {
      type: String,
      enum: Object.values(SCRIPT_FORMATS),
      required: true,
    },
    status: {
      type: String,
      enum: Object.values(SCRIPT_STATUS),
      default: SCRIPT_STATUS.DRAFT,
      index: true,
    },

    // ── Content ─────────────────────────────────
    content: { type: String }, // Main script content (markdown/fountain)
    logline: { type: String, maxlength: 500 },
    synopsis: { type: String, maxlength: 3000 },

    // ── AI Generation Metadata ──────────────────
    aiGenerated: { type: Boolean, default: false },
    aiMetadata: {
      provider: { type: String, enum: Object.values(AI_PROVIDERS) },
      model: String,
      prompt: String,
      parameters: mongoose.Schema.Types.Mixed,
      generatedAt: Date,
      tokensUsed: Number,
      generationTimeMs: Number,
    },

    // ── Versioning ──────────────────────────────
    version: { type: Number, default: 1 },
    versions: [{
      version: Number,
      content: String,
      createdBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
      createdAt: { type: Date, default: Date.now },
      changelog: String,
    }],

    // ── Structure ───────────────────────────────
    scenes: [{
      sceneNumber: Number,
      heading: String, // INT./EXT. LOCATION - TIME
      description: String,
      characters: [String],
      duration: Number, // estimated minutes
    }],
    characters: [{
      name: String,
      description: String,
      role: { type: String, enum: ['lead', 'supporting', 'minor', 'extra'] },
      dialogueCount: Number,
    }],

    // ── Relations ───────────────────────────────
    project: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Project',
      required: true,
      index: true,
    },
    author: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
      index: true,
    },
    collaborators: [{
      user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
      permission: { type: String, enum: ['read', 'comment', 'edit'], default: 'read' },
    }],

    // ── Feedback ────────────────────────────────
    comments: [{
      user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
      content: String,
      lineRef: Number, // Reference to specific line in script
      createdAt: { type: Date, default: Date.now },
      resolved: { type: Boolean, default: false },
    }],

    // ── Stats ───────────────────────────────────
    wordCount: { type: Number, default: 0 },
    pageCount: { type: Number, default: 0 },
    estimatedDuration: { type: Number, default: 0 }, // minutes
  },
  {
    timestamps: true,
    collection: 'scripts',
  },
);

// ── Indexes ─────────────────────────────────

scriptSchema.index({ project: 1, status: 1 });
scriptSchema.index({ author: 1, createdAt: -1 });
scriptSchema.index({ title: 'text', logline: 'text' });

// ── Plugins ─────────────────────────────────

scriptSchema.plugin(toJSON);
scriptSchema.plugin(paginate);
scriptSchema.plugin(softDelete);

// ── Pre-save: auto-calculate stats ──────────

scriptSchema.pre('save', function preSave(next) {
  if (this.isModified('content') && this.content) {
    this.wordCount = this.content.split(/\s+/).filter(Boolean).length;
    this.pageCount = Math.ceil(this.wordCount / 250); // Industry standard
    this.estimatedDuration = this.pageCount; // ~1 min per page
  }
  next();
});

const Script = mongoose.model('Script', scriptSchema);

module.exports = Script;
