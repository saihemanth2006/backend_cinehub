const express = require('express');
const { authenticate } = require('../../../middleware');
const teamController = require('./team.controller');

const router = express.Router();

router.get('/me', authenticate(), teamController.myTeams);
router.get('/project/:projectId', authenticate(), teamController.getByProject);
router.post('/:id/invite', authenticate(), teamController.inviteMember);
router.post('/:id/respond', authenticate(), teamController.respondToInvite);
router.delete('/:id/members/:userId', authenticate(), teamController.removeMember);

module.exports = router;
