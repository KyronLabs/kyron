/**
 * Queues clips that predate the transcode for a re-encode.
 *
 * TranscodeService only ever ran on upload, and says of itself that a server
 * with no ffmpeg, or a clip it cannot read, means "the original bytes are
 * stored exactly as they arrived -- which is what happened to every clip
 * before this existed". So every clip older than that feature is still at
 * whatever a phone recorded it at. A 4K one still decodes as 4K in a feed, and
 * no amount of care in the app makes that cheap.
 *
 * Two modes, and the one that changes nothing is the default on purpose:
 *
 *   npx ts-node scripts/backfill-media.ts            count, change nothing
 *   npx ts-node scripts/backfill-media.ts --probe    ...and read each file
 *   npx ts-node scripts/backfill-media.ts --commit   queue the work
 *
 *   --limit N   look at no more than N clips (default: all of them)
 *
 * --probe downloads each clip and asks ffprobe its real shape, which is the
 * only way to catch a 720p clip at 8 Mbps: the height in the database cannot
 * show that. It costs a whole download per clip, so start with --limit.
 *
 * --commit only writes MediaJob rows. It re-encodes nothing itself. MediaWorker
 * picks those rows up one at a time, and probes each clip before touching it --
 * one already inside the ceiling is recorded SKIPPED. So queueing a clip that
 * turns out not to need it costs a probe, not a file.
 *
 * A re-encode writes back over the same path, so no URL changes and nothing
 * linking to a clip breaks. The original bytes are replaced, though, and there
 * is no undo. See docs/MEDIA_JOBS.md before running --commit.
 */
import { MediaKind } from '@prisma/client';
import { PrismaService } from '../src/infrastructure/prisma/prisma.service';
import { SupabaseService } from '../src/infrastructure/supabase/supabase.service';
import { MediaQueue } from '../src/modules/media/media-queue.service';
import { TranscodeService } from '../src/modules/media/transcode.service';
import { storedPathFromUrl } from '../src/modules/media/stored-path';

const BUCKET = process.env.SUPABASE_BUCKET_NAME || 'kyron-media';

/** Stands in when a clip's parent is gone. Only ever read to say whose clip
 *  is stuck, never for access. */
const NOBODY = '00000000-0000-0000-0000-000000000000';

const argv = process.argv.slice(2);
const commit = argv.includes('--commit');
const probe = argv.includes('--probe');
const limitAt = argv.indexOf('--limit');
const limit =
  limitAt >= 0 ? Number.parseInt(argv[limitAt + 1] ?? '', 10) : null;

if (limitAt >= 0 && (limit === null || !Number.isFinite(limit) || limit < 1)) {
  console.error('--limit wants a whole number of clips, e.g. --limit 20');
  process.exit(2);
}

/** Bytes, as something a person reads rather than counts. */
function size(bytes: number): string {
  if (bytes < 1024) return `${bytes} B`;
  const units = ['KB', 'MB', 'GB'];
  let value = bytes / 1024;
  let unit = 0;
  while (value >= 1024 && unit < units.length - 1) {
    value /= 1024;
    unit += 1;
  }
  return `${value.toFixed(1)} ${units[unit]}`;
}

interface Candidate {
  path: string;
  userId: string;
}

async function main(): Promise<number> {
  const prisma = new PrismaService();
  await prisma.$connect();

  const queue = new MediaQueue(prisma);
  const transcode = new TranscodeService();
  const storage = new SupabaseService();

  console.log(commit ? '== queueing ==' : '== counting, changing nothing ==');

  const clips = await prisma.media.findMany({
    where: { kind: MediaKind.VIDEO },
    select: {
      url: true,
      height: true,
      post: { select: { authorId: true } },
      comment: { select: { authorId: true } },
      message: { select: { senderId: true } },
    },
    orderBy: { createdAt: 'asc' },
    ...(limit === null ? {} : { take: limit }),
  });

  const capped = limit === null ? '' : ` (capped at ${limit})`;
  console.log(`${clips.length} video attachment(s)${capped}`);

  // Which of them this can act on at all. A URL it does not recognise gets
  // counted with its reason rather than guessed at: a path is where the
  // smaller file is written back, so a wrong one aims a write at the wrong
  // object. See storedPathFromUrl.
  const addressable: Candidate[] = [];
  const refusals = new Map<string, number>();
  for (const clip of clips) {
    const answer = storedPathFromUrl(clip.url, BUCKET);
    if ('refused' in answer) {
      refusals.set(answer.refused, (refusals.get(answer.refused) ?? 0) + 1);
      continue;
    }
    addressable.push({
      path: answer.path,
      userId:
        clip.post?.authorId ??
        clip.comment?.authorId ??
        clip.message?.senderId ??
        NOBODY,
    });
  }

  console.log(`  ${addressable.length} with a storage path this can act on`);
  for (const [why, count] of [...refusals].sort((a, b) => b[1] - a[1])) {
    console.log(`  ${count} skipped: ${why}`);
  }

  // Ones already accounted for, whatever came of them. Re-queueing a DONE
  // clip would re-encode an already re-encoded file.
  const seen = new Set(
    (
      await prisma.mediaJob.findMany({
        where: { path: { in: addressable.map((c) => c.path) } },
        select: { path: true },
      })
    ).map((job) => job.path),
  );
  const candidates = addressable.filter((c) => !seen.has(c.path));
  console.log(
    `  ${seen.size} already queued at some point, ` +
      `${candidates.length} never looked at`,
  );

  if (probe) {
    if (!transcode.isAvailable) {
      console.error(
        'ffprobe is not on this machine, so --probe can read nothing. Run it ' +
          'where ffmpeg is installed, or drop --probe.',
      );
      return 2;
    }

    console.log(`\n-- reading ${candidates.length} clip(s) --`);
    let over = 0;
    let within = 0;
    let unreadable = 0;
    let bytesOver = 0;

    for (const [index, clip] of candidates.entries()) {
      let bytes = 0;
      let shape: Awaited<ReturnType<TranscodeService['probe']>> = null;
      try {
        const file = await storage.downloadFile(clip.path);
        bytes = file.length;
        shape = await transcode.probe(file);
      } catch (error) {
        unreadable += 1;
        console.log(`  ?  ${clip.path}: ${String(error)}`);
        continue;
      }

      if (!shape) {
        unreadable += 1;
        console.log(`  ?  ${clip.path}: ffprobe would not read it`);
        continue;
      }

      if (TranscodeService.shouldReencode(shape)) {
        over += 1;
        bytesOver += bytes;
        const kbps =
          shape.bitrate === null ? '?' : Math.round(shape.bitrate / 1000);
        console.log(
          `  >  ${clip.path}: ${shape.height ?? '?'}p, ${kbps} kbps, ` +
            size(bytes),
        );
      } else {
        within += 1;
      }

      if ((index + 1) % 25 === 0) {
        console.log(`  ... ${index + 1}/${candidates.length}`);
      }
    }

    console.log(
      `\n${over} over the ceiling (${size(bytesOver)}), ` +
        `${within} already within it, ${unreadable} unreadable`,
    );
    if (over === 0 && unreadable === 0) {
      console.log(
        'Nothing read here needs it, so a backfill would be a no-op.',
      );
    }
  } else if (!commit) {
    // What can be said without downloading anything.
    const tall = clips.filter((c) => c.height !== null && c.height > 1280);
    const unknown = clips.filter((c) => c.height === null);
    console.log(
      `  ${tall.length} taller than 1280 by the stored height, ` +
        `${unknown.length} with no height recorded`,
    );
    console.log(
      '\nThat height is a floor rather than the answer: it cannot show a 720p',
    );
    console.log(
      'clip at 8 Mbps, which is over the bitrate ceiling and every bit as',
    );
    console.log('expensive to decode. Add --probe to read the files instead.');
  }

  if (!commit) {
    console.log(
      `\nNothing was changed. --commit would queue ${candidates.length} clip(s).`,
    );
    return 0;
  }

  let queued = 0;
  let missing = 0;
  for (const clip of candidates) {
    let bytes: number;
    try {
      // enqueue records what the original weighed, so the saving stays a
      // measurement rather than a claim.
      bytes = (await storage.downloadFile(clip.path)).length;
    } catch (error) {
      missing += 1;
      console.log(
        `  !  ${clip.path}: not readable, not queued (${String(error)})`,
      );
      continue;
    }

    await queue.enqueue({
      path: clip.path,
      userId: clip.userId,
      bytesIn: bytes,
    });
    queued += 1;
    if (queued % 25 === 0) {
      console.log(`  ... queued ${queued}/${candidates.length}`);
    }
  }

  const depth = await queue.depth();
  console.log(
    `\nQueued ${queued}${missing > 0 ? `, skipped ${missing} unreadable` : ''}. ` +
      `The queue holds ${depth.pending} pending and ${depth.failed} given up on.`,
  );
  console.log(
    'MediaWorker drains it one clip at a time, probing each before touching',
  );
  console.log(
    'it, so anything already inside the ceiling is recorded SKIPPED rather',
  );
  console.log('than re-encoded.');
  return 0;
}

main()
  .then((code) => process.exit(code))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
