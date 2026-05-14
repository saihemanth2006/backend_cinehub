// Lightweight launcher for local runs. The main Express app is in app.js
const { app, startStandalone } = require('./app');

// When run directly, attempt DB connect (if configured) then start HTTP server
if (require.main === module) {
  const mongoUri = process.env.MONGODB_URI;
  if (mongoUri) {
    const mongoose = require('mongoose');
    const dbName = process.env.MONGODB_DBNAME || 'cine_hub';
    const connectOpts = { dbName, useNewUrlParser: true, useUnifiedTopology: true, serverSelectionTimeoutMS: 5000, connectTimeoutMS: 5000 };
    mongoose.connect(mongoUri, connectOpts)
      .then(() => { console.log(`Connected to MongoDB database: ${dbName}`); startStandalone(); })
      .catch(err => { console.warn('MongoDB connection warning:', err && err.message ? err.message : err); console.warn('The server will still start, but requests requiring MongoDB may fail.'); startStandalone(); });
  } else {
    console.warn('MONGODB_URI not provided; starting server without DB connection.');
    startStandalone();
  }
}

module.exports = app;
