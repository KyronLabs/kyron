import { ConflictException, ServiceUnavailableException } from '@nestjs/common';
import {
  CreatorWithdrawalStatus,
  FxQuoteStatus,
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
        create: jest.fn(),
        update: jest.fn(),
      },
      fxQuote: {
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

    return { service, prisma, tx, payoutProvider };
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
});
