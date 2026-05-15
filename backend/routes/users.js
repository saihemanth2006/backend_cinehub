const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const User = require('../models/User');
const Follow = require('../models/Follow');

// get profile
router.get('/:id', async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select('username display_name avatar created_at').lean();
    if (!user) return res.status(404).json({ error: 'user not found' });
    const followers = await Follow.countDocuments({ following: user._id });
    const following = await Follow.countDocuments({ follower: user._id });
    res.json({ ...user, followers, following });
  } catch (err) {
    res.status(500).json({ error: 'server error' });
  }
});

// follow
router.post('/:id/follow', auth, async (req, res) => {
  const targetId = req.params.id;
  if (req.user.id === targetId) return res.status(400).json({ error: 'cannot follow yourself' });
  try {
    const doc = new Follow({ follower: req.user.id, following: targetId });
    await doc.save();
    res.json({ ok: true });
  } catch (err) {
    if (err.code === 11000) return res.status(400).json({ error: 'already following' });
    res.status(500).json({ error: 'server error' });
  }
});

// unfollow
router.post('/:id/unfollow', auth, async (req, res) => {
  const targetId = req.params.id;
  const info = await Follow.deleteOne({ follower: req.user.id, following: targetId });
  if (info.deletedCount === 0) return res.status(400).json({ error: 'not following' });
  res.json({ ok: true });
});

module.exports = router;
