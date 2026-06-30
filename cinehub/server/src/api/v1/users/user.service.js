/**
 * @module api/v1/users/user.service
 */
const ApiError = require('../../../utils/ApiError');
const userRepo = require('../../../repositories/user.repository');
const eventEmitter = require('../../../events/emitter');

class UserService {
  async getUserById(id) {
    const user = await userRepo.findById(id, { populate: 'projects' });
    if (!user) throw ApiError.notFound('User not found');
    return user;
  }

  async getUserBySlug(slug) {
    const user = await userRepo.findBySlug(slug);
    if (!user) throw ApiError.notFound('User not found');
    return user;
  }

  async updateProfile(userId, updateData) {
    const user = await userRepo.updateById(userId, updateData);
    if (!user) throw ApiError.notFound('User not found');
    return user;
  }

  async listUsers(filter, options) {
    const query = { isActive: true };
    if (filter.role) query.role = filter.role;
    if (filter.skill) query['skills.name'] = { $regex: filter.skill, $options: 'i' };
    if (filter.search) {
      query.$or = [
        { firstName: { $regex: filter.search, $options: 'i' } },
        { lastName: { $regex: filter.search, $options: 'i' } },
        { headline: { $regex: filter.search, $options: 'i' } },
      ];
    }
    return userRepo.paginate(query, options);
  }

  async followUser(currentUserId, targetUserId) {
    if (currentUserId === targetUserId) throw ApiError.badRequest('Cannot follow yourself');
    const target = await userRepo.findById(targetUserId);
    if (!target) throw ApiError.notFound('User not found');
    await userRepo.addFollower(targetUserId, currentUserId);
    eventEmitter.emit('user:followed', { followerId: currentUserId, followedId: targetUserId });
  }

  async unfollowUser(currentUserId, targetUserId) {
    await userRepo.removeFollower(targetUserId, currentUserId);
  }

  async getFollowers(userId, options) {
    const user = await userRepo.findById(userId);
    if (!user) throw ApiError.notFound('User not found');
    return userRepo.paginate({ _id: { $in: user.followers || [] } }, options);
  }

  async getFollowing(userId, options) {
    const user = await userRepo.findById(userId);
    if (!user) throw ApiError.notFound('User not found');
    return userRepo.paginate({ _id: { $in: user.following || [] } }, options);
  }

  async deactivateAccount(userId) {
    await userRepo.updateById(userId, { isActive: false });
    eventEmitter.emit('user:deactivated', { userId });
  }
}

module.exports = new UserService();
