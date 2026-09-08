import { Injectable, Logger } from '@nestjs/common';
import { MediaJob, MediaJobStatus, Prisma } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/**
 * The clips still owed a re-encode.
 *
 * A table rather than a queue in memory. The work is measured in tens of
 * seconds, so a deploy lands in the middle of one regularly; held in memory
 * that work would vanish with nothing anywhere recording that it had, and the
 * clip would keep its upload bitrate forever. A row survives the restart and
 * is picked up again.
 *
 * There is one API process today and this does not need Postgres to be a
 * broker. It claims with `FOR UPDATE SKIP LOCKED` anyway, because that is the
 * difference between "correct on one machine" and "correct", and it costs a
 * clause.
 */
@Injectable()
export class MediaQueue {
  private readonly logger = new Logger(MediaQueue.name);

  constructor(private readonly prisma: PrismaService) {}

  /**
   * How many times a clip is picked up before it is given up on.
   *
   * Three, because the failures worth retrying are the transient ones -- a
   * storage blip, a machine that went away mid-encode. A clip ffmpeg cannot
   * read fails identically every time, and retrying it forever is a busy loop
   * that never finishes.
   */
  static readonly maxAttempts = 3;

  /**
   * How long a claim is trusted before the job is considered abandoned.
   *
   * Longer than the longest legitimate encode, or a slow job gets picked up a
   * second time while the first is still running. A five-minute clip is the
   * ceiling and encodes well inside this.
   */
  static readonly staleAfterMs = 20 * 60_000;

  /**
   * Records that a stored clip is owed a re-encode.
   *
   * Keyed by storage path, so an upload retried to the same place queues the
   * work once. Never throws into the upload: the clip is already stored and
   * already plays, and failing the request now would tell somebody their post
   * did not happen when it did.
   */
  async enqueue(job: {
    path: string;
    userId: string;
    bytesIn: number;
  }): Promise<void> {
    try {
      await this.prisma.mediaJob.upsert({
        where: { path: job.path },
        create: { ...job },
        update: {
          status: MediaJobStatus.PENDING,
          attempts: 0,
          lastError: null,
          claimedAt: null,
        },
      });
    } catch (error) {
      this.logger.error(
        `A clip went up but could not be queued for re-encoding: ${String(error)}`,
      );
    }
  }

  /**
   * Takes the oldest job nobody else holds, or null when there is none.
   *
   * One statement, so claiming cannot race: the row is locked, marked and
   * returned together. A job left RUNNING by a process that died is claimable
   * again once its claim is stale, which is how a killed encode is retried
   * rather than lost.
   */
  async claim(): Promise<MediaJob | null> {
    const staleSeconds = Math.round(MediaQueue.staleAfterMs / 1000);

    const claimed = await this.prisma.$queryRaw<MediaJob[]>(Prisma.sql`
      UPDATE "MediaJob"
      SET status = 'RUNNING',
          "claimedAt" = now(),
          attempts = attempts + 1,
          "updatedAt" = now()
      WHERE id = (
        SELECT id FROM "MediaJob"
        WHERE status = 'PENDING'
           OR (
             status = 'RUNNING'
             AND "claimedAt" < now() - make_interval(secs => ${staleSeconds})
           )
        ORDER BY "createdAt"
        LIMIT 1
        FOR UPDATE SKIP LOCKED
      )
      RETURNING *
    `);

    return claimed[0] ?? null;
  }

  /** The clip is smaller now. */
  async finish(id: string, bytesOut: number): Promise<void> {
    await this.prisma.mediaJob.update({
      where: { id },
      data: { status: MediaJobStatus.DONE, bytesOut, lastError: null },
    });
  }

  /**
   * ffprobe changed its mind, or ffmpeg is gone. Recorded rather than deleted:
   * "nothing was needed" and "nothing happened" are different answers, and
   * only one of them is a problem.
   */
  async skip(id: string, why: string): Promise<void> {
    await this.prisma.mediaJob.update({
      where: { id },
      data: { status: MediaJobStatus.SKIPPED, lastError: why },
    });
  }

  /**
   * The attempt failed. Back to PENDING while attempts remain, FAILED after.
   *
   * FAILED is not a lost clip -- the original is stored and plays. What is
   * lost is the smaller file, and this row is what says so out loud instead of
   * leaving it to be noticed in a storage bill.
   */
  async fail(job: MediaJob, error: string): Promise<void> {
    const spent = job.attempts >= MediaQueue.maxAttempts;
    await this.prisma.mediaJob.update({
      where: { id: job.id },
      data: {
        status: spent ? MediaJobStatus.FAILED : MediaJobStatus.PENDING,
        claimedAt: null,
        lastError: error.slice(0, 500),
      },
    });

    if (spent) {
      this.logger.error(
        `Gave up re-encoding ${job.path} after ${job.attempts} attempts: ${error}`,
      );
    } else {
      this.logger.warn(`Re-encode of ${job.path} failed, will retry: ${error}`);
    }
  }

  /** How many clips are waiting, and how many were given up on. */
  async depth(): Promise<{ pending: number; failed: number }> {
    const [pending, failed] = await Promise.all([
      this.prisma.mediaJob.count({
        where: {
          status: { in: [MediaJobStatus.PENDING, MediaJobStatus.RUNNING] },
        },
      }),
      this.prisma.mediaJob.count({
        where: { status: MediaJobStatus.FAILED },
      }),
    ]);
    return { pending, failed };
  }
}
