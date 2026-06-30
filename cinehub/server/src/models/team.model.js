/**
 * @module models/team.model
 * @description Team schema for film project collaboration.
 */
const mongoose = require('mongoose');
const { TEAM_ROLES, MEMBER_STATUS } = require('../utils/constants');
const toJSON = require('./plugins/toJSON.plugin');
const paginate = require('./plugins/paginate.plugin');
const softDelete = require('./plugins/softDelete.plugin');

const teamSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true, maxlength: 150 },
  description: { type: String, maxlength: 1000 },
  project: { type: mongoose.Schema.Types.ObjectId, ref: 'Project', required: true, index: true },
  owner: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true, index: true },
  members: [{
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    role: { type: String, enum: Object.values(TEAM_ROLES), default: TEAM_ROLES.MEMBER },
    status: { type: String, enum: Object.values(MEMBER_STATUS), default: MEMBER_STATUS.INVITED },
    permissions: {
      canEdit: { type: Boolean, default: false },
      canInvite: { type: Boolean, default: false },
      canRemove: { type: Boolean, default: false },
      canManageScripts: { type: Boolean, default: false },
    },
    joinedAt: Date,
    invitedAt: { type: Date, default: Date.now },
    invitedBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  }],
  openRoles: [{
    role: { type: String, enum: Object.values(TEAM_ROLES) },
    title: String,
    description: String,
    requirements: [String],
    applicants: [{
      user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
      message: String,
      appliedAt: { type: Date, default: Date.now },
      status: { type: String, enum: ['pending', 'accepted', 'rejected'], default: 'pending' },
    }],
    isFilled: { type: Boolean, default: false },
  }],
  maxMembers: { type: Number, default: 50 },
  isPublic: { type: Boolean, default: false },
}, { timestamps: true, collection: 'teams' });

teamSchema.index({ 'members.user': 1 });
teamSchema.plugin(toJSON);
teamSchema.plugin(paginate);
teamSchema.plugin(softDelete);

teamSchema.virtual('memberCount').get(function getMemberCount() {
  return this.members ? this.members.filter((m) => m.status === MEMBER_STATUS.ACTIVE).length : 0;
});

teamSchema.methods.isMember = function isMember(userId) {
  return this.members.some((m) => m.user.toString() === userId.toString() && m.status === MEMBER_STATUS.ACTIVE);
};

const Team = mongoose.model('Team', teamSchema);
module.exports = Team;
