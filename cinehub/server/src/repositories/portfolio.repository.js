/**
 * @module repositories/portfolio.repository
 */
const BaseRepository = require('./base.repository');
const Portfolio = require('../models/portfolio.model');

class PortfolioRepository extends BaseRepository {
  constructor() { super(Portfolio); }

  async findByOwner(ownerId, options = {}) {
    return this.paginate({ owner: ownerId }, { ...options, sort: { order: 1, createdAt: -1 } });
  }

  async findPublicByOwner(ownerId, options = {}) {
    return this.paginate({ owner: ownerId, visibility: 'public' }, options);
  }

  async findFeatured(options = {}) {
    return this.paginate({ isFeatured: true, visibility: 'public' }, { ...options, sort: { viewCount: -1 } });
  }

  async findTrending(limit = 20) {
    const oneWeekAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
    return this.find(
      { visibility: 'public', createdAt: { $gte: oneWeekAgo } },
      { sort: { viewCount: -1, likeCount: -1 }, limit, populate: 'owner' },
    );
  }

  async toggleLike(portfolioId, userId) {
    const item = await this.model.findById(portfolioId);
    const hasLiked = item.likes.includes(userId);
    if (hasLiked) {
      item.likes.pull(userId);
      item.likeCount = Math.max(0, item.likeCount - 1);
    } else {
      item.likes.push(userId);
      item.likeCount += 1;
    }
    return item.save();
  }

  async incrementViewCount(portfolioId) {
    return this.model.findByIdAndUpdate(portfolioId, { $inc: { viewCount: 1 } });
  }
}

module.exports = new PortfolioRepository();
