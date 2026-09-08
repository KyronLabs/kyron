import { MediaJob, MediaJobStatus } from '@prisma/client';
import { MetricsService } from '../../infrastructure/observability/metrics.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { MediaQueue } from './media-queue.service';
import { MediaWorker } from './media-worker.service';
import { TranscodeService } from './transcode.service';

const job = (over: Partial<MediaJob> = {}): MediaJob =>
  ({
    id: 'job-1',
    path: 'post-media/clip.mp4',
    userId: 'user-1',
    status: MediaJobStatus.RUNNING,
    attempts: 1,
    lastError: null,
    claimedAt: new Date(),
    bytesIn: 20_000_000,
    bytesOut: null,
    createdAt: new Date(),
    updatedAt: new Date(),
    ...over,
  }) as MediaJob;

/** Hands out a fixed list of jobs, then nothing -- like a draining queue. */
function fakeQueue(jobs: MediaJob[]) {
  const queued = [...jobs];
  return {
    claim: jest.fn(() => Promise.resolve(queued.shift() ?? null)),
    finish: jest.fn(() => Promise.resolve()),
    skip: jest.fn(() => Promise.resolve()),
    fail: jest.fn(() => Promise.resolve()),
    depth: jest.fn(() => Promise.resolve({ pending: 0, failed: 0 })),
  };
}

function build(parts: {
  queue: ReturnType<typeof fakeQueue>;
  available?: boolean;
  reencode?: () => Promise<Buffer | null>;
  download?: () => Promise<Buffer>;
  upload?: jest.Mock;
}) {
  const upload = parts.upload ?? jest.fn(() => Promise.resolve({}));
  const transcode = {
    isAvailable: parts.available ?? true,
    reencode: parts.reencode ?? (() => Promise.resolve(Buffer.alloc(1000))),
  } as unknown as TranscodeService;
  const storage = {
    downloadFile: parts.download ?? (() => Promise.resolve(Buffer.alloc(5000))),
    uploadToPath: upload,
  } as unknown as SupabaseService;

  const worker = new MediaWorker(
    parts.queue as unknown as MediaQueue,
    transcode,
    storage,
    new MetricsService(),
  );
  return { worker, upload };
}

describe('MediaWorker', () => {
  it('writes the smaller clip back over the same path', async () => {
    // The URL is already in somebody's post. Writing anywhere else would mean
    // finding and updating every row that links to it.
    const queue = fakeQueue([job()]);
    const { worker, upload } = build({
      queue,
      download: () => Promise.resolve(Buffer.alloc(5000)),
      reencode: () => Promise.resolve(Buffer.alloc(1200)),
    });

    await worker.drain();

    expect(upload).toHaveBeenCalledWith(
      'post-media/clip.mp4',
      expect.any(Buffer),
      'video/mp4',
    );
    expect(queue.finish).toHaveBeenCalledWith('job-1', 1200);
    expect(queue.fail).not.toHaveBeenCalled();
  });

  it('throws away a re-encode that came out bigger', async () => {
    // H.264 over an already-efficient clip can lose that bet, and storing the
    // result would make the file worse for everybody who plays it.
    const queue = fakeQueue([job()]);
    const { worker, upload } = build({
      queue,
      download: () => Promise.resolve(Buffer.alloc(1000)),
      reencode: () => Promise.resolve(Buffer.alloc(4000)),
    });

    await worker.drain();

    expect(upload).not.toHaveBeenCalled();
    expect(queue.skip).toHaveBeenCalledWith(
      'job-1',
      expect.stringContaining('bigger'),
    );
  });

  it('skips rather than retries when there is no ffmpeg', async () => {
    // Nothing is wrong with the clip and nothing will change on a retry.
    const queue = fakeQueue([job()]);
    const { worker } = build({ queue, available: false });

    await worker.drain();

    expect(queue.skip).toHaveBeenCalledWith(
      'job-1',
      expect.stringContaining('ffmpeg'),
    );
    expect(queue.fail).not.toHaveBeenCalled();
  });

  it('skips a clip ffmpeg read and refused', async () => {
    const queue = fakeQueue([job()]);
    const { worker } = build({ queue, reencode: () => Promise.resolve(null) });

    await worker.drain();

    expect(queue.skip).toHaveBeenCalled();
    expect(queue.fail).not.toHaveBeenCalled();
  });

  it('fails the job when storage does, so it is retried', async () => {
    // A storage blip is the transient kind: the clip is fine and the next
    // attempt may well work.
    const queue = fakeQueue([job()]);
    const { worker } = build({
      queue,
      download: () => Promise.reject(new Error('503 from storage')),
    });

    await worker.drain();

    expect(queue.fail).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'job-1' }),
      expect.stringContaining('503'),
    );
  });

  it('keeps going after one clip fails', async () => {
    // One unreadable clip must not stop the queue behind it.
    let call = 0;
    const queue = fakeQueue([job({ id: 'a' }), job({ id: 'b' })]);
    const { worker } = build({
      queue,
      download: () => {
        call += 1;
        return call === 1
          ? Promise.reject(new Error('bad'))
          : Promise.resolve(Buffer.alloc(5000));
      },
      reencode: () => Promise.resolve(Buffer.alloc(1000)),
    });

    await worker.drain();

    expect(queue.fail).toHaveBeenCalledTimes(1);
    expect(queue.finish).toHaveBeenCalledWith('b', 1000);
  });

  it('does not run two encodes at once', async () => {
    // An encode routinely outlasts the tick that started it. A second drain
    // taking the next job would put two on the CPU at the same time.
    const queue = fakeQueue([job({ id: 'a' }), job({ id: 'b' })]);
    let running = 0;
    let overlapped = false;

    const { worker } = build({
      queue,
      reencode: async () => {
        running += 1;
        if (running > 1) overlapped = true;
        await new Promise((resolve) => setTimeout(resolve, 5));
        running -= 1;
        return Buffer.alloc(100);
      },
    });

    await Promise.all([worker.drain(), worker.drain(), worker.drain()]);

    expect(overlapped).toBe(false);
    expect(queue.finish).toHaveBeenCalledTimes(2);
  });

  it('reports how deep the queue is', async () => {
    const queue = fakeQueue([]);
    queue.depth.mockResolvedValue({ pending: 7, failed: 2 });
    const { worker } = build({ queue });

    await worker.drain();

    // Read on the tick rather than at scrape time: a scrape must not put a
    // query on the database.
    expect(queue.depth).toHaveBeenCalled();
  });

  it('survives the queue itself being unreachable', async () => {
    const queue = fakeQueue([]);
    queue.claim.mockRejectedValue(new Error('database is down'));
    const { worker } = build({ queue });

    // The jobs are still in the table; the next tick tries again.
    await expect(worker.drain()).resolves.toBeUndefined();
  });
});
