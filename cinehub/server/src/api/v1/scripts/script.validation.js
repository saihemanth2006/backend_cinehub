/**
 * @module api/v1/scripts — validation, service, controller, routes
 */
const Joi = require('joi');
const { SCRIPT_FORMATS, SCRIPT_STATUS } = require('../../../utils/constants');
Joi.objectId = () => Joi.string().pattern(/^[0-9a-fA-F]{24}$/, 'valid ObjectId');

const createScript = {
  body: Joi.object({
    title: Joi.string().trim().max(300).required(),
    format: Joi.string().valid(...Object.values(SCRIPT_FORMATS)).required(),
    projectId: Joi.objectId().required(),
    content: Joi.string(),
    logline: Joi.string().max(500),
    synopsis: Joi.string().max(3000),
  }),
};

const updateScript = {
  params: Joi.object({ id: Joi.objectId().required() }),
  body: Joi.object({
    title: Joi.string().trim().max(300),
    content: Joi.string(),
    status: Joi.string().valid(...Object.values(SCRIPT_STATUS)),
    logline: Joi.string().max(500),
    synopsis: Joi.string().max(3000),
    changelog: Joi.string().max(500),
  }).min(1),
};

const generateScript = {
  body: Joi.object({
    projectId: Joi.objectId().required(),
    format: Joi.string().valid(...Object.values(SCRIPT_FORMATS)).required(),
    prompt: Joi.string().min(10).max(2000).required(),
    genre: Joi.string(),
    tone: Joi.string(),
    length: Joi.string().valid('short', 'medium', 'long').default('medium'),
    characters: Joi.array().items(Joi.object({ name: Joi.string(), description: Joi.string() })),
    additionalContext: Joi.string().max(1000),
  }),
};

module.exports = { createScript, updateScript, generateScript };
