/**
 * @module api/v1/projects/project.routes
 */
const express = require('express');
const { authenticate, validate } = require('../../../middleware');
const projectController = require('./project.controller');
const projectValidation = require('./project.validation');

const router = express.Router();

router.get('/', validate(projectValidation.listProjects), projectController.list);
router.get('/me', authenticate(), projectController.myProjects);
router.get('/slug/:slug', projectController.getBySlug);
router.get('/:id', projectController.getById);
router.post('/', authenticate(), validate(projectValidation.createProject), projectController.create);
router.patch('/:id', authenticate(), validate(projectValidation.updateProject), projectController.update);
router.delete('/:id', authenticate(), projectController.remove);

module.exports = router;
