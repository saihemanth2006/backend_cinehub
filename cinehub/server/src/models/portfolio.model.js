/**
 * @module models/portfolio.model
 * @description Portfolio item schema for showcasing creative work.
 */
const mongoose = require('mongoose');
const { PORTFOLIO_ITEM_TYPES, MEDIA_TYPES } = require('../utils/constants');
const toJSON = require('./plugins/toJSON.plugin');
const paginate = require('./plugins/paginate.plugin');
const softDelete = require('./plugins/softDelete.plugin');

const portfolioSchema = new mongoose.Schema({
  title: { type: String, required: true, trim: true, maxlength: 200 },
  description: { type: String, maxlength: 2000 },
  type: { type: String, enum: Object.values(PORTFOLIO_ITEM_TYPES), required: true, index: true },
  owner: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true, index: true },
  project: { type: mongoose.Schema.Types.ObjectId, ref: 'Project' },
  media: {
    url: { type: String, required: true },
    thumbnail: String,
    type: { type: String, enum: Object.values(MEDIA_TYPES) },
    duration: Number,
    resolution: String,
  },
  tags: [{ type: String, trim: true }],
  credits: [{ name: String, role: String, user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' } }],
  viewCount: { type: Number, default: 0 },
  likeCount: { type: Number, default: 0 },
  likes: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
  comments: [{
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    content: { type: String, maxlength: 500 },
    createdAt: { type: Date, default: Date.now },
  }],
  isFeatured: { type: Boolean, default: false },
  visibility: { type: String, enum: ['public', 'private', 'unlisted'], default: 'public' },
  order: { type: Number, default: 0 },
}, { timestamps: true, collection: 'portfolios' });

portfolioSchema.index({ title: 'text', tags: 'text' });
portfolioSchema.index({ owner: 1, type: 1 });
portfolioSchema.index({ viewCount: -1 });

portfolioSchema.plugin(toJSON);
portfolioSchema.plugin(paginate);
portfolioSchema.plugin(softDelete);

const Portfolio = mongoose.model('Portfolio', portfolioSchema);
module.exports = Portfolio;
