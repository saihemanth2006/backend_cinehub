/**
 * @module integrations/ai/queue/ai.queue
 * @description AI Request Queue — BullMQ-powered async processing for expensive AI operations.
 * Enables background processing, priority queuing, retry logic, and concurrent job management.
 *
 * Queue Architecture:
 * ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
 * │  API Request  │───▶│  BullMQ      │───▶│  AI Worker   │
 * │  (enqueue)   │    │  Queue       │    │  (process)   │
 * └──────────────┘    └──────────────┘    └──────┬───────┘
 *                                                │
 *                                         ┌──────▼───────┐
 *                                         │  Notify via  │
 *                                         │  WebSocket   │
 *                                         └──────────────┘
 *
 * Job Priorities:
 * 1 (highest) — Interactive / real-time requests
 * 5 (default) — Standard generation requests
 * 10 (lowest) — Batch / background processing
 */
const { Queue, Worker, QueueEvents } = require('bullmq');
const { logger } = require('../../../config');

const QUEUE_NAME = 'ai-orchestration';

/** Job type configuration with priority and retry settings */
const JOB_CONFIGS = {
  'script.generate': { priority: 3, attempts: 2, backoff: { type: 'exponential', delay: 5000 }, timeout: 120000 },
  'script.enhance': { priority: 5, attempts: 2, backoff: { type: 'exponential', delay: 3000 }, timeout: 60000 },
  'analysis.genre': { priority: 5, attempts: 3, backoff: { type: 'exponential', delay: 2000 }, timeout: 30000 },
  'production.budget': { priority: 5, attempts: 2, backoff: { type: 'exponential', delay: 3000 }, timeout: 45000 },
  'production.talent': { priority: 5, attempts: 2, backoff: { type: 'exponential', delay: 3000 }, timeout: 45000 },
  'assistant.creative': { priority: 1, attempts: 1, backoff: { type: 'fixed', delay: 1000 }, timeout: 30000 },
  'insights.project': { priority: 7, attempts: 3, backoff: { type: 'exponential', delay: 2000 }, timeout: 30000 },
  'recommendation.user': { priority: 7, attempts: 3, backoff: { type: 'exponential', delay: 2000 }, timeout: 30000 },
  default: { priority: 5, attempts: 2, backoff: { type: 'exponential', delay: 3000 }, timeout: 60000 },
};

class AIQueue {
  /**
   * @param {import('ioredis')} redisConnection - Redis connection for BullMQ
   */
  constructor(redisConnection) {
    this.connection = redisConnection;
    this.queue = null;
    this.worker = null;
    this.queueEvents = null;
    this._processor = null;
    this._eventHandlers = new Map();
  }

  /**
   * Initializes the queue and worker.
   * @param {Function} processor - Job processor function: (job) => Promise<result>
   * @param {Object} [workerOptions]
   */
  initialize(processor, workerOptions = {}) {
    if (!this.connection) {
      logger.warn('[AI Queue] No Redis connection — queue disabled');
      return;
    }

    this._processor = processor;

    // Create queue
    this.queue = new Queue(QUEUE_NAME, {
      connection: this.connection,
      defaultJobOptions: {
        removeOnComplete: { count: 500 },
        removeOnFail: { count: 200 },
      },
    });

    // Create worker
    this.worker = new Worker(
      QUEUE_NAME,
      async (job) => {
        const startTime = Date.now();
        logger.info(`[AI Queue] Processing job ${job.id} (${job.name})`, {
          templateId: job.data.templateId,
          userId: job.data.userId,
          attempt: job.attemptsMade + 1,
        });

        try {
          const result = await processor(job.data);
          logger.info(`[AI Queue] Job ${job.id} completed in ${Date.now() - startTime}ms`);
          return result;
        } catch (err) {
          logger.error(`[AI Queue] Job ${job.id} failed: ${err.message}`, {
            attempt: job.attemptsMade + 1,
            maxAttempts: job.opts.attempts,
          });
          throw err;
        }
      },
      {
        connection: this.connection,
        concurrency: workerOptions.concurrency || 3,
        limiter: workerOptions.limiter || {
          max: 10,
          duration: 60000, // Max 10 jobs per minute
        },
      },
    );

    // Queue events for monitoring
    this.queueEvents = new QueueEvents(QUEUE_NAME, {
      connection: this.connection,
    });

    this._setupEventListeners();
    logger.info('[AI Queue] ✅ Queue and worker initialized');
  }

  /**
   * Enqueues an AI job for background processing.
   * @param {Object} jobData
   * @param {string} jobData.templateId - AI template to execute
   * @param {Object} jobData.variables - Template variables
   * @param {string} jobData.userId - Requesting user
   * @param {string} [jobData.provider] - Preferred AI provider
   * @param {Object} [jobData.options] - Additional generation options
   * @param {Object} [queueOptions] - BullMQ job options override
   * @returns {Promise<{ jobId: string, status: string }>}
   */
  async enqueue(jobData, queueOptions = {}) {
    if (!this.queue) {
      // Queue not initialized — process synchronously
      logger.debug('[AI Queue] Queue not available, processing synchronously');
      if (this._processor) {
        const result = await this._processor(jobData);
        return { jobId: 'sync', status: 'completed', result };
      }
      throw new Error('AI Queue not initialized and no processor available');
    }

    const config = JOB_CONFIGS[jobData.templateId] || JOB_CONFIGS.default;

    const job = await this.queue.add(jobData.templateId, jobData, {
      priority: queueOptions.priority || config.priority,
      attempts: config.attempts,
      backoff: config.backoff,
      timeout: config.timeout,
      ...queueOptions,
    });

    logger.info(`[AI Queue] Job enqueued: ${job.id} (${jobData.templateId})`, {
      priority: config.priority,
      userId: jobData.userId,
    });

    return { jobId: job.id, status: 'queued' };
  }

  /**
   * Gets the status and result of a queued job.
   * @param {string} jobId
   * @returns {Promise<Object>}
   */
  async getJobStatus(jobId) {
    if (!this.queue) return { status: 'unknown', message: 'Queue not initialized' };

    const job = await this.queue.getJob(jobId);
    if (!job) return { status: 'not_found' };

    const state = await job.getState();

    return {
      jobId: job.id,
      status: state,
      templateId: job.name,
      progress: job.progress,
      attemptsMade: job.attemptsMade,
      result: state === 'completed' ? job.returnvalue : null,
      error: state === 'failed' ? job.failedReason : null,
      createdAt: new Date(job.timestamp),
      processedAt: job.processedOn ? new Date(job.processedOn) : null,
      completedAt: job.finishedOn ? new Date(job.finishedOn) : null,
    };
  }

  /**
   * Waits for a job to complete and returns the result.
   * @param {string} jobId
   * @param {number} [timeoutMs=120000]
   * @returns {Promise<Object>}
   */
  async waitForJob(jobId, timeoutMs = 120000) {
    if (!this.queueEvents) {
      throw new Error('Queue events not initialized');
    }

    return new Promise((resolve, reject) => {
      const timeout = setTimeout(() => {
        reject(new Error(`Job ${jobId} timed out after ${timeoutMs}ms`));
      }, timeoutMs);

      this.queueEvents.on('completed', ({ jobId: completedId, returnvalue }) => {
        if (completedId === jobId) {
          clearTimeout(timeout);
          resolve(typeof returnvalue === 'string' ? JSON.parse(returnvalue) : returnvalue);
        }
      });

      this.queueEvents.on('failed', ({ jobId: failedId, failedReason }) => {
        if (failedId === jobId) {
          clearTimeout(timeout);
          reject(new Error(`Job ${failedId} failed: ${failedReason}`));
        }
      });
    });
  }

  /**
   * Registers an event handler for job lifecycle events.
   * @param {string} event - 'completed' | 'failed' | 'progress'
   * @param {Function} handler
   */
  onJobEvent(event, handler) {
    this._eventHandlers.set(event, handler);
  }

  /**
   * Returns queue health metrics.
   * @returns {Promise<Object>}
   */
  async getQueueMetrics() {
    if (!this.queue) return { available: false };

    const [waiting, active, completed, failed, delayed] = await Promise.all([
      this.queue.getWaitingCount(),
      this.queue.getActiveCount(),
      this.queue.getCompletedCount(),
      this.queue.getFailedCount(),
      this.queue.getDelayedCount(),
    ]);

    return {
      available: true,
      waiting,
      active,
      completed,
      failed,
      delayed,
      total: waiting + active + completed + failed + delayed,
    };
  }

  /**
   * Gracefully shuts down the queue and worker.
   */
  async shutdown() {
    if (this.worker) {
      await this.worker.close();
      logger.info('[AI Queue] Worker shut down');
    }
    if (this.queueEvents) {
      await this.queueEvents.close();
    }
    if (this.queue) {
      await this.queue.close();
      logger.info('[AI Queue] Queue shut down');
    }
  }

  // ── Internal ──────────────────────────────────────────

  _setupEventListeners() {
    if (!this.worker) return;

    this.worker.on('completed', (job, result) => {
      const handler = this._eventHandlers.get('completed');
      if (handler) handler(job.data, result);
    });

    this.worker.on('failed', (job, error) => {
      logger.error(`[AI Queue] Job permanently failed: ${job?.id}`, { error: error.message });
      const handler = this._eventHandlers.get('failed');
      if (handler) handler(job?.data, error);
    });

    this.worker.on('error', (err) => {
      logger.error(`[AI Queue] Worker error: ${err.message}`);
    });
  }
}

module.exports = { AIQueue, JOB_CONFIGS, QUEUE_NAME };
