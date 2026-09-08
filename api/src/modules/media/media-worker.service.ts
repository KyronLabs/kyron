import {
  Injectable,
  Logger,
  OnModuleDestroy,
  OnModuleInit,
} from '@nestjs/common';
import { MediaJob } from '@prisma/client';
import { MetricsService } from '../../infrastructure/observability/metrics.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { MediaQueue } from './media-queue.service';
import { TranscodeService } from './transcode.service';

/**
 * Drains the re-encode queue, one clip at a time.
 *
 * One at a time on purpose. ffmpeg runs in a child process, so it never blocks
 * the event loop -- what it competes for is CPU, and two encodes at once on a
 * single machine make every request served alongside them slower for no gain
 * in throughput. The queue is allowed to be a queue.
 *
 * The clip is already stored and already plays before any of this runs. Every
 * failure here costs a smaller file, never an upload.
 */
@Injectable()
export class MediaWorker implements OnModuleInit, OnModuleDestroy {
  private readonly logger = new Logger(MediaWorker.name);

  private timer: NodeJS.Timeout | null = null;
  private draining = false;
  private stopped = false;

  /** Last read of the queue, for the gauge. Scraping must not hit the
   *  database, so this is refreshed on the tick instead. */
  private depth = { pending: 0, failed: 0 };

  constructor(
    private readonly queue: MediaQueue,
    private readonly transcode: TranscodeService,
    private readonly storage: SupabaseService,
    private readonly metrics: MetricsService,
  ) {}

  /**
   * How often the queue is looked at when it is empty.
   *
   * A poll rather than a notification because the alternative on Postgres is
   * LISTEN/NOTIFY on a dedicated connection, and five seconds of latency on
   * work that takes thirty is not worth a connection to hold open. A tick that
   * finds work keeps going until there is none.
   */
  static readonly tickMs = 5_000;

  onModuleInit(): void {
    this.metrics.gauge(
      'kyron_media_reencode_pending',
      'Clips uploaded and still owed a re-encode.',
      () => this.depth.pending,
    );
    this.metrics.gauge(
      'kyron_media_reencode_failed',
      'Clips given up on. Each still plays at its upload bitrate.',
      () => this.depth.failed,
    );

    this.timer = setInterval(() => void this.drain(), MediaWorker.tickMs);
    // So a pending tick cannot hold the process open on shutdown.
    this.timer.unref();
  }

  onModuleDestroy(): void {
    this.stopped = true;
    if (this.timer) clearInterval(this.timer);
    this.timer = null;
  }

  /**
   * Works the queue until it is empty.
   *
   * Guarded against overlap: an encode routinely outlasts the tick that
   * started it, and a second drain would take the next job and run two at
   * once.
   */
  async drain(): Promise<void> {
    if (this.draining || this.stopped) return;
    this.draining = true;

    try {
      for (;;) {
        const job = await this.queue.claim();
        if (!job) break;
        await this.run(job);
        if (this.stopped) break;
      }
    } catch (error) {
      // Claiming failed -- the database, not the clip. The next tick tries
      // again; the jobs are still there.
      this.logger.error(`Could not work the re-encode queue: ${String(error)}`);
    } finally {
      this.draining = false;
      await this.readDepth();
    }
  }

  /** One clip: fetch, re-encode, write back over the same path. */
  private async run(job: MediaJob): Promise<void> {
    const started = Date.now();

    try {
      if (!this.transcode.isAvailable) {
        // Nothing is wrong with the clip; there is no encoder here. Recorded
        // as skipped so it is not retried until something changes.
        await this.queue.skip(job.id, 'ffmpeg is not installed on this server');
        return;
      }

      const original = await this.storage.downloadFile(job.path);
      const smaller = await this.transcode.reencode(original);

      if (!smaller) {
        // ffmpeg read it and refused. Retrying will not change its mind.
        await this.queue.skip(job.id, 'ffmpeg would not re-encode this clip');
        return;
      }

      // A re-encode that came out bigger is one worth throwing away: the point
      // was a smaller file, and H.264 over an already-efficient clip can lose
      // that bet.
      if (smaller.length >= original.length) {
        await this.queue.skip(
          job.id,
          `re-encoding made it bigger (${original.length} to ${smaller.length} bytes)`,
        );
        return;
      }

      // Back over the same path, so the URL every post already links to keeps
      // working and only the bytes behind it change. See docs/MEDIA_JOBS.md
      // for what that costs.
      await this.storage.uploadToPath(job.path, smaller, 'video/mp4');
      await this.queue.finish(job.id, smaller.length);

      const saved = Math.round((1 - smaller.length / original.length) * 100);
      this.logger.log(
        `re-encoded ${job.path}: ${original.length} to ${smaller.length} bytes ` +
          `(${saved}% smaller) in ${Date.now() - started}ms`,
      );
    } catch (error) {
      await this.queue.fail(job, String(error));
    }
  }

  private async readDepth(): Promise<void> {
    try {
      this.depth = await this.queue.depth();
    } catch {
      // The gauge keeps its last value rather than reporting a zero that would
      // read as an empty queue.
    }
  }
}
