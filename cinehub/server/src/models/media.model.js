/**
 * @module models/media.model
 * @description Media metadata schema for files uploaded to the platform.
 */
const mongoose = require('mongoose');
const { MEDIA_TYPES } = require('../utils/constants');
const toJSON = require('./plugins/toJSON.plugin');
const paginate = require('./plugins/paginate.plugin');
const softDelete = require('./plugins/softDelete.plugin');

const mediaSchema = new mongoose.Schema({
  filename: { type: String, required: true },
  originalName: { type: String, required: true },
  mimeType: { type: String, required: true },
  type: { type: String, enum: Object.values(MEDIA_TYPES), required: true, index: true },
  size: { type: Number, required: true },
  url: { type: String, required: true },
  thumbnailUrl: String,
  storageProvider: { type: String, enum: ['local', 's3'], default: 'local' },
  storagePath: String,
  dimensions: { width: Number, height: Number },
  duration: Number,
  metadata: { type: mongoose.Schema.Types.Mixed },
  uploadedBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true, index: true },
  project: { type: mongoose.Schema.Types.ObjectId, ref: 'Project', index: true },
  tags: [String],
  isProcessed: { type: Boolean, default: false },
  processingStatus: { type: String, enum: ['pending', 'processing', 'completed', 'failed'], default: 'pending' },
}, { timestamps: true, collection: 'media' });

mediaSchema.index({ uploadedBy: 1, type: 1 });
mediaSchema.plugin(toJSON);
mediaSchema.plugin(paginate);
mediaSchema.plugin(softDelete);

const Media = mongoose.model('Media', mediaSchema);
module.exports = Media;
