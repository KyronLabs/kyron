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
 * Gifts against a real Postgres: the ledger, grandfathered balances and
 * wallet locks. Skipped unless MODERATION_TEST_DATABASE_URL names a migrated
 * database (see docs/MODERATION.md).
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

const WEDNESDAY = new Date('2026-10-28T12:00:00Z');
const NEXT_TUESDAY = new Date('2026-11-03T12:00:00Z');

run('gifts, against a real database', () => {
  let prisma: PrismaClient;
  let gifts: GiftsService;
  let delivery: RecordingDelivery;

  const [
    ada,
    ben,
    cy,
    newcomer,
    rewardSender,
    rewardCreator,
    purchaseSender,
    purchaseCreator,
  ] = Array.from({ length: 8 }, () => randomUUID());
  const stamp = Date.now();
  let post = '';

  const gift = (type: string, requestId = randomUUID()) => ({
    type,
    requestId,
  });

  const previousGiftFlag = process.env.CASH_EARNING_GIFTS_ENABLED;
  beforeAll(async () => {
    process.env.CASH_EARNING_GIFTS_ENABLED = 'true';
    prisma = new PrismaClient({ datasources: { db: { url } } });
    delivery = new RecordingDelivery();
    gifts = new GiftsService(prisma as PrismaService, delivery);
    for (const [id, name] of [
      [ada, 'Ada'],
      [ben, 'Ben'],
      [cy, 'Cy'],
      [newcomer, 'Newcomer'],
      [rewardSender, 'RewardSender'],
      [rewardCreator, 'RewardCreator'],
      [purchaseSender, 'PurchaseSender'],
      [purchaseCreator, 'PurchaseCreator'],
    ]) {
      await prisma.user.create({
        data: { id, name, email: `${name}.${stamp}@example.test` },
      });
    }
    // These balances model complimentary grants issued before the weekly
    // benefit was retired. New users do not receive a grant automatically.
    await prisma.coinEntry.createMany({
      data: [ada, ben, cy].map((userId) => ({
        userId,
        kind: 'GRANT' as const,
        amount: 100,
        key: `legacy-weekly-grant:${userId}`,
      })),
    });
    await prisma.coinEntry.create({
      data: {
        userId: rewardSender,
        kind: 'REWARD_GRANT',
        amount: 20,
        key: `reward-test:${stamp}`,
      },
    });
    post = (
      await prisma.post.create({
        data: { authorId: ada, content: 'Something worth a gift' },
      })
    ).id;
  });

  afterAll(async () => {
    if (previousGiftFlag === undefined)
      delete process.env.CASH_EARNING_GIFTS_ENABLED;
    else process.env.CASH_EARNING_GIFTS_ENABLED = previousGiftFlag;
    await prisma?.user.deleteMany({
      where: {
        id: {
          in: [
            ada,
            ben,
            cy,
            newcomer,
            rewardSender,
            rewardCreator,
            purchaseSender,
            purchaseCreator,
          ],
        },
      },
    });
    await prisma?.$disconnect();
  });

  it('does not issue automatic coins to a new wallet', async () => {
    const first = await gifts.wallet(newcomer, WEDNESDAY);
    const again = await gifts.wallet(newcomer, NEXT_TUESDAY);

    expect(first).toMatchObject({
      coins: 0,
      legacyComplimentary: 0,
      promotional: 0,
    });
    expect(again.coins).toBe(0);
    expect(
      await prisma.coinEntry.count({
        where: { userId: newcomer, kind: 'GRANT' },
      }),
    ).toBe(0);
  });

  it('preserves old complimentary balances without replenishing them', async () => {
    const first = await gifts.wallet(cy, WEDNESDAY);
    const afterWeek = await gifts.wallet(cy, NEXT_TUESDAY);

    expect(first).toMatchObject({ coins: 100, legacyComplimentary: 100 });
    expect(afterWeek).toMatchObject({ coins: 100, legacyComplimentary: 100 });
    expect(
      await prisma.coinEntry.count({
        where: { userId: cy, kind: 'GRANT' },
      }),
    ).toBe(1);
  });

  it('moves coins from sender to author, and tells the author', async () => {
    const sent = await gifts.send(ben, post, gift('fire'), WEDNESDAY);

    expect(sent.wallet.coins).toBe(85);
    expect(sent.gifts).toBe(1);
    expect((await gifts.wallet(ada, WEDNESDAY)).earned).toBe(15);
    expect((await gifts.wallet(ada, WEDNESDAY)).purchaseFundedEarned).toBe(0);
    expect((await gifts.wallet(ada, WEDNESDAY)).promotionalEarned).toBe(15);
    expect((await gifts.wallet(ada, WEDNESDAY)).withdrawableEarned).toBe(0);
    expect(delivery.ofType('notification.new')).toContainEqual({
      type: 'notification.new',
      kind: 'gift',
      actorId: ben,
      postId: post,
    });
  });

  it('materializes approved reward-funded proceeds as withdrawable earnings', async () => {
    const rewardPost = (
      await prisma.post.create({
        data: { authorId: rewardCreator, content: 'Reward-funded earnings' },
      })
    ).id;
    const sent = await gifts.send(rewardSender, rewardPost, gift('fire'));
    const earning = await prisma.creatorEarning.findUniqueOrThrow({
      where: {
        sourceCoinEntryKey: `gift:${sent.gift.id}:reward-earn`,
      },
    });

    expect(earning).toMatchObject({
      creatorId: rewardCreator,
      source: 'APPROVED_REWARD',
      amount: 15,
      withdrawable: true,
      giftId: sent.gift.id,
    });
    expect(await gifts.wallet(rewardCreator)).toMatchObject({
      rewardFundedEarned: 15,
      withdrawableEarned: 15,
    });
  });

  it('turns purchased coin spending into withdrawable purchase-funded creator proceeds', async () => {
    const purchasePost = (
      await prisma.post.create({
        data: { authorId: purchaseCreator, content: 'Purchased coin proceeds' },
      })
    ).id;
    const purchaseIds: string[] = [];
    for (const [index, amount] of [2, 28].entries()) {
      const key = `test-purchase-grant:${stamp}:${index}`;
      const createdAt = new Date(WEDNESDAY.getTime() + index);
      const purchase = await prisma.googlePlayPurchase.create({
        data: {
          userId: purchaseSender,
          purchaseTokenHash: randomUUID().replaceAll('-', '').repeat(2),
          encryptedToken: 'test-token',
          productId: 'test-coins',
          quantity: 1,
          coinAmount: amount,
          purchaseTime: createdAt,
          acknowledgementState: 1,
          coinEntryKey: key,
        },
      });
      purchaseIds.push(purchase.id);
      await prisma.coinEntry.create({
        data: {
          userId: purchaseSender,
          kind: 'PURCHASE_GRANT',
          amount,
          key,
          createdAt,
        },
      });
    }

    const request = gift('fire');
    const sent = await gifts.send(purchaseSender, purchasePost, request);
    const purchaseSpend = await prisma.coinEntry.findUniqueOrThrow({
      where: { key: `gift:${sent.gift.id}:purchase-spend` },
    });
    const purchaseEarn = await prisma.coinEntry.findUniqueOrThrow({
      where: { key: `gift:${sent.gift.id}:purchase-earn` },
    });
    const earning = await prisma.creatorEarning.findUniqueOrThrow({
      where: { sourceCoinEntryKey: purchaseEarn.key },
    });

    const allocation = await prisma.financialSourceRecord.findUniqueOrThrow({
      where: {
        sourceType_sourceId: {
          sourceType: 'GIFT_PURCHASE_SPEND_ALLOCATION',
          sourceId: sent.gift.id,
        },
      },
    });
    expect(allocation.payload).toEqual({
      allocations: [
        { purchaseId: purchaseIds[0], coins: 2 },
        { purchaseId: purchaseIds[1], coins: 13 },
      ],
      unattributedCoins: 0,
    });

    expect(sent.wallet).toMatchObject({
      coins: 15,
      purchased: 15,
      legacyComplimentary: 0,
      promotional: 0,
    });
    expect(purchaseSpend).toMatchObject({
      kind: 'PURCHASE_SPEND',
      amount: -15,
    });
    expect(purchaseEarn).toMatchObject({
      kind: 'PURCHASE_EARN',
      amount: 15,
    });
    expect(earning).toMatchObject({
      creatorId: purchaseCreator,
      source: 'PURCHASE',
      amount: 15,
      withdrawable: true,
      giftId: sent.gift.id,
    });
    expect(await gifts.wallet(purchaseCreator)).toMatchObject({
      purchaseFundedEarned: 15,
      withdrawableEarned: 15,
    });
    delete process.env.CASH_EARNING_GIFTS_ENABLED;
    try {
      expect(gifts.catalogue()).toEqual([]);
      await expect(
        gifts.send(purchaseSender, purchasePost, gift('fire')),
      ).rejects.toThrow('gifting is currently paused');
      const replay = await gifts.send(purchaseSender, purchasePost, request);
      expect(replay.gift.id).toBe(sent.gift.id);
      expect((await gifts.wallet(purchaseSender)).purchased).toBe(15);
      expect((await gifts.wallet(purchaseCreator)).purchaseFundedEarned).toBe(
        15,
      );
    } finally {
      process.env.CASH_EARNING_GIFTS_ENABLED = 'true';
    }
    const later = await gifts.send(purchaseSender, purchasePost, gift('fire'));
    const laterAllocation =
      await prisma.financialSourceRecord.findUniqueOrThrow({
        where: {
          sourceType_sourceId: {
            sourceType: 'GIFT_PURCHASE_SPEND_ALLOCATION',
            sourceId: later.gift.id,
          },
        },
      });
    expect(laterAllocation.payload).toEqual({
      allocations: [{ purchaseId: purchaseIds[1], coins: 15 }],
      unattributedCoins: 0,
    });
  });

  it('does not let earnings be spent', async () => {
    // Ada has 15 in gift proceeds and her own grandfathered 100 coins.
    const wallet = await gifts.wallet(ada, WEDNESDAY);
    expect(wallet).toMatchObject({
      coins: 100,
      legacyComplimentary: 100,
      earned: 15,
    });
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
    // Cy has 100 grandfathered coins. Ten crowns at once would be 500;
    // exactly two fit. The balance was seeded before the requests so the test
    // isolates the wallet lock, not coin issuance.
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

  it('refuses a gift the wallet cannot cover without promising a refill', async () => {
    await expect(
      gifts.send(cy, post, gift('spark'), WEDNESDAY),
    ).rejects.toThrow('wallet');
    expect((await gifts.wallet(cy, NEXT_TUESDAY)).coins).toBe(0);
  });

  it('does not increase grandfathered balances when a week turns', async () => {
    const before = (await gifts.wallet(ben, WEDNESDAY)).coins;
    const after = (await gifts.wallet(ben, NEXT_TUESDAY)).coins;
    expect(after).toBe(before);
    expect(
      await prisma.coinEntry.count({
        where: { userId: ben, kind: 'GRANT' },
      }),
    ).toBe(1);
  });

  it('lets an existing complimentary balance continue to fund gifts', async () => {
    const before = (await gifts.wallet(ben, NEXT_TUESDAY)).coins;
    expect(before).toBe(75);

    const sent = await gifts.send(ben, post, gift('gem'), NEXT_TUESDAY);
    expect(sent.wallet.coins).toBe(45);
  });

  it('counts each kind of gift a post was given', async () => {
    const summary = await gifts.summary(post, ben);
    const counted = Object.fromEntries(
      summary.byType.map((row) => [row.type, row.count]),
    );

    expect(counted).toEqual({ spark: 2, fire: 1, gem: 1, crown: 2 });
    expect(summary.total).toBe(6);
  });

  it('says who gave the post what, the biggest giver first', async () => {
    const { senders } = await gifts.summary(post, ben);
    const rows = await prisma.gift.findMany({
      where: { postId: post, commentId: null },
      select: { senderId: true, type: true, coins: true },
    });

    expect(senders.length).toBeGreaterThan(1);
    // Every sender once, with everything they sent and spent.
    expect(new Set(senders.map((s) => s.user.id))).toEqual(
      new Set(rows.map((r) => r.senderId)),
    );
    for (const sender of senders) {
      const theirs = rows.filter((r) => r.senderId === sender.user.id);
      expect(sender.coins).toBe(theirs.reduce((sum, r) => sum + r.coins, 0));
      expect(sender.gifts.reduce((sum, g) => sum + g.count, 0)).toBe(
        theirs.length,
      );
    }
    // Biggest giver first, and each one's gifts most valuable first.
    const spent = senders.map((s) => s.coins);
    expect(spent).toEqual([...spent].sort((a, b) => b - a));
    for (const sender of senders) {
      const prices = sender.gifts.map(
        (g) => rows.find((r) => r.type === g.type)!.coins,
      );
      expect(prices).toEqual([...prices].sort((a, b) => b - a));
    }
  });

  it('leaves out of the givers anybody the reader has blocked', async () => {
    const { senders: before } = await gifts.summary(post, ben);
    const other = before.find((s) => s.user.id !== ben)!.user.id;
    await prisma.block.create({ data: { blockerId: ben, blockedId: other } });
    try {
      const { senders } = await gifts.summary(post, ben);
      expect(senders.map((s) => s.user.id)).not.toContain(other);
      expect(senders.length).toBe(before.length - 1);
    } finally {
      await prisma.block.deleteMany({
        where: { blockerId: ben, blockedId: other },
      });
    }
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
    expect((await feed.getPost(post, cy)).viewerGift).toBe('crown');
    // The author has given it nothing; Cy's and Ben's gifts are theirs.
    expect((await feed.getPost(post, ada)).viewerGift).toBeNull();
  });

  it('keeps each kind it was sent once, and stacks the best on top', async () => {
    // spark, fire, gem and crown by now, some of them twice.
    const row = await prisma.post.findUniqueOrThrow({
      where: { id: post },
      select: { giftTypes: true, giftCount: true },
    });
    expect([...row.giftTypes].sort()).toEqual([
      'crown',
      'fire',
      'gem',
      'spark',
    ]);
    expect(row.giftCount).toBe(6);

    const feed = new FeedService(
      prisma as PrismaService,
      new ModerationService(
        prisma as PrismaService,
        {} as unknown as EnforcementService,
      ),
      new RankingService(),
      delivery,
    );
    // Everyone sees the stack, not only those who gave: most valuable first,
    // three at most.
    expect((await feed.getPost(post, ada)).topGifts).toEqual([
      'crown',
      'gem',
      'fire',
    ]);
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
    // Ben's four on the first post, and his Rose on the pictured one.
    expect(senders).toHaveLength(5);
  });

  describe('to a comment', () => {
    const feed = () =>
      new FeedService(
        prisma as PrismaService,
        new ModerationService(
          prisma as PrismaService,
          {} as unknown as EnforcementService,
        ),
        new RankingService(),
        delivery,
      );

    it("pays the comment's author, counts on the comment, and leaves the post's gifts alone", async () => {
      // Ben's reply under Ada's post; Ada sends it a gift.
      const reply = (
        await prisma.comment.create({
          data: { postId: post, authorId: ben, content: 'Lovely light' },
        })
      ).id;
      const postBefore = await prisma.post.findUniqueOrThrow({
        where: { id: post },
        select: { giftCount: true, giftTypes: true },
      });
      const earnedBefore = (await gifts.wallet(ben, NEXT_TUESDAY)).earned;
      const summaryBefore = await gifts.summary(post, ada);

      const sent = await gifts.sendToComment(
        ada,
        reply,
        gift('gem'),
        NEXT_TUESDAY,
      );

      expect(sent.gifts).toBe(1);
      expect((await gifts.wallet(ben, NEXT_TUESDAY)).earned).toBe(
        earnedBefore + 30,
      );
      expect(
        await prisma.comment.findUniqueOrThrow({
          where: { id: reply },
          select: { giftCount: true, giftTypes: true },
        }),
      ).toEqual({ giftCount: 1, giftTypes: ['gem'] });
      // The post is exactly as it was: count, kinds, and its own summary.
      expect(
        await prisma.post.findUniqueOrThrow({
          where: { id: post },
          select: { giftCount: true, giftTypes: true },
        }),
      ).toEqual(postBefore);
      expect(await gifts.summary(post, ada)).toEqual(summaryBefore);
      expect(delivery.ofType('notification.new')).toContainEqual({
        type: 'notification.new',
        kind: 'gift',
        actorId: ada,
        postId: post,
        commentId: reply,
      });

      // The thread shows it on the reply, and the reply's author is told
      // it was their reply.
      const page = await feed().listComments(post, ada);
      expect(page.items.find((c) => c.id === reply)).toMatchObject({
        gifts: 1,
        topGifts: ['gem'],
      });
      const rows = await new NotificationsService(prisma as PrismaService).list(
        ben,
        { gifts: true },
      );
      expect(rows.items.find((row) => row.kind === 'gift')).toMatchObject({
        content: 'Lovely light',
        gift: { type: 'gem', onComment: true },
      });
    });

    it('refuses a gift to your own comment, and a retry is the same gift', async () => {
      const mine = (
        await prisma.comment.create({
          data: { postId: post, authorId: ben, content: 'Mine' },
        })
      ).id;
      await expect(
        gifts.sendToComment(ben, mine, gift('spark'), NEXT_TUESDAY),
      ).rejects.toThrow('own comment');

      const requestId = randomUUID();
      const once = await gifts.sendToComment(
        ada,
        mine,
        gift('spark', requestId),
        NEXT_TUESDAY,
      );
      const twice = await gifts.sendToComment(
        ada,
        mine,
        gift('spark', requestId),
        NEXT_TUESDAY,
      );
      expect(twice.gift.id).toBe(once.gift.id);
      // The same request id may not move to another reply instead.
      const other = (
        await prisma.comment.create({
          data: { postId: post, authorId: ben, content: 'Another' },
        })
      ).id;
      await expect(
        gifts.sendToComment(ada, other, gift('spark', requestId), NEXT_TUESDAY),
      ).rejects.toThrow('already used for a different gift');
    });

    it('saves a comment for its reader only, and lists it with its post', async () => {
      const reply = (
        await prisma.comment.create({
          data: { postId: post, authorId: ben, content: 'Keep this one' },
        })
      ).id;
      const service = feed();

      await service.setCommentSaved(ada, reply, true);
      await service.setCommentSaved(ada, reply, true);

      const saved = await service.listSavedComments(ada);
      expect(saved.items.map((c) => c.id)).toEqual([reply]);
      expect(saved.items[0]).toMatchObject({
        saved: true,
        postId: post,
        onPost: { id: post, author: { id: ada } },
      });
      // Saves are private: Ben sees his reply unsaved, and has no list.
      const asBen = await service.listComments(post, ben);
      expect(asBen.items.find((c) => c.id === reply)?.saved).toBe(false);
      expect((await service.listSavedComments(ben)).items).toEqual([]);

      await service.setCommentSaved(ada, reply, false);
      expect((await service.listSavedComments(ada)).items).toEqual([]);
    });
  });
});
