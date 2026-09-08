/**
 * Checks the re-encode queue against a real Postgres.
 *
 * The claim is raw SQL -- `FOR UPDATE SKIP LOCKED`, an interval, an enum
 * comparison. A jest spec with a faked Prisma exercises none of that, and the
 * failures it would miss are the worst kind: two workers running the same
 * encode, or a job never picked up again after the process holding it died.
 *
 * This imports MediaQueue itself rather than restating its SQL, so it cannot
 * drift into checking a copy that no longer matches what ships.
 *
 * Not a jest spec because CI has no database. Run it against one by hand:
 *
 *   DATABASE_URL=postgresql://... npx ts-node scripts/check-media-queue.ts
 *
 * It writes and deletes rows under the `check/` path prefix, so point it at a
 * scratch database rather than at production.
 */
import { randomUUID } from 'node:crypto';
import { PrismaService } from '../src/infrastructure/prisma/prisma.service';
import { MediaQueue } from '../src/modules/media/media-queue.service';

const prisma = new PrismaService();
const queue = new MediaQueue(prisma);

let failures = 0;

function check(what: string, got: unknown, want: unknown): void {
  const ok = JSON.stringify(got) === JSON.stringify(want);
  if (!ok) failures += 1;
  console.log(
    `${ok ? 'ok  ' : 'FAIL'} ${what}` +
      (ok
        ? ''
        : `\n       wanted ${JSON.stringify(want)}, got ${JSON.stringify(got)}`),
  );
}

const clear = () =>
  prisma.mediaJob.deleteMany({ where: { path: { startsWith: 'check/' } } });

async function main(): Promise<void> {
  await clear();

  await queue.enqueue({
    path: 'check/first.mp4',
    userId: randomUUID(),
    bytesIn: 10,
  });
  await queue.enqueue({
    path: 'check/second.mp4',
    userId: randomUUID(),
    bytesIn: 20,
  });
  // enqueue stamps createdAt with now(), and the two land in the same
  // millisecond often enough to make "oldest first" a coin toss otherwise.
  await prisma.mediaJob.update({
    where: { path: 'check/first.mp4' },
    data: { createdAt: new Date(Date.now() - 60_000) },
  });

  const first = await queue.claim();
  check('claims the oldest job first', first?.path, 'check/first.mp4');
  check('marks it running', first?.status, 'RUNNING');
  check('counts the attempt', first?.attempts, 1);

  const second = await queue.claim();
  check(
    'does not hand the same job out twice',
    second?.path,
    'check/second.mp4',
  );

  check('answers nothing when the queue is empty', await queue.claim(), null);

  // A worker that died mid-encode leaves its job RUNNING forever. Backdating
  // the claim is what that looks like once it has gone stale.
  await prisma.mediaJob.update({
    where: { path: 'check/first.mp4' },
    data: {
      claimedAt: new Date(Date.now() - MediaQueue.staleAfterMs - 60_000),
    },
  });
  const reclaimed = await queue.claim();
  check(
    'picks up a job abandoned by a dead worker',
    reclaimed?.path,
    'check/first.mp4',
  );
  check('and counts that as a second attempt', reclaimed?.attempts, 2);

  // Re-uploading to the same path must queue the work once, not twice.
  await queue.enqueue({
    path: 'check/first.mp4',
    userId: randomUUID(),
    bytesIn: 10,
  });
  const rows = await prisma.mediaJob.count({
    where: { path: 'check/first.mp4' },
  });
  check('one clip is one job however often it is queued', rows, 1);

  // Two workers claiming at the same instant must not get the same row.
  await clear();
  await queue.enqueue({
    path: 'check/contended.mp4',
    userId: randomUUID(),
    bytesIn: 30,
  });

  const rival = new MediaQueue(new PrismaService());
  const [mine, theirs] = await Promise.all([queue.claim(), rival.claim()]);
  const winners = [mine, theirs].filter(Boolean);
  check('exactly one of two racing workers gets the job', winners.length, 1);

  await clear();
  await prisma.$disconnect();

  console.log(
    failures === 0 ? '\nall checks passed' : `\n${failures} check(s) failed`,
  );
  process.exit(failures === 0 ? 0 : 1);
}

main().catch(async (error) => {
  console.error(error);
  await prisma.$disconnect();
  process.exit(1);
});
