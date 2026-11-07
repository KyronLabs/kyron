import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { EnforcementService } from '../moderation/enforcement.service';
import { ModerationService } from '../moderation/moderation.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { FeedService } from './feed.service';
import { RankingService } from './ranking.service';

/**
 * Editing a post against a real Postgres: the window, the hashtags filed
 * again, and mentions told once. Skipped unless MODERATION_TEST_DATABASE_URL
 * names a migrated database (see docs/MODERATION.md), because CI has none.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('editing a post, against a real database', () => {
  let prisma: PrismaClient;
  let feed: FeedService;
  let delivery: RecordingDelivery;
  const stamp = Date.now();
  const [ada, ben, cy] = [0, 1, 2].map(() => randomUUID());
  const names = {
    [ada]: `ada${stamp}`,
    [ben]: `ben${stamp}`,
    [cy]: `cy${stamp}`,
  };

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    delivery = new RecordingDelivery();
    feed = new FeedService(
      prisma as PrismaService,
      new ModerationService(
        prisma as PrismaService,
        {} as unknown as EnforcementService,
      ),
      new RankingService(),
      delivery,
    );
    for (const id of [ada, ben, cy]) {
      await prisma.user.create({
        data: { id, username: names[id], email: `${names[id]}@example.test` },
      });
    }
  });

  afterAll(async () => {
    await prisma?.user.deleteMany({ where: { id: { in: [ada, ben, cy] } } });
    await prisma?.$disconnect();
  });

  it('changes the words and marks it edited, inside the window', async () => {
    const post = await feed.createPost(ada, {
      content: `first take #dawn with @${names[ben]}`,
    });
    const at = new Date(post.createdAt.getTime() + 5 * 60_000);

    const edited = await feed.editPost(
      ada,
      post.id,
      { content: `second take #dusk with @${names[cy]}` },
      at,
    );

    expect(edited.content).toBe(`second take #dusk with @${names[cy]}`);
    expect(edited.editedAt?.getTime()).toBe(at.getTime());
    // Filed under its new tag only.
    const tags = await prisma.postHashtag.findMany({
      where: { postId: post.id },
      select: { hashtag: { select: { tag: true } } },
    });
    expect(tags.map((t) => t.hashtag.tag)).toEqual(['dusk']);
    // Ben is no longer named; Cy is, and is told.
    const mentioned = await prisma.mention.findMany({
      where: { postId: post.id },
      select: { userId: true },
    });
    expect(mentioned.map((m) => m.userId)).toEqual([cy]);
  });

  it('tells nobody twice', async () => {
    const post = await feed.createPost(ada, {
      content: `hello @${names[ben]}`,
    });
    const before = await prisma.mention.count({ where: { postId: post.id } });
    await feed.editPost(ada, post.id, {
      content: `hello again @${names[ben]}`,
    });
    expect(await prisma.mention.count({ where: { postId: post.id } })).toBe(
      before,
    );
  });

  it('refuses after the window, and refuses anybody else', async () => {
    const post = await feed.createPost(ada, { content: 'settled' });
    const late = new Date(post.createdAt.getTime() + 16 * 60_000);

    await expect(
      feed.editPost(ada, post.id, { content: 'changed' }, late),
    ).rejects.toThrow('first 15 minutes');
    await expect(
      feed.editPost(ben, post.id, { content: 'mine now' }),
    ).rejects.toThrow('Post not found');
  });
});
