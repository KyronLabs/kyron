import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { CreatorEarningsService } from './creator-earnings.service';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('creator earnings, holds and reservations against Postgres', () => {
  let prisma: PrismaClient;
  let earnings: CreatorEarningsService;
  const creatorId = randomUUID();
  const stamp = randomUUID();
  let earningId = '';

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    earnings = new CreatorEarningsService(prisma as PrismaService);
    await prisma.user.create({
      data: {
        id: creatorId,
        name: 'Creator earnings test',
        email: `creator-earnings-${stamp}@example.test`,
      },
    });
    const entry = await prisma.coinEntry.create({
      data: {
        userId: creatorId,
        kind: 'REWARD_EARN',
        amount: 25,
        key: `creator-earnings-test:${stamp}`,
      },
    });
    await prisma.$transaction(async (tx) => {
      await earnings.recordFromCoinEntry(tx, {
        userId: entry.userId,
        kind: entry.kind,
        amount: entry.amount,
        key: entry.key,
        giftId: entry.giftId,
      });
    });
    const materialized = await prisma.creatorEarning.findUniqueOrThrow({
      where: { sourceCoinEntryKey: entry.key },
    });
    earningId = materialized.id;
  });

  afterAll(async () => {
    await prisma?.user.delete({ where: { id: creatorId } });
    await prisma?.$disconnect();
  });

  it('makes approved reward proceeds immediately available', async () => {
    expect(await earnings.balance(creatorId)).toMatchObject({
      withdrawableCoins: 25,
      heldCoins: 0,
      reservedCoins: 0,
      availableCoins: 25,
    });
  });

  it('removes held earnings from availability and restores them on release', async () => {
    const hold = await earnings.placeHold({
      earningId,
      reasonCode: 'RISK_REVIEW',
      note: 'Test hold',
      actorId: creatorId,
    });
    expect(await earnings.balance(creatorId)).toMatchObject({
      heldCoins: 25,
      availableCoins: 0,
    });

    await earnings.releaseHold({
      holdId: hold.id,
      actorId: creatorId,
      note: 'Test review complete',
    });
    expect(await earnings.balance(creatorId)).toMatchObject({
      heldCoins: 0,
      availableCoins: 25,
    });
  });

  it('reserves FIFO value idempotently and prevents over-reservation', async () => {
    const request = {
      creatorId,
      amount: 18,
      idempotencyKey: `reserve:${stamp}`,
      actorId: creatorId,
    };
    const first = await earnings.reserve(request);
    const retry = await earnings.reserve(request);
    expect(retry.id).toBe(first.id);
    expect(first.lines).toHaveLength(1);
    expect(first.lines[0].amount).toBe(18);
    expect(await earnings.balance(creatorId)).toMatchObject({
      reservedCoins: 18,
      availableCoins: 7,
    });

    await expect(
      earnings.reserve({
        creatorId,
        amount: 8,
        idempotencyKey: `reserve-too-much:${stamp}`,
      }),
    ).rejects.toThrow('not have enough available');
  });

  it('returns released reservations to availability and keeps settled value consumed', async () => {
    const first = await prisma.creatorEarningReservation.findUniqueOrThrow({
      where: { idempotencyKey: `reserve:${stamp}` },
    });
    await earnings.finalizeReservation({
      reservationId: first.id,
      status: 'RELEASED',
      actorId: creatorId,
    });
    expect((await earnings.balance(creatorId)).availableCoins).toBe(25);

    const expiresAt = new Date(Date.now() + 1_000);
    const expiring = await earnings.reserve({
      creatorId,
      amount: 25,
      idempotencyKey: `reserve-expiring:${stamp}`,
      expiresAt,
      actorId: creatorId,
    });
    const afterExpiry = new Date(expiresAt.getTime() + 1_000);
    expect(await earnings.balance(creatorId, afterExpiry)).toMatchObject({
      reservedCoins: 0,
      availableCoins: 25,
    });
    await earnings.finalizeReservation({
      reservationId: expiring.id,
      status: 'RELEASED',
      actorId: creatorId,
      now: afterExpiry,
    });

    const second = await earnings.reserve({
      creatorId,
      amount: 25,
      idempotencyKey: `reserve-settle:${stamp}`,
      actorId: creatorId,
    });
    await earnings.finalizeReservation({
      reservationId: second.id,
      status: 'SETTLED',
      actorId: creatorId,
    });
    expect(await earnings.balance(creatorId)).toMatchObject({
      settledCoins: 25,
      reservedCoins: 0,
      availableCoins: 0,
    });
    await expect(
      earnings.reserve({
        creatorId,
        amount: 1,
        idempotencyKey: `after-settlement:${stamp}`,
      }),
    ).rejects.toThrow();
  });
});
