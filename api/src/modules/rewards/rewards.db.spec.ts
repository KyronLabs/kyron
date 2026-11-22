import { randomUUID } from 'node:crypto';

import {
  CoinKind,
  PrismaClient,
  RewardProgramStatus,
  UserRole,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { nextRefill } from '../gifts/gift-catalogue';
import { RecordingDelivery } from '../push/delivery.test-double';
import { GiftsService } from '../gifts/gifts.service';
import { RewardsService } from './rewards.service';

/** Run against the migrated Postgres supplied by api-ci.yml. */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('post excellence rewards, against a real database', () => {
  let prisma: PrismaClient;
  let rewards: RewardsService;
  let gifts: GiftsService;
  let programId: string | undefined;

  const staffId = randomUUID();
  const authorId = randomUUID();
  const nominatorId = randomUUID();
  const stamp = Date.now();
  let nominatedPostId = '';
  let secondNominatedPostId = '';
  let recipientPostId = '';

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    rewards = new RewardsService(prisma as PrismaService);
    gifts = new GiftsService(
      prisma as PrismaService,
      new RecordingDelivery(),
    );

    await prisma.user.create({
      data: {
        id: staffId,
        name: 'Reward reviewer',
        email: `reward-staff-${stamp}@example.test`,
        role: UserRole.MODERATOR,
      },
    });
    await prisma.user.create({
      data: {
        id: authorId,
        name: 'Exceptional creator',
        email: `reward-author-${stamp}@example.test`,
      },
    });
    await prisma.user.create({
      data: {
        id: nominatorId,
        name: 'Nominator',
        email: `reward-nominator-${stamp}@example.test`,
      },
    });

    nominatedPostId = (
      await prisma.post.create({
        data: {
          authorId,
          content: 'An unusually thoughtful post that deserves human review.',
        },
      })
    ).id;
    secondNominatedPostId = (
      await prisma.post.create({
        data: {
          authorId,
          content: 'A second exceptional post reserved for the budget-cap test.',
        },
      })
    ).id;
    recipientPostId = (
      await prisma.post.create({
        data: {
          authorId: nominatorId,
          content: 'A different post to receive a test gift.',
        },
      })
    ).id;
  });

  afterAll(async () => {
    if (programId) {
      await prisma.postRewardAuditEvent.deleteMany({
        where: { programId },
      });
      await prisma.postRewardProgram.deleteMany({
        where: { id: programId },
      });
    }
    await prisma?.user.deleteMany({
      where: { id: { in: [staffId, authorId, nominatorId] } },
    });
    await prisma?.$disconnect();
  });

  it('requires review, grants once, and keeps promotional coins additive', async () => {
    const staff = { id: staffId, role: UserRole.MODERATOR };
    const now = new Date();
    const policy = {
      version: 1,
      nomination: {
        enabled: true,
        minPostAgeHours: 0,
        maxPostAgeDays: 30,
        maxPerUserPerDay: 3,
        allowSelfNomination: false,
      },
      limits: {
        maxAwardsPerPost: 1,
        maxAwardsPerCreatorPer30Days: 2,
        maxTotalPromotionalCoins: 50,
      },
      rewards: [{ type: 'PROMOTIONAL_COINS', amount: 50 }],
    };

    const program = await rewards.createProgram(staff, {
      key: `post-excellence-${stamp}`,
      name: 'Post Excellence Test',
      description: 'Integration-test programme.',
      policy,
    });
    programId = program.id;
    await rewards.updateProgram(staff, program.id, {
      status: RewardProgramStatus.ACTIVE,
    });

    const nomination = await rewards.nominate(
      nominatorId,
      program.id,
      {
        postId: nominatedPostId,
        reason:
          'This post contains original research and a genuinely useful explanation.',
      },
      now,
    );

    expect(nomination.status).toBe('PENDING');
    expect(
      await prisma.postRewardGrant.count({
        where: { nominationId: nomination.id },
      }),
    ).toBe(0);

    await expect(
      rewards.decide(
        { id: nominatorId, role: UserRole.MODERATOR },
        nomination.id,
        'APPROVE',
        'Attempted self-review.',
        now,
      ),
    ).rejects.toThrow('You cannot review a nomination you submitted.');

    const decision = await rewards.decide(
      staff,
      nomination.id,
      'APPROVE',
      'Reviewed by staff.',
      now,
    );
    expect(decision.nomination.status).toBe('APPROVED');
    expect(decision.grants).toHaveLength(1);

    const grant = decision.grants[0];
    expect(grant.rewardType).toBe('PROMOTIONAL_COINS');
    expect(
      await prisma.coinEntry.findUnique({
        where: { key: `reward:${grant.id}` },
        select: { kind: true, amount: true },
      }),
    ).toEqual({ kind: CoinKind.REWARD_GRANT, amount: 50 });

    await expect(
      rewards.decide(staff, nomination.id, 'APPROVE', 'Retry.', now),
    ).rejects.toThrow('already been decided');
    expect(
      await prisma.postRewardGrant.count({
        where: { nominationId: nomination.id },
      }),
    ).toBe(1);

    // The award is on top of, not in place of, the weekly 100-coin allowance.
    const wallet = await gifts.wallet(authorId, now);
    expect(wallet).toMatchObject({
      coins: 150,
      earned: 0,
      promotional: 50,
      weeklyCoins: 100,
    });

    // Gifts consume the weekly bucket first, then promotional reward credits.
    await gifts.send(
      authorId,
      recipientPostId,
      { type: 'rocket', requestId: randomUUID() },
      now,
    );
    const afterWeeklySpend = await gifts.wallet(authorId, now);
    expect(afterWeeklySpend).toMatchObject({
      coins: 50,
      promotional: 50,
    });

    await gifts.send(
      authorId,
      recipientPostId,
      { type: 'gem', requestId: randomUUID() },
      now,
    );
    const afterRewardSpend = await gifts.wallet(authorId, now);
    expect(afterRewardSpend).toMatchObject({
      coins: 30,
      promotional: 30,
    });

    // Free or reward-credit spending creates non-cashable proceeds for the
    // recipient; it must never land in the purchase-funded earnings bucket.
    await prisma.coinEntry.createMany({
      data: [
        {
          userId: nominatorId,
          kind: CoinKind.EARN,
          amount: 7,
          key: `legacy-test-earnings:${stamp}`,
        },
        {
          userId: nominatorId,
          kind: CoinKind.PURCHASE_EARN,
          amount: 10,
          key: `verified-purchase-earnings:${stamp}`,
        },
      ],
    });
    const recipientWallet = await gifts.wallet(nominatorId, now);
    expect(recipientWallet.earned).toBe(137);
    expect(recipientWallet.purchaseFundedEarned).toBe(10);
    expect(recipientWallet.promotionalEarned).toBe(120);

    // A later nomination keeps its original policy snapshot, but cannot
    // exceed the programme's current shared budget after the first award.
    const pendingSecond = await rewards.nominate(
      nominatorId,
      program.id,
      {
        postId: secondNominatedPostId,
        reason:
          'This second post is also excellent, but the programme budget is spent.',
      },
      now,
    );
    await expect(
      rewards.decide(staff, pendingSecond.id, 'APPROVE', 'Over budget.', now),
    ).rejects.toThrow('programme has reached its promotional coin budget');
    expect(
      (
        await prisma.postRewardNomination.findUnique({
          where: { id: pendingSecond.id },
          select: { status: true },
        })
      )?.status,
    ).toBe('PENDING');

    // The next refill restores the weekly bucket without consuming or capping
    // the promotional balance.
    const nextWeek = nextRefill(now);
    const nextWallet = await gifts.wallet(authorId, nextWeek);
    expect(nextWallet).toMatchObject({
      coins: 130,
      promotional: 30,
      weeklyCoins: 100,
    });
  });

  it('does not allow an author to nominate their own post', async () => {
    const staff = { id: staffId, role: UserRole.MODERATOR };
    const program = await rewards.createProgram(staff, {
      key: `self-nomination-${stamp}`,
      name: 'Self nomination test',
      policy: {
        version: 1,
        nomination: {
          enabled: true,
          minPostAgeHours: 0,
          maxPostAgeDays: 30,
          maxPerUserPerDay: 3,
          allowSelfNomination: false,
        },
        limits: {
          maxAwardsPerPost: 1,
          maxAwardsPerCreatorPer30Days: 2,
          maxTotalPromotionalCoins: 1000,
        },
        rewards: [{ type: 'PROMOTIONAL_COINS', amount: 10 }],
      },
    });
    try {
      await rewards.updateProgram(staff, program.id, {
        status: RewardProgramStatus.ACTIVE,
      });
      await expect(
        rewards.nominate(authorId, program.id, {
          postId: nominatedPostId,
          reason:
            'I believe my own post is exceptional and should receive this reward.',
        }),
      ).rejects.toThrow('cannot nominate your own post');
    } finally {
      await prisma.postRewardAuditEvent.deleteMany({
        where: { programId: program.id },
      });
      await prisma.postRewardProgram.delete({ where: { id: program.id } });
    }
  });
});
