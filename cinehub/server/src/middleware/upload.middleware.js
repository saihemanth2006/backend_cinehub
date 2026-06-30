/**
 * @module middleware/upload
 * @description Multer-based file upload middleware.
 * Pre-configured for image and video uploads with validation.
 */
const path = require('path');

const multer = require('multer');
const { v4: uuidv4 } = require('uuid');

const { env } = require('../config');
const ApiError = require('../utils/ApiError');

// ── Storage Configuration ───────────────────

const storage = multer.diskStorage({
  destination: (_req, _file, cb) => {
    cb(null, path.resolve(__dirname, '../../', env.upload.dir));
  },
  filename: (_req, file, cb) => {
    const ext = path.extname(file.originalname);
    const uniqueName = `${uuidv4()}${ext}`;
    cb(null, uniqueName);
  },
});

// ── File Filter ─────────────────────────────

const fileFilter = (allowedTypes) => (_req, file, cb) => {
  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(ApiError.badRequest(
      `File type '${file.mimetype}' is not allowed. Accepted: ${allowedTypes.join(', ')}`,
      'INVALID_FILE_TYPE',
    ));
  }
};

// ── Upload Presets ──────────────────────────

/** Single image upload (avatar, cover, thumbnail) */
const uploadImage = multer({
  storage,
  limits: { fileSize: 10 * 1024 * 1024 }, // 10MB
  fileFilter: fileFilter(env.upload.allowedImageTypes),
});

/** Single video upload */
const uploadVideo = multer({
  storage,
  limits: { fileSize: env.upload.maxFileSize },
  fileFilter: fileFilter(env.upload.allowedVideoTypes),
});

/** Mixed media upload (images + videos) */
const uploadMedia = multer({
  storage,
  limits: { fileSize: env.upload.maxFileSize },
  fileFilter: fileFilter([...env.upload.allowedImageTypes, ...env.upload.allowedVideoTypes]),
});

/** Memory storage for processing (e.g., sharp resize before saving) */
const uploadToMemory = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 },
  fileFilter: fileFilter(env.upload.allowedImageTypes),
});

module.exports = {
  uploadImage,
  uploadVideo,
  uploadMedia,
  uploadToMemory,
};
