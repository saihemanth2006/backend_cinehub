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
