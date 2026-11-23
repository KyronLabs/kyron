import { randomUUID } from 'node:crypto';

import {
  CreatorEarningReservationStatus,
  CreatorWithdrawalStatus,
  PayoutAttemptStatus,
  PayoutProviderEventOutcome,
  PrismaClient,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  DisabledPayoutWebhookProvider,
  PayoutReconciliationService,
} from './payout-reconciliation.service';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

type Fixture = {
  reservationId: string;
  destinationId: string;
  fxQuoteId: string;
  withdrawalId: string;
  attemptId: string;
  eventId: string;
};

run('payout terminal reconciliation against Postgres', () => {
  let prisma: PrismaClient;
  let reconciliation: PayoutReconciliationService;
  const fixtures: Fixture[] = [];

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    reconciliation = new PayoutReconciliationService(
      prisma as PrismaService,
      new DisabledPayoutWebhookProvider(),
    );
  });

  afterAll(async () => {
    for (const fixture of fixtures) {
      await prisma.financialAuditEvent.deleteMany({
        where: {
          OR: [
            { subjectId: fixture.withdrawalId },
            { subjectId: fixture.reservationId },
          ],
        },
      });
      await prisma.payoutProviderEvent.deleteMany({
        where: { id: fixture.eventId },
      });
      await prisma.payoutAttempt.deleteMany({
        where: { id: fixture.attemptId },
      });
      await prisma.creatorWithdrawal.deleteMany({
        where: { id: fixture.withdrawalId },
      });
      await prisma.fxQuote.deleteMany({ where: { id: fixture.fxQuoteId } });
      await prisma.payoutDestination.deleteMany({
        where: { id: fixture.destinationId },
      });
      await prisma.creatorEarningReservation.deleteMany({
        where: { id: fixture.reservationId },
      });
    }
    await prisma?.$disconnect();
  });

  const createFixture = async (
    reservationStatus: CreatorEarningReservationStatus =
      CreatorEarningReservationStatus.ACTIVE,
    outcome: PayoutProviderEventOutcome =
      PayoutProviderEventOutcome.SUCCEEDED,
  ): Promise<Fixture> => {
    const stamp = randomUUID();
    const creatorId = randomUUID();
    const reservation = await prisma.creatorEarningReservation.create({
      data: {
        creatorId,
        idempotencyKey: `payout-reconcile-reservation:${stamp}`,
        amount: 10,
        status: reservationStatus,
      },
    });
    const destination = await prisma.payoutDestination.create({
      data: {
        creatorId,
        providerCode: 'test-provider',
        providerRecipientRef: `recipient:${stamp}`,
        countryCode: 'GH',
        currency: 'GHS',
      },
    });
    const fxQuote = await prisma.fxQuote.create({
      data: {
        creatorId,
        coinAmount: 10,
        targetCurrency: 'GHS',
        targetAmountMinor: 500n,
        rateNumerator: 50n,
        rateDenominator: 1n,
        providerCode: 'test-fx',
        expiresAt: new Date(Date.now() + 60_000),
      },
    });
    const withdrawal = await prisma.creatorWithdrawal.create({
      data: {
        creatorId,
        reservationId: reservation.id,
        destinationId: destination.id,
        fxQuoteId: fxQuote.id,
        idempotencyKey: `payout-reconcile-withdrawal:${stamp}`,
        coinAmount: 10,
        currency: 'GHS',
        fiatAmountMinor: 500n,
        status: CreatorWithdrawalStatus.PROCESSING,
      },
    });
    const attempt = await prisma.payoutAttempt.create({
      data: {
        withdrawalId: withdrawal.id,
        providerCode: 'test-provider',
        idempotencyKey: `payout:${withdrawal.id}`,
        providerTransferRef: `transfer:${stamp}`,
        status: PayoutAttemptStatus.SUBMITTED,
      },
    });
    const event = await prisma.payoutProviderEvent.create({
      data: {
        providerCode: 'test-provider',
        providerEventId: `event:${stamp}`,
        eventType: 'transfer.completed',
        payloadHash: 'a'.repeat(64),
        outcome,
        providerTransferRef: attempt.providerTransferRef,
        providerIdempotencyKey: attempt.idempotencyKey,
        amountMinor: 500n,
        currency: 'GHS',
        providerOccurredAt: new Date(),
      },
    });
    const fixture = {
      reservationId: reservation.id,
      destinationId: destination.id,
      fxQuoteId: fxQuote.id,
      withdrawalId: withdrawal.id,
      attemptId: attempt.id,
      eventId: event.id,
    };
    fixtures.push(fixture);
    return fixture;
  };

  it('settles a reservation with the same transaction that confirms a payout', async () => {
    const fixture = await createFixture();

    await expect(reconciliation.reconcile(fixture.eventId)).resolves.toEqual({
      status: 'PAID',
      withdrawalId: fixture.withdrawalId,
    });

    const [attempt, withdrawal, reservation, event] = await Promise.all([
      prisma.payoutAttempt.findUniqueOrThrow({
        where: { id: fixture.attemptId },
      }),
      prisma.creatorWithdrawal.findUniqueOrThrow({
        where: { id: fixture.withdrawalId },
      }),
      prisma.creatorEarningReservation.findUniqueOrThrow({
        where: { id: fixture.reservationId },
      }),
      prisma.payoutProviderEvent.findUniqueOrThrow({
        where: { id: fixture.eventId },
      }),
    ]);
    expect(attempt.status).toBe(PayoutAttemptStatus.SUCCEEDED);
    expect(withdrawal.status).toBe(CreatorWithdrawalStatus.PAID);
    expect(reservation.status).toBe(CreatorEarningReservationStatus.SETTLED);
    expect(event.processedAt).toBeInstanceOf(Date);

    await expect(reconciliation.reconcile(fixture.eventId)).resolves.toEqual({
      status: 'DUPLICATE',
    });
  });

  it('does not overwrite a reservation already finalized by another operation', async () => {
    const fixture = await createFixture(
      CreatorEarningReservationStatus.RELEASED,
    );

    await expect(reconciliation.reconcile(fixture.eventId)).rejects.toThrow(
      'The creator earnings reservation is not active.',
    );

    const [attempt, withdrawal, reservation, event] = await Promise.all([
      prisma.payoutAttempt.findUniqueOrThrow({
        where: { id: fixture.attemptId },
      }),
      prisma.creatorWithdrawal.findUniqueOrThrow({
        where: { id: fixture.withdrawalId },
      }),
      prisma.creatorEarningReservation.findUniqueOrThrow({
        where: { id: fixture.reservationId },
      }),
      prisma.payoutProviderEvent.findUniqueOrThrow({
        where: { id: fixture.eventId },
      }),
    ]);
    expect(attempt.status).toBe(PayoutAttemptStatus.SUBMITTED);
    expect(withdrawal.status).toBe(CreatorWithdrawalStatus.PROCESSING);
    expect(reservation.status).toBe(CreatorEarningReservationStatus.RELEASED);
    expect(event.processedAt).toBeNull();
  });

  it('releases a reservation atomically after a terminal provider failure', async () => {
    const fixture = await createFixture(
      CreatorEarningReservationStatus.ACTIVE,
      PayoutProviderEventOutcome.FAILED,
    );

    await expect(reconciliation.reconcile(fixture.eventId)).resolves.toEqual({
      status: 'FAILED',
      withdrawalId: fixture.withdrawalId,
    });

    const [attempt, withdrawal, reservation] = await Promise.all([
      prisma.payoutAttempt.findUniqueOrThrow({
        where: { id: fixture.attemptId },
      }),
      prisma.creatorWithdrawal.findUniqueOrThrow({
        where: { id: fixture.withdrawalId },
      }),
      prisma.creatorEarningReservation.findUniqueOrThrow({
        where: { id: fixture.reservationId },
      }),
    ]);
    expect(attempt.status).toBe(PayoutAttemptStatus.FAILED);
    expect(withdrawal.status).toBe(CreatorWithdrawalStatus.FAILED);
    expect(reservation.status).toBe(CreatorEarningReservationStatus.RELEASED);
  });
});
