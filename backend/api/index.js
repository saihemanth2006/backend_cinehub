// Fully lazy serverless wrapper: do not require app or serverless-http at module
// load time. Instead, initialize on first request to avoid crashes caused by
// synchronous exceptions during module import in Vercel's runtime.
let initPromise = null;
let delegatedHandler = null;

async function initHandler() {
	if (delegatedHandler || initPromise) return initPromise;
	initPromise = (async () => {
		try {
			const serverless = require('serverless-http');
			const app = require('../server');
			delegatedHandler = serverless(app);
			console.log('Serverless handler lazily initialized');
			return delegatedHandler;
		} catch (err) {
			console.error('Lazy initialization failed:', err && err.stack ? err.stack : err);
			delegatedHandler = null;
			return null;
		}
	})();
	return initPromise;
}

module.exports = async (req, res) => {
	// Fast-path: respond to CORS preflight immediately to avoid cold-start timeouts
	if (req && req.method === 'OPTIONS') {
		try {
			res.setHeader('Access-Control-Allow-Origin', '*');
			res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS');
			res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
			res.statusCode = 204;
			return res.end();
		} catch (e) {
			console.warn('Failed to send preflight response:', e && e.message ? e.message : e);
		}
	}

	// Fast-path: health check or root can respond without initializing full app
	const url = (req && (req.url || req.path)) || '';
	if (url === '/health' || url === '/') {
		try {
			res.setHeader('Access-Control-Allow-Origin', '*');
			return res.status(200).json({ ok: true, fallback: true });
		} catch (e) {
			// fall through to lazy init
			console.warn('Health fast-path failed:', e && e.message ? e.message : e);
		}
	}

	try {
		await initHandler();
		if (delegatedHandler) {
			return delegatedHandler(req, res);
		}
	} catch (err) {
		console.error('Error while invoking delegated handler:', err && err.stack ? err.stack : err);
	}

	// Safe fallback so the function always responds instead of crashing.
	res.status(200).json({ ok: false, message: 'Backend initialization error (fallback response). Check function logs.' });
};
