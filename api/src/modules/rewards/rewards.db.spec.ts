import { randomUUID } from 'node:crypto';

import {
  CoinKind,
  PrismaClient,
  RewardProgramStatus,
  UserRole,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
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
    gifts = new GiftsService(prisma as PrismaService, new RecordingDelivery());

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
        name: 'Nominator and moderator',
        email: `reward-nominator-${stamp}@example.test`,
        role: UserRole.MODERATOR,
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
          content:
            'A second exceptional post reserved for the budget-cap test.',
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
        maxTotalPromotionalCoins: 100,
      },
      rewards: [{ type: 'PROMOTIONAL_COINS', amount: 100 }],
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
    ).toEqual({ kind: CoinKind.REWARD_GRANT, amount: 100 });

    await expect(
      rewards.decide(staff, nomination.id, 'APPROVE', 'Retry.', now),
    ).rejects.toThrow('already been decided');
    expect(
      await prisma.postRewardGrant.count({
        where: { nominationId: nomination.id },
      }),
    ).toBe(1);

    // New accounts receive no automatic complimentary grant. Seed five
    // grandfathered weekly coins to prove a mixed-source gift is split in
    // the ledger, while reward-funded proceeds remain withdrawable.
    await prisma.coinEntry.create({
      data: {
        userId: authorId,
        kind: CoinKind.GRANT,
        amount: 5,
        key: `legacy-weekly-balance:${stamp}`,
      },
    });
    const wallet = await gifts.wallet(authorId, now);
    expect(wallet).toMatchObject({
      coins: 100,
      legacyComplimentary: 0,
      earned: 0,
      promotional: 100,
    });

    // Legacy complimentary credits are spent first, then reward credits.
    await gifts.send(
      authorId,
      recipientPostId,
      { type: 'rocket', requestId: randomUUID() },
      now,
    );
    const afterRewardSpend = await gifts.wallet(authorId, now);
    expect(afterRewardSpend).toMatchObject({
      coins: 0,
      legacyComplimentary: 0,
      promotional: 0,
    });

    // Reward-funded creator proceeds are withdrawable just like proceeds from
    // purchased-coin spending. Only the five legacy weekly coins remain
    // classified as non-withdrawable historical promotional proceeds.
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
    expect(recipientWallet.earned).toBe(110);
    expect(recipientWallet.withdrawableEarned).toBe(110);
    expect(recipientWallet.purchaseFundedEarned).toBe(10);
    expect(recipientWallet.rewardFundedEarned).toBe(100);
    expect(recipientWallet.promotionalEarned).toBe(0);

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

    // Time passing does not create new complimentary coins or consume the
    // five reward coins left after the mixed-source gift.
    const laterWallet = await gifts.wallet(
      authorId,
      new Date(now.getTime() + 8 * 24 * 60 * 60 * 1000),
    );
    expect(laterWallet).toMatchObject({
      coins: 0,
      legacyComplimentary: 0,
      promotional: 0,
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
