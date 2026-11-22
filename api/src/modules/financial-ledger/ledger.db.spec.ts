import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

/**
 * Database invariants for the financial foundation. These tests use real
 * Postgres because deferred constraint triggers and transaction IDs cannot
 * be meaningfully tested with a mocked Prisma client.
 *
 * Ledger evidence is intentionally retained after the test user is deleted.
 */
run('financial ledger, against a real database', () => {
  let prisma: PrismaClient;
  const userId = randomUUID();
  const stamp = randomUUID();
  const debitAccountId = randomUUID();
  const creditAccountId = randomUUID();
  let balancedTransactionId = '';

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });

    await prisma.user.create({
      data: {
        id: userId,
        name: 'Ledger test owner',
        email: `ledger-test-${stamp}@example.test`,
      },
    });

    await prisma.ledgerAccount.createMany({
      data: [
        {
          id: debitAccountId,
          accountKey: `test:${stamp}:debit`,
          name: 'Test debit account',
          accountType: 'ASSET',
          normalSide: 'DEBIT',
          currencyCode: 'KCOIN',
          ownerId: userId,
        },
        {
          id: creditAccountId,
          accountKey: `test:${stamp}:credit`,
          name: 'Test credit account',
          accountType: 'LIABILITY',
          normalSide: 'CREDIT',
          currencyCode: 'KCOIN',
          ownerId: userId,
        },
      ],
    });
  });

  afterAll(async () => {
    await prisma?.$disconnect();
  });

  const postBalancedTransaction = async () => {
    const id = randomUUID();
    await prisma.$transaction(async (tx) => {
      await tx.ledgerTransaction.create({
        data: {
          id,
          idempotencyKey: `test-ledger:${id}`,
          eventType: 'TEST_POSTING',
          sourceType: 'TEST',
          sourceId: id,
          currencyCode: 'KCOIN',
          actorId: userId,
        },
      });

      await tx.ledgerPosting.createMany({
        data: [
          {
            transactionId: id,
            accountId: debitAccountId,
            lineNumber: 1,
            side: 'DEBIT',
            amount: 10,
          },
          {
            transactionId: id,
            accountId: creditAccountId,
            lineNumber: 2,
            side: 'CREDIT',
            amount: 10,
          },
        ],
      });
    });
    return id;
  };

  it('commits a balanced transaction with at least two lines', async () => {
    balancedTransactionId = await postBalancedTransaction();

    const postings = await prisma.ledgerPosting.findMany({
      where: { transactionId: balancedTransactionId },
      orderBy: { lineNumber: 'asc' },
    });

    expect(postings).toHaveLength(2);
    expect(postings[0].amount.toString()).toBe('10');
    expect(postings[1].amount.toString()).toBe('10');
    expect(postings[0].side).toBe('DEBIT');
    expect(postings[1].side).toBe('CREDIT');
  });

  it('rejects an unbalanced transaction at commit time', async () => {
    const id = randomUUID();

    await expect(
      prisma.$transaction(async (tx) => {
        await tx.ledgerTransaction.create({
          data: {
            id,
            idempotencyKey: `test-unbalanced:${id}`,
            eventType: 'TEST_UNBALANCED',
            sourceType: 'TEST',
            sourceId: id,
            currencyCode: 'KCOIN',
            actorId: userId,
          },
        });
        await tx.ledgerPosting.create({
          data: {
            transactionId: id,
            accountId: debitAccountId,
            lineNumber: 1,
            side: 'DEBIT',
            amount: 10,
          },
        });
      }),
    ).rejects.toThrow();
  });

  it('rejects posting lines added after the parent transaction committed', async () => {
    await expect(
      prisma.ledgerPosting.create({
        data: {
          transactionId: balancedTransactionId,
          accountId: debitAccountId,
          lineNumber: 3,
          side: 'DEBIT',
          amount: 1,
        },
      }),
    ).rejects.toThrow(/same SQL transaction/i);
  });

  it('rejects updates and deletes to posted transactions and postings', async () => {
    const posting = await prisma.ledgerPosting.findFirstOrThrow({
      where: { transactionId: balancedTransactionId },
    });

    await expect(
      prisma.ledgerTransaction.update({
        where: { id: balancedTransactionId },
        data: { description: 'rewritten history' },
      }),
    ).rejects.toThrow();

    await expect(
      prisma.ledgerPosting.delete({ where: { id: posting.id } }),
    ).rejects.toThrow();
  });

  it('protects ledger account identity while allowing status changes', async () => {
    await expect(
      prisma.ledgerAccount.update({
        where: { id: debitAccountId },
        data: { currencyCode: 'GHS' },
      }),
    ).rejects.toThrow();

    const frozen = await prisma.ledgerAccount.update({
      where: { id: debitAccountId },
      data: { status: 'FROZEN' },
    });
    expect(frozen.status).toBe('FROZEN');
  });

  it('keeps conversion-rate versions immutable', async () => {
    const rate = await prisma.creatorConversionRate.create({
      data: {
        countryCode: 'GH',
        currencyCode: 'GHS',
        fiatPerCoin: '0.001000000000',
        rateSource: 'TEST_FIXTURE',
        policyVersion: 1,
        effectiveAt: new Date('2026-11-01T00:00:00.000Z'),
        createdById: userId,
      },
    });

    await expect(
      prisma.creatorConversionRate.update({
        where: { id: rate.id },
        data: { fiatPerCoin: '0.002000000000' },
      }),
    ).rejects.toThrow();
  });

  it('keeps financial audit events immutable', async () => {
    const event = await prisma.financialAuditEvent.create({
      data: {
        actorId: userId,
        eventType: 'TEST_EVENT',
        subjectType: 'TEST',
        subjectId: stamp,
        metadata: { fixture: true },
      },
    });

    await expect(
      prisma.financialAuditEvent.update({
        where: { id: event.id },
        data: { eventType: 'REWRITTEN_EVENT' },
      }),
    ).rejects.toThrow();
  });

  it('preserves ledger evidence when the owning user is deleted', async () => {
    await prisma.user.delete({ where: { id: userId } });

    const account = await prisma.ledgerAccount.findUniqueOrThrow({
      where: { id: debitAccountId },
    });
    const transaction = await prisma.ledgerTransaction.findUniqueOrThrow({
      where: { id: balancedTransactionId },
    });

    expect(account.ownerId).toBe(userId);
    expect(transaction.actorId).toBe(userId);
    expect(
      await prisma.ledgerPosting.count({
        where: { transactionId: balancedTransactionId },
      }),
    ).toBe(2);
  });
});
