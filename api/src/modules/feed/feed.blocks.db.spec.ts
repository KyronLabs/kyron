import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { EnforcementService } from '../moderation/enforcement.service';
import { ModerationService } from '../moderation/moderation.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { FeedService } from './feed.service';
import { RankingService } from './ranking.service';

/**
 * Hiding and blocking against a real Postgres, because both turned on what
 * SQL does with null and with rows a mock would not have. Skipped unless
 * MODERATION_TEST_DATABASE_URL names a migrated database.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('hidden posts and blocks, against a real database', () => {
  let prisma: PrismaClient;
  let feed: FeedService;
  let moderation: ModerationService;
  let delivery: RecordingDelivery;
  const stamp = Date.now();
  const [ada, ben, cy] = [0, 1, 2].map(() => randomUUID());
  const names = {
    [ada]: `adab${stamp}`,
    [ben]: `benb${stamp}`,
    [cy]: `cyb${stamp}`,
  };

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    delivery = new RecordingDelivery();
    moderation = new ModerationService(
      prisma as PrismaService,
      {} as unknown as EnforcementService,
    );
    feed = new FeedService(
      prisma as PrismaService,
      moderation,
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

  it('hiding one post leaves an ordinary post in the feed', async () => {
    const hidden = await feed.createPost(ada, { content: 'hide me' });
    const plain = await feed.createPost(ada, { content: 'quotes nothing' });
    const quote = await feed.createPost(ada, {
      content: 'quoting the hidden one',
      quotedPostId: hidden.id,
    });
    await moderation.setHidden(cy, hidden.id, true);

    const where = await feed.visibleWhere({ authorId: ada }, cy);
    const ids = (
      await prisma.post.findMany({ where, select: { id: true } })
    ).map((post) => post.id);

    expect(ids).toContain(plain.id);
    expect(ids).not.toContain(hidden.id);
    expect(ids).not.toContain(quote.id);
  });

  it('a blocked account cannot like, repost, save or quote', async () => {
    const post = await feed.createPost(ada, { content: 'mine' });
    await moderation.setBlocked(ada, ben, true);

    await expect(feed.setLiked(ben, post.id, true)).rejects.toThrow(
      'Post not found.',
    );
    await expect(feed.setReposted(ben, post.id, true)).rejects.toThrow(
      'Post not found.',
    );
    await expect(feed.setSaved(ben, post.id, true)).rejects.toThrow(
      'Post not found.',
    );
    await expect(
      feed.createPost(ben, { content: 'look at this', quotedPostId: post.id }),
    ).rejects.toThrow('Post not found.');

    const after = await prisma.post.findUniqueOrThrow({
      where: { id: post.id },
      select: { likeCount: true, repostCount: true },
    });
    expect(after).toEqual({ likeCount: 0, repostCount: 0 });
    // Somebody not involved in the block is unaffected.
    await expect(feed.setLiked(cy, post.id, true)).resolves.toMatchObject({
      liked: true,
    });
  });

  it('cannot answer a comment by somebody who blocked them', async () => {
    const post = await feed.createPost(cy, { content: 'a third person' });
    const comment = await feed.addComment(post.id, ada, 'ada says');

    await expect(
      feed.addComment(post.id, ben, 'ben answers', comment.id),
    ).rejects.toThrow('Comment not found.');
  });

  it('refuses the muted word past the ceiling', async () => {
    await prisma.mute.createMany({
      data: Array.from({ length: ModerationService.maxMutes.WORD }, (_, i) => ({
        userId: cy,
        kind: 'WORD' as const,
        phrase: `word${i}`,
      })),
    });
    await expect(moderation.mutePhrase(cy, 'one more', true)).rejects.toThrow(
      /as many/,
    );
    // Muting one already muted is not a new one.
    await expect(moderation.mutePhrase(cy, 'word3', true)).resolves.toEqual({
      muted: true,
    });
  });
});
