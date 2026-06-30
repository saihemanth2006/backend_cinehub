/**
 * @module repositories/team.repository
 */
const BaseRepository = require('./base.repository');
const Team = require('../models/team.model');

class TeamRepository extends BaseRepository {
  constructor() { super(Team); }

  async findByProject(projectId) {
    return this.findOne({ project: projectId }, { populate: 'members.user owner' });
  }

  async findUserTeams(userId, options = {}) {
    return this.paginate({ 'members.user': userId, 'members.status': 'active' }, { ...options, populate: 'project owner' });
  }

  async addMember(teamId, memberData) {
    return this.model.findByIdAndUpdate(teamId, { $push: { members: memberData } }, { new: true });
  }

  async removeMember(teamId, userId) {
    return this.model.findByIdAndUpdate(teamId, {
      $pull: { members: { user: userId } },
    }, { new: true });
  }

  async updateMemberStatus(teamId, userId, status) {
    return this.model.findOneAndUpdate(
      { _id: teamId, 'members.user': userId },
      { $set: { 'members.$.status': status, ...(status === 'active' ? { 'members.$.joinedAt': new Date() } : {}) } },
      { new: true },
    );
  }
}

module.exports = new TeamRepository();
