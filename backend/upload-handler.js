const fs = require('fs');
const path = require('path');

// Create uploads directory if it doesn't exist
const uploadsDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir, { recursive: true });
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

    fs.writeFileSync(storagePath, buffer);

    const fileUrl = `/api/media/${fileId}${ext}`;
    this.files.set(fileId, {
      path: storagePath,
      mimetype,
      filename,
      createdAt: Date.now(),
      url: fileUrl,
    });

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
