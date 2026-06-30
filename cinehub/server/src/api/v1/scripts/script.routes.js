const express = require('express');
const { authenticate, validate } = require('../../../middleware');
const scriptController = require('./script.controller');
const scriptValidation = require('./script.validation');

const router = express.Router();

router.get('/me', authenticate(), scriptController.myScripts);
router.get('/project/:projectId', authenticate(), scriptController.getProjectScripts);
router.get('/:id', authenticate(), scriptController.getById);
router.post('/', authenticate(), validate(scriptValidation.createScript), scriptController.create);
router.patch('/:id', authenticate(), validate(scriptValidation.updateScript), scriptController.update);
router.delete('/:id', authenticate(), scriptController.remove);

module.exports = router;
