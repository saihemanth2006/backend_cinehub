require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Ensure uploads directory exists
const uploadsDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir);
}

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
const nodemailer = require('nodemailer');
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST || 'smtp.gmail.com',
  port: parseInt(process.env.SMTP_PORT || '587', 10),
  secure: false, // true for 465, false for other ports
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASS,
  },
});

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Configure Multer for file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  }
});
const upload = multer({ storage: storage });

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
    var Job = require('./models/Job');
  } catch (e) {
    // models may not be present yet
  }
} catch (e) {
  console.warn('Mongoose not installed or failed to load:', e && e.message ? e.message : e);
}

// In-memory store for OTPs. Use Redis or DB in production.
const otps = new Map(); // email -> { code, expiresAt }
// In-memory store for recently verified emails. short TTL
const verifiedEmails = new Map(); // email -> expiresAt
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
    const { email } = req.body;
    if (!email) return res.status(400).json({ ok: false, error: 'email required' });
    const targetEmail = email.toLowerCase().trim();

    const code = generateOtp();
    const expiresAt = Date.now() + otpTtl * 1000;
    otps.set(targetEmail, { code, expiresAt });

    if (process.env.SMTP_USER && process.env.SMTP_PASS) {
      try {
        await transporter.sendMail({
          from: `"CineHub" <${process.env.SMTP_FROM || process.env.SMTP_USER}>`,
          to: targetEmail,
          subject: 'Your CineHub Verification Code',
          text: `Your OTP is: ${code}. It expires in ${otpTtl / 60} minutes.`,
        });
        return res.json({ ok: true, message: 'OTP sent' });
      } catch (err) {
        console.error('Email send error:', err);
        return res.status(500).json({ ok: false, error: 'email_send_failed' });
      }
    } else {
      console.log(`(dev) OTP for ${targetEmail}: ${code}`);
      return res.json({ ok: true, message: 'OTP sent (dev)', code });
    }
  } catch (err) {
    console.error(err);
    return res.status(500).json({ ok: false, error: 'internal_error' });
  }
});

app.post('/verify-otp', (req, res) => {
  try {
    const { email, otp } = req.body;
    if (!email || !otp) return res.status(400).json({ ok: false, error: 'email and otp required' });
    const targetEmail = email.toLowerCase().trim();

    const entry = otps.get(targetEmail);
    if (!entry) return res.status(400).json({ ok: false, error: 'no_otp_found' });
    if (Date.now() > entry.expiresAt) {
      otps.delete(targetEmail);
      return res.status(400).json({ ok: false, error: 'otp_expired' });
    }
    if (entry.code !== otp) return res.status(400).json({ ok: false, error: 'invalid_otp' });

    verifiedEmails.set(targetEmail, Date.now() + 5 * 60 * 1000); // 5 minutes
    otps.delete(targetEmail);
    return res.json({ ok: true, message: 'verified' });
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

// Upload endpoint
app.post('/api/upload', authenticateToken, upload.single('media'), (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ ok: false, error: 'no_file_uploaded' });
    }
    // Return the relative or absolute URL
    // In production, you'd use a full domain or S3 URL
    const fileUrl = `/uploads/${req.file.filename}`;
    return res.json({ ok: true, url: fileUrl });
  } catch (e) {
    console.error('Upload error:', e);
    return res.status(500).json({ ok: false, error: 'upload_failed' });
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
    if (!email) return res.status(400).json({ ok: false, error: 'email required' });
    if (!otp) return res.status(400).json({ ok: false, error: 'otp required' });
    if (!phone) return res.status(400).json({ ok: false, error: 'phone required' });
    const toPhone = normalizePhone(phone);
    const targetEmail = email.toLowerCase().trim();
    
    const errors = [];
    if (password) {
      if (password.length < 6) errors.push('password must be at least 6 characters');
    } else {
      errors.push('password required');
    }
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(targetEmail)) errors.push('invalid email');
    if (errors.length) {
      console.warn('Register validation failed:', errors);
      return res.status(400).json({ ok: false, error: 'validation_failed', details: errors });
    }

    let otpVerified = false;
    const vExpires = verifiedEmails.get(targetEmail);
    if (vExpires && Date.now() <= vExpires) {
      otpVerified = true;
      verifiedEmails.delete(targetEmail);
    } else {
      const entry = otps.get(targetEmail);
      if (entry && entry.code === otp && Date.now() <= entry.expiresAt) {
        otpVerified = true;
        otps.delete(targetEmail);
      }
    }
    
    if (!otpVerified) {
      return res.status(400).json({ ok: false, error: 'otp_not_verified' });
    }

    // Create or update user
    const update = {
      fullName: fullName || undefined,
      email: targetEmail,
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
    const user = await User.findOneAndUpdate({ email: targetEmail }, update, opts).lean();
    console.log('User upserted:', { email: user && user.email, id: user && user._id });
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

    try {
      const socialRouterFactory = require('./routes/social');
      const socialRouter = socialRouterFactory({ authenticateToken, models: { User, Follow, Post, Like, Comment, Conversation, Message }, io });
      app.use('/api', socialRouter);

      const jobsRouterFactory = require('./routes/jobs');
      const jobsRouter = jobsRouterFactory({ authenticateToken, models: { Job } });
      app.use('/api', jobsRouter);

      let CollabRequest = null;
      try { CollabRequest = require('./models/CollabRequest'); } catch(e) {}
      
      if (CollabRequest) {
        const collabRouterFactory = require('./routes/collab');
        const collabRouter = collabRouterFactory({ authenticateToken, models: { CollabRequest } });
        app.use('/api', collabRouter);
      }
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
  const connectOptions = {
    dbName,
    serverSelectionTimeoutMS: 30000,
    socketTimeoutMS: 45000,
    maxPoolSize: 10,
    minPoolSize: 2,
    retryWrites: true,
    retryReads: true,
  };
  mongoose.connect(mongoUri, connectOptions)
    .then(() => {
      console.log(`Connected to MongoDB database: ${dbName}`);
      // Attach connection event listeners for resilience visibility
      mongoose.connection.on('error', (err) => {
        console.error('MongoDB connection error:', err && err.message ? err.message : err);
      });
      mongoose.connection.on('disconnected', () => {
        console.warn('MongoDB disconnected. Mongoose will attempt to reconnect automatically.');
      });
      mongoose.connection.on('reconnected', () => {
        console.log('MongoDB reconnected successfully.');
      });
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

// Export the express app for Vercel serverless environment
module.exports = app;
