/**
 * @module index
 * @description Application entry point — bootstraps database, events, and HTTP server.
 * Handles graceful shutdown on SIGTERM/SIGINT.
 */
const { env, logger, connectDatabase, disconnectDatabase, disconnectRedis } = require('./config');
const { registerListeners } = require('./events/listeners');
const app = require('./app');

const PORT = env.port;

/** @type {import('http').Server} */
let server;

async function bootstrap() {
  try {
    // 1. Connect to database
    await connectDatabase();

    // 2. Register event listeners
    registerListeners();

    // 3. Ensure uploads directory exists
    const fs = require('fs');
    const path = require('path');
    const uploadDir = path.resolve(__dirname, '..', env.upload.dir);
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
      logger.info(`[Boot] Created uploads directory: ${uploadDir}`);
    }

    // 4. Start HTTP server
    server = app.listen(PORT, () => {
      logger.info(`
╔═══════════════════════════════════════════════╗
║                                               ║
║   🎬  ${env.appName} Server v1.0.0              ║
║                                               ║
║   Environment : ${env.nodeEnv.padEnd(28)}  ║
║   Port        : ${String(PORT).padEnd(28)}  ║
║   API         : ${`${env.appUrl}${env.apiPrefix}/v1`.padEnd(28)}  ║
║                                               ║
╚═══════════════════════════════════════════════╝
      `);
    });

    server.on('error', (err) => {
      logger.error(`[Server] Error: ${err.message}`);
      process.exit(1);
    });
  } catch (err) {
    logger.error(`[Boot] Fatal error during startup: ${err.message}`);
    logger.error(err.stack);
    process.exit(1);
  }
}

// ── Graceful Shutdown ───────────────────────

async function shutdown(signal) {
  logger.info(`\n[Shutdown] ${signal} received. Starting graceful shutdown...`);

  // Stop accepting new connections
  if (server) {
    await new Promise((resolve) => {
      server.close(resolve);
    });
    logger.info('[Shutdown] HTTP server closed');
  }

  // Disconnect services
  try {
    await disconnectDatabase();
    await disconnectRedis();
  } catch (err) {
    logger.error(`[Shutdown] Error during cleanup: ${err.message}`);
  }

  logger.info('[Shutdown] ✅ Graceful shutdown complete');
  process.exit(0);
}

process.on('SIGTERM', () => shutdown('SIGTERM'));
process.on('SIGINT', () => shutdown('SIGINT'));

// Catch unhandled errors
process.on('unhandledRejection', (reason) => {
  logger.error(`[Process] Unhandled Rejection: ${reason}`);
});

process.on('uncaughtException', (err) => {
  logger.error(`[Process] Uncaught Exception: ${err.message}`);
  logger.error(err.stack);
  shutdown('uncaughtException');
});

// ── Start ───────────────────────────────────
bootstrap();
