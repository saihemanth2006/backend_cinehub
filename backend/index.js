const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const path = require('path');
const fs = require('fs');

dotenv.config();

// connect to MongoDB if configured
require('./db');

const PORT = process.env.PORT || 4000;
const UPLOAD_DIR = process.env.UPLOAD_DIR || path.join(__dirname, 'uploads');

if (!fs.existsSync(UPLOAD_DIR)) fs.mkdirSync(UPLOAD_DIR, { recursive: true });

const app = express();
app.use(cors({ origin: process.env.FRONTEND_URL || '*' }));
app.use(express.json());
app.use('/uploads', express.static(UPLOAD_DIR));

// Basic runtime checks
const missingTwilio = !process.env.TWILIO_ACCOUNT_SID || !process.env.TWILIO_AUTH_TOKEN || !process.env.TWILIO_PHONE_NUMBER;
if (missingTwilio) console.warn('TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN or TWILIO_PHONE_NUMBER not set. Twilio features will be disabled.');

// routes
app.use('/auth', require('./routes/auth'));
app.use('/users', require('./routes/users'));
app.use('/posts', require('./routes/posts'));

app.get('/', (req, res) => res.json({ ok: true, message: 'CineHub backend running' }));

// Graceful error handlers
process.on('uncaughtException', (err) => {
	console.error('Uncaught exception', err);
});
process.on('unhandledRejection', (reason) => {
	console.error('Unhandled rejection', reason);
});

// Export handler for serverless platforms (Vercel), and start listener for local dev
try {
	const serverless = require('serverless-http');
	module.exports.handler = serverless(app);
} catch (e) {
	// if serverless-http not available, just start Express
	app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));
}
