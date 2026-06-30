const express = require('express');

module.exports = function(dependencies) {
  const router = express.Router();
  const { authenticateToken, models } = dependencies;
  const { CollabRequest } = models;

  if (!CollabRequest) {
    console.warn('CollabRequest model not provided to collab router');
  }

  // GET /api/collab-requests
  router.get('/collab-requests', authenticateToken, async (req, res) => {
    try {
      if (!CollabRequest) return res.status(500).json({ ok: false, error: 'mongodb_not_configured' });
      
      const requests = await CollabRequest.find()
        .populate('user', 'fullName username role')
        .sort({ createdAt: -1 })
        .limit(50);
        
      return res.json({ ok: true, requests });
    } catch (e) {
      console.error('Fetch collab requests error:', e);
      return res.status(500).json({ ok: false, error: 'internal_error' });
    }
  });

  // POST /api/collab-requests
  router.post('/collab-requests', authenticateToken, async (req, res) => {
    try {
      if (!CollabRequest) return res.status(500).json({ ok: false, error: 'mongodb_not_configured' });
      const uid = req.user && req.user.sub;
      if (!uid) return res.status(400).json({ ok: false, error: 'invalid_token' });
      
      const { role, skills, location, type } = req.body;
      
      const newReq = new CollabRequest({
        user: uid,
        role: role || 'Collaborator',
        skills: skills || [],
        location: location || 'Remote',
        type: type || 'Collaborative'
      });
      
      await newReq.save();
      await newReq.populate('user', 'fullName username role');
      
      return res.json({ ok: true, request: newReq });
    } catch (e) {
      console.error('Post collab request error:', e);
      return res.status(500).json({ ok: false, error: 'internal_error' });
    }
  });

  return router;
};
