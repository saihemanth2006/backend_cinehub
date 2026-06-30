/**
 * @module api/v1/discovery
 * @description Creator discovery — talent search, recommendations, and matching.
 */
const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const pick = require('../../../utils/pick');
const userRepo = require('../../../repositories/user.repository');
const projectRepo = require('../../../repositories/project.repository');
const portfolioRepo = require('../../../repositories/portfolio.repository');

class DiscoveryService {
  async searchCreators(filter, options) {
    const query = { isActive: true, role: { $in: ['creator', 'producer'] } };
    if (filter.skills && filter.skills.length) query['skills.name'] = { $in: filter.skills };
    if (filter.location) query['location.country'] = { $regex: filter.location, $options: 'i' };
    if (filter.search) {
      query.$or = [
        { firstName: { $regex: filter.search, $options: 'i' } },
        { lastName: { $regex: filter.search, $options: 'i' } },
        { headline: { $regex: filter.search, $options: 'i' } },
      ];
    }
    return userRepo.paginate(query, {
      ...options,
      select: 'firstName lastName displayName slug avatar headline skills location followerCount',
    });
  }

  async getTopCreators(limit = 10) {
    return userRepo.getTopCreators(limit);
  }

  async getSuggestedConnections(userId) {
    const user = await userRepo.findById(userId);
    if (!user) return [];
    const userSkills = (user.skills || []).map((s) => s.name);

    // Find users with overlapping skills who aren't already followed
    const suggestions = await userRepo.model.find({
      _id: { $ne: userId, $nin: user.following || [] },
      'skills.name': { $in: userSkills },
      isActive: true,
    })
      .select('firstName lastName displayName slug avatar headline skills followerCount')
      .sort({ followerCount: -1 })
      .limit(20)
      .lean();

    return suggestions;
  }

  async discoverProjects(filter, options) {
    const query = { visibility: 'public', status: { $nin: ['archived', 'draft'] } };
    if (filter.type) query.type = filter.type;
    if (filter.genre) query.genres = { $in: [filter.genre] };
    if (filter.allowApplications) query.allowApplications = true;
    return projectRepo.paginate(query, { ...options, populate: 'owner' });
  }

  async getTrendingContent() {
    const [creators, projects, portfolios] = await Promise.all([
      userRepo.getTopCreators(5),
      projectRepo.find({ visibility: 'public' }, { sort: { viewCount: -1 }, limit: 5, populate: 'owner' }),
      portfolioRepo.findTrending(5),
    ]);
    return { creators, projects, portfolios };
  }
}

const service = new DiscoveryService();

const controller = {
  searchCreators: catchAsync(async (req, res) => {
    const filter = pick(req.query, ['search', 'skills', 'location']);
    if (filter.skills && typeof filter.skills === 'string') filter.skills = filter.skills.split(',');
    const options = pick(req.query, ['page', 'limit', 'sortBy']);
    const result = await service.searchCreators(filter, options);
    ApiResponse.paginated(result.docs, result.pagination).send(res);
  }),
  topCreators: catchAsync(async (req, res) => {
    const creators = await service.getTopCreators(parseInt(req.query.limit, 10) || 10);
    ApiResponse.ok(creators).send(res);
  }),
  suggestions: catchAsync(async (req, res) => {
    const suggestions = await service.getSuggestedConnections(req.user._id);
    ApiResponse.ok(suggestions).send(res);
  }),
  discoverProjects: catchAsync(async (req, res) => {
    const filter = pick(req.query, ['type', 'genre', 'allowApplications']);
    const options = pick(req.query, ['page', 'limit', 'sortBy']);
    const result = await service.discoverProjects(filter, options);
    ApiResponse.paginated(result.docs, result.pagination).send(res);
  }),
  trending: catchAsync(async (req, res) => {
    const content = await service.getTrendingContent();
    ApiResponse.ok(content).send(res);
  }),
};

const express = require('express');
const { authenticate } = require('../../../middleware');
const router = express.Router();

router.get('/creators', controller.searchCreators);
router.get('/creators/top', controller.topCreators);
router.get('/suggestions', authenticate(), controller.suggestions);
router.get('/projects', controller.discoverProjects);
router.get('/trending', controller.trending);

module.exports = router;
