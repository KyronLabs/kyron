import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { EnforcementService } from '../moderation/enforcement.service';
import { ModerationService } from '../moderation/moderation.service';
import type { DeliveryService } from '../push/delivery.service';
import { FeedService } from './feed.service';
import { RankingService } from './ranking.service';

/**
 * For You against a real Postgres: the impressions statement, and paging a
 * ranking while the reader's own scrolling is being written underneath it.
 * Skipped unless MODERATION_TEST_DATABASE_URL names a migrated database (see
 * docs/MODERATION.md), because CI has none.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('For You, against a real database', () => {
  let prisma: PrismaClient;
  let feed: FeedService;

  const reader = randomUUID();
  const authors = Array.from({ length: 6 }, () => randomUUID());
  const posts: string[] = [];
  const stamp = Date.now();
  const DAY = 86_400_000;

  const row = (postId: string) =>
    prisma.postImpression.findUnique({
      where: { viewerId_postId: { viewerId: reader, postId } },
    });

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    feed = new FeedService(
      prisma as PrismaService,
      // Only its filters are read here, and they come from the database.
      new ModerationService(
        prisma as PrismaService,
        {} as unknown as EnforcementService,
      ),
      new RankingService(),
      { tell: () => undefined } as unknown as DeliveryService,
    );

    for (const id of [reader, ...authors]) {
      await prisma.user.create({
        data: { id, email: `${id}.${stamp}@example.test` },
      });
    }
    // Forty-five posts over two months: more than the fourteen days the pool
    // used to stop at, on a network as quiet as Kyron's.
    for (let i = 0; i < 45; i++) {
      const post = await prisma.post.create({
        data: {
          authorId: authors[i % authors.length],
          content: `post ${i}`,
          createdAt: new Date(Date.now() - i * 1.4 * DAY),
        },
      });
      posts.push(post.id);
    }
  });

  afterAll(async () => {
    await prisma?.post.deleteMany({ where: { id: { in: posts } } });
    await prisma?.user.deleteMany({
      where: { id: { in: [reader, ...authors] } },
    });
    await prisma?.$disconnect();
  });

  it('notes what was on screen, once per sitting', async () => {
    await feed.recordImpressions(reader, [posts[0], posts[0], posts[1]]);
    await feed.recordImpressions(reader, [posts[0]]);

    // Scrolling back up is the same sitting.
    expect(await row(posts[0])).toMatchObject({ count: 1, prevAt: null });
    expect(await row(posts[1])).toMatchObject({ count: 1 });
  });

  it('counts a later sitting, keeping when the last one was', async () => {
    const earlier = new Date(Date.now() - 3_600_000);
    await prisma.postImpression.update({
      where: { viewerId_postId: { viewerId: reader, postId: posts[0] } },
      data: { lastAt: earlier },
    });

    await feed.recordImpressions(reader, [posts[0]]);

    const after = await row(posts[0]);
    expect(after?.count).toBe(2);
    expect(after?.prevAt).toEqual(earlier);
    expect(after!.lastAt.getTime()).toBeGreaterThan(earlier.getTime());
  });

  it('skips an id that names no post rather than failing the batch', async () => {
    await expect(
      feed.recordImpressions(reader, [randomUUID(), posts[2]]),
    ).resolves.toBeUndefined();
    expect(await row(posts[2])).toMatchObject({ count: 1 });
  });

  it('reaches every post, not just the last fortnight', async () => {
    await prisma.postImpression.deleteMany({ where: { viewerId: reader } });
    const ids: string[] = [];
    let cursor: string | undefined;
    do {
      const page = await feed.listRecent(reader, 20, cursor);
      ids.push(...page.items.map((p) => p.id));
      cursor = page.nextCursor ?? undefined;
    } while (cursor);

    // Other specs share the database, and their posts are in the feed too.
    expect(new Set(ids.filter((id) => posts.includes(id)))).toEqual(
      new Set(posts),
    );
  });

  it('pages without repeats or gaps while the reader is being recorded', async () => {
    // What the app does: page one comes, its posts are reported as shown --
    // twice, as when two cards report together -- then page two is asked
    // for. Ranked live, page one's posts would drop down the order and page
    // two would skip whatever moved up past them.
    await prisma.postImpression.deleteMany({ where: { viewerId: reader } });
    // A history from earlier sessions, so there is something to undo wrongly.
    await feed.recordImpressions(reader, posts.slice(0, 15));
    await prisma.postImpression.updateMany({
      where: { viewerId: reader },
      data: { lastAt: new Date(Date.now() - 6 * 3_600_000) },
    });

    const ids: string[] = [];
    let cursor: string | undefined;
    do {
      const page = await feed.listRecent(reader, 20, cursor);
      const shown = page.items.map((p) => p.id);
      ids.push(...shown);
      await feed.recordImpressions(reader, shown);
      await feed.recordImpressions(reader, shown);
      cursor = page.nextCursor ?? undefined;
    } while (cursor);

    // No post twice, and none of these missing.
    expect(new Set(ids).size).toBe(ids.length);
    expect(new Set(ids.filter((id) => posts.includes(id)))).toEqual(
      new Set(posts),
    );
  });

  it('opens the next session on what the last one did not show', async () => {
    // The previous test has just shown all of them; show the newest ten
    // again, so they have been on screen in more sittings than the rest.
    const newest = new Set(posts.slice(0, 10));
    await prisma.postImpression.updateMany({
      where: { viewerId: reader, postId: { in: [...newest] } },
      data: { lastAt: new Date(Date.now() - 3_600_000), count: 4 },
    });
    await prisma.postImpression.deleteMany({
      where: { viewerId: reader, postId: { notIn: [...newest] } },
    });

    const page = await feed.listRecent(reader, 10);

    const repeats = page.items.filter((p) => newest.has(p.id));
    expect(repeats.length).toBeLessThanOrEqual(3);
  });
});
