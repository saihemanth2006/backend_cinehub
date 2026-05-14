// Temporary lightweight health handler to verify Vercel can serve functions
module.exports = (req, res) => {
  try {
    res.status(200).json({ ok: true, message: 'ping', env: { node: process.version } });
  } catch (e) {
    console.error('ping handler error:', e && e.stack ? e.stack : e);
    res.status(500).json({ ok: false, error: 'ping_failed' });
  }
};
