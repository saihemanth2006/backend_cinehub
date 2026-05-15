const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret';

router.post('/register', async (req, res) => {
  const { username, password, display_name } = req.body;
  if (!username || !password) return res.status(400).json({ error: 'username and password required' });
  try {
    const hash = await bcrypt.hash(password, 10);
    const userDoc = new User({ username, password: hash, display_name: display_name || null });
    await userDoc.save();
    const user = { id: userDoc._id.toString(), username: userDoc.username, display_name: userDoc.display_name, avatar: userDoc.avatar };
    const token = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '30d' });
    res.json({ user, token });
  } catch (err) {
    if (err.code === 11000) return res.status(400).json({ error: 'username already taken' });
    console.error(err);
    res.status(500).json({ error: 'server error' });
  }
});

router.post('/login', async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) return res.status(400).json({ error: 'username and password required' });
  try {
    const userRow = await User.findOne({ username }).lean();
    if (!userRow) return res.status(400).json({ error: 'invalid credentials' });
    const ok = await bcrypt.compare(password, userRow.password);
    if (!ok) return res.status(400).json({ error: 'invalid credentials' });
    const user = { id: userRow._id.toString(), username: userRow.username, display_name: userRow.display_name, avatar: userRow.avatar };
    const token = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '30d' });
    res.json({ user, token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'server error' });
  }
});

module.exports = router;
