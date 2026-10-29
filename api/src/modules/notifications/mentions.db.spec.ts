import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { FeedService } from '../feed/feed.service';
import { RankingService } from '../feed/ranking.service';
import type { EnforcementService } from '../moderation/enforcement.service';
import { ModerationService } from '../moderation/moderation.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { NotificationsService } from './notifications.service';

/**
 * Mentions, from writing @handle to the bell, against a real Postgres.
 * Skipped unless MODERATION_TEST_DATABASE_URL names a migrated database (see
 * docs/MODERATION.md), because CI has none.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('mentions, against a real database', () => {
  let prisma: PrismaClient;
  let feed: FeedService;
  let notifications: NotificationsService;
  let delivery: RecordingDelivery;

  const stamp = Date.now().toString(36);
  const [writer, ada, bob, blocker] = [0, 1, 2, 3].map(() => randomUUID());
  const handle = (who: string) =>
    ({
      [writer]: `w_${stamp}`,
      [ada]: `ada_${stamp}`,
      [bob]: `bob_${stamp}`,
      [blocker]: `blk_${stamp}`,
    })[who];

  const mentionsOf = async (userId: string, mentions = true) =>
    (await notifications.list(userId, { mentions })).items.filter(
      (i) => i.kind === 'mention',
    );

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
    notifications = new NotificationsService(prisma as PrismaService);
    for (const id of [writer, ada, bob, blocker]) {
      await prisma.user.create({
        data: {
          id,
          email: `${id}@example.test`,
          username: handle(id),
          name: handle(id),
        },
      });
    }
    await prisma.block.create({
      data: { blockerId: blocker, blockedId: writer },
    });
  });

  afterAll(async () => {
    await prisma?.post.deleteMany({
      where: { authorId: { in: [writer, ada, bob, blocker] } },
    });
    await prisma?.block.deleteMany({ where: { blockerId: blocker } });
    await prisma?.user.deleteMany({
      where: { id: { in: [writer, ada, bob, blocker] } },
    });
    await prisma?.$disconnect();
  });

  it('tells somebody named in a post, with what was written', async () => {
    const post = await feed.createPost(writer, {
      content: `look at this @${handle(ada).toUpperCase()}`,
    });

    const rows = await mentionsOf(ada);
    expect(rows).toHaveLength(1);
    expect(rows[0]).toMatchObject({
      postId: post.id,
      actor: { id: writer },
      content: `look at this @${handle(ada).toUpperCase()}`,
      unread: true,
    });
    expect(
      delivery.activities.filter(
        (a) => a.userId === ada && a.activity.kind === 'mention',
      ),
    ).toHaveLength(1);
    expect(
      (await notifications.unreadCount(ada, { mentions: true })).count,
    ).toBeGreaterThanOrEqual(1);
  });

  it('is not shown to an app that did not ask, which would call it a like', async () => {
    expect(await mentionsOf(ada, false)).toHaveLength(0);
  });

  it('never tells the writer, nor anybody blocking them', async () => {
    await feed.createPost(writer, {
      content: `@${handle(writer)} @${handle(blocker)} hello`,
    });
    expect(await mentionsOf(writer)).toHaveLength(0);
    expect(await mentionsOf(blocker)).toHaveLength(0);
  });

  it('does not tell somebody twice about a reply to them', async () => {
    // Bob is told of the reply to his post; naming him in it is the same
    // news. Ada is named and told.
    const post = await feed.createPost(bob, { content: 'my post' });
    await feed.addComment(
      post.id,
      writer,
      `@${handle(bob)} agreed, and @${handle(ada)} too`,
    );

    expect(await mentionsOf(bob)).toHaveLength(0);
    const ada2 = (await mentionsOf(ada)).find((r) => r.postId === post.id);
    expect(ada2?.content).toContain('agreed');
  });

  it('goes when the post it was in is deleted', async () => {
    const post = await feed.createPost(writer, {
      content: `temporary @${handle(bob)}`,
    });
    expect((await mentionsOf(bob)).some((r) => r.postId === post.id)).toBe(
      true,
    );
    await prisma.post.update({
      where: { id: post.id },
      data: { deletedAt: new Date() },
    });
    expect((await mentionsOf(bob)).some((r) => r.postId === post.id)).toBe(
      false,
    );
  });
});
