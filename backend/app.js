require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Graceful JSON parse error handler: return JSON error instead of HTML error page
// when a client sends invalid JSON. This helps the frontend handle errors
// consistently instead of receiving an HTML error page.
app.use((err, req, res, next) => {
  if (err && err.type === 'entity.parse.failed') {
    console.warn('Invalid JSON received:', err && err.message ? err.message : err);
    return res.status(400).json({ ok: false, error: 'invalid_json', message: err.message });
  }
  next(err);
});

// Twilio config (may be undefined in local/dev without .env)
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const fromNumber = process.env.TWILIO_PHONE_NUMBER;
const verifyServiceSid = process.env.TWILIO_VERIFY_SERVICE_SID;
let twilioClient = null;
if (accountSid && authToken) {
  try { twilioClient = require('twilio')(accountSid, authToken); } catch (e) { twilioClient = null; }
}

// Mongoose and models (loaded if available)
// Defer loading heavy DB/models until actually needed in a request.
let mongoose = null;
let User = null;
let Follow, Post, Like, Comment, Conversation, Message;

async function ensureModels() {
  if (User && mongoose) return true;
  const mongoUri = process.env.MONGODB_URI;
  if (!mongoUri) return false;
  try {
    mongoose = require('mongoose');
    // Connect lazily if not already connected
    if (mongoose.connection && mongoose.connection.readyState === 0) {
      const dbName = process.env.MONGODB_DBNAME || 'cine_hub';
      // Use short timeouts for serverless environments so a bad or unreachable
      // MongoDB URI doesn't block requests for long (fails fast).
      const connectOpts = { dbName, useNewUrlParser: true, useUnifiedTopology: true, serverSelectionTimeoutMS: 5000, connectTimeoutMS: 5000 };
      await mongoose.connect(mongoUri, connectOpts);
      console.log('Connected to MongoDB (lazy)');
    }
    // require models after mongoose is available
    User = require('./models/User');
    try {
      Follow = require('./models/Follow');
      Post = require('./models/Post');
      Like = require('./models/Like');
      Comment = require('./models/Comment');
      Conversation = require('./models/Conversation');
      Message = require('./models/Message');
    } catch (e) {
      // some social models may be absent; that's fine
    }
    return true;
  } catch (e) {
    console.warn('Lazy model init failed:', e && e.message ? e.message : e);
    mongoose = null;
    User = null;
    return false;
  }
}

// In-memory stores (simple dev fallback)
const otps = new Map();
const verifiedPhones = new Map();
const blacklistedTokens = new Map();

function generateOtp() { return Math.floor(100000 + Math.random() * 900000).toString(); }
function normalizePhone(phone) {
  if (!phone || typeof phone !== 'string') return phone;
  let p = phone.trim(); p = p.replace(/[^\d+]/g, ''); p = p.replace(/(?!^)\+/g, '');
  if (/^\d{10}$/.test(p)) return '+91' + p;
  if (/^\d+$/.test(p)) return '+' + p;
  if (/^\+\d+$/.test(p)) return p;
  return phone.trim();
}

const otpTtl = parseInt(process.env.OTP_TTL_SECONDS || '300', 10);
const jwtSecret = process.env.JWT_SECRET || 'dev_jwt_secret_change_me';

if (!accountSid || !authToken || !fromNumber) {
  console.warn('TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN or TWILIO_PHONE_NUMBER not set. Please set them in .env');
}

// Global error handlers to surface uncaught errors in serverless logs
process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err && err.stack ? err.stack : err);
});
process.on('unhandledRejection', (reason) => {
  console.error('Unhandled Rejection:', reason && reason.stack ? reason.stack : reason);
});

app.post('/send-otp', async (req, res) => {
  try {
    const { phone } = req.body; if (!phone) return res.status(400).json({ ok: false, error: 'phone required' });
    const toPhone = normalizePhone(phone);
    const code = generateOtp(); const expiresAt = Date.now() + otpTtl * 1000; otps.set(toPhone, { code, expiresAt });
    if (twilioClient && verifyServiceSid) {
      try { const vResp = await twilioClient.verify.v2.services(verifyServiceSid).verifications.create({ to: toPhone, channel: 'sms' }); return res.json({ ok: true, message: 'OTP sent (verify)', sid: vResp.sid, to: toPhone }); } catch (e) { console.error('Twilio Verify send error:', e && e.message ? e.message : e); return res.status(500).json({ ok: false, error: 'twilio_verify_failed' }); }
    }
    if (twilioClient && fromNumber) {
      try { await twilioClient.messages.create({ body: `Your CineHub OTP is: ${code}`, from: fromNumber, to: toPhone }); return res.json({ ok: true, message: 'OTP sent', to: toPhone }); } catch (e) { console.error('Twilio Messages send error:', e && e.message ? e.message : e); return res.status(500).json({ ok: false, error: 'twilio_send_failed' }); }
    }
    console.log(`(dev) OTP for ${phone}: ${code}`);
    return res.json({ ok: true, message: 'OTP sent (dev)', code });
  } catch (err) { console.error(err); return res.status(500).json({ ok: false, error: 'internal_error' }); }
});

app.post('/verify-otp', (req, res) => {
  try {
    const { phone, otp } = req.body; if (!phone || !otp) return res.status(400).json({ ok: false, error: 'phone and otp required' });
    const toPhone = normalizePhone(phone);
    if (twilioClient && verifyServiceSid) {
      twilioClient.verify.v2.services(verifyServiceSid).verificationChecks.create({ to: toPhone, code: otp })
        .then(check => {
          if (check.status === 'approved') { verifiedPhones.set(toPhone, Date.now() + 5 * 60 * 1000); otps.delete(toPhone); return res.json({ ok: true, message: 'verified' }); }
          const entry = otps.get(toPhone);
          if (entry && entry.code === otp && Date.now() <= entry.expiresAt) { verifiedPhones.set(toPhone, Date.now() + 5 * 60 * 1000); otps.delete(toPhone); return res.json({ ok: true, message: 'verified (fallback)' }); }
          return res.status(400).json({ ok: false, error: 'invalid_otp' });
        })
        .catch(e => { console.error('Twilio verify check error:', e && e.message ? e.message : e); const entry = otps.get(toPhone); if (entry && entry.code === otp && Date.now() <= entry.expiresAt) { verifiedPhones.set(toPhone, Date.now() + 5 * 60 * 1000); otps.delete(toPhone); return res.json({ ok: true, message: 'verified (fallback)' }); } return res.status(500).json({ ok: false, error: 'twilio_verify_failed' }); });
      return;
    }
    const entry = otps.get(toPhone); if (!entry) return res.status(400).json({ ok: false, error: 'no_otp_found' }); if (Date.now() > entry.expiresAt) { otps.delete(toPhone); return res.status(400).json({ ok: false, error: 'otp_expired' }); } if (entry.code !== otp) return res.status(400).json({ ok: false, error: 'invalid_otp' }); verifiedPhones.set(toPhone, Date.now() + 5 * 60 * 1000); otps.delete(toPhone); return res.json({ ok: true, message: 'verified (fallback)' });
  } catch (err) { console.error(err); return res.status(500).json({ ok: false, error: 'internal_error' }); }
});

// Authentication middleware used by various endpoints
function authenticateToken(req, res, next) {
  const auth = req.headers && req.headers.authorization; if (!auth) return res.status(401).json({ ok: false, error: 'missing_authorization' }); const parts = auth.split(' '); if (parts.length !== 2 || parts[0] !== 'Bearer') return res.status(401).json({ ok: false, error: 'invalid_authorization' }); const token = parts[1]; try { const jwt = require('jsonwebtoken'); const nowTs = Date.now(); for (const [t, exp] of blacklistedTokens) { if (exp <= nowTs) blacklistedTokens.delete(t); } const blackExp = blacklistedTokens.get(token); if (blackExp && blackExp > nowTs) return res.status(401).json({ ok: false, error: 'token_revoked' }); const payload = jwt.verify(token, jwtSecret); req.user = payload; next(); } catch (e) { return res.status(401).json({ ok: false, error: 'invalid_token' }); }
}

app.post('/login', async (req, res) => {
  try {
    const ok = await ensureModels();
    if (!ok) return res.status(500).json({ ok: false, error: 'mongodb_not_configured' });
    const { identifier, password } = req.body || {}; if (!identifier || !password) return res.status(400).json({ ok: false, error: 'identifier_and_password_required' });
    let query = {}; const asPhone = normalizePhone(identifier); if (asPhone && /^\+\d+$/.test(asPhone)) { query = { phone: asPhone }; } else if (/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(identifier)) { query = { email: identifier.toLowerCase() }; } else { query = { username: identifier }; }
    const user = await User.findOne(query).lean(); if (!user) return res.status(401).json({ ok: false, error: 'invalid_credentials' });
    try { const bcrypt = require('bcryptjs'); const match = user.passwordHash ? bcrypt.compareSync(password, user.passwordHash) : false; if (!match) return res.status(401).json({ ok: false, error: 'invalid_credentials' }); } catch (e) { console.warn('bcrypt not available for login check:', e && e.message ? e.message : e); return res.status(500).json({ ok: false, error: 'server_error' }); }
    try { const jwt = require('jsonwebtoken'); const token = jwt.sign({ sub: user._id.toString(), role: user.role, phone: user.phone }, jwtSecret, { expiresIn: '7d' }); const safeUser = { _id: user._id, fullName: user.fullName, email: user.email, username: user.username, phone: user.phone, role: user.role }; return res.json({ ok: true, token, user: safeUser }); } catch (e) { console.error('JWT sign failed:', e && e.message ? e.message : e); return res.status(500).json({ ok: false, error: 'token_error' }); }
  } catch (e) { console.error('Login error:', e && e.message ? e.message : e); return res.status(500).json({ ok: false, error: 'internal_error' }); }
});

app.post('/logout', authenticateToken, (req, res) => {
  try { const auth = req.headers && req.headers.authorization; if (!auth) return res.status(400).json({ ok: false, error: 'missing_authorization' }); const parts = auth.split(' '); if (parts.length !== 2) return res.status(400).json({ ok: false, error: 'invalid_authorization' }); const token = parts[1]; try { const jwt = require('jsonwebtoken'); const decoded = jwt.decode(token) || {}; const exp = decoded.exp ? decoded.exp * 1000 : Date.now() + (24 * 3600 * 1000); blacklistedTokens.set(token, exp); return res.json({ ok: true, message: 'logged_out' }); } catch (err) { blacklistedTokens.set(token, Date.now() + (24 * 3600 * 1000)); return res.json({ ok: true, message: 'logged_out' }); } } catch (e) { console.error('logout error:', e && e.message ? e.message : e); return res.status(500).json({ ok: false, error: 'logout_failed' }); }
});

app.get('/me', authenticateToken, async (req, res) => {
  try {
    const ok = await ensureModels();
    if (!ok) return res.status(500).json({ ok: false, error: 'mongodb_not_configured' });
    const uid = req.user && req.user.sub;
    if (!uid) return res.status(400).json({ ok: false, error: 'invalid_token_payload' });
    const user = await User.findById(uid).lean();
    if (!user) return res.status(404).json({ ok: false, error: 'user_not_found' });
    const safeUser = { _id: user._id, fullName: user.fullName, email: user.email, username: user.username, phone: user.phone, role: user.role };
    return res.json({ ok: true, user: safeUser });
  } catch (e) {
    console.error('me error:', e && e.message ? e.message : e);
    return res.status(500).json({ ok: false, error: 'internal_error' });
  }
});

app.post('/register', async (req, res) => {
  try {
    const ok = await ensureModels();
    if (!ok) return res.status(500).json({ ok: false, error: 'mongodb_not_configured' });
    const { fullName, email, username, password, phone, role, otp } = req.body;
    console.log('Register request payload:', { fullName, email, username, phone, role });
    if (!phone) return res.status(400).json({ ok: false, error: 'phone required' });
    if (!otp) return res.status(400).json({ ok: false, error: 'otp required' });
    const toPhone = normalizePhone(phone);
    const errors = [];
    if (password) {
      if (password.length < 6) errors.push('password must be at least 6 characters');
      if (!/[!@#\$%\^&\*(),.?":{}|<>]/.test(password)) errors.push('password must contain a special character');
    } else {
      errors.push('password required');
    }
    if (email && !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) errors.push('invalid email');
    if (errors.length) { console.warn('Register validation failed:', errors); return res.status(400).json({ ok: false, error: 'validation_failed', details: errors }); }

    let otpVerified = false;
    const vExpires = verifiedPhones.get(toPhone);
    if (vExpires && Date.now() <= vExpires) { otpVerified = true; verifiedPhones.delete(toPhone); }
    if (!otpVerified) {
      if (twilioClient && verifyServiceSid) {
        try { const check = await twilioClient.verify.v2.services(verifyServiceSid).verificationChecks.create({ to: toPhone, code: otp }); if (check && check.status === 'approved') otpVerified = true; } catch (e) { console.warn('Twilio verify check error during register:', e && e.message ? e.message : e); }
      }
    }
    if (!otpVerified) { const entry = otps.get(toPhone); if (entry && entry.code === otp && Date.now() <= entry.expiresAt) { otpVerified = true; otps.delete(toPhone); } }
    if (!otpVerified) { console.warn('OTP not verified for', toPhone); return res.status(400).json({ ok: false, error: 'otp_not_verified' }); }

    const update = { fullName: fullName || undefined, email: email || undefined, username: username || undefined, role: role || undefined, updatedAt: Date.now(), phone: toPhone };
    if (password) { try { const bcrypt = require('bcryptjs'); const salt = bcrypt.genSaltSync(10); update.passwordHash = bcrypt.hashSync(password, salt); } catch (e) { console.warn('bcrypt not installed or failed to load:', e && e.message ? e.message : e); } }
    const opts = { upsert: true, new: true, setDefaultsOnInsert: true };
    const user = await User.findOneAndUpdate({ phone: toPhone }, update, opts).lean();
    console.log('User upserted:', { phone: user && user.phone, id: user && user._id });
    return res.json({ ok: true, user });
  } catch (e) { console.error('Register error:', e && e.message ? e.message : e); return res.status(500).json({ ok: false, error: 'register_failed' }); }
});

app.get('/', (req, res) => res.json({ ok: true, message: 'CineHub Backend is running' }));
app.get('/health', (req, res) => res.json({ ok: true }));

// Media upload endpoints rely on local FileStorage
const { FileStorage, uploadsDir } = require('./upload-handler');
const fs = require('fs');
const path = require('path');
const fileStorage = new FileStorage();

app.post('/api/upload', authenticateToken, (req, res) => {
  try { const { file, filename, mimetype } = req.body || {}; if (!file || !filename || !mimetype) return res.status(400).json({ ok: false, error: 'file, filename, and mimetype required' }); const buffer = Buffer.from(file, 'base64'); const fileUrl = fileStorage.saveBuffer(buffer, mimetype, filename); return res.json({ ok: true, url: fileUrl, filename }); } catch (e) { console.error('Upload error:', e && e.message ? e.message : e); return res.status(400).json({ ok: false, error: e.message || 'upload_failed' }); }
});

app.get('/api/media/:filename', (req, res) => {
  try {
    const { filename } = req.params;
    const fileId = path.basename(filename, path.extname(filename));
    const entry = fileStorage.getFile(fileId);
    if (entry) {
      if (entry.path && fs.existsSync(entry.path)) {
        return res.sendFile(entry.path);
      }
      if (entry.buffer) {
        res.setHeader('Content-Type', entry.mimetype || 'application/octet-stream');
        return res.send(entry.buffer);
      }
    }

    // Fallback: attempt to serve from uploadsDir (if present on disk)
    const filePath = path.join(uploadsDir, filename);
    if (!filePath.startsWith(uploadsDir)) return res.status(403).json({ ok: false, error: 'forbidden' });
    if (!fs.existsSync(filePath)) return res.status(404).json({ ok: false, error: 'not_found' });
    return res.sendFile(filePath);
  } catch (e) {
    console.error('Media retrieval error:', e && e.message ? e.message : e);
    return res.status(500).json({ ok: false, error: 'retrieval_failed' });
  }
});

// Export app and a helper to start a standalone HTTP server for local runs
function startStandalone() {
  const http = require('http');
  const server = http.createServer(app);
  // Attach socket.io only when running standalone (not in serverless)
  try {
    const { Server } = require('socket.io');
    const io = new Server(server, { cors: { origin: '*' } });
    io.on('connection', (socket) => {
      console.log('socket connected:', socket.id);
      socket.on('join_user', (userId) => { try { socket.join(String(userId)); } catch (e) {} });
      socket.on('join_conversation', (conversationId) => { try { socket.join(String(conversationId)); } catch (e) {} });
      socket.on('send_message', async (payload) => {
        try {
          const { conversationId, sender, text } = payload || {};
          if (!conversationId || !sender || !text) return;
          if (typeof Message !== 'undefined') {
            const msg = await Message.create({ conversation: conversationId, sender, text });
            if (typeof Conversation !== 'undefined') {
              await Conversation.findByIdAndUpdate(conversationId, { lastMessage: text, updatedAt: Date.now() });
              const conv = await Conversation.findById(conversationId).lean();
              io.to(String(conversationId)).emit('message', msg);
              if (conv && conv.participants) conv.participants.forEach(pid => io.to(String(pid)).emit('message', msg));
            } else {
              io.to(String(conversationId)).emit('message', msg);
            }
          }
        } catch (e) { console.error('socket send_message error:', e && e.message ? e.message : e); }
      });
    });
  } catch (e) {
    console.warn('Socket.io not available; realtime chat disabled.');
  }

  const port = process.env.PORT ? Number(process.env.PORT) : undefined;
  const listenPort = port || 0;
  server.listen(listenPort, function() {
    const addr = server.address && server.address();
    const actualPort = addr && addr.port;
    console.log(`CineHub OTP backend listening on ${actualPort}${port ? ` (configured PORT=${port})` : ' (no PORT configured; OS-assigned)'}`);
  });
  server.on('error', (err) => {
    if (err && err.code === 'EADDRINUSE') {
      console.error(`Port ${port || '(unspecified)'} is already in use. Another process is listening on this port.`);
      if (port) console.error('Use: netstat -ano | findstr :' + port + '  and taskkill /PID <pid> /F to free the port.');
      process.exit(1);
    }
    console.error('Server error:', err);
    process.exit(1);
  });
}

// Export the Express app as the module default to satisfy serverless platforms
// that expect the module export to be a function/server. Attach helpers as
// properties on the `app` object so local `server.js` can still access them.
try {
  app.startStandalone = startStandalone;
  app._mongoose = () => mongoose;
  app._mongoUri = process.env.MONGODB_URI;
  module.exports = app;
} catch (e) {
  // In case of any issue attaching properties, fall back to previous shape.
  module.exports = { app, startStandalone, mongoose, mongoUri: process.env.MONGODB_URI };
}
