/**
 * @module models/ai-generation.model
 * @description MongoDB model for persisting AI generation history.
 * Tracks all AI interactions for analytics, billing, and audit.
 */
const mongoose = require('mongoose');

const aiGenerationSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
      index: true,
    },
    module: {
      type: String,
      required: true,
      index: true,
    },
    task: {
      type: String,
      required: true,
      index: true,
    },
    templateId: {
      type: String,
      required: true,
    },
    input: {
      type: mongoose.Schema.Types.Mixed,
      required: true,
    },
    output: {
      type: mongoose.Schema.Types.Mixed,
    },
    meta: {
      provider: String,
      model: String,
      tokensUsed: { type: Number, default: 0 },
      promptTokens: { type: Number, default: 0 },
      completionTokens: { type: Number, default: 0 },
      generationTimeMs: { type: Number, default: 0 },
      cached: { type: Boolean, default: false },
      warnings: [String],
    },
    status: {
      type: String,
      enum: ['pending', 'completed', 'failed', 'cancelled'],
      default: 'pending',
    },
    error: {
      message: String,
      code: String,
    },
    requestId: String,
    projectId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Project',
    },
  },
  {
    timestamps: true,
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  },
);

// ── Indexes ─────────────────────────────────────────────
aiGenerationSchema.index({ userId: 1, createdAt: -1 });
aiGenerationSchema.index({ module: 1, task: 1, createdAt: -1 });
aiGenerationSchema.index({ status: 1 });
aiGenerationSchema.index({ createdAt: -1 });

// ── Statics ─────────────────────────────────────────────

/**
 * Get usage stats for a user.
 */
aiGenerationSchema.statics.getUserStats = async function (userId, period = 30) {
  const since = new Date();
  since.setDate(since.getDate() - period);

  const stats = await this.aggregate([
    { $match: { userId: new mongoose.Types.ObjectId(userId), createdAt: { $gte: since } } },
    {
      $group: {
        _id: null,
        totalRequests: { $sum: 1 },
        totalTokens: { $sum: '$meta.tokensUsed' },
        avgLatency: { $avg: '$meta.generationTimeMs' },
        byModule: { $push: '$module' },
      },
    },
  ]);

  return stats[0] || { totalRequests: 0, totalTokens: 0, avgLatency: 0 };
};

/**
 * Get generation history for a user.
 */
aiGenerationSchema.statics.getHistory = async function (userId, { page = 1, limit = 20, module } = {}) {
  const filter = { userId: new mongoose.Types.ObjectId(userId) };
  if (module) filter.module = module;

  const [results, total] = await Promise.all([
    this.find(filter)
      .sort({ createdAt: -1 })
      .skip((page - 1) * limit)
      .limit(limit)
      .select('-output')
      .lean(),
    this.countDocuments(filter),
  ]);

  return { results, total, page, pages: Math.ceil(total / limit) };
};

const AIGeneration = mongoose.model('AIGeneration', aiGenerationSchema);

module.exports = AIGeneration;
