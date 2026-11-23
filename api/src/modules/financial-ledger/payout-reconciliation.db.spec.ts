import { randomUUID } from 'node:crypto';

import { ConflictException } from '@nestjs/common';
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
  beforeAll(() => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    reconciliation = new PayoutReconciliationService(
      prisma as PrismaService,
      new DisabledPayoutWebhookProvider(),
    );
  });

  afterAll(async () => {
    // Financial source, allocation and provider records are intentionally
    // immutable; this isolated test database is discarded after the run.
    await prisma?.$disconnect();
  });

  const createFixture = async ({
    reservationStatus = CreatorEarningReservationStatus.ACTIVE,
    outcome = PayoutProviderEventOutcome.SUCCEEDED,
    withdrawalStatus = CreatorWithdrawalStatus.PROCESSING,
    attemptStatus = PayoutAttemptStatus.SUBMITTED,
  }: {
    reservationStatus?: CreatorEarningReservationStatus;
    outcome?: PayoutProviderEventOutcome;
    withdrawalStatus?: CreatorWithdrawalStatus;
    attemptStatus?: PayoutAttemptStatus;
  } = {}): Promise<Fixture> => {
    const stamp = randomUUID();
    const creatorId = randomUUID();
    const reservation = await prisma.$transaction(async (tx) => {
      const earning = await tx.creatorEarning.create({
        data: {
          creatorId,
          sourceCoinEntryKey: `payout-reconcile-earning:${stamp}`,
          source: 'APPROVED_REWARD',
          amount: 10,
          withdrawable: true,
        },
      });
      const createdReservation = await tx.creatorEarningReservation.create({
        data: {
          creatorId,
          idempotencyKey: `payout-reconcile-reservation:${stamp}`,
          amount: 10,
          status: reservationStatus,
          finalizedAt:
            reservationStatus === CreatorEarningReservationStatus.ACTIVE
              ? null
              : new Date(),
        },
      });
      await tx.creatorEarningReservationLine.create({
        data: {
          reservationId: createdReservation.id,
          earningId: earning.id,
          amount: 10,
        },
      });
      return createdReservation;
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
        status: withdrawalStatus,
      },
    });
    const attempt = await prisma.payoutAttempt.create({
      data: {
        withdrawalId: withdrawal.id,
        providerCode: 'test-provider',
        idempotencyKey: `payout:${withdrawal.id}`,
        providerTransferRef: `transfer:${stamp}`,
        status: attemptStatus,
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
    const fixture = await createFixture({
      reservationStatus: CreatorEarningReservationStatus.RELEASED,
    });

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

  it('serializes competing terminal events for the same payout attempt', async () => {
    const fixture = await createFixture();
    const attempt = await prisma.payoutAttempt.findUniqueOrThrow({
      where: { id: fixture.attemptId },
    });
    const competingEvent = await prisma.payoutProviderEvent.create({
      data: {
        providerCode: 'test-provider',
        providerEventId: `competing-event:${randomUUID()}`,
        eventType: 'transfer.failed',
        payloadHash: 'b'.repeat(64),
        outcome: PayoutProviderEventOutcome.FAILED,
        providerTransferRef: attempt.providerTransferRef,
        providerIdempotencyKey: attempt.idempotencyKey,
        amountMinor: 500n,
        currency: 'GHS',
        providerOccurredAt: new Date(),
      },
    });

    const outcomes = await Promise.allSettled([
      reconciliation.reconcile(fixture.eventId),
      reconciliation.reconcile(competingEvent.id),
    ]);
    const fulfilled = outcomes.filter(
      (outcome) => outcome.status === 'fulfilled',
    );
    const rejected = outcomes.find(
      (outcome): outcome is PromiseRejectedResult =>
        outcome.status === 'rejected',
    );
    expect(fulfilled).toHaveLength(1);
    expect(rejected?.reason).toBeInstanceOf(ConflictException);

    const [finalAttempt, finalWithdrawal, finalReservation, providerEvents] =
      await Promise.all([
        prisma.payoutAttempt.findUniqueOrThrow({
          where: { id: fixture.attemptId },
        }),
        prisma.creatorWithdrawal.findUniqueOrThrow({
          where: { id: fixture.withdrawalId },
        }),
        prisma.creatorEarningReservation.findUniqueOrThrow({
          where: { id: fixture.reservationId },
        }),
        prisma.payoutProviderEvent.findMany({
          where: { id: { in: [fixture.eventId, competingEvent.id] } },
        }),
      ]);

    const succeeded = finalAttempt.status === PayoutAttemptStatus.SUCCEEDED;
    expect([
      PayoutAttemptStatus.SUCCEEDED,
      PayoutAttemptStatus.FAILED,
    ]).toContain(finalAttempt.status);
    expect(finalWithdrawal.status).toBe(
      succeeded ? CreatorWithdrawalStatus.PAID : CreatorWithdrawalStatus.FAILED,
    );
    expect(finalReservation.status).toBe(
      succeeded
        ? CreatorEarningReservationStatus.SETTLED
        : CreatorEarningReservationStatus.RELEASED,
    );
    expect(providerEvents.filter((event) => event.processedAt)).toHaveLength(1);
  });

  it('does not mark an already-applied payout event processed when its reservation is inconsistent', async () => {
    const fixture = await createFixture({
      attemptStatus: PayoutAttemptStatus.SUCCEEDED,
      withdrawalStatus: CreatorWithdrawalStatus.PAID,
      reservationStatus: CreatorEarningReservationStatus.ACTIVE,
    });

    await expect(
      reconciliation.reconcile(fixture.eventId),
    ).rejects.toBeInstanceOf(ConflictException);

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
    expect(reservation.status).toBe(CreatorEarningReservationStatus.ACTIVE);
    expect(event.processedAt).toBeNull();
  });

  it('releases a reservation atomically after a terminal provider failure', async () => {
    const fixture = await createFixture({
      outcome: PayoutProviderEventOutcome.FAILED,
    });

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
