/**
 * @module repositories/user.repository
 */
const BaseRepository = require('./base.repository');
const User = require('../models/user.model');

class UserRepository extends BaseRepository {
  constructor() { super(User); }

  async findByEmail(email) {
    return this.model.findOne({ email: email.toLowerCase() });
  }

  async findBySlug(slug) {
    return this.findOne({ slug }, { populate: 'projects' });
  }

  async searchUsers(query, options = {}) {
    const filter = { $text: { $search: query }, isActive: true };
    return this.paginate(filter, { ...options, sort: { score: { $meta: 'textScore' } } });
  }

  async findBySkills(skills, options = {}) {
    return this.paginate({ 'skills.name': { $in: skills }, isActive: true }, options);
  }

  async findNearLocation(coordinates, maxDistanceKm = 50, options = {}) {
    return this.find({
      'location.coordinates': {
        $near: { $geometry: { type: 'Point', coordinates }, $maxDistance: maxDistanceKm * 1000 },
      },
      isActive: true,
    }, options);
  }

  async addFollower(userId, followerId) {
    await Promise.all([
      this.model.findByIdAndUpdate(userId, { $addToSet: { followers: followerId }, $inc: { followerCount: 1 } }),
      this.model.findByIdAndUpdate(followerId, { $addToSet: { following: userId }, $inc: { followingCount: 1 } }),
    ]);
  }

  async removeFollower(userId, followerId) {
    await Promise.all([
      this.model.findByIdAndUpdate(userId, { $pull: { followers: followerId }, $inc: { followerCount: -1 } }),
      this.model.findByIdAndUpdate(followerId, { $pull: { following: userId }, $inc: { followingCount: -1 } }),
    ]);
  }

  async getTopCreators(limit = 10) {
    return this.find(
      { role: { $in: ['creator', 'producer'] }, isActive: true },
      { sort: { followerCount: -1 }, limit },
    );
  }
}

module.exports = new UserRepository();
