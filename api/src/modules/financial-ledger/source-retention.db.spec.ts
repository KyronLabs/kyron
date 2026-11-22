import { randomUUID } from 'node:crypto';

import {
  PrismaClient,
  RewardProgramStatus,
  UserRole,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { GiftsService } from '../gifts/gifts.service';
import { RewardsService } from '../rewards/rewards.service';
import { RecordingDelivery } from '../push/delivery.test-double';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

/**
 * Financial source snapshots must survive hard deletion of every social or
 * identity record that originally owned the event. These are real Postgres
 * tests because FK cascades and immutability triggers are the behavior under
 * test. Snapshot rows intentionally remain as test evidence.
 */
run('financial source retention, against a real database', () => {
  let prisma: PrismaClient;
  let gifts: GiftsService;
  let rewards: RewardsService;

  const staffId = randomUUID();
  const nominatorId = randomUUID();
  const giftSenderId = randomUUID();
  const commentAuthorId = randomUUID();
  const recipientAId = randomUUID();
  const recipientBId = randomUUID();
  const stamp = randomUUID();

  let postAId = '';
  let postBId = '';
  let commentId = '';
  let giftPostId = '';
  let giftCommentId = '';
  let grantAId = '';
  let grantBId = '';
  let programId = '';

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    gifts = new GiftsService(prisma as PrismaService, new RecordingDelivery());
    rewards = new RewardsService(prisma as PrismaService);

    for (const [id, name, role] of [
      [staffId, 'Retention Staff', UserRole.MODERATOR],
      [nominatorId, 'Retention Nominator', UserRole.USER],
      [giftSenderId, 'Retention Sender', UserRole.USER],
      [commentAuthorId, 'Retention Comment Author', UserRole.USER],
      [recipientAId, 'Retention Recipient A', UserRole.USER],
      [recipientBId, 'Retention Recipient B', UserRole.USER],
    ] as const) {
      await prisma.user.create({
        data: {
          id,
          name,
          role,
          email: `retention-${name.toLowerCase().replaceAll(' ', '-')}-${stamp}@example.test`,
        },
      });
    }

    await prisma.coinEntry.create({
      data: {
        userId: giftSenderId,
        kind: 'GRANT',
        amount: 100,
        key: `retention-wallet:${stamp}`,
      },
    });

    postAId = (
      await prisma.post.create({
        data: { authorId: recipientAId, content: 'Retention post A' },
      })
    ).id;
    postBId = (
      await prisma.post.create({
        data: { authorId: recipientBId, content: 'Retention post B' },
      })
    ).id;
    commentId = (
      await prisma.comment.create({
        data: {
          postId: postBId,
          authorId: commentAuthorId,
          content: 'Retention comment',
        },
      })
    ).id;

    giftPostId = (
      await gifts.send(giftSenderId, postAId, {
        type: 'spark',
        requestId: randomUUID(),
      })
    ).gift.id;
    giftCommentId = (
      await gifts.sendToComment(giftSenderId, commentId, {
        type: 'fire',
        requestId: randomUUID(),
      })
    ).gift.id;

    const policy = {
      version: 1,
      nomination: {
        enabled: true,
        minPostAgeHours: 0,
        maxPostAgeDays: 30,
        maxPerUserPerDay: 5,
        allowSelfNomination: false,
      },
      limits: {
        maxAwardsPerPost: 1,
        maxAwardsPerCreatorPer30Days: 2,
        maxTotalPromotionalCoins: 1000,
      },
      rewards: [{ type: 'PROMOTIONAL_COINS', amount: 12 }],
    };

    const program = await rewards.createProgram(
      { id: staffId, role: UserRole.MODERATOR },
      {
        key: `retention-${stamp}`,
        name: 'Retention test programme',
        policy,
      },
    );
    programId = program.id;
    await rewards.updateProgram(
      { id: staffId, role: UserRole.MODERATOR },
      programId,
      { status: RewardProgramStatus.ACTIVE },
    );

    const nominationA = await rewards.nominate(nominatorId, programId, {
      postId: postAId,
      reason: 'Temporary nomination reason A',
    });
    const nominationB = await rewards.nominate(nominatorId, programId, {
      postId: postBId,
      reason: 'Temporary nomination reason B',
    });

    const decisionA = await rewards.decide(
      { id: staffId, role: UserRole.MODERATOR },
      nominationA.id,
      'APPROVE',
    );
    const decisionB = await rewards.decide(
      { id: staffId, role: UserRole.MODERATOR },
      nominationB.id,
      'APPROVE',
    );
    grantAId = decisionA.grants[0].id;
    grantBId = decisionB.grants[0].id;
  });

  afterAll(async () => {
    if (programId) {
      await prisma?.postRewardProgram.deleteMany({
        where: { id: programId },
      });
    }
    await prisma?.user.deleteMany({
      where: {
        id: {
          in: [staffId, nominatorId, giftSenderId, commentAuthorId, recipientBId],
        },
      },
    });
    await prisma?.$disconnect();
  });

  it('retains complete source snapshots after social and identity cascades', async () => {
    const giftPostSource = await prisma.financialSourceRecord.findUniqueOrThrow({
      where: {
        sourceType_sourceId: { sourceType: 'GIFT', sourceId: giftPostId },
      },
    });
    expect(giftPostSource).toMatchObject({
      eventType: 'GIFT_SENT',
      actorId: giftSenderId,
      beneficiaryId: recipientAId,
      amount: 5,
      unitCode: 'COIN',
      relatedIds: { postId: postAId, commentId: null },
      payload: { type: 'spark', coins: 5 },
    });

    const giftCommentSource =
      await prisma.financialSourceRecord.findUniqueOrThrow({
        where: {
          sourceType_sourceId: {
            sourceType: 'GIFT',
            sourceId: giftCommentId,
          },
        },
      });
    expect(giftCommentSource).toMatchObject({
      beneficiaryId: commentAuthorId,
      relatedIds: { postId: postBId, commentId },
      payload: { type: 'fire', coins: 5 },
    });

    const rewardSourceA =
      await prisma.financialSourceRecord.findUniqueOrThrow({
        where: {
          sourceType_sourceId: {
            sourceType: 'POST_REWARD_GRANT',
            sourceId: grantAId,
          },
        },
      });
    expect(rewardSourceA).toMatchObject({
      eventType: 'REWARD_GRANTED',
      actorId: staffId,
      beneficiaryId: recipientAId,
      amount: 12,
      unitCode: 'COIN',
      relatedIds: {
        programId,
        nominationId: expect.any(String),
        postId: postAId,
      },
      payload: {
        rewardType: 'PROMOTIONAL_COINS',
        rewardPayload: { amount: 12 },
      },
    });

    // A hard comment delete cascades through Gift; the source snapshot has
    // no relation to that comment or its parent post.
    await prisma.comment.delete({ where: { id: commentId } });
    await expect(
      prisma.gift.findUnique({ where: { id: giftCommentId } }),
    ).resolves.toBeNull();
    await expect(
      prisma.financialSourceRecord.findUnique({
        where: {
          sourceType_sourceId: {
            sourceType: 'GIFT',
            sourceId: giftCommentId,
          },
        },
      }),
    ).resolves.toMatchObject({ beneficiaryId: commentAuthorId });

    // Deleting the recipient hard-deletes their post, gift and reward grant.
    // CoinEntry and FinancialSourceRecord are deliberately independent.
    await prisma.user.delete({ where: { id: recipientAId } });
    await expect(
      prisma.gift.findUnique({ where: { id: giftPostId } }),
    ).resolves.toBeNull();
    await expect(
      prisma.postRewardGrant.findUnique({ where: { id: grantAId } }),
    ).resolves.toBeNull();
    await expect(
      prisma.financialSourceRecord.findUnique({
        where: {
          sourceType_sourceId: {
            sourceType: 'GIFT',
            sourceId: giftPostId,
          },
        },
      }),
    ).resolves.toMatchObject({
      actorId: giftSenderId,
      beneficiaryId: recipientAId,
      relatedIds: { postId: postAId, commentId: null },
    });
    await expect(
      prisma.financialSourceRecord.findUnique({
        where: {
          sourceType_sourceId: {
            sourceType: 'POST_REWARD_GRANT',
            sourceId: grantAId,
          },
        },
      }),
    ).resolves.toMatchObject({
      beneficiaryId: recipientAId,
      relatedIds: { programId, postId: postAId },
      payload: { rewardPayload: { amount: 12 } },
    });

    // Deleting a programme cascades through its nominations and grants.
    await prisma.postRewardProgram.delete({ where: { id: programId } });
    await expect(
      prisma.postRewardGrant.findUnique({ where: { id: grantBId } }),
    ).resolves.toBeNull();
    await expect(
      prisma.financialSourceRecord.findUnique({
        where: {
          sourceType_sourceId: {
            sourceType: 'POST_REWARD_GRANT',
            sourceId: grantBId,
          },
        },
      }),
    ).resolves.toMatchObject({
      beneficiaryId: recipientBId,
      relatedIds: { programId, postId: postBId },
      payload: { rewardPayload: { amount: 12 } },
    });

    // The evidence store itself rejects mutation and deletion.
    await expect(
      prisma.financialSourceRecord.update({
        where: {
          sourceType_sourceId: {
            sourceType: 'GIFT',
            sourceId: giftPostId,
          },
        },
        data: { eventType: 'REWRITTEN' },
      }),
    ).rejects.toThrow();
    await expect(
      prisma.financialSourceRecord.delete({
        where: {
          sourceType_sourceId: {
            sourceType: 'GIFT',
            sourceId: giftPostId,
          },
        },
      }),
    ).rejects.toThrow();
  });
});
