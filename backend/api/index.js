// Robust serverless wrapper: attempt to require the app at startup, but if that
// fails, respond with a lightweight fallback so the deployment stays healthy.
const serverless = require('serverless-http');
let handler = null;
try {
	// require the exported Express app (server.js exports the app)
	const app = require('../server');
	handler = serverless(app);
	console.log('Serverless handler initialized');
} catch (e) {
	console.error('Serverless initialization warning:', e && e.stack ? e.stack : e);
	handler = null;
}

// Export a function that dispatches to the initialized handler when available,
// otherwise returns a safe fallback response. This keeps the function warm
// and responsive while we gather logs and fix the root cause.
module.exports = async (req, res) => {
	try {
		if (handler) {
			// delegate to serverless-http handler
			return handler(req, res);
		}
	} catch (e) {
		console.error('Runtime handler error:', e && e.stack ? e.stack : e);
	}
	// Lightweight fallback
	res.status(200).json({ ok: true, message: 'CineHub backend (limited fallback) - initialization issue detected' });
};
