/**
 * @module api/v1/users/user.routes
 */
const express = require('express');
const { authenticate, validate } = require('../../../middleware');
const userController = require('./user.controller');
const userValidation = require('./user.validation');

const router = express.Router();

router.get('/', authenticate(), validate(userValidation.listUsers), userController.listUsers);
router.get('/:id', validate(userValidation.getUser), userController.getUser);
router.patch('/profile', authenticate(), validate(userValidation.updateProfile), userController.updateProfile);
router.post('/:id/follow', authenticate(), userController.followUser);
router.delete('/:id/follow', authenticate(), userController.unfollowUser);
router.get('/:id/followers', validate(userValidation.getUser), userController.getFollowers);
router.get('/:id/following', validate(userValidation.getUser), userController.getFollowing);

module.exports = router;
