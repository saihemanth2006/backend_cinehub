/**
 * @module utils/pick
 * @description Extracts a subset of keys from an object.
 * Used extensively for sanitizing query params and request bodies.
 *
 * @param {Object} object - Source object
 * @param {string[]} keys - Keys to extract
 * @returns {Object} New object with only the specified keys
 *
 * @example
 * const filter = pick(req.query, ['status', 'role', 'search']);
 */
const pick = (object, keys) => keys.reduce((acc, key) => {
  if (object && Object.prototype.hasOwnProperty.call(object, key)) {
    acc[key] = object[key];
  }
  return acc;
}, {});

module.exports = pick;
