module.exports = function(opts) {
  const express = require('express');
  const router = express.Router();
  const { authenticateToken, models } = opts;
  const { Job } = models;

  // Fetch all jobs
  router.get('/jobs', async (req, res) => {
    try {
      const jobs = await Job.find().sort({ createdAt: -1 });
      res.json({ ok: true, jobs });
    } catch (e) {
      console.error('Error fetching jobs:', e);
      res.status(500).json({ ok: false, error: 'internal_error' });
    }
  });

  // Post a new job
  router.post('/jobs', authenticateToken, async (req, res) => {
    try {
      const { title, company, location, type, pay, category, urgent } = req.body;
      
      if (!title || !company || !location || !category) {
        return res.status(400).json({ ok: false, error: 'missing_fields' });
      }

      const job = new Job({
        title,
        company,
        location,
        type: type || 'On-site',
        pay: pay || 'N/A',
        category,
        urgent: urgent || false,
        postedBy: req.user.sub
      });

      await job.save();
      res.json({ ok: true, job });
    } catch (e) {
      console.error('Error creating job:', e);
      res.status(500).json({ ok: false, error: 'internal_error' });
    }
  });

  return router;
};
