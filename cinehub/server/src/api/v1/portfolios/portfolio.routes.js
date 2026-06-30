/**
 * @module api/v1/portfolios
 * @description Portfolio service + controller + routes (compact module)
 */
const ApiError = require('../../../utils/ApiError');
const portfolioRepo = require('../../../repositories/portfolio.repository');
const catchAsync = require('../../../utils/catchAsync');
const ApiResponse = require('../../../utils/ApiResponse');
const pick = require('../../../utils/pick');
const eventEmitter = require('../../../events/emitter');

// ── Service ─────────────────────────────────

class PortfolioService {
  async create(userId, data) {
    return portfolioRepo.create({ ...data, owner: userId });
  }

  async getById(id) {
    const item = await portfolioRepo.findById(id, { populate: 'owner' });
    if (!item) throw ApiError.notFound('Portfolio item not found');
    await portfolioRepo.incrementViewCount(id);
    return item;
  }

  async update(id, userId, data) {
    const item = await portfolioRepo.findById(id);
    if (!item) throw ApiError.notFound('Portfolio item not found');
    if (item.owner.toString() !== userId.toString()) throw ApiError.forbidden('Not your portfolio item');
    return portfolioRepo.updateById(id, data);
  }

  async delete(id, userId) {
    const item = await portfolioRepo.findById(id);
    if (!item) throw ApiError.notFound('Portfolio item not found');
    if (item.owner.toString() !== userId.toString()) throw ApiError.forbidden('Not your portfolio item');
    await portfolioRepo.softDeleteById(id, userId);
  }

  async getByOwner(ownerId, options) {
    return portfolioRepo.findPublicByOwner(ownerId, options);
  }

  async getMyPortfolio(userId, options) {
    return portfolioRepo.findByOwner(userId, options);
  }

  async getFeatured(options) {
    return portfolioRepo.findFeatured(options);
  }

  async getTrending(limit) {
    return portfolioRepo.findTrending(limit);
  }

  async toggleLike(portfolioId, userId) {
    const result = await portfolioRepo.toggleLike(portfolioId, userId);
    eventEmitter.emit('portfolio:liked', { portfolioId, userId });
    return result;
  }

  async addComment(portfolioId, userId, content) {
    const item = await portfolioRepo.findById(portfolioId, { lean: false });
    if (!item) throw ApiError.notFound('Portfolio item not found');
    // Need a non-lean doc to push
    const Portfolio = require('../../../models/portfolio.model');
    const doc = await Portfolio.findById(portfolioId);
    doc.comments.push({ user: userId, content });
    await doc.save();
    eventEmitter.emit('portfolio:commented', { portfolioId, userId });
    return doc;
  }
}

const service = new PortfolioService();

// ── Controller ──────────────────────────────

const controller = {
  create: catchAsync(async (req, res) => {
    const item = await service.create(req.user._id, req.body);
    ApiResponse.created(item, 'Portfolio item created').send(res);
  }),
  getById: catchAsync(async (req, res) => {
    const item = await service.getById(req.params.id);
    ApiResponse.ok(item).send(res);
  }),
  update: catchAsync(async (req, res) => {
    const item = await service.update(req.params.id, req.user._id, req.body);
    ApiResponse.ok(item, 'Portfolio item updated').send(res);
  }),
  delete: catchAsync(async (req, res) => {
    await service.delete(req.params.id, req.user._id);
    ApiResponse.ok(null, 'Portfolio item deleted').send(res);
  }),
  getByOwner: catchAsync(async (req, res) => {
    const options = pick(req.query, ['page', 'limit']);
    const result = await service.getByOwner(req.params.userId, options);
    ApiResponse.paginated(result.docs, result.pagination).send(res);
  }),
  myPortfolio: catchAsync(async (req, res) => {
    const options = pick(req.query, ['page', 'limit']);
    const result = await service.getMyPortfolio(req.user._id, options);
    ApiResponse.paginated(result.docs, result.pagination).send(res);
  }),
  featured: catchAsync(async (req, res) => {
    const options = pick(req.query, ['page', 'limit']);
    const result = await service.getFeatured(options);
    ApiResponse.paginated(result.docs, result.pagination).send(res);
  }),
  trending: catchAsync(async (req, res) => {
    const items = await service.getTrending(parseInt(req.query.limit, 10) || 20);
    ApiResponse.ok(items).send(res);
  }),
  toggleLike: catchAsync(async (req, res) => {
    const item = await service.toggleLike(req.params.id, req.user._id);
    ApiResponse.ok({ likeCount: item.likeCount }, 'Like toggled').send(res);
  }),
  addComment: catchAsync(async (req, res) => {
    const item = await service.addComment(req.params.id, req.user._id, req.body.content);
    ApiResponse.created(item, 'Comment added').send(res);
  }),
};

// ── Routes ──────────────────────────────────

const express = require('express');
const { authenticate } = require('../../../middleware');
const router = express.Router();

router.get('/featured', controller.featured);
router.get('/trending', controller.trending);
router.get('/me', authenticate(), controller.myPortfolio);
router.get('/user/:userId', controller.getByOwner);
router.get('/:id', controller.getById);
router.post('/', authenticate(), controller.create);
router.patch('/:id', authenticate(), controller.update);
router.delete('/:id', authenticate(), controller.delete);
router.post('/:id/like', authenticate(), controller.toggleLike);
router.post('/:id/comments', authenticate(), controller.addComment);

module.exports = router;
