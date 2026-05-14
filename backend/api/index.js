// Vercel Serverless wrapper with guarded initialization so startup errors are logged
try {
	const serverless = require('serverless-http');
	const app = require('../server');
	module.exports = serverless(app);
} catch (e) {
	// If initialization fails, log the error and export a simple function that
	// returns 500 with a generic message. This prevents Vercel from showing
	// FUNCTION_INVOCATION_FAILED with no server logs.
	console.error('Serverless function initialization error:', e && e.stack ? e.stack : e);
	const express = require('express');
	const fallback = express();
	fallback.use((req, res) => {
		res.status(500).json({ ok: false, error: 'server_initialization_failed' });
	});
	module.exports = require('serverless-http')(fallback);
}
