/**
 * @module api/v1/users/user.validation
 */
const Joi = require('joi');
Joi.objectId = () => Joi.string().pattern(/^[0-9a-fA-F]{24}$/, 'valid ObjectId');

const getUser = { params: Joi.object({ id: Joi.objectId().required() }) };

const updateProfile = {
  body: Joi.object({
    firstName: Joi.string().trim().max(50),
    lastName: Joi.string().trim().max(50),
    bio: Joi.string().max(500).allow(''),
    headline: Joi.string().max(150).allow(''),
    location: Joi.object({ city: Joi.string(), state: Joi.string(), country: Joi.string() }),
    skills: Joi.array().items(Joi.object({
      name: Joi.string().required(),
      category: Joi.string(),
      proficiency: Joi.number().min(1).max(5),
    })).max(20),
    socialLinks: Joi.object({
      website: Joi.string().uri().allow(''),
      imdb: Joi.string().allow(''),
      linkedin: Joi.string().allow(''),
      instagram: Joi.string().allow(''),
      youtube: Joi.string().allow(''),
      vimeo: Joi.string().allow(''),
      twitter: Joi.string().allow(''),
    }),
    preferences: Joi.object({
      emailNotifications: Joi.boolean(),
      pushNotifications: Joi.boolean(),
      profileVisibility: Joi.string().valid('public', 'private', 'connections'),
    }),
  }).min(1),
};

const listUsers = {
  query: Joi.object({
    search: Joi.string().max(100),
    role: Joi.string().valid('user', 'creator', 'producer', 'admin'),
    skill: Joi.string(),
    page: Joi.number().integer().min(1),
    limit: Joi.number().integer().min(1).max(100),
    sortBy: Joi.string(),
  }),
};

module.exports = { getUser, updateProfile, listUsers };
