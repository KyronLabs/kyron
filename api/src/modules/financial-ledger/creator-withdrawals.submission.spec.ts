import {
  ConflictException,
  ServiceUnavailableException,
} from '@nestjs/common';
import {
  CreatorEarningReservationStatus,
  CreatorWithdrawalStatus,
  FxQuoteStatus,
  PayoutAttemptStatus,
  PayoutDestinationStatus,
} from '@prisma/client';
import { CreatorWithdrawalsService } from './creator-withdrawals.service';

describe('creator payout submission safety boundary', () => {
  const originalEnv = {
    submissions: process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED,
    withdrawals: process.env.CREATOR_WITHDRAWALS_ENABLED,
    minimum: process.env.CREATOR_WITHDRAWAL_MIN_COINS,
  };

  beforeEach(() => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'false';
    process.env.CREATOR_WITHDRAWALS_ENABLED = 'true';
    process.env.CREATOR_WITHDRAWAL_MIN_COINS = '1';
  });

  afterAll(() => {
    const restore = (key: string, value: string | undefined): void => {
      if (value === undefined) {
        delete process.env[key];
      } else {
        process.env[key] = value;
      }
    };

    restore('CREATOR_PAYOUT_SUBMISSIONS_ENABLED', originalEnv.submissions);
    restore('CREATOR_WITHDRAWALS_ENABLED', originalEnv.withdrawals);
    restore('CREATOR_WITHDRAWAL_MIN_COINS', originalEnv.minimum);
  });

  const createHarness = (overrides: Record<string, unknown> = {}) => {
    const withdrawal = {
      id: '33333333-3333-4333-8333-333333333333',
      creatorId: 'creator-1',
      reservationId: '44444444-4444-4444-8444-444444444444',
      fxQuoteId: '55555555-5555-4555-8555-555555555555',
      coinAmount: 100,
      currency: 'USD',
      fiatAmountMinor: 1000n,
      status: CreatorWithdrawalStatus.APPROVED,
      approvalRequestId: 'withdrawal-approval-01',
      approvalRequestedById: 'admin-requester',
      approvalRequestedAt: new Date(),
      approvedById: 'admin-approver',
      approvedAt: new Date(),
      destination: {
        creatorId: 'creator-1',
        providerCode: 'PROVIDER',
        providerRecipientRef: 'recipient-token',
        status: PayoutDestinationStatus.ACTIVE,
      },
      fxQuote: {
        creatorId: 'creator-1',
        coinAmount: 100,
        targetCurrency: 'USD',
        targetAmountMinor: 1000n,
        status: FxQuoteStatus.ACTIVE,
        expiresAt: new Date(Date.now() + 60_000),
      },
      reservation: {
        id: '44444444-4444-4444-8444-444444444444',
        status: CreatorEarningReservationStatus.ACTIVE,
        amount: 100,
      },
      attempts: [],
      ...overrides,
    };
    const tx = {
      $queryRaw: jest.fn(),
      creatorWithdrawal: {
        findUnique: jest.fn().mockResolvedValue(withdrawal),
        update: jest.fn(),
      },
      payoutAttempt: {
        create: jest.fn().mockResolvedValue({
          id: 'attempt-1',
          idempotencyKey: 'payout:33333333-3333-4333-8333-333333333333',
        }),
        update: jest.fn(),
      },
      fxQuote: {
        update: jest.fn(),
      },
      creatorEarningReservation: {
        findUnique: jest.fn().mockResolvedValue(withdrawal.reservation),
        update: jest.fn(),
      },
      financialAuditEvent: {
        create: jest.fn(),
      },
    };
    const prisma = {
      $transaction: jest.fn(
        (callback: (transaction: typeof tx) => unknown) => callback(tx),
      ),
      payoutAttempt: {
        update: jest.fn(),
      },
    };
    const payoutProvider = {
      isConfigured: jest.fn().mockReturnValue(true),
      submit: jest.fn(),
    };
    const service = new CreatorWithdrawalsService(
      prisma as never,
      {} as never,
      {} as never,
      payoutProvider as never,
    );

    return { service, prisma, tx, payoutProvider, withdrawal };
  };

  it('keeps the submission kill switch closed by default', async () => {
    const { service, prisma, payoutProvider } = createHarness();

    await expect(
      service.submitApproved('33333333-3333-4333-8333-333333333333'),
    ).rejects.toBeInstanceOf(ServiceUnavailableException);

    expect(prisma.$transaction).not.toHaveBeenCalled();
    expect(payoutProvider.isConfigured).not.toHaveBeenCalled();
    expect(payoutProvider.submit).not.toHaveBeenCalled();
  });

  it('requires persisted dual-control approval metadata before preparing a payout', async () => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'true';
    const { service, tx, payoutProvider } = createHarness({
      approvalRequestId: null,
      approvalRequestedById: null,
      approvalRequestedAt: null,
      approvedById: null,
      approvedAt: null,
    });

    await expect(
      service.submitApproved('33333333-3333-4333-8333-333333333333'),
    ).rejects.toBeInstanceOf(ConflictException);

    expect(tx.payoutAttempt.create).not.toHaveBeenCalled();
    expect(payoutProvider.submit).not.toHaveBeenCalled();
  });

  it('rejects a withdrawal approved by the same administrator who requested it', async () => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'true';
    const { service, tx, payoutProvider } = createHarness({
      approvedById: 'admin-requester',
    });

    await expect(
      service.submitApproved('33333333-3333-4333-8333-333333333333'),
    ).rejects.toBeInstanceOf(ConflictException);

    expect(tx.payoutAttempt.create).not.toHaveBeenCalled();
    expect(payoutProvider.submit).not.toHaveBeenCalled();
  });

  it('requires an active earnings reservation before creating a payout attempt', async () => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'true';
    const { service, tx, payoutProvider } = createHarness({
      reservation: {
        id: '44444444-4444-4444-8444-444444444444',
        status: CreatorEarningReservationStatus.SETTLED,
        amount: 100,
      },
    });

    await expect(
      service.submitApproved('33333333-3333-4333-8333-333333333333'),
    ).rejects.toBeInstanceOf(ConflictException);

    expect(tx.payoutAttempt.create).not.toHaveBeenCalled();
    expect(payoutProvider.submit).not.toHaveBeenCalled();
  });

  it('atomically records a provider rejection and releases the earnings reservation', async () => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'true';
    const { service, prisma, tx, payoutProvider, withdrawal } =
      createHarness();
    payoutProvider.submit.mockResolvedValue({
      accepted: false,
      errorCode: 'BANK_ACCOUNT_CLOSED',
    });

    await expect(service.submitApproved(withdrawal.id)).resolves.toEqual({
      status: 'FAILED',
    });

    expect(prisma.$transaction).toHaveBeenCalledTimes(2);
    expect(tx.payoutAttempt.update).toHaveBeenCalledWith({
      where: { id: 'attempt-1' },
      data: expect.objectContaining({
        status: PayoutAttemptStatus.FAILED,
        providerErrorCode: 'BANK_ACCOUNT_CLOSED',
        completedAt: expect.any(Date),
      }),
    });
    expect(tx.creatorWithdrawal.update).toHaveBeenLastCalledWith({
      where: { id: withdrawal.id },
      data: expect.objectContaining({
        status: CreatorWithdrawalStatus.FAILED,
        failureCode: 'BANK_ACCOUNT_CLOSED',
        completedAt: expect.any(Date),
      }),
    });
    expect(tx.creatorEarningReservation.update).toHaveBeenCalledWith({
      where: { id: withdrawal.reservationId },
      data: {
        status: CreatorEarningReservationStatus.RELEASED,
        finalizedAt: expect.any(Date),
      },
    });
    expect(tx.financialAuditEvent.create).toHaveBeenCalledTimes(2);
    expect(tx.financialAuditEvent.create).toHaveBeenNthCalledWith(
      1,
      expect.objectContaining({
        data: expect.objectContaining({
          eventType: 'CREATOR_PAYOUT_REJECTED',
          subjectId: withdrawal.id,
        }),
      }),
    );
    expect(tx.financialAuditEvent.create).toHaveBeenNthCalledWith(
      2,
      expect.objectContaining({
        data: expect.objectContaining({
          eventType: 'CREATOR_EARNINGS_RESERVATION_RELEASED',
          subjectId: withdrawal.reservationId,
        }),
      }),
    );
    expect(prisma.payoutAttempt.update).not.toHaveBeenCalled();
  });

  it('does not relabel a known provider rejection as UNKNOWN when finalization fails', async () => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'true';
    const { service, prisma, tx, payoutProvider, withdrawal } =
      createHarness();
    payoutProvider.submit.mockResolvedValue({
      accepted: false,
      errorCode: 'BANK_ACCOUNT_CLOSED',
    });
    tx.creatorEarningReservation.update.mockRejectedValue(
      new Error('reservation write failed'),
    );

    await expect(service.submitApproved(withdrawal.id)).rejects.toThrow(
      'reservation write failed',
    );

    expect(prisma.payoutAttempt.update).not.toHaveBeenCalled();
  });

  it('marks an ambiguous provider exception as UNKNOWN', async () => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'true';
    const { service, prisma, payoutProvider, withdrawal } = createHarness();
    payoutProvider.submit.mockRejectedValue(new Error('provider timeout'));

    await expect(service.submitApproved(withdrawal.id)).rejects.toThrow(
      'provider timeout',
    );

    expect(prisma.payoutAttempt.update).toHaveBeenCalledWith({
      where: { id: 'attempt-1' },
      data: {
        status: PayoutAttemptStatus.UNKNOWN,
        providerErrorCode: 'PROVIDER_OUTCOME_UNKNOWN',
      },
    });
  });
});
