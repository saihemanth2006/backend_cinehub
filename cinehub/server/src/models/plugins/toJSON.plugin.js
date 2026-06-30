/**
 * @module models/plugins/toJSON
 * @description Mongoose plugin that transforms document output:
 * - Replaces _id with id
 * - Removes __v
 * - Removes any fields marked as private (e.g., password)
 */
const toJSON = (schema) => {
  const transform = (_doc, ret) => {
    ret.id = ret._id.toString();
    delete ret._id;
    delete ret.__v;

    // Remove fields marked private in schema options
    Object.keys(schema.paths).forEach((path) => {
      if (schema.paths[path].options && schema.paths[path].options.private) {
        delete ret[path];
      }
    });

    return ret;
  };

  schema.set('toJSON', {
    transform,
    virtuals: true,
    getters: true,
  });

  schema.set('toObject', {
    transform,
    virtuals: true,
    getters: true,
  });
};

module.exports = toJSON;
