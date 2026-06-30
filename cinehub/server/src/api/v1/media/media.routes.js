/**
 * @module api/v1/media
 * @description Media upload, metadata management, and retrieval.
 */
const ApiError = require('../../../utils/ApiError');
const mediaRepo = require('../../../repositories/media.repository');
const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const pick = require('../../../utils/pick');

class MediaService {
  async uploadMedia(userId, file, metadata = {}) {
    if (!file) throw ApiError.badRequest('No file provided');

    const mediaDoc = await mediaRepo.create({
      filename: file.filename,
      originalName: file.originalname,
      mimeType: file.mimetype,
      type: this._detectMediaType(file.mimetype),
      size: file.size,
      url: `/uploads/${file.filename}`,
      storagePath: file.path,
      storageProvider: 'local',
      uploadedBy: userId,
      project: metadata.projectId || undefined,
      tags: metadata.tags || [],
    });

    return mediaDoc;
  }

  async getById(id) {
    const media = await mediaRepo.findById(id);
    if (!media) throw ApiError.notFound('Media not found');
    return media;
  }

  async getByProject(projectId, options) {
    return mediaRepo.findByProject(projectId, options);
  }

  async getMyMedia(userId, options) {
    return mediaRepo.findByUploader(userId, options);
  }

  async deleteMedia(id, userId) {
    const media = await mediaRepo.findById(id);
    if (!media) throw ApiError.notFound('Media not found');
    if (media.uploadedBy.toString() !== userId.toString()) {
      throw ApiError.forbidden('Not your media');
    }
    await mediaRepo.softDeleteById(id, userId);
  }

  async getStorageUsage(userId) {
    return mediaRepo.getStorageUsage(userId);
  }

  _detectMediaType(mimeType) {
    if (mimeType.startsWith('image/')) return 'image';
    if (mimeType.startsWith('video/')) return 'video';
    if (mimeType.startsWith('audio/')) return 'audio';
    return 'document';
  }
}

const service = new MediaService();

const controller = {
  upload: catchAsync(async (req, res) => {
    const media = await service.uploadMedia(req.user._id, req.file, req.body);
    ApiResponse.created(media, 'Media uploaded').send(res);
  }),
  getById: catchAsync(async (req, res) => {
    const media = await service.getById(req.params.id);
    ApiResponse.ok(media).send(res);
  }),
  getByProject: catchAsync(async (req, res) => {
    const options = pick(req.query, ['page', 'limit']);
    const result = await service.getByProject(req.params.projectId, options);
    ApiResponse.paginated(result.docs, result.pagination).send(res);
  }),
  myMedia: catchAsync(async (req, res) => {
    const options = pick(req.query, ['page', 'limit']);
    const result = await service.getMyMedia(req.user._id, options);
    ApiResponse.paginated(result.docs, result.pagination).send(res);
  }),
  remove: catchAsync(async (req, res) => {
    await service.deleteMedia(req.params.id, req.user._id);
    ApiResponse.ok(null, 'Media deleted').send(res);
  }),
  storageUsage: catchAsync(async (req, res) => {
    const usage = await service.getStorageUsage(req.user._id);
    ApiResponse.ok(usage).send(res);
  }),
};

const express = require('express');
const { authenticate, uploadMedia } = require('../../../middleware');
const router = express.Router();

router.get('/me', authenticate(), controller.myMedia);
router.get('/storage-usage', authenticate(), controller.storageUsage);
router.get('/project/:projectId', authenticate(), controller.getByProject);
router.get('/:id', authenticate(), controller.getById);
router.post('/upload', authenticate(), uploadMedia.single('file'), controller.upload);
router.delete('/:id', authenticate(), controller.remove);

module.exports = router;
