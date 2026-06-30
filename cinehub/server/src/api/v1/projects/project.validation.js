/**
 * @module api/v1/projects/project.validation
 */
const Joi = require('joi');
const { PROJECT_TYPES, PROJECT_STATUS } = require('../../../utils/constants');
Joi.objectId = () => Joi.string().pattern(/^[0-9a-fA-F]{24}$/, 'valid ObjectId');

const createProject = {
  body: Joi.object({
    title: Joi.string().trim().max(200).required(),
    type: Joi.string().valid(...Object.values(PROJECT_TYPES)).required(),
    tagline: Joi.string().max(300),
    synopsis: Joi.string().max(2000),
    description: Joi.string().max(5000),
    genres: Joi.array().items(Joi.string().trim()).max(5),
    language: Joi.string(),
    budget: Joi.object({ estimated: Joi.number().min(0), currency: Joi.string() }),
    duration: Joi.object({ estimated: Joi.number().min(1) }),
    visibility: Joi.string().valid('public', 'private', 'team_only'),
  }),
};

const updateProject = {
  params: Joi.object({ id: Joi.objectId().required() }),
  body: Joi.object({
    title: Joi.string().trim().max(200),
    tagline: Joi.string().max(300),
    synopsis: Joi.string().max(2000),
    description: Joi.string().max(5000),
    status: Joi.string().valid(...Object.values(PROJECT_STATUS)),
    genres: Joi.array().items(Joi.string().trim()).max(5),
    visibility: Joi.string().valid('public', 'private', 'team_only'),
    allowApplications: Joi.boolean(),
  }).min(1),
};

const listProjects = {
  query: Joi.object({
    search: Joi.string().max(100),
    type: Joi.string().valid(...Object.values(PROJECT_TYPES)),
    status: Joi.string().valid(...Object.values(PROJECT_STATUS)),
    genre: Joi.string(),
    page: Joi.number().integer().min(1),
    limit: Joi.number().integer().min(1).max(100),
    sortBy: Joi.string(),
  }),
};

module.exports = { createProject, updateProject, listProjects };
