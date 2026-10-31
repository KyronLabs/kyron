import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { FeedService } from '../feed/feed.service';
import { RankingService } from '../feed/ranking.service';
import type { EnforcementService } from '../moderation/enforcement.service';
import { ModerationService } from '../moderation/moderation.service';
import { NotificationsService } from '../notifications/notifications.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { GiftsService } from './gifts.service';

/**
 * Gifts against a real Postgres: the ledger, the lock, the refill. Skipped
 * unless MODERATION_TEST_DATABASE_URL names a migrated database (see
 * docs/MODERATION.md), because CI has none.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

const WEDNESDAY = new Date('2026-10-28T12:00:00Z');
const NEXT_TUESDAY = new Date('2026-11-03T12:00:00Z');

run('gifts, against a real database', () => {
  let prisma: PrismaClient;
  let gifts: GiftsService;
  let delivery: RecordingDelivery;

  const [ada, ben, cy] = [0, 1, 2].map(() => randomUUID());
  const stamp = Date.now();
  let post = '';

  const gift = (type: string, requestId = randomUUID()) => ({
    type,
    requestId,
  });

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    delivery = new RecordingDelivery();
    gifts = new GiftsService(prisma as PrismaService, delivery);
    for (const [id, name] of [
      [ada, 'Ada'],
      [ben, 'Ben'],
      [cy, 'Cy'],
    ]) {
      await prisma.user.create({
        data: { id, name, email: `${name}.${stamp}@example.test` },
      });
    }
    post = (
      await prisma.post.create({
        data: { authorId: ada, content: 'Something worth a gift' },
      })
    ).id;
  });

  afterAll(async () => {
    await prisma?.user.deleteMany({ where: { id: { in: [ada, ben, cy] } } });
    await prisma?.$disconnect();
  });

  it('fills a new wallet to 100 coins, once', async () => {
    const first = await gifts.wallet(ben, WEDNESDAY);
    const again = await gifts.wallet(ben, WEDNESDAY);

    expect(first).toMatchObject({ coins: 100, earned: 0, weeklyCoins: 100 });
    expect(again.coins).toBe(100);
    expect(
      await prisma.coinEntry.count({ where: { userId: ben, kind: 'GRANT' } }),
    ).toBe(1);
  });

  it('moves coins from sender to author, and tells the author', async () => {
    const sent = await gifts.send(ben, post, gift('fire'), WEDNESDAY);

    expect(sent.wallet.coins).toBe(95);
    expect(sent.gifts).toBe(1);
    expect((await gifts.wallet(ada, WEDNESDAY)).earned).toBe(5);
    expect(delivery.ofType('notification.new')).toContainEqual({
      type: 'notification.new',
      kind: 'gift',
      actorId: ben,
      postId: post,
    });
  });

  it('does not let earnings be spent', async () => {
    // Ada has 5 earned and her own 100 coins: earnings never join the coins.
    const wallet = await gifts.wallet(ada, WEDNESDAY);
    expect(wallet).toMatchObject({ coins: 100, earned: 5 });
  });

  it('treats a retried request as the same gift', async () => {
    const requestId = randomUUID();
    const once = await gifts.send(
      ben,
      post,
      gift('spark', requestId),
      WEDNESDAY,
    );
    const twice = await gifts.send(
      ben,
      post,
      gift('spark', requestId),
      WEDNESDAY,
    );

    expect(twice.gift.id).toBe(once.gift.id);
    expect(twice.wallet.coins).toBe(once.wallet.coins);
    expect(twice.gifts).toBe(once.gifts);
  });

  it('refuses to reuse a request for a different gift', async () => {
    const requestId = randomUUID();
    await gifts.send(ben, post, gift('spark', requestId), WEDNESDAY);
    await expect(
      gifts.send(ben, post, gift('fire', requestId), WEDNESDAY),
    ).rejects.toThrow('already used for a different gift');
  });

  it('never spends the same coins twice, however many gifts arrive at once', async () => {
    // Cy has 100. Ten crowns at once would be 500; two fit.
    //
    // Refilled first and on its own. Otherwise all ten race to write the
    // week's refill, nine lose on its unique key, and the test passes without
    // the lock it exists to prove -- which it did, until this line.
    expect((await gifts.wallet(cy, WEDNESDAY)).coins).toBe(100);
    const results = await Promise.allSettled(
      Array.from({ length: 10 }, () =>
        gifts.send(cy, post, gift('crown'), WEDNESDAY),
      ),
    );

    const sent = results.filter((r) => r.status === 'fulfilled');
    expect(sent).toHaveLength(2);
    expect((await gifts.wallet(cy, WEDNESDAY)).coins).toBe(0);
  });

  it('refuses a gift the wallet cannot cover, and says when it refills', async () => {
    await expect(
      gifts.send(cy, post, gift('spark'), WEDNESDAY),
    ).rejects.toThrow('Your coins refill every Monday.');
  });

  it('refills once the week turns: up to 100, not on top of what is left', async () => {
    expect((await gifts.wallet(cy, NEXT_TUESDAY)).coins).toBe(100);
    // Ben still had coins left; the refill tops him up rather than adding 100.
    expect((await gifts.wallet(ben, NEXT_TUESDAY)).coins).toBe(100);
  });

  it('refills a full wallet only once in a week, even after it spends', async () => {
    // Full at the start of the week, so the refill adds nothing -- and must
    // still count as this week's, or the next gift would trigger another.
    await gifts.wallet(cy, NEXT_TUESDAY);
    await gifts.send(cy, post, gift('gem'), NEXT_TUESDAY);
    expect((await gifts.wallet(cy, NEXT_TUESDAY)).coins).toBe(80);
  });

  it('counts each kind of gift a post was given', async () => {
    const summary = await gifts.summary(post, ben);
    const counted = Object.fromEntries(
      summary.byType.map((row) => [row.type, row.count]),
    );

    expect(counted).toEqual({ spark: 2, fire: 1, gem: 1, crown: 2 });
    expect(summary.total).toBe(6);
  });

  it('tells the author, on the notifications screen of an app that asked', async () => {
    const notifications = new NotificationsService(prisma as PrismaService);

    const asked = await notifications.list(ada, { gifts: true });
    const didNotAsk = await notifications.list(ada);

    expect(asked.items.filter((row) => row.kind === 'gift')).toHaveLength(6);
    expect(asked.items[0].gift).toMatchObject({ name: 'Gem', emoji: '💎' });
    expect(didNotAsk.items.some((row) => row.kind === 'gift')).toBe(false);
    expect(
      (await notifications.unreadCount(ada, { gifts: true })).count,
    ).toBeGreaterThanOrEqual(6);
  });

  it("tells each reader which gift they last sent a post, and nobody else's", async () => {
    const feed = new FeedService(
      prisma as PrismaService,
      new ModerationService(
        prisma as PrismaService,
        {} as unknown as EnforcementService,
      ),
      new RankingService(),
      delivery,
    );
    const [last] = await prisma.gift.findMany({
      where: { postId: post, senderId: ben },
      orderBy: { createdAt: 'desc' },
      take: 1,
    });

    expect((await feed.getPost(post, ben)).viewerGift).toBe(last.type);
    expect((await feed.getPost(post, cy)).viewerGift).toBe('gem');
    // The author has given it nothing; Cy's and Ben's gifts are theirs.
    expect((await feed.getPost(post, ada)).viewerGift).toBeNull();
  });

  it("shows the post's picture on its notification, and none for words alone", async () => {
    const notifications = new NotificationsService(prisma as PrismaService);
    const pictured = (
      await prisma.post.create({
        data: {
          authorId: ada,
          content: 'A kingfisher',
          media: {
            create: [
              {
                kind: 'IMAGE',
                url: 'https://cdn.test/second.jpg',
                position: 1,
              },
              { kind: 'IMAGE', url: 'https://cdn.test/first.jpg', position: 0 },
            ],
          },
        },
      })
    ).id;
    await gifts.send(ben, pictured, gift('rose'), NEXT_TUESDAY);

    const rows = (await notifications.list(ada, { gifts: true })).items;
    const onPicture = rows.find(
      (row) => row.kind === 'gift' && row.postId === pictured,
    );
    // The first picture by its position, not the first one stored.
    expect(onPicture?.postImage).toBe('https://cdn.test/first.jpg');
    expect(
      rows.find((row) => row.kind === 'gift' && row.postId === post)?.postImage,
    ).toBeNull();
  });

  it("keeps the author's earnings when a sender deletes their account", async () => {
    const before = (await gifts.wallet(ada, NEXT_TUESDAY)).earned;
    await prisma.user.delete({ where: { id: cy } });

    expect((await gifts.wallet(ada, NEXT_TUESDAY)).earned).toBe(before);
    expect(await prisma.gift.count({ where: { postId: post } })).toBe(6);

    // Their gifts stay counted, but there is nobody left to name in a row.
    const rows = await new NotificationsService(prisma as PrismaService).list(
      ada,
      { gifts: true },
    );
    const senders = rows.items
      .filter((row) => row.kind === 'gift')
      .map((row) => row.actor?.id);
    expect(senders).not.toContain(cy);
    // Ben's three on the first post, and his Rose on the pictured one.
    expect(senders).toHaveLength(4);
  });
});
