/**
 * @module models/plugins/softDelete
 * @description Mongoose plugin for soft deletion.
 * Adds isDeleted flag and deletedAt timestamp.
 * Overrides find/findOne to exclude deleted documents by default.
 */
const softDelete = (schema) => {
  schema.add({
    isDeleted: { type: Boolean, default: false, index: true },
    deletedAt: { type: Date, default: null },
    deletedBy: { type: require('mongoose').Schema.Types.ObjectId, ref: 'User', default: null },
  });

  // Instance method to soft-delete
  schema.methods.softDelete = async function softDeleteDoc(userId = null) {
    this.isDeleted = true;
    this.deletedAt = new Date();
    this.deletedBy = userId;
    return this.save();
  };

  // Instance method to restore
  schema.methods.restore = async function restoreDoc() {
    this.isDeleted = false;
    this.deletedAt = null;
    this.deletedBy = null;
    return this.save();
  };

  // Pre-hooks to exclude deleted docs from queries by default
  const excludeDeleted = function excludeDeletedMiddleware(next) {
    if (this.getFilter().isDeleted === undefined) {
      this.where({ isDeleted: false });
    }
    next();
  };

  schema.pre('find', excludeDeleted);
  schema.pre('findOne', excludeDeleted);
  schema.pre('findOneAndUpdate', excludeDeleted);
  schema.pre('countDocuments', excludeDeleted);

  // Static to query including deleted
  schema.statics.findWithDeleted = function findWithDeletedDocs(filter = {}) {
    return this.find({ ...filter, isDeleted: { $in: [true, false] } });
  };

  schema.statics.findDeleted = function findDeletedDocs(filter = {}) {
    return this.find({ ...filter, isDeleted: true });
  };
};

module.exports = softDelete;
