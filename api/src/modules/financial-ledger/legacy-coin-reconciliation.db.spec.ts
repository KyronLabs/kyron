import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { LegacyCoinReconciliationService } from './legacy-coin-reconciliation.service';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('legacy coin reconciliation, against a real database', () => {
  let prisma: PrismaClient;
  let reconciliation: LegacyCoinReconciliationService;

  const senderId = randomUUID();
  const creatorId = randomUUID();
  const giftId = randomUUID();
  const rewardGiftId = randomUUID();
  const rewardGrantId = randomUUID();
  const missingGiftId = randomUUID();
  const stamp = randomUUID();

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    reconciliation = new LegacyCoinReconciliationService(
      prisma as PrismaService,
    );

    await prisma.coinEntry.createMany({
      data: [
        {
          userId: senderId,
          kind: 'GRANT',
          amount: 20,
          key: `legacy-grant:${stamp}`,
        },
        {
          userId: senderId,
          kind: 'SPEND',
          amount: -5,
          key: `gift:${giftId}:legacy-spend`,
        },
        {
          userId: creatorId,
          kind: 'PROMOTIONAL_EARN',
          amount: 5,
          key: `gift:${giftId}:legacy-earn`,
        },
        {
          userId: senderId,
          kind: 'REWARD_GRANT',
          amount: 10,
          key: `reward:${rewardGrantId}`,
        },
        {
          userId: senderId,
          kind: 'REWARD_SPEND',
          amount: -10,
          key: `gift:${rewardGiftId}:reward-spend`,
        },
        {
          userId: creatorId,
          kind: 'REWARD_EARN',
          amount: 10,
          key: `gift:${rewardGiftId}:reward-earn`,
        },
        {
          userId: creatorId,
          kind: 'EARN',
          amount: 3,
          key: `legacy-unknown-earn:${stamp}`,
        },
      ],
    });

    await prisma.financialSourceRecord.createMany({
      data: [
        {
          sourceType: 'GIFT',
          sourceId: giftId,
          eventType: 'GIFT_SENT',
          actorId: senderId,
          beneficiaryId: creatorId,
          relatedIds: {},
          amount: 5,
          unitCode: 'COIN',
          payload: { type: 'fire', coins: 5 },
          occurredAt: new Date('2026-10-01T12:00:00.000Z'),
        },
        {
          sourceType: 'GIFT',
          sourceId: rewardGiftId,
          eventType: 'GIFT_SENT',
          actorId: senderId,
          beneficiaryId: creatorId,
          relatedIds: {},
          amount: 10,
          unitCode: 'COIN',
          payload: { type: 'star', coins: 10 },
          occurredAt: new Date('2026-10-02T12:00:00.000Z'),
        },
        {
          sourceType: 'POST_REWARD_GRANT',
          sourceId: rewardGrantId,
          eventType: 'REWARD_GRANTED',
          actorId: null,
          beneficiaryId: senderId,
          relatedIds: {},
          amount: 10,
          unitCode: 'COIN',
          payload: {
            rewardType: 'PROMOTIONAL_COINS',
            rewardPayload: { amount: 10 },
          },
          occurredAt: new Date('2026-10-03T12:00:00.000Z'),
        },
      ],
    });
  });

  afterAll(async () => {
    await prisma?.$disconnect();
  });

  it('reconciles every supported kind and keeps its eligibility classification', async () => {
    const beforeCoinEntries = await prisma.coinEntry.count();
    const beforeAccounts = await prisma.ledgerAccount.count();
    const beforeTransactions = await prisma.ledgerTransaction.count();
    const beforePostings = await prisma.ledgerPosting.count();
    const report = await reconciliation.dryRun({
      pageSize: 2,
      includeUserBalances: true,
      userIds: [senderId, creatorId],
    });

    expect(report).toMatchObject({
      mode: 'DRY_RUN',
      readOnly: true,
      scope: 'SELECTED_USERS',
      mutationCount: 0,
      summary: {
        coinEntries: 7,
        users: 2,
        mappedEntries: 7,
        unmappedEntries: 0,
        zeroAmountEntries: 0,
        eligibleTransactions: 7,
        alreadyImportedEntries: 0,
        newTransactions: 7,
        debitTotal: '63',
        creditTotal: '63',
      },
    });
    expect(report.summary.issues.blockers).toBe(0);
    expect(report.summary.issues.byCode.UNKNOWN_PROVENANCE_EARN).toBe(1);

    expect(report.userBalances).toEqual(
      expect.arrayContaining([
        {
          userId: senderId,
          buckets: {
            LEGACY_COMPLIMENTARY: '15',
            REWARD_PROMOTIONAL: '0',
            CREATOR_PAYABLE: '0',
            CREATOR_PROMOTIONAL: '0',
            CREATOR_UNKNOWN: '0',
          },
        },
        {
          userId: creatorId,
          buckets: {
            LEGACY_COMPLIMENTARY: '0',
            REWARD_PROMOTIONAL: '0',
            CREATOR_PAYABLE: '10',
            CREATOR_PROMOTIONAL: '5',
            CREATOR_UNKNOWN: '3',
          },
        },
      ]),
    );

    expect(await prisma.coinEntry.count()).toBe(beforeCoinEntries);
    expect(await prisma.ledgerAccount.count()).toBe(beforeAccounts);
    expect(await prisma.ledgerTransaction.count()).toBe(beforeTransactions);
    expect(await prisma.ledgerPosting.count()).toBe(beforePostings);
  });

  it('blocks a gift spend when its immutable source snapshot is missing', async () => {
    await prisma.coinEntry.create({
      data: {
        userId: senderId,
        kind: 'SPEND',
        amount: -1,
        key: `gift:${missingGiftId}:legacy-spend`,
      },
    });

    const report = await reconciliation.dryRun({
      pageSize: 3,
      userIds: [senderId, creatorId],
    });

    expect(report.summary.issues.blockers).toBeGreaterThan(0);
    expect(report.summary.issues.byCode.MISSING_GIFT_SNAPSHOT).toBe(1);
  });

  it('blocks an existing import whose postings do not match the deterministic plan', async () => {
    const source = await prisma.coinEntry.findFirstOrThrow({
      where: { key: `legacy-grant:${stamp}` },
    });
    const wrongAccountKey = `TEST_MISMATCH:${stamp}:wrong-owner-bucket`;
    const offsetAccountKey = `TEST_MISMATCH:${stamp}:offset`;

    await prisma.$transaction(async (tx) => {
      await tx.ledgerAccount.createMany({
        data: [
          {
            accountKey: wrongAccountKey,
            name: 'Incorrect legacy coin bucket',
            accountType: 'LIABILITY',
            normalSide: 'CREDIT',
            currencyCode: 'KCOIN',
            ownerId: senderId,
          },
          {
            accountKey: offsetAccountKey,
            name: 'Legacy coin test offset',
            accountType: 'EQUITY',
            normalSide: 'CREDIT',
            currencyCode: 'KCOIN',
          },
        ],
      });

      const transaction = await tx.ledgerTransaction.create({
        data: {
          idempotencyKey: `legacy-coin-entry:${source.id}`,
          requestHash: 'd'.repeat(64),
          eventType: 'LEGACY_COIN_ENTRY_IMPORT',
          sourceType: 'LEGACY_COIN_ENTRY',
          sourceId: source.id,
          currencyCode: 'KCOIN',
        },
      });

      const wrongAccount = await tx.ledgerAccount.findUniqueOrThrow({
        where: { accountKey: wrongAccountKey },
        select: { id: true },
      });
      const offsetAccount = await tx.ledgerAccount.findUniqueOrThrow({
        where: { accountKey: offsetAccountKey },
        select: { id: true },
      });

      await tx.ledgerPosting.createMany({
        data: [
          {
            transactionId: transaction.id,
            accountId: wrongAccount.id,
            lineNumber: 1,
            side: 'CREDIT',
            amount: 20,
          },
          {
            transactionId: transaction.id,
            accountId: offsetAccount.id,
            lineNumber: 2,
            side: 'DEBIT',
            amount: 20,
          },
        ],
      });
    });

    const report = await reconciliation.dryRun({
      userIds: [senderId, creatorId],
    });

    expect(report.summary.alreadyImportedEntries).toBe(0);
    expect(report.summary.issues.byCode.IMPORTED_LEDGER_MISMATCH).toBe(1);
    expect(report.summary.issues.blockers).toBeGreaterThan(0);
  });
});
