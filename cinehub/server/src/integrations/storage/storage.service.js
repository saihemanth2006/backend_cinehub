/**
 * @module integrations/storage/storage.service
 * @description Abstracted storage service supporting local filesystem and AWS S3.
 */
const fs = require('fs');
const path = require('path');
const { S3Client, PutObjectCommand, DeleteObjectCommand, GetObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');
const { env, logger } = require('../../config');

class StorageService {
  constructor() {
    this.provider = env.storage.provider;
    if (this.provider === 's3') {
      this.s3 = new S3Client({
        region: env.aws.region,
        credentials: { accessKeyId: env.aws.accessKeyId, secretAccessKey: env.aws.secretAccessKey },
      });
      this.bucket = env.aws.s3Bucket;
    }
  }

  async upload(filePath, destination, options = {}) {
    if (this.provider === 's3') return this._uploadToS3(filePath, destination, options);
    return this._uploadToLocal(filePath, destination);
  }

  async delete(fileKey) {
    if (this.provider === 's3') return this._deleteFromS3(fileKey);
    return this._deleteFromLocal(fileKey);
  }

  async getSignedUrl(fileKey, expiresIn = 3600) {
    if (this.provider !== 's3') return `/uploads/${fileKey}`;
    const command = new GetObjectCommand({ Bucket: this.bucket, Key: fileKey });
    return getSignedUrl(this.s3, command, { expiresIn });
  }

  // ── S3 ────────────────────────────────────

  async _uploadToS3(filePath, destination, options) {
    const fileContent = fs.readFileSync(filePath);
    const command = new PutObjectCommand({
      Bucket: this.bucket,
      Key: destination,
      Body: fileContent,
      ContentType: options.contentType,
      ACL: options.public ? 'public-read' : 'private',
    });
    await this.s3.send(command);
    logger.info(`[Storage] Uploaded to S3: ${destination}`);
    return { provider: 's3', key: destination, url: `https://${this.bucket}.s3.amazonaws.com/${destination}` };
  }

  async _deleteFromS3(fileKey) {
    const command = new DeleteObjectCommand({ Bucket: this.bucket, Key: fileKey });
    await this.s3.send(command);
    logger.info(`[Storage] Deleted from S3: ${fileKey}`);
  }

  // ── Local ─────────────────────────────────

  async _uploadToLocal(filePath, destination) {
    const destPath = path.resolve(__dirname, '../../../uploads', destination);
    fs.mkdirSync(path.dirname(destPath), { recursive: true });
    fs.copyFileSync(filePath, destPath);
    logger.info(`[Storage] Saved locally: ${destPath}`);
    return { provider: 'local', key: destination, url: `/uploads/${destination}` };
  }

  async _deleteFromLocal(fileKey) {
    const filePath = path.resolve(__dirname, '../../../uploads', fileKey);
    if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    logger.info(`[Storage] Deleted locally: ${fileKey}`);
  }
}

module.exports = new StorageService();
