import { ConflictException, ServiceUnavailableException } from '@nestjs/common';
import {
  CreatorEarningReservationStatus,
  CreatorWithdrawalStatus,
  PayoutAttemptStatus,
  PayoutProviderEventOutcome,
} from '@prisma/client';
import {
  DisabledPayoutWebhookProvider,
  PayoutReconciliationService,
  PayoutWebhookProvider,
} from './payout-reconciliation.service';

const partial = (value: Record<string, unknown>): Record<string, unknown> =>
  expect.objectContaining(value) as unknown as Record<string, unknown>;

describe('payout webhook provider boundary', () => {
  it('fails closed when no provider verifier is configured', async () => {
    const provider = new DisabledPayoutWebhookProvider();
    expect(provider.isConfigured()).toBe(false);
    await expect(
      provider.verifyAndParse(new Uint8Array([1]), {}),
    ).rejects.toBeInstanceOf(ServiceUnavailableException);
  });

  it('passes the original raw bytes to the provider-specific verifier', async () => {
    class TestProvider extends PayoutWebhookProvider {
      readonly providerCode = 'test-provider';

      isConfigured(): boolean {
        return true;
      }

      verifyAndParse(
        rawBody: Uint8Array,
        headers: Record<string, string | string[] | undefined>,
      ) {
        void headers;
        expect(Array.from(rawBody)).toEqual([1, 2, 3]);
        return Promise.resolve({
          providerEventId: 'evt_123',
          eventType: 'transfer.completed',
          outcome: 'SUCCEEDED' as never,
          providerTransferRef: 'tr_123',
          amountMinor: 1000n,
          currency: 'GHS',
          occurredAt: new Date('2026-11-22T00:00:00.000Z'),
        });
      }
    }

    const event = await new TestProvider().verifyAndParse(
      new Uint8Array([1, 2, 3]),
      {},
    );
    expect(event.providerEventId).toBe('evt_123');
    expect(event.amountMinor).toBe(1000n);
  });
});

describe('payout terminal reconciliation locking', () => {
  const createHarness = ({
    reservationStatus = CreatorEarningReservationStatus.ACTIVE,
    attemptStatus = PayoutAttemptStatus.SUBMITTED,
    withdrawalStatus = CreatorWithdrawalStatus.PROCESSING,
  }: {
    reservationStatus?: CreatorEarningReservationStatus;
    attemptStatus?: PayoutAttemptStatus;
    withdrawalStatus?: CreatorWithdrawalStatus;
  } = {}) => {
    const event = {
      id: 'event-1',
      processedAt: null,
      outcome: PayoutProviderEventOutcome.SUCCEEDED,
      providerCode: 'test-provider',
      providerTransferRef: 'transfer-1',
      providerIdempotencyKey: 'payout:withdrawal-1',
      amountMinor: 1000n,
      currency: 'USD',
    };
    const withdrawal = {
      id: 'withdrawal-1',
      reservationId: 'reservation-1',
      fiatAmountMinor: 1000n,
      currency: 'USD',
      status: withdrawalStatus,
    };
    const attempt = {
      id: 'attempt-1',
      status: attemptStatus,
      providerCode: 'test-provider',
      providerTransferRef: 'transfer-1',
      idempotencyKey: 'payout:withdrawal-1',
      withdrawal,
    };
    const tx = {
      $queryRaw: jest.fn(),
      payoutProviderEvent: {
        findUnique: jest.fn().mockResolvedValue(event),
        update: jest.fn(),
      },
      payoutAttempt: {
        findFirst: jest.fn().mockResolvedValue(attempt),
        findUnique: jest.fn().mockResolvedValue(attempt),
        update: jest.fn(),
      },
      creatorWithdrawal: {
        update: jest.fn(),
      },
      creatorEarningReservation: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'reservation-1',
          status: reservationStatus,
          amount: 100,
        }),
        update: jest.fn(),
      },
      financialAuditEvent: {
        create: jest.fn(),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (transaction: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const service = new PayoutReconciliationService(
      prisma as never,
      new DisabledPayoutWebhookProvider(),
    );

    return { service, tx, event };
  };

  it('locks the payout attempt before locking and re-reading its reservation', async () => {
    const { service, tx, event } = createHarness();

    await expect(service.reconcile(event.id)).resolves.toEqual({
      status: 'PAID',
      withdrawalId: 'withdrawal-1',
    });

    expect(tx.$queryRaw).toHaveBeenCalledTimes(3);
    expect(
      tx.payoutAttempt.findUnique.mock.invocationCallOrder[0],
    ).toBeGreaterThan(tx.$queryRaw.mock.invocationCallOrder[1]);
    expect(tx.$queryRaw.mock.invocationCallOrder[2]).toBeGreaterThan(
      tx.payoutAttempt.findUnique.mock.invocationCallOrder[0],
    );
    expect(
      tx.creatorEarningReservation.findUnique.mock.invocationCallOrder[0],
    ).toBeGreaterThan(tx.$queryRaw.mock.invocationCallOrder[2]);
    expect(tx.creatorEarningReservation.update).toHaveBeenCalledWith(
      partial({
        where: { id: 'reservation-1' },
        data: partial({
          status: CreatorEarningReservationStatus.SETTLED,
        }),
      }),
    );
  });

  it('accepts an already-applied payout only when its reservation has the matching terminal state', async () => {
    const { service, tx, event } = createHarness({
      reservationStatus: CreatorEarningReservationStatus.SETTLED,
      attemptStatus: PayoutAttemptStatus.SUCCEEDED,
      withdrawalStatus: CreatorWithdrawalStatus.PAID,
    });

    await expect(service.reconcile(event.id)).resolves.toEqual({
      status: 'ALREADY_APPLIED',
      withdrawalId: 'withdrawal-1',
    });

    expect(tx.$queryRaw).toHaveBeenCalledTimes(3);
    expect(
      tx.creatorEarningReservation.findUnique.mock.invocationCallOrder[0],
    ).toBeGreaterThan(tx.$queryRaw.mock.invocationCallOrder[2]);
    expect(tx.creatorEarningReservation.update).not.toHaveBeenCalled();
    expect(tx.payoutProviderEvent.update).toHaveBeenCalledTimes(1);
  });

  it('does not consume an already-applied event when its reservation is inconsistent', async () => {
    const { service, tx, event } = createHarness({
      reservationStatus: CreatorEarningReservationStatus.ACTIVE,
      attemptStatus: PayoutAttemptStatus.SUCCEEDED,
      withdrawalStatus: CreatorWithdrawalStatus.PAID,
    });

    await expect(service.reconcile(event.id)).rejects.toBeInstanceOf(
      ConflictException,
    );

    expect(tx.payoutAttempt.update).not.toHaveBeenCalled();
    expect(tx.creatorWithdrawal.update).not.toHaveBeenCalled();
    expect(tx.creatorEarningReservation.update).not.toHaveBeenCalled();
    expect(tx.payoutProviderEvent.update).not.toHaveBeenCalled();
  });

  it('leaves terminal provider evidence unresolved when the reservation is already finalized', async () => {
    const { service, tx, event } = createHarness({
      reservationStatus: CreatorEarningReservationStatus.RELEASED,
    });

    await expect(service.reconcile(event.id)).rejects.toBeInstanceOf(
      ConflictException,
    );

    expect(tx.payoutAttempt.update).not.toHaveBeenCalled();
    expect(tx.creatorWithdrawal.update).not.toHaveBeenCalled();
    expect(tx.creatorEarningReservation.update).not.toHaveBeenCalled();
    expect(tx.payoutProviderEvent.update).not.toHaveBeenCalled();
  });
});
