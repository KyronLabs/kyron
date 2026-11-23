import { NotFoundException } from '@nestjs/common';
import {
  CreatorEarningReservationStatus,
  CreatorWithdrawalStatus,
  FxQuoteStatus,
  PayoutAttemptStatus,
  PayoutDestinationStatus,
} from '@prisma/client';
import { CreatorWithdrawalsService } from './creator-withdrawals.service';

const partial = (value: Record<string, unknown>): Record<string, unknown> =>
  expect.objectContaining(value) as unknown as Record<string, unknown>;

describe('creator payout submission readiness preflight', () => {
  const originalEnv = {
    submissions: process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED,
    withdrawals: process.env.CREATOR_WITHDRAWALS_ENABLED,
    minimum: process.env.CREATOR_WITHDRAWAL_MIN_COINS,
  };

  beforeEach(() => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'true';
    process.env.CREATOR_WITHDRAWALS_ENABLED = 'true';
    process.env.CREATOR_WITHDRAWAL_MIN_COINS = '50';
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

  const makeWithdrawal = (overrides: Record<string, unknown> = {}) => ({
    id: '33333333-3333-4333-8333-333333333333',
    creatorId: 'creator-1',
    coinAmount: 100,
    currency: 'GHS',
    fiatAmountMinor: 12500n,
    status: CreatorWithdrawalStatus.APPROVED,
    approvalRequestId: 'approval-request-01',
    approvalRequestedById: 'admin-requester',
    approvalRequestedAt: new Date('2026-11-23T10:00:00.000Z'),
    approvedById: 'admin-approver',
    approvedAt: new Date('2026-11-23T10:01:00.000Z'),
    destination: {
      creatorId: 'creator-1',
      status: PayoutDestinationStatus.ACTIVE,
    },
    fxQuote: {
      creatorId: 'creator-1',
      coinAmount: 100,
      targetCurrency: 'GHS',
      targetAmountMinor: 12500n,
      status: FxQuoteStatus.ACTIVE,
      expiresAt: new Date('2026-11-24T10:00:00.000Z'),
    },
    reservation: {
      status: CreatorEarningReservationStatus.ACTIVE,
    },
    attempts: [],
    ...overrides,
  });

  const createHarness = (
    withdrawal: ReturnType<typeof makeWithdrawal> | null = makeWithdrawal(),
    providerConfigured = true,
  ) => {
    const findUnique = jest.fn().mockResolvedValue(withdrawal);
    const auditCreate = jest.fn().mockResolvedValue({ id: 'audit-1' });
    const transaction = jest.fn();
    const submit = jest.fn();
    const isConfigured = jest.fn().mockReturnValue(providerConfigured);
    const prisma = {
      creatorWithdrawal: { findUnique },
      financialAuditEvent: { create: auditCreate },
      $transaction: transaction,
    };
    const provider = { isConfigured, submit };
    const service = new CreatorWithdrawalsService(
      prisma as never,
      {} as never,
      {} as never,
      provider as never,
    );
    return {
      service,
      prisma,
      findUnique,
      auditCreate,
      transaction,
      submit,
      isConfigured,
    };
  };

  it('reports a fully eligible withdrawal without preparing or submitting it', async () => {
    const { service, findUnique, auditCreate, transaction, submit } =
      createHarness();

    const result = await service.getSubmissionReadinessForOperator(
      '33333333-3333-4333-8333-333333333333',
      'admin-1',
      new Date('2026-11-23T11:00:00.000Z'),
    );

    expect(result).toEqual({
      withdrawalId: '33333333-3333-4333-8333-333333333333',
      ready: true,
      blockers: [],
      coinAmount: 100,
      currency: 'GHS',
      fiatAmountMinor: '12500',
      checkedAt: '2026-11-23T11:00:00.000Z',
    });
    expect(findUnique).toHaveBeenCalledTimes(1);
    expect(auditCreate).toHaveBeenCalledWith({
      data: {
        actorId: 'admin-1',
        eventType: 'CREATOR_PAYOUT_SUBMISSION_PREFLIGHT_VIEWED',
        subjectType: 'CREATOR_WITHDRAWAL',
        subjectId: '33333333-3333-4333-8333-333333333333',
        metadata: { ready: true, blockerCodes: [] },
      },
    });
    expect(transaction).not.toHaveBeenCalled();
    expect(submit).not.toHaveBeenCalled();
  });

  it('reports every relevant blocker without mutating payout state', async () => {
    process.env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED = 'false';
    process.env.CREATOR_WITHDRAWAL_MIN_COINS = '500';

    const withdrawal = makeWithdrawal({
      status: CreatorWithdrawalStatus.REQUESTED,
      approvalRequestId: null,
      approvalRequestedById: null,
      approvalRequestedAt: null,
      approvedById: null,
      approvedAt: null,
      coinAmount: 100,
      destination: {
        creatorId: 'different-creator',
        status: PayoutDestinationStatus.DISABLED,
      },
      fxQuote: {
        creatorId: 'creator-1',
        coinAmount: 99,
        targetCurrency: 'USD',
        targetAmountMinor: 12000n,
        status: FxQuoteStatus.EXPIRED,
        expiresAt: new Date('2026-11-22T10:00:00.000Z'),
      },
      reservation: {
        status: CreatorEarningReservationStatus.RELEASED,
      },
      attempts: [{ status: PayoutAttemptStatus.UNKNOWN }],
    });
    const { service, auditCreate, transaction, submit } = createHarness(
      withdrawal,
      false,
    );

    const result = await service.getSubmissionReadinessForOperator(
      withdrawal.id,
      'admin-1',
      new Date('2026-11-23T11:00:00.000Z'),
    );

    expect(result.ready).toBe(false);
    expect(result.blockers).toEqual(
      expect.arrayContaining([
        'PAYOUT_SUBMISSIONS_DISABLED',
        'BANK_PAYOUT_PROVIDER_NOT_CONFIGURED',
        'WITHDRAWAL_NOT_APPROVED',
        'DUAL_CONTROL_APPROVAL_INCOMPLETE',
        'BELOW_WITHDRAWAL_MINIMUM',
        'PAYOUT_DESTINATION_INVALID',
        'FX_QUOTE_INVALID_OR_EXPIRED',
        'EARNINGS_RESERVATION_NOT_ACTIVE',
        'PAYOUT_ATTEMPT_REQUIRES_RECONCILIATION',
      ]),
    );
    expect(auditCreate).toHaveBeenCalledWith(
      partial({
        data: partial({
          actorId: 'admin-1',
          eventType: 'CREATOR_PAYOUT_SUBMISSION_PREFLIGHT_VIEWED',
          metadata: partial({
            ready: false,
            blockerCodes: result.blockers,
          }),
        }),
      }),
    );
    expect(transaction).not.toHaveBeenCalled();
    expect(submit).not.toHaveBeenCalled();
  });

  it('reports the withdrawal feature flag and missing minimum separately', async () => {
    delete process.env.CREATOR_WITHDRAWALS_ENABLED;
    delete process.env.CREATOR_WITHDRAWAL_MIN_COINS;
    const { service } = createHarness();

    const result = await service.getSubmissionReadinessForOperator(
      '33333333-3333-4333-8333-333333333333',
      'admin-1',
    );

    expect(result.blockers).toEqual(
      expect.arrayContaining([
        'CREATOR_WITHDRAWALS_DISABLED',
        'WITHDRAWAL_MINIMUM_NOT_CONFIGURED',
      ]),
    );
  });

  it('does not disclose or return the tokenized payout recipient reference', async () => {
    const withdrawal = {
      ...makeWithdrawal(),
      destination: {
        creatorId: 'creator-1',
        status: PayoutDestinationStatus.ACTIVE,
        providerRecipientRef: 'sensitive-recipient-token',
      },
    };
    const { service } = createHarness(withdrawal);

    const result = await service.getSubmissionReadinessForOperator(
      withdrawal.id,
      'admin-1',
    );

    expect(JSON.stringify(result)).not.toContain('sensitive-recipient-token');
  });

  it('does not audit or mutate when the withdrawal does not exist', async () => {
    const { service, auditCreate, transaction, submit } = createHarness(null);

    await expect(
      service.getSubmissionReadinessForOperator(
        '33333333-3333-4333-8333-333333333333',
        'admin-1',
      ),
    ).rejects.toBeInstanceOf(NotFoundException);

    expect(auditCreate).not.toHaveBeenCalled();
    expect(transaction).not.toHaveBeenCalled();
    expect(submit).not.toHaveBeenCalled();
  });
});
