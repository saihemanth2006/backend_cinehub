const express = require('express');
const router = express.Router();

module.exports = function ({ authenticateToken, models, io }) {
  const { User, Follow, Post, Like, Comment, Conversation, Message } = models;

  // follow a user
  router.post('/follow', authenticateToken, async (req, res) => {
    try {
      const from = req.user && req.user.sub;
      let { to } = req.body || {};
      if (!from || !to) return res.status(400).json({ ok: false, error: 'from_and_to_required' });
      // if `to` is not an ObjectId-like string, try to resolve by username or fullName
      try {
        const mongoose = require('mongoose');
        if (!mongoose.Types.ObjectId.isValid(String(to))) {
          // try username then fullName
          let found = await User.findOne({ username: String(to) }).select('_id').lean();
          if (!found) found = await User.findOne({ fullName: String(to) }).select('_id').lean();
          if (found && found._id) to = found._id.toString();
        }
      } catch (e) {
        // ignore resolution errors and proceed
      }
      if (from === to) return res.status(400).json({ ok: false, error: 'cannot_follow_self' });
      await Follow.create({ follower: from, followee: to });
      // emit realtime event to the followed user
      try {
        if (io) io.to(String(to)).emit('follow_event', { type: 'follow', from: String(from), to: String(to) });
      } catch (e) {}
      return res.json({ ok: true });
    } catch (e) {
      if (e && e.code === 11000) return res.json({ ok: true });
      console.error('follow error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'follow_failed' });
    }
  });

  // unfollow
  router.post('/unfollow', authenticateToken, async (req, res) => {
    try {
      const from = req.user && req.user.sub;
      let { to } = req.body || {};
      if (!from || !to) return res.status(400).json({ ok: false, error: 'from_and_to_required' });
      // resolve non-objectId to user id if possible
      try {
        const mongoose = require('mongoose');
        if (!mongoose.Types.ObjectId.isValid(String(to))) {
          let found = await User.findOne({ username: String(to) }).select('_id').lean();
          if (!found) found = await User.findOne({ fullName: String(to) }).select('_id').lean();
          if (found && found._id) to = found._id.toString();
        }
      } catch (e) {}
      await Follow.deleteOne({ follower: from, followee: to });
      try {
        if (io) io.to(String(to)).emit('follow_event', { type: 'unfollow', from: String(from), to: String(to) });
      } catch (e) {}
      return res.json({ ok: true });
    } catch (e) {
      console.error('unfollow error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'unfollow_failed' });
    }
  });

  // get followers list for a user
  router.get('/users/:id/followers', authenticateToken, async (req, res) => {
    try {
      const uid = req.params.id;
      const items = await Follow.find({ followee: uid }).sort({ createdAt: -1 }).populate('follower', 'fullName username').lean();
      const list = items.map(i => i.follower || {});
      return res.json({ ok: true, followers: list });
    } catch (e) {
      console.error('followers list error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'followers_failed' });
    }
  });

  // get following list for a user
  router.get('/users/:id/following', authenticateToken, async (req, res) => {
    try {
      const uid = req.params.id;
      const items = await Follow.find({ follower: uid }).sort({ createdAt: -1 }).populate('followee', 'fullName username').lean();
      const list = items.map(i => i.followee || {});
      return res.json({ ok: true, following: list });
    } catch (e) {
      console.error('following list error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'following_failed' });
    }
  });

  // get simple stats: followers and following counts
  router.get('/users/:id/stats', authenticateToken, async (req, res) => {
    try {
      const uid = req.params.id;
      const followers = await Follow.countDocuments({ followee: uid });
      const following = await Follow.countDocuments({ follower: uid });
      return res.json({ ok: true, followers, following });
    } catch (e) {
      console.error('user stats error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'stats_failed' });
    }
  });

  // list users (basic public info)
  router.get('/users', authenticateToken, async (req, res) => {
    try {
      // return basic fields only
      const users = await User.find({}).select('_id fullName username role').lean();
      return res.json({ ok: true, users });
    } catch (e) {
      console.error('list users error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'users_failed' });
    }
  });

  // create post
  router.post('/posts', authenticateToken, async (req, res) => {
    try {
      const uid = req.user && req.user.sub;
      // accept multiple aliases for text content
      const body = req.body || {};
      const content = (typeof body.content === 'string' && body.content.trim()) ? body.content.trim()
        : (typeof body.text === 'string' && body.text.trim()) ? body.text.trim()
        : (typeof body.caption === 'string' && body.caption.trim()) ? body.caption.trim()
        : '';
      const media = Array.isArray(body.media) ? body.media : (Array.isArray(body.images) ? body.images : []);
      if (!uid || (!content && media.length === 0)) return res.status(400).json({ ok: false, error: 'invalid_payload', message: 'content or media required' });
      const created = await Post.create({ author: uid, content: content || '', media });
      // populate author fields for immediate client use
      const post = await Post.findById(created._id).populate('author', 'fullName username').lean();
      // emit realtime new_post event to followers and global feed
      try {
        if (io) {
          // send to author's followers room and to a global room
          try {
            const followers = await Follow.find({ followee: uid }).select('follower').lean();
            if (Array.isArray(followers)) {
              followers.forEach(f => {
                try { io.to(String(f.follower)).emit('new_post', post); } catch (e) {}
              });
            }
          } catch (e) {}
          try { io.emit('new_post', post); } catch (e) {}
        }
      } catch (e) {}
      return res.status(201).json({ ok: true, post });
    } catch (e) {
      console.error('create post error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'create_post_failed' });
    }
  });

  // feed: posts from followed users + own posts, paginated
  router.get('/feed', authenticateToken, async (req, res) => {
    try {
      const uid = req.user && req.user.sub;
      const page = parseInt(req.query.page || '1', 10);
      const limit = Math.min(50, parseInt(req.query.limit || '20', 10));
      const skip = (Math.max(1, page) - 1) * limit;
      // find followees
      const follows = await Follow.find({ follower: uid }).select('followee').lean();
      const ids = follows.map(f => f.followee.toString());
      ids.push(uid);
      // If user follows nobody (ids contains only uid), show public feed (all posts).
      const filter = (ids.length > 1) ? { author: { $in: ids } } : {};
      const posts = await Post.find(filter).sort({ createdAt: -1 }).skip(skip).limit(limit).populate('author', 'fullName username').lean();
      return res.json({ ok: true, posts });
    } catch (e) {
      console.error('feed error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'feed_failed' });
    }
  });

  // like/unlike
  router.post('/posts/:id/like', authenticateToken, async (req, res) => {
    try {
      const uid = req.user && req.user.sub;
      const postId = req.params.id;
      await Like.create({ user: uid, post: postId });
      await Post.findByIdAndUpdate(postId, { $inc: { likesCount: 1 } });
      return res.json({ ok: true });
    } catch (e) {
      if (e && e.code === 11000) return res.json({ ok: true });
      console.error('like error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'like_failed' });
    }
  });

  router.delete('/posts/:id/like', authenticateToken, async (req, res) => {
    try {
      const uid = req.user && req.user.sub;
      const postId = req.params.id;
      const r = await Like.findOneAndDelete({ user: uid, post: postId });
      if (r) await Post.findByIdAndUpdate(postId, { $inc: { likesCount: -1 } });
      return res.json({ ok: true });
    } catch (e) {
      console.error('unlike error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'unlike_failed' });
    }
  });

  // comments
  router.post('/posts/:id/comments', authenticateToken, async (req, res) => {
    try {
      const uid = req.user && req.user.sub;
      const postId = req.params.id;
      const { text } = req.body;
      if (!text) return res.status(400).json({ ok: false, error: 'text_required' });
      const comment = await Comment.create({ post: postId, user: uid, text });
      await Post.findByIdAndUpdate(postId, { $inc: { commentsCount: 1 } });
      return res.json({ ok: true, comment });
    } catch (e) {
      console.error('comment error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'comment_failed' });
    }
  });

  router.get('/posts/:id/comments', authenticateToken, async (req, res) => {
    try {
      const postId = req.params.id;
      const comments = await Comment.find({ post: postId }).sort({ createdAt: -1 }).populate('user', 'fullName username').lean();
      return res.json({ ok: true, comments });
    } catch (e) {
      console.error('get comments error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'comments_failed' });
    }
  });

  // Conversations
  router.post('/conversations', authenticateToken, async (req, res) => {
    try {
      const uid = req.user && req.user.sub;
      const { participants } = req.body;
      if (!participants || !Array.isArray(participants)) return res.status(400).json({ ok: false, error: 'participants_required' });
      // ensure uid is included
      const set = new Set(participants.map(String));
      set.add(String(uid));
      const arr = Array.from(set);
      let conv = await Conversation.findOne({ participants: { $size: arr.length, $all: arr } }).lean();
      if (!conv) conv = await Conversation.create({ participants: arr });
      return res.json({ ok: true, conversation: conv });
    } catch (e) {
      console.error('create conversation error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'create_conversation_failed' });
    }
  });

  router.get('/conversations', authenticateToken, async (req, res) => {
    try {
      const uid = req.user && req.user.sub;
      const convs = await Conversation.find({ participants: uid }).sort({ updatedAt: -1 }).lean();
      return res.json({ ok: true, conversations: convs });
    } catch (e) {
      console.error('list conv error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'conversations_failed' });
    }
  });

  router.get('/conversations/:id/messages', authenticateToken, async (req, res) => {
    try {
      const convId = req.params.id;
      const page = parseInt(req.query.page || '1', 10);
      const limit = Math.min(100, parseInt(req.query.limit || '50', 10));
      const skip = (Math.max(1, page) - 1) * limit;
      const msgs = await Message.find({ conversation: convId }).sort({ createdAt: -1 }).skip(skip).limit(limit).lean();
      return res.json({ ok: true, messages: msgs });
    } catch (e) {
      console.error('get messages error:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'messages_failed' });
    }
  });

  return router;
};
