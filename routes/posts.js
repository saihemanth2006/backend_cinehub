const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const Post = require('../models/Post');
const Like = require('../models/Like');
const Comment = require('../models/Comment');
const User = require('../models/User');
const multer = require('multer');
const path = require('path');

const UPLOAD_DIR = process.env.UPLOAD_DIR || path.join(__dirname, '..', 'uploads');
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, UPLOAD_DIR),
  filename: (req, file, cb) => cb(null, `${Date.now()}-${file.originalname.replace(/\s+/g,'_')}`)
});
const upload = multer({ storage });

// create post (with optional media)
router.post('/', auth, upload.single('media'), (req, res) => {
  const { content } = req.body;
  const media = req.file ? `/uploads/${path.basename(req.file.path)}` : null;
  try {
    const postDoc = new Post({ user: req.user.id, content: content || null, media });
    await postDoc.save();
    const post = await Post.findById(postDoc._id).lean();
    res.json({ post });
  } catch (err) {
    res.status(500).json({ error: 'server error' });
  }
});

// list posts (simple feed)
router.get('/', (req, res) => {
  try {
    const posts = await Post.find().sort({ created_at: -1 }).populate('user', 'username display_name avatar').lean();
    // attach counts
    const results = await Promise.all(posts.map(async (p) => {
      const likes_count = await Like.countDocuments({ post: p._id });
      const comments_count = await Comment.countDocuments({ post: p._id });
      return { ...p, likes_count, comments_count };
    }));
    res.json({ posts: results });
  } catch (err) {
    res.status(500).json({ error: 'server error' });
  }
});

// like
router.post('/:id/like', auth, (req, res) => {
  const postId = req.params.id;
  try {
    const like = new Like({ user: req.user.id, post: postId });
    await like.save();
    res.json({ ok: true });
  } catch (err) {
    if (err.code === 11000) return res.status(400).json({ error: 'already liked' });
    res.status(500).json({ error: 'server error' });
  }
});

// unlike
router.post('/:id/unlike', auth, (req, res) => {
  const postId = req.params.id;
  const info = await Like.deleteOne({ user: req.user.id, post: postId });
  if (info.deletedCount === 0) return res.status(400).json({ error: 'not liked' });
  res.json({ ok: true });
});

// comments
router.post('/:id/comments', auth, (req, res) => {
  const postId = req.params.id;
  const { content } = req.body;
  if (!content) return res.status(400).json({ error: 'content required' });
  try {
    const commentDoc = new Comment({ user: req.user.id, post: postId, content });
    await commentDoc.save();
    const comment = await Comment.findById(commentDoc._id).populate('user', 'username display_name').lean();
    res.json({ comment });
  } catch (err) {
    res.status(500).json({ error: 'server error' });
  }
});

router.get('/:id/comments', (req, res) => {
  const postId = req.params.id;
  try {
    const comments = await Comment.find({ post: postId }).sort({ created_at: 1 }).populate('user', 'username display_name').lean();
    res.json({ comments });
  } catch (err) {
    res.status(500).json({ error: 'server error' });
  }
});

module.exports = router;
