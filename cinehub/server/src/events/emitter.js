/**
 * @module events/emitter
 * @description Application-wide event emitter for decoupled communication.
 * Services emit events; listeners handle side-effects (notifications, emails, analytics).
 */
const EventEmitter = require('events');
const { logger } = require('../config');

class AppEventEmitter extends EventEmitter {
  constructor() {
    super();
    this.setMaxListeners(30);
  }

  emit(event, data) {
    logger.debug(`[Event] Emitting: ${event}`, { data: typeof data === 'object' ? JSON.stringify(data).slice(0, 200) : data });
    return super.emit(event, data);
  }
}

module.exports = new AppEventEmitter();
