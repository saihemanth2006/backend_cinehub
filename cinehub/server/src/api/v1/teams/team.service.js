/**
 * @module api/v1/teams/team.service
 */
const ApiError = require('../../../utils/ApiError');
const teamRepo = require('../../../repositories/team.repository');
const eventEmitter = require('../../../events/emitter');

class TeamService {
  async getTeamByProject(projectId) {
    const team = await teamRepo.findByProject(projectId);
    if (!team) throw ApiError.notFound('Team not found');
    return team;
  }

  async getMyTeams(userId, options) {
    return teamRepo.findUserTeams(userId, options);
  }

  async inviteMember(teamId, userId, memberData) {
    const team = await teamRepo.findById(teamId);
    if (!team) throw ApiError.notFound('Team not found');
    if (team.owner.toString() !== userId.toString()) {
      throw ApiError.forbidden('Only the team owner can invite members');
    }
    const existing = team.members.find((m) => m.user.toString() === memberData.userId);
    if (existing) throw ApiError.conflict('User is already a team member');

    const updated = await teamRepo.addMember(teamId, {
      user: memberData.userId,
      role: memberData.role || 'member',
      status: 'invited',
      invitedBy: userId,
    });

    eventEmitter.emit('team:memberInvited', {
      teamId, invitedUserId: memberData.userId, invitedBy: userId,
    });

    return updated;
  }

  async respondToInvite(teamId, userId, accept) {
    const status = accept ? 'active' : 'removed';
    const team = await teamRepo.updateMemberStatus(teamId, userId, status);
    if (!team) throw ApiError.notFound('Invitation not found');

    if (accept) {
      eventEmitter.emit('team:memberJoined', { teamId, userId });
    }
    return team;
  }

  async removeMember(teamId, ownerId, targetUserId) {
    const team = await teamRepo.findById(teamId);
    if (!team) throw ApiError.notFound('Team not found');
    if (team.owner.toString() !== ownerId.toString()) {
      throw ApiError.forbidden('Only the team owner can remove members');
    }
    if (targetUserId === ownerId.toString()) {
      throw ApiError.badRequest('Cannot remove yourself as owner');
    }
    return teamRepo.removeMember(teamId, targetUserId);
  }

  async updateMemberRole(teamId, ownerId, targetUserId, newRole) {
    const team = await teamRepo.findById(teamId);
    if (!team) throw ApiError.notFound('Team not found');
    if (team.owner.toString() !== ownerId.toString()) {
      throw ApiError.forbidden('Only the team owner can change roles');
    }
    return teamRepo.model.findOneAndUpdate(
      { _id: teamId, 'members.user': targetUserId },
      { $set: { 'members.$.role': newRole } },
      { new: true },
    );
  }
}

module.exports = new TeamService();
