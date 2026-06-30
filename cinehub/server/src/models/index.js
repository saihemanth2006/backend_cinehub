/**
 * @module models
 * @description Model barrel export.
 */
const User = require('./user.model');
const Project = require('./project.model');
const Script = require('./script.model');
const Team = require('./team.model');
const Portfolio = require('./portfolio.model');
const Notification = require('./notification.model');
const Media = require('./media.model');

module.exports = { User, Project, Script, Team, Portfolio, Notification, Media };
