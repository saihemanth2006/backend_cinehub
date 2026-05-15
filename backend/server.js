require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const fromNumber = process.env.TWILIO_PHONE_NUMBER;
const verifyServiceSid = process.env.TWILIO_VERIFY_SERVICE_SID; // optional: use Twilio Verify
const port = process.env.PORT || 4000;
const otpTtl = parseInt(process.env.OTP_TTL_SECONDS || '300', 10);
const jwtSecret = process.env.JWT_SECRET || 'dev_jwt_secret_change_me';

if (!accountSid || !authToken || !fromNumber) {
  console.warn('TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN or TWILIO_PHONE_NUMBER not set. Please set them in .env');
}

// Create Twilio client only when credentials are provided to avoid crash
let twilioClient = null;
if (accountSid && authToken) {
  try {
    twilioClient = require('twilio')(accountSid, authToken);
  } catch (e) {
    console.warn('Failed to create Twilio client:', e && e.message ? e.message : e);
    twilioClient = null;
  }
}
const app = express();
app.use(cors());
app.use(bodyParser.json());

// Root route to avoid "Cannot GET /" on deployments and provide a simple status
app.get('/', (req, res) => {
  res.json({ ok: true, message: 'CineHub backend is running', health: '/health' });
});

// --- MongoDB (Mongoose) setup ---
let mongoose = null;
let User = null;
const mongoUri = process.env.MONGODB_URI || 'mongodb+srv://hemanth:cinehub@cluster0.astjpnx.mongodb.net';
try {
  mongoose = require('mongoose');
  User = require('./models/User');
  // Load social models if present
  try {
    var Follow = require('./models/Follow');
    var Post = require('./models/Post');
    var Like = require('./models/Like');
    var Comment = require('./models/Comment');
    var Conversation = require('./models/Conversation');
    var Message = require('./models/Message');
  } catch (e) {
    // models may not be present yet
  }
} catch (e) {
  console.warn('Mongoose not installed or failed to load:', e && e.message ? e.message : e);
}

// In-memory store for OTPs. Use Redis or DB in production.
const otps = new Map(); // phone -> { code, expiresAt }
// In-memory store for recently verified phones (set by /verify-otp). short TTL
const verifiedPhones = new Map(); // phone -> expiresAt
// In-memory token blacklist for logout (token -> expiresAt). Use Redis in production.
const blacklistedTokens = new Map();

function generateOtp() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

function normalizePhone(phone) {
  if (!phone || typeof phone !== 'string') return phone;
  let p = phone.trim();
  // Remove common separators and any characters except digits and plus
  p = p.replace(/[^\d+]/g, '');
  // Remove any plus signs that are not the leading one
  p = p.replace(/(?!^)\+/g, '');
  // If it's exactly 10 digits, assume Indian number and add +91
  if (/^\d{10}$/.test(p)) return '+91' + p;
  // If it starts with digits but missing plus, add plus
  if (/^\d+$/.test(p)) return '+' + p;
  // If it already starts with + and digits, return as-is
  if (/^\+\d+$/.test(p)) return p;
  // Otherwise return original trimmed input as a fallback
  return phone.trim();
}

app.post('/send-otp', async (req, res) => {
  try {
    const { phone } = req.body;
    if (!phone) return res.status(400).json({ ok: false, error: 'phone required' });
    const toPhone = normalizePhone(phone);

    const code = generateOtp();
    const expiresAt = Date.now() + otpTtl * 1000;
    otps.set(toPhone, { code, expiresAt });

    // If Twilio Verify service SID is configured, prefer using Verify to send SMS
    if (twilioClient && verifyServiceSid) {
      try {
        const vResp = await twilioClient.verify.v2.services(verifyServiceSid).verifications.create({ to: toPhone, channel: 'sms' });
        // don't return code in production
        return res.json({ ok: true, message: 'OTP sent (verify)', sid: vResp.sid, to: toPhone });
      } catch (e) {
        console.error('Twilio Verify send error:', e && e.message ? e.message : e);
        return res.status(500).json({ ok: false, error: 'twilio_verify_failed' });
      }
    }

    // Fallback: send SMS via Twilio Messages API if configured
    if (twilioClient && fromNumber) {
      try {
        await twilioClient.messages.create({ body: `Your CineHub OTP is: ${code}`, from: fromNumber, to: toPhone });
        return res.json({ ok: true, message: 'OTP sent', to: toPhone });
      } catch (e) {
        console.error('Twilio Messages send error:', e && e.message ? e.message : e);
        return res.status(500).json({ ok: false, error: 'twilio_send_failed' });
      }
    }

    // Development fallback: log and return code
    console.log(`(dev) OTP for ${phone}: ${code}`);
    return res.json({ ok: true, message: 'OTP sent (dev)', code });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ ok: false, error: 'internal_error' });
  }
});

app.post('/verify-otp', (req, res) => {
  try {
    const { phone, otp } = req.body;
    if (!phone || !otp) return res.status(400).json({ ok: false, error: 'phone and otp required' });

    // If Twilio Verify is configured, use it to check the code
    const toPhone = normalizePhone(phone);
    if (twilioClient && verifyServiceSid) {
      twilioClient.verify.v2.services(verifyServiceSid).verificationChecks.create({ to: toPhone, code: otp })
        .then(check => {
          if (check.status === 'approved') {
            // mark as verified for short period to allow /register to complete
            verifiedPhones.set(toPhone, Date.now() + 5 * 60 * 1000); // 5 minutes
            // delete any existing otps stored
            otps.delete(toPhone);
            return res.json({ ok: true, message: 'verified' });
              }
          // If Verify did not approve, fall back to in-memory OTP (useful for dev or Messages send path)
          const entry = otps.get(toPhone);
          if (entry && entry.code === otp && Date.now() <= entry.expiresAt) {
            // mark verified and delete stored OTP
            verifiedPhones.set(toPhone, Date.now() + 5 * 60 * 1000);
            otps.delete(toPhone);
            return res.json({ ok: true, message: 'verified (fallback)' });
          }
          return res.status(400).json({ ok: false, error: 'invalid_otp' });
        })
        .catch(e => {
          console.error('Twilio verify check error:', e && e.message ? e.message : e);
          // On Twilio errors, still attempt fallback to in-memory OTP so local testing can continue
          const entry = otps.get(toPhone);
          if (entry && entry.code === otp && Date.now() <= entry.expiresAt) {
            verifiedPhones.set(toPhone, Date.now() + 5 * 60 * 1000);
            otps.delete(toPhone);
            return res.json({ ok: true, message: 'verified (fallback)' });
          }
          return res.status(500).json({ ok: false, error: 'twilio_verify_failed' });
        });
      return;
    }

    // Fallback to in-memory OTP store
    const entry = otps.get(toPhone);
    if (!entry) return res.status(400).json({ ok: false, error: 'no_otp_found' });
    if (Date.now() > entry.expiresAt) {
      otps.delete(toPhone);
      return res.status(400).json({ ok: false, error: 'otp_expired' });
    }
    if (entry.code !== otp) return res.status(400).json({ ok: false, error: 'invalid_otp' });

    // Successful verification
    // mark as verified for short period to allow /register to complete
    verifiedPhones.set(toPhone, Date.now() + 5 * 60 * 1000); // 5 minutes
    // delete any existing otps stored
    otps.delete(toPhone);
    return res.json({ ok: true, message: 'verified (fallback)' });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ ok: false, error: 'internal_error' });
  }
});

// Login endpoint - supports phone (with country code) or email/username + password
app.post('/login', async (req, res) => {
  try {
    if (!User) return res.status(500).json({ ok: false, error: 'mongodb_not_configured' });
    const { identifier, password } = req.body || {};
    if (!identifier || !password) return res.status(400).json({ ok: false, error: 'identifier_and_password_required' });

    // Try to detect phone vs email/username
    let query = {};
    const asPhone = normalizePhone(identifier);
    if (asPhone && /^\+\d+$/.test(asPhone)) {
      query = { phone: asPhone };
    } else if (/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(identifier)) {
      query = { email: identifier.toLowerCase() };
    } else {
      query = { username: identifier };
    }

    const user = await User.findOne(query).lean();
    if (!user) return res.status(401).json({ ok: false, error: 'invalid_credentials' });

    // Check password
    try {
      const bcrypt = require('bcryptjs');
      const match = user.passwordHash ? bcrypt.compareSync(password, user.passwordHash) : false;
      if (!match) return res.status(401).json({ ok: false, error: 'invalid_credentials' });
    } catch (e) {
      console.warn('bcrypt not available for login check:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'server_error' });
    }

    // Generate JWT
    try {
      const jwt = require('jsonwebtoken');
      const token = jwt.sign({ sub: user._id.toString(), role: user.role, phone: user.phone }, jwtSecret, { expiresIn: '7d' });
      // return safe user info
      const safeUser = { _id: user._id, fullName: user.fullName, email: user.email, username: user.username, phone: user.phone, role: user.role };
      return res.json({ ok: true, token, user: safeUser });
    } catch (e) {
      console.error('JWT sign failed:', e && e.message ? e.message : e);
      return res.status(500).json({ ok: false, error: 'token_error' });
    }
  } catch (e) {
    console.error('Login error:', e && e.message ? e.message : e);
    return res.status(500).json({ ok: false, error: 'internal_error' });
  }
});

// Simple middleware to protect endpoints with Bearer token
function authenticateToken(req, res, next) {
  const auth = req.headers && req.headers.authorization;
  if (!auth) return res.status(401).json({ ok: false, error: 'missing_authorization' });
  const parts = auth.split(' ');
  if (parts.length !== 2 || parts[0] !== 'Bearer') return res.status(401).json({ ok: false, error: 'invalid_authorization' });
  const token = parts[1];
  try {
    const jwt = require('jsonwebtoken');
    // cleanup expired blacklisted tokens lazily (small map)
    const nowTs = Date.now();
    for (const [t, exp] of blacklistedTokens) {
      if (exp <= nowTs) blacklistedTokens.delete(t);
    }
    // check blacklist
    const blackExp = blacklistedTokens.get(token);
    if (blackExp && blackExp > nowTs) return res.status(401).json({ ok: false, error: 'token_revoked' });

    const payload = jwt.verify(token, jwtSecret);
    req.user = payload; // attach payload to request
    next();
  } catch (e) {
    return res.status(401).json({ ok: false, error: 'invalid_token' });
  }
}

// Logout endpoint: blacklists the presented token so it cannot be used again
app.post('/logout', authenticateToken, (req, res) => {
  try {
    const auth = req.headers && req.headers.authorization;
    if (!auth) return res.status(400).json({ ok: false, error: 'missing_authorization' });
    const parts = auth.split(' ');
    if (parts.length !== 2) return res.status(400).json({ ok: false, error: 'invalid_authorization' });
    const token = parts[1];
    try {
      const jwt = require('jsonwebtoken');
      // decode to get expiry; do not verify again (already verified by middleware)
      const decoded = jwt.decode(token) || {};
      const exp = decoded.exp ? decoded.exp * 1000 : Date.now() + (24 * 3600 * 1000);
      blacklistedTokens.set(token, exp);
      return res.json({ ok: true, message: 'logged_out' });
    } catch (err) {
      // fallback: blacklist for 24 hours
      blacklistedTokens.set(token, Date.now() + (24 * 3600 * 1000));
      return res.json({ ok: true, message: 'logged_out' });
    }
  } catch (e) {
    console.error('logout error:', e && e.message ? e.message : e);
    return res.status(500).json({ ok: false, error: 'logout_failed' });
  }
});

// Protected route to get current user info
app.get('/me', authenticateToken, async (req, res) => {
  try {
    if (!User) return res.status(500).json({ ok: false, error: 'mongodb_not_configured' });
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

// Register endpoint to create or update a user record in the users DB
app.post('/register', async (req, res) => {
  try {
    if (!User) return res.status(500).json({ ok: false, error: 'mongodb_not_configured' });
    const { fullName, email, username, password, phone, role, otp } = req.body;
    console.log('Register request payload:', { fullName, email, username, phone, role });

    // Basic validation
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
    if (errors.length) {
      console.warn('Register validation failed:', errors);
      return res.status(400).json({ ok: false, error: 'validation_failed', details: errors });
    }

    // Verify: allow if phone was recently verified via /verify-otp
    let otpVerified = false;
    const vExpires = verifiedPhones.get(toPhone);
    if (vExpires && Date.now() <= vExpires) {
      otpVerified = true;
      verifiedPhones.delete(toPhone);
    }
    // If not verified yet, try Verify API or in-memory OTP check
    if (!otpVerified) {
      if (twilioClient && verifyServiceSid) {
        try {
          const check = await twilioClient.verify.v2.services(verifyServiceSid).verificationChecks.create({ to: toPhone, code: otp });
          if (check && check.status === 'approved') otpVerified = true;
        } catch (e) {
          console.warn('Twilio verify check error during register:', e && e.message ? e.message : e);
        }
      }
    }
    if (!otpVerified) {
      const entry = otps.get(toPhone);
      if (entry && entry.code === otp && Date.now() <= entry.expiresAt) {
        otpVerified = true;
        otps.delete(toPhone);
      }
    }
    if (!otpVerified) {
      console.warn('OTP not verified for', toPhone);
      return res.status(400).json({ ok: false, error: 'otp_not_verified' });
    }

    // Create or update user
    const update = {
      fullName: fullName || undefined,
      email: email || undefined,
      username: username || undefined,
      role: role || undefined,
      updatedAt: Date.now(),
      phone: toPhone,
    };
    if (password) {
      try {
        const bcrypt = require('bcryptjs');
        const salt = bcrypt.genSaltSync(10);
        update.passwordHash = bcrypt.hashSync(password, salt);
      } catch (e) {
        console.warn('bcrypt not installed or failed to load:', e && e.message ? e.message : e);
      }
    }

    const opts = { upsert: true, new: true, setDefaultsOnInsert: true };
    const user = await User.findOneAndUpdate({ phone: toPhone }, update, opts).lean();
    console.log('User upserted:', { phone: user && user.phone, id: user && user._id });
    return res.json({ ok: true, user });
  } catch (e) {
    console.error('Register error:', e && e.message ? e.message : e);
    return res.status(500).json({ ok: false, error: 'register_failed' });
  }
});

app.get('/health', (req, res) => res.json({ ok: true }));

// Start server after attempting MongoDB connection so queries don't race before ready
function startServer() {
  // create HTTP server so we can attach socket.io
  const http = require('http');
  const server = http.createServer(app);
  // try to attach Socket.io if available
  let io = null;
  try {
    const { Server } = require('socket.io');
    io = new Server(server, { cors: { origin: '*' } });

    io.on('connection', (socket) => {
      console.log('socket connected:', socket.id);

      socket.on('join_user', (userId) => {
        try { socket.join(String(userId)); } catch (e) {}
      });

      socket.on('join_conversation', (conversationId) => {
        try { socket.join(String(conversationId)); } catch (e) {}
      });

      socket.on('send_message', async (payload) => {
        // payload: { conversationId, sender, text }
        try {
          const { conversationId, sender, text } = payload || {};
          if (!conversationId || !sender || !text) return;
          if (typeof Message !== 'undefined') {
            const msg = await Message.create({ conversation: conversationId, sender, text });
            if (typeof Conversation !== 'undefined') {
              await Conversation.findByIdAndUpdate(conversationId, { lastMessage: text, updatedAt: Date.now() });
              const conv = await Conversation.findById(conversationId).lean();
              // emit to conversation room
              io.to(String(conversationId)).emit('message', msg);
              // also emit to participant user rooms
              if (conv && conv.participants) {
                conv.participants.forEach(pid => io.to(String(pid)).emit('message', msg));
              }
            } else {
              io.to(String(conversationId)).emit('message', msg);
            }
          }
        } catch (e) {
          console.error('socket send_message error:', e && e.message ? e.message : e);
        }
      });
    });
  } catch (e) {
    console.warn('Socket.io not available; realtime chat disabled.');
  }

    // mount social routes with io so they can emit realtime events
    try {
      const socialRouterFactory = require('./routes/social');
      const socialRouter = socialRouterFactory({ authenticateToken, models: { User, Follow, Post, Like, Comment, Conversation, Message }, io });
      app.use('/api', socialRouter);
    } catch (e) {
      console.warn('Social routes not loaded at server start:', e && e.message ? e.message : e);
    }

  server.listen(port, () => {
    console.log(`CineHub OTP backend listening on ${port}`);
  });

  server.on('error', (err) => {
    if (err && err.code === 'EADDRINUSE') {
      console.error(`Port ${port} is already in use. Another process is listening on this port.`);
      console.error('Use: netstat -ano | findstr :' + port + '  and taskkill /PID <pid> /F to free the port.');
      process.exit(1);
    }
    console.error('Server error:', err);
    process.exit(1);
  });
}

// If mongoose is available, try to connect first. Otherwise start server immediately.
if (mongoose) {
  const dbName = process.env.MONGODB_DBNAME || 'cine_hub';
  mongoose.connect(mongoUri, { dbName, useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
      console.log(`Connected to MongoDB database: ${dbName}`);
      // social routes will be mounted when server starts so Socket.io can be injected
      startServer();
    })
    .catch(err => {
      console.warn('MongoDB connection warning:', err && err.message ? err.message : err);
      console.warn('The server will still start, but requests requiring MongoDB may fail.');
      startServer();
    });
} else {
  console.warn('Mongoose not available; starting server without DB connection.');
  startServer();
}
