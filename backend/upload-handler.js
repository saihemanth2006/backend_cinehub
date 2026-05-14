const fs = require('fs');
const path = require('path');

// Create uploads directory if it doesn't exist. In serverless environments
// this may be read-only, so fall back to in-memory storage if mkdir fails.
const uploadsDir = path.join(__dirname, 'uploads');
let uploadsDirWritable = false;
try {
  if (!fs.existsSync(uploadsDir)) {
    fs.mkdirSync(uploadsDir, { recursive: true });
  }
  // test write permission
  const testFile = path.join(uploadsDir, '.write_test');
  fs.writeFileSync(testFile, 'ok');
  fs.unlinkSync(testFile);
  uploadsDirWritable = true;
} catch (e) {
  uploadsDirWritable = false;
  console.warn('Uploads directory not writable, falling back to in-memory storage.');
}

// Simple in-memory file storage with expiry
class FileStorage {
  constructor() {
    this.files = new Map();
    this.maxFileSize = 50 * 1024 * 1024; // 50MB max
    this.maxFilesPerRequest = 5;
  }

  saveBuffer(buffer, mimetype, filename) {
    if (buffer.length > this.maxFileSize) {
      throw new Error(`File too large. Max: ${this.maxFileSize / (1024 * 1024)}MB`);
    }

    const fileId = `file_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
    const ext = this.getExtensionFromMimetype(mimetype);
    const storagePath = path.join(uploadsDir, `${fileId}${ext}`);
    const fileUrl = `/api/media/${fileId}${ext}`;
    const meta = { mimetype, filename, createdAt: Date.now(), url: fileUrl };

    if (uploadsDirWritable) {
      try {
        fs.writeFileSync(storagePath, buffer);
        meta.path = storagePath;
        this.files.set(fileId, meta);
        return fileUrl;
      } catch (e) {
        // fallback to memory
        console.warn('Failed to write upload to disk, using in-memory storage.', e && e.message ? e.message : e);
      }
    }

    // In-memory fallback: store the buffer and metadata
    meta.buffer = buffer;
    this.files.set(fileId, meta);
    return fileUrl;
  }

  getExtensionFromMimetype(mimetype) {
    const extensions = {
      'image/jpeg': '.jpg',
      'image/png': '.png',
      'image/gif': '.gif',
      'image/webp': '.webp',
      'video/mp4': '.mp4',
      'video/quicktime': '.mov',
      'video/x-msvideo': '.avi',
      'video/webm': '.webm',
    };
    return extensions[mimetype] || '.bin';
  }

  getFile(fileId) {
    return this.files.get(fileId);
  }

  getAllFiles() {
    return Array.from(this.files.values());
  }
}

module.exports = {
  FileStorage,
  uploadsDir,
};
