import {
  BadRequestException,
  ConflictException,
  NotFoundException,
} from '@nestjs/common';
import {
  PayoutAttemptStatus,
  PayoutProviderEventOutcome,
} from '@prisma/client';
import { PayoutOperationsService } from './payout-operations.service';

function firstMockCallArgument(mock: {
  mock: { calls: unknown[][] };
}): unknown {
  return mock.mock.calls[0]?.[0];
}

describe('PayoutOperationsService', () => {
  const payoutAttemptFindMany = jest.fn();
  const payoutAttemptCount = jest.fn();
  const payoutProviderEventFindMany = jest.fn();
  const payoutProviderEventCount = jest.fn();
  const financialAuditFindMany = jest.fn();
  const financialAuditFindFirst = jest.fn();
  const financialAuditCreate = jest.fn();
  const payoutAttemptFindUnique = jest.fn();
  const payoutProviderEventFindUnique = jest.fn();
  const queryRaw = jest.fn();
  const transaction = jest.fn();
  const reconcile = jest.fn();

  const tx = {
    $queryRaw: queryRaw,
    payoutAttempt: {
      findUnique: payoutAttemptFindUnique,
    },
    payoutProviderEvent: {
      findUnique: payoutProviderEventFindUnique,
    },
    financialAuditEvent: {
      findFirst: financialAuditFindFirst,
      create: financialAuditCreate,
    },
  };

  const prisma = {
    payoutAttempt: {
      findMany: payoutAttemptFindMany,
      count: payoutAttemptCount,
    },
    payoutProviderEvent: {
      findMany: payoutProviderEventFindMany,
      count: payoutProviderEventCount,
      findUnique: payoutProviderEventFindUnique,
    },
    financialAuditEvent: {
      findMany: financialAuditFindMany,
      findFirst: financialAuditFindFirst,
      create: financialAuditCreate,
    },
    $transaction: transaction,
  };

  let service: PayoutOperationsService;

  beforeEach(() => {
    jest.clearAllMocks();
    transaction.mockImplementation(
      (callback: (client: typeof tx) => Promise<unknown>) => callback(tx),
    );
    service = new PayoutOperationsService(
      prisma as never,
      { reconcile } as never,
    );
    reconcile.mockReset();
  });

  describe('getOperationalReport', () => {
    it('reports stale attempts and events without writes', async () => {
      payoutAttemptFindMany.mockResolvedValue([
        {
          id: 'attempt-1',
          status: PayoutAttemptStatus.UNKNOWN,
          providerCode: 'example',
          providerTransferRef: null,
          providerErrorCode: 'PROVIDER_OUTCOME_UNKNOWN',
          createdAt: new Date('2026-11-22T00:00:00.000Z'),
          submittedAt: null,
          withdrawal: {
            id: 'withdrawal-1',
            status: 'PROCESSING',
            currency: 'GHS',
            fiatAmountMinor: 2500n,
          },
        },
      ]);
      payoutAttemptCount.mockResolvedValue(2);
      payoutProviderEventFindMany.mockResolvedValue([
        {
          id: 'event-1',
          providerCode: 'example',
          providerEventId: 'provider-event-1',
          eventType: 'transfer.completed',
          outcome: PayoutProviderEventOutcome.SUCCEEDED,
          providerTransferRef: 'transfer-1',
          providerIdempotencyKey: null,
          receivedAt: new Date('2026-11-22T00:00:00.000Z'),
          providerOccurredAt: null,
          processingError: null,
        },
      ]);
      payoutProviderEventCount
        .mockResolvedValueOnce(1)
        .mockResolvedValueOnce(1);
      financialAuditFindMany.mockResolvedValue([]);

      const report = await service.getOperationalReport({
        staleAfterMinutes: 30,
        limit: 25,
      });

      expect(report.staleAttemptCount).toBe(2);
      expect(report.staleAttempts[0].ageMinutes).toBeGreaterThanOrEqual(30);
      expect(report.staleAttempts[0].withdrawal.fiatAmountMinor).toBe('2500');
      expect(report.unresolvedProviderEventCount).toBe(1);
      expect(report.unmatchedTerminalProviderEventCount).toBe(1);
      expect(report.unresolvedProviderEvents).toHaveLength(1);
      expect(firstMockCallArgument(payoutAttemptFindMany)).toMatchObject({
        where: {
          status: {
            in: [
              PayoutAttemptStatus.CREATED,
              PayoutAttemptStatus.SUBMITTED,
              PayoutAttemptStatus.UNKNOWN,
            ],
          },
        },
        take: 25,
      });
      expect(payoutAttemptFindMany).toHaveBeenCalledTimes(1);
    });

    it('rejects unsafe report limits and stale windows', async () => {
      await expect(
        service.getOperationalReport({ staleAfterMinutes: 0 }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });
  });

  describe('requestManualReview', () => {
    it('records a manual review without changing payout state', async () => {
      payoutAttemptFindUnique.mockResolvedValue({
        id: 'attempt-1',
        status: PayoutAttemptStatus.UNKNOWN,
        providerCode: 'example',
        providerTransferRef: null,
        withdrawalId: 'withdrawal-1',
      });
      financialAuditFindFirst.mockResolvedValue(null);
      financialAuditCreate.mockResolvedValue({ id: 'audit-1' });

      const result = await service.requestManualReview({
        payoutAttemptId: 'attempt-1',
        actorId: 'operator-1',
        requestId: 'review-request-1',
        reasonCode: 'UNKNOWN_PROVIDER_OUTCOME',
      });

      expect(result.status).toBe('REVIEW_REQUESTED');
      expect(firstMockCallArgument(financialAuditCreate)).toMatchObject({
        data: {
          eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_REQUESTED',
          subjectId: 'attempt-1',
        },
      });
      expect(payoutAttemptFindUnique).toHaveBeenCalledTimes(1);
    });

    it('rejects review of terminal attempts', async () => {
      payoutAttemptFindUnique.mockResolvedValue({
        id: 'attempt-1',
        status: PayoutAttemptStatus.SUCCEEDED,
        providerCode: 'example',
        providerTransferRef: 'transfer-1',
        withdrawalId: 'withdrawal-1',
      });

      await expect(
        service.requestManualReview({
          payoutAttemptId: 'attempt-1',
          actorId: 'operator-1',
          requestId: 'review-request-2',
          reasonCode: 'OTHER',
        }),
      ).rejects.toBeInstanceOf(ConflictException);
    });

    it('deduplicates identical manual review requests', async () => {
      payoutAttemptFindUnique.mockResolvedValue({
        id: 'attempt-1',
        status: PayoutAttemptStatus.SUBMITTED,
        providerCode: 'example',
        providerTransferRef: 'transfer-1',
        withdrawalId: 'withdrawal-1',
      });
      financialAuditFindFirst.mockResolvedValue({
        actorId: 'operator-1',
        metadata: { reasonCode: 'STALE_SUBMITTED_ATTEMPT' },
      });

      const result = await service.requestManualReview({
        payoutAttemptId: 'attempt-1',
        actorId: 'operator-1',
        requestId: 'review-request-3',
        reasonCode: 'STALE_SUBMITTED_ATTEMPT',
      });

      expect(result.status).toBe('DUPLICATE');
      expect(financialAuditCreate).not.toHaveBeenCalled();
    });
  });

  describe('resolveManualReview', () => {
    it('records a resolution without financial mutation', async () => {
      payoutAttemptFindUnique.mockResolvedValue({ id: 'attempt-1' });
      financialAuditFindFirst
        .mockResolvedValueOnce({ id: 'review-audit-1' })
        .mockResolvedValueOnce(null);
      financialAuditCreate.mockResolvedValue({ id: 'resolution-audit-1' });

      const result = await service.resolveManualReview({
        payoutAttemptId: 'attempt-1',
        actorId: 'operator-2',
        requestId: 'review-request-4',
        resolutionCode: 'EVIDENCE_ATTACHED_FOR_RECONCILIATION',
      });

      expect(result.status).toBe('RESOLVED');
      expect(firstMockCallArgument(financialAuditCreate)).toMatchObject({
        data: {
          eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_RESOLVED',
          requestId: 'review-request-4',
        },
      });
    });

    it('requires an existing review request', async () => {
      payoutAttemptFindUnique.mockResolvedValue({ id: 'attempt-1' });
      financialAuditFindFirst.mockResolvedValue(null);

      await expect(
        service.resolveManualReview({
          payoutAttemptId: 'attempt-1',
          actorId: 'operator-2',
          requestId: 'missing-review',
          resolutionCode: 'NO_ACTION_REQUIRED',
        }),
      ).rejects.toBeInstanceOf(NotFoundException);
    });
  });

  describe('reprocessUnmatchedProviderEvent', () => {
    it('reprocesses unmatched terminal events and audits outcome', async () => {
      payoutProviderEventFindUnique.mockResolvedValue({
        id: 'event-1',
        providerCode: 'example',
        outcome: PayoutProviderEventOutcome.SUCCEEDED,
        withdrawalId: null,
        processedAt: null,
      });
      financialAuditFindFirst
        .mockResolvedValueOnce(null)
        .mockResolvedValueOnce(null);
      financialAuditCreate.mockResolvedValue({ id: 'audit-event' });
      reconcile.mockResolvedValue({
        status: 'PAID',
        withdrawalId: 'withdrawal-1',
      });

      const result = await service.reprocessUnmatchedProviderEvent({
        providerEventId: 'event-1',
        actorId: 'operator-1',
        requestId: 'reprocess-1',
      });

      expect(reconcile).toHaveBeenCalledWith('event-1');
      expect(result).toEqual({
        status: 'PAID',
        withdrawalId: 'withdrawal-1',
      });
      expect(financialAuditCreate).toHaveBeenCalledTimes(2);
    });

    it('refuses non-terminal provider events', async () => {
      payoutProviderEventFindUnique.mockResolvedValue({
        id: 'event-2',
        providerCode: 'example',
        outcome: PayoutProviderEventOutcome.PENDING,
        withdrawalId: null,
        processedAt: null,
      });

      await expect(
        service.reprocessUnmatchedProviderEvent({
          providerEventId: 'event-2',
          actorId: 'operator-1',
          requestId: 'reprocess-2',
        }),
      ).rejects.toBeInstanceOf(ConflictException);
      expect(reconcile).not.toHaveBeenCalled();
    });

    it('rejects linked or processed provider events', async () => {
      payoutProviderEventFindUnique.mockResolvedValue({
        id: 'event-3',
        providerCode: 'example',
        outcome: PayoutProviderEventOutcome.SUCCEEDED,
        withdrawalId: 'withdrawal-1',
        processedAt: null,
      });

      await expect(
        service.reprocessUnmatchedProviderEvent({
          providerEventId: 'event-3',
          actorId: 'operator-1',
          requestId: 'reprocess-3',
        }),
      ).rejects.toBeInstanceOf(ConflictException);
      expect(reconcile).not.toHaveBeenCalled();
    });
  });
});
