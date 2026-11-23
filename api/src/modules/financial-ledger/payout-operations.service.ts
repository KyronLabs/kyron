import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import {
  CreatorWithdrawalStatus,
  PayoutAttemptStatus,
  PayoutProviderEventOutcome,
  Prisma,
} from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { PayoutReconciliationService } from './payout-reconciliation.service';

const MAX_REPORT_LIMIT = 500;
const MAX_STALE_MINUTES = 10_080;

export const PAYOUT_MANUAL_REVIEW_REASON_CODES = [
  'STALE_CREATED_ATTEMPT',
  'STALE_SUBMITTED_ATTEMPT',
  'UNKNOWN_PROVIDER_OUTCOME',
  'MISSING_TRANSFER_REFERENCE',
  'CONFLICTING_PROVIDER_EVIDENCE',
  'OTHER',
] as const;

export const PAYOUT_MANUAL_REVIEW_RESOLUTION_CODES = [
  'EVIDENCE_ATTACHED_FOR_RECONCILIATION',
  'NO_PROVIDER_TRANSFER_FOUND',
  'ESCALATED_TO_PROVIDER',
  'NO_ACTION_REQUIRED',
] as const;

function metadataString(
  metadata: Prisma.JsonValue,
  key: string,
): string | null {
  if (
    metadata === null ||
    Array.isArray(metadata) ||
    typeof metadata !== 'object'
  ) {
    return null;
  }
  const value = metadata[key];
  return typeof value === 'string' ? value : null;
}

export type PayoutManualReviewReasonCode =
  (typeof PAYOUT_MANUAL_REVIEW_REASON_CODES)[number];

export type PayoutManualReviewResolutionCode =
  (typeof PAYOUT_MANUAL_REVIEW_RESOLUTION_CODES)[number];

export interface PayoutOperationalReportInput {
  staleAfterMinutes?: number;
  limit?: number;
}

export interface PayoutOperationalReport {
  generatedAt: Date;
  staleAfterMinutes: number;
  staleBefore: Date;
  staleAttemptCount: number;
  staleAttempts: Array<{
    id: string;
    status: PayoutAttemptStatus;
    providerCode: string;
    providerTransferRef: string | null;
    providerErrorCode: string | null;
    createdAt: Date;
    submittedAt: Date | null;
    ageMinutes: number;
    withdrawal: {
      id: string;
      status: CreatorWithdrawalStatus;
      currency: string;
      fiatAmountMinor: string;
    };
  }>;
  unresolvedProviderEventCount: number;
  unmatchedTerminalProviderEventCount: number;
  unresolvedProviderEvents: Array<{
    id: string;
    providerCode: string;
    providerEventId: string;
    withdrawalId: string | null;
    eventType: string;
    outcome: PayoutProviderEventOutcome | null;
    providerTransferRef: string | null;
    providerIdempotencyKey: string | null;
    receivedAt: Date;
    providerOccurredAt: Date | null;
    processingError: string | null;
  }>;
  recentManualReviews: Array<{
    payoutAttemptId: string;
    requestId: string;
    reasonCode: string;
    requestedAt: Date;
    resolved: boolean;
    resolvedAt: Date | null;
    resolutionCode: string | null;
  }>;
}

@Injectable()
export class PayoutOperationsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly reconciliation: PayoutReconciliationService,
  ) {}

  /**
   * Read-only operational snapshot. Stale attempts and events are reported,
   * never mutated or retried by this method.
   */
  async getOperationalReport(
    input: PayoutOperationalReportInput = {},
  ): Promise<PayoutOperationalReport> {
    const staleAfterMinutes = input.staleAfterMinutes ?? 60;
    const limit = input.limit ?? 100;
    if (
      !Number.isSafeInteger(staleAfterMinutes) ||
      staleAfterMinutes < 1 ||
      staleAfterMinutes > MAX_STALE_MINUTES
    ) {
      throw new BadRequestException(
        'staleAfterMinutes must be between 1 and 10080.',
      );
    }
    if (!Number.isSafeInteger(limit) || limit < 1 || limit > MAX_REPORT_LIMIT) {
      throw new BadRequestException('limit must be between 1 and 500.');
    }

    const generatedAt = new Date();
    const staleBefore = new Date(
      generatedAt.getTime() - staleAfterMinutes * 60_000,
    );
    const staleAttemptWhere = {
      status: {
        in: [
          PayoutAttemptStatus.CREATED,
          PayoutAttemptStatus.SUBMITTED,
          PayoutAttemptStatus.UNKNOWN,
        ],
      },
      OR: [
        { submittedAt: { lte: staleBefore } },
        { submittedAt: null, createdAt: { lte: staleBefore } },
      ],
    };
    const unresolvedEventWhere = {
      processedAt: null,
      receivedAt: { lte: staleBefore },
    };

    const [
      staleAttempts,
      staleAttemptCount,
      unresolvedProviderEvents,
      unresolvedProviderEventCount,
      unmatchedTerminalProviderEventCount,
      reviewRequests,
    ] = await Promise.all([
      this.prisma.payoutAttempt.findMany({
        where: staleAttemptWhere,
        select: {
          id: true,
          status: true,
          providerCode: true,
          providerTransferRef: true,
          providerErrorCode: true,
          createdAt: true,
          submittedAt: true,
          withdrawal: {
            select: {
              id: true,
              status: true,
              currency: true,
              fiatAmountMinor: true,
            },
          },
        },
        orderBy: { createdAt: 'asc' },
        take: limit,
      }),
      this.prisma.payoutAttempt.count({ where: staleAttemptWhere }),
      this.prisma.payoutProviderEvent.findMany({
        where: unresolvedEventWhere,
        select: {
          id: true,
          providerCode: true,
          providerEventId: true,
          withdrawalId: true,
          eventType: true,
          outcome: true,
          providerTransferRef: true,
          providerIdempotencyKey: true,
          receivedAt: true,
          providerOccurredAt: true,
          processingError: true,
        },
        orderBy: { receivedAt: 'asc' },
        take: limit,
      }),
      this.prisma.payoutProviderEvent.count({
        where: unresolvedEventWhere,
      }),
      this.prisma.payoutProviderEvent.count({
        where: {
          ...unresolvedEventWhere,
          withdrawalId: null,
          outcome: {
            in: [
              PayoutProviderEventOutcome.SUCCEEDED,
              PayoutProviderEventOutcome.FAILED,
            ],
          },
        },
      }),
      this.prisma.financialAuditEvent.findMany({
        where: {
          eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_REQUESTED',
          subjectType: 'PAYOUT_ATTEMPT',
        },
        select: {
          subjectId: true,
          requestId: true,
          metadata: true,
          createdAt: true,
        },
        orderBy: { createdAt: 'desc' },
        take: limit,
      }),
    ]);

    const validReviewRequests = reviewRequests.filter(
      (
        review,
      ): review is typeof review & {
        subjectId: string;
        requestId: string;
      } => Boolean(review.subjectId && review.requestId),
    );
    const resolutions =
      validReviewRequests.length > 0
        ? await this.prisma.financialAuditEvent.findMany({
            where: {
              eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_RESOLVED',
              subjectType: 'PAYOUT_ATTEMPT',
              OR: validReviewRequests.map((review) => ({
                subjectId: review.subjectId,
                requestId: review.requestId,
              })),
            },
            select: {
              subjectId: true,
              requestId: true,
              metadata: true,
              createdAt: true,
            },
          })
        : [];

    const resolutionByReview = new Map<
      string,
      { resolutionCode: string; resolvedAt: Date }
    >();
    for (const resolution of resolutions) {
      if (!resolution.subjectId || !resolution.requestId) continue;
      resolutionByReview.set(
        `${resolution.subjectId}:${resolution.requestId}`,
        {
          resolutionCode:
            metadataString(resolution.metadata, 'resolutionCode') ?? 'UNKNOWN',
          resolvedAt: resolution.createdAt,
        },
      );
    }

    return {
      generatedAt,
      staleAfterMinutes,
      staleBefore,
      staleAttemptCount,
      staleAttempts: staleAttempts.map((attempt) => ({
        ...attempt,
        ageMinutes: Math.max(
          0,
          Math.floor(
            (generatedAt.getTime() -
              (attempt.submittedAt ?? attempt.createdAt).getTime()) /
              60_000,
          ),
        ),
        withdrawal: {
          ...attempt.withdrawal,
          fiatAmountMinor: attempt.withdrawal.fiatAmountMinor.toString(),
        },
      })),
      unresolvedProviderEventCount,
      unmatchedTerminalProviderEventCount,
      unresolvedProviderEvents,
      recentManualReviews: validReviewRequests.map((review) => {
        const key = `${review.subjectId}:${review.requestId}`;
        const resolution = resolutionByReview.get(key);
        return {
          payoutAttemptId: review.subjectId,
          requestId: review.requestId,
          reasonCode:
            metadataString(review.metadata, 'reasonCode') ?? 'UNKNOWN',
          requestedAt: review.createdAt,
          resolved: Boolean(resolution),
          resolvedAt: resolution?.resolvedAt ?? null,
          resolutionCode: resolution?.resolutionCode ?? null,
        };
      }),
    };
  }

  /**
   * Reads the report and records who accessed financial operations. Only
   * aggregate counts and the requested bounds are added to the audit trail;
   * individual payout details remain in the report response only.
   */
  async getOperationalReportForOperator(
    input: PayoutOperationalReportInput,
    actorId: string,
  ): Promise<PayoutOperationalReport> {
    if (!actorId.trim() || actorId.length > 80) {
      throw new BadRequestException('A valid audit actor is required.');
    }

    const report = await this.getOperationalReport(input);
    await this.prisma.financialAuditEvent.create({
      data: {
        actorId,
        eventType: 'FINANCIAL_OPERATIONS_REPORT_VIEWED',
        subjectType: 'PAYOUT_OPERATIONS_REPORT',
        metadata: {
          staleAfterMinutes: report.staleAfterMinutes,
          limit: input.limit ?? 100,
          staleAttemptCount: report.staleAttemptCount,
          unresolvedProviderEventCount: report.unresolvedProviderEventCount,
          unmatchedTerminalProviderEventCount:
            report.unmatchedTerminalProviderEventCount,
          returnedStaleAttemptCount: report.staleAttempts.length,
          returnedProviderEventCount: report.unresolvedProviderEvents.length,
        },
      },
    });
    return report;
  }

  /**
   * Records a human review request. It deliberately does not change payout
   * state, submit a transfer, release a reservation, or retry a provider call.
   */
  async requestManualReview(input: {
    payoutAttemptId: string;
    actorId: string;
    requestId: string;
    reasonCode: PayoutManualReviewReasonCode;
  }) {
    this.validateAuditInput(input.actorId, input.requestId);
    if (!PAYOUT_MANUAL_REVIEW_REASON_CODES.includes(input.reasonCode)) {
      throw new BadRequestException('Invalid payout review reason code.');
    }

    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "PayoutAttempt" WHERE id = ${input.payoutAttemptId}::uuid FOR UPDATE`;
      const attempt = await tx.payoutAttempt.findUnique({
        where: { id: input.payoutAttemptId },
        select: {
          id: true,
          status: true,
          providerCode: true,
          providerTransferRef: true,
          withdrawalId: true,
        },
      });
      if (!attempt) {
        throw new NotFoundException('Payout attempt not found.');
      }
      if (
        attempt.status !== PayoutAttemptStatus.CREATED &&
        attempt.status !== PayoutAttemptStatus.SUBMITTED &&
        attempt.status !== PayoutAttemptStatus.UNKNOWN
      ) {
        throw new ConflictException(
          'Only unresolved payout attempts can be sent for manual review.',
        );
      }

      const existing = await tx.financialAuditEvent.findFirst({
        where: {
          eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_REQUESTED',
          subjectType: 'PAYOUT_ATTEMPT',
          subjectId: attempt.id,
          requestId: input.requestId,
        },
        select: { actorId: true, metadata: true },
      });
      if (existing) {
        if (
          existing.actorId !== input.actorId ||
          metadataString(existing.metadata, 'reasonCode') !== input.reasonCode
        ) {
          throw new ConflictException(
            'The review request ID was already used with different details.',
          );
        }
        return {
          status: 'DUPLICATE' as const,
          payoutAttemptId: attempt.id,
        };
      }

      await tx.financialAuditEvent.create({
        data: {
          actorId: input.actorId,
          eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_REQUESTED',
          subjectType: 'PAYOUT_ATTEMPT',
          subjectId: attempt.id,
          requestId: input.requestId,
          metadata: {
            reasonCode: input.reasonCode,
            payoutStatus: attempt.status,
            providerCode: attempt.providerCode,
            providerTransferRef: attempt.providerTransferRef,
            withdrawalId: attempt.withdrawalId,
          },
        },
      });
      return {
        status: 'REVIEW_REQUESTED' as const,
        payoutAttemptId: attempt.id,
      };
    });
  }

  /**
   * Closes an operational review record only. This is an audit action, not a
   * financial decision; payout reconciliation remains a separate operation.
   */
  async resolveManualReview(input: {
    payoutAttemptId: string;
    actorId: string;
    requestId: string;
    resolutionCode: PayoutManualReviewResolutionCode;
  }) {
    this.validateAuditInput(input.actorId, input.requestId);
    if (!PAYOUT_MANUAL_REVIEW_RESOLUTION_CODES.includes(input.resolutionCode)) {
      throw new BadRequestException('Invalid payout review resolution code.');
    }

    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "PayoutAttempt" WHERE id = ${input.payoutAttemptId}::uuid FOR UPDATE`;
      const attempt = await tx.payoutAttempt.findUnique({
        where: { id: input.payoutAttemptId },
        select: { id: true },
      });
      if (!attempt) {
        throw new NotFoundException('Payout attempt not found.');
      }

      const reviewRequest = await tx.financialAuditEvent.findFirst({
        where: {
          eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_REQUESTED',
          subjectType: 'PAYOUT_ATTEMPT',
          subjectId: attempt.id,
          requestId: input.requestId,
        },
        select: { id: true },
      });
      if (!reviewRequest) {
        throw new NotFoundException('Payout manual review request not found.');
      }

      const existingResolution = await tx.financialAuditEvent.findFirst({
        where: {
          eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_RESOLVED',
          subjectType: 'PAYOUT_ATTEMPT',
          subjectId: attempt.id,
          requestId: input.requestId,
        },
        select: { actorId: true, metadata: true },
      });
      if (existingResolution) {
        if (
          existingResolution.actorId !== input.actorId ||
          metadataString(existingResolution.metadata, 'resolutionCode') !==
            input.resolutionCode
        ) {
          throw new ConflictException(
            'The review request was already resolved with different details.',
          );
        }
        return {
          status: 'DUPLICATE' as const,
          payoutAttemptId: attempt.id,
        };
      }

      await tx.financialAuditEvent.create({
        data: {
          actorId: input.actorId,
          eventType: 'CREATOR_PAYOUT_MANUAL_REVIEW_RESOLVED',
          subjectType: 'PAYOUT_ATTEMPT',
          subjectId: attempt.id,
          requestId: input.requestId,
          metadata: { resolutionCode: input.resolutionCode },
        },
      });
      return {
        status: 'RESOLVED' as const,
        payoutAttemptId: attempt.id,
      };
    });
  }

  /**
   * Replays only a previously authenticated terminal webhook event that is
   * still unmatched and unprocessed. The reconciliation service retains all
   * amount, currency, attempt-state, reservation and locking checks.
   */
  async reprocessUnmatchedProviderEvent(input: {
    providerEventId: string;
    actorId: string;
    requestId: string;
  }) {
    this.validateAuditInput(input.actorId, input.requestId);

    const prepared = await this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "PayoutProviderEvent" WHERE id = ${input.providerEventId}::uuid FOR UPDATE`;
      const event = await tx.payoutProviderEvent.findUnique({
        where: { id: input.providerEventId },
        select: {
          id: true,
          providerCode: true,
          outcome: true,
          withdrawalId: true,
          processedAt: true,
        },
      });
      if (!event) {
        throw new NotFoundException('Payout provider event not found.');
      }
      if (event.processedAt) {
        return { status: 'DUPLICATE' as const, eventId: event.id };
      }
      if (event.withdrawalId) {
        throw new ConflictException(
          'Only unmatched payout provider events can be reprocessed.',
        );
      }
      if (
        event.outcome !== PayoutProviderEventOutcome.SUCCEEDED &&
        event.outcome !== PayoutProviderEventOutcome.FAILED
      ) {
        throw new ConflictException(
          'Only authenticated terminal payout events can be reprocessed.',
        );
      }

      const completed = await tx.financialAuditEvent.findFirst({
        where: {
          eventType: 'PAYOUT_PROVIDER_EVENT_REPROCESS_COMPLETED',
          subjectType: 'PAYOUT_PROVIDER_EVENT',
          subjectId: event.id,
          requestId: input.requestId,
        },
        select: { id: true },
      });
      if (completed) {
        return { status: 'DUPLICATE' as const, eventId: event.id };
      }

      const existingRequest = await tx.financialAuditEvent.findFirst({
        where: {
          eventType: 'PAYOUT_PROVIDER_EVENT_REPROCESS_REQUESTED',
          subjectType: 'PAYOUT_PROVIDER_EVENT',
          subjectId: event.id,
          requestId: input.requestId,
        },
        select: { actorId: true },
      });
      if (existingRequest && existingRequest.actorId !== input.actorId) {
        throw new ConflictException(
          'The event reprocessing request ID belongs to another actor.',
        );
      }
      if (!existingRequest) {
        await tx.financialAuditEvent.create({
          data: {
            actorId: input.actorId,
            eventType: 'PAYOUT_PROVIDER_EVENT_REPROCESS_REQUESTED',
            subjectType: 'PAYOUT_PROVIDER_EVENT',
            subjectId: event.id,
            requestId: input.requestId,
            metadata: {
              providerCode: event.providerCode,
              outcome: event.outcome,
            },
          },
        });
      }
      return { status: 'READY' as const, eventId: event.id };
    });

    if (prepared.status === 'DUPLICATE') {
      return prepared;
    }

    let result: Awaited<ReturnType<PayoutReconciliationService['reconcile']>>;
    try {
      result = await this.reconciliation.reconcile(prepared.eventId);
    } catch (error) {
      await this.prisma.financialAuditEvent.create({
        data: {
          actorId: input.actorId,
          eventType: 'PAYOUT_PROVIDER_EVENT_REPROCESS_FAILED',
          subjectType: 'PAYOUT_PROVIDER_EVENT',
          subjectId: prepared.eventId,
          requestId: input.requestId,
          metadata: { failureCode: 'RECONCILIATION_FAILED' },
        },
      });
      throw error;
    }

    await this.prisma.financialAuditEvent.create({
      data: {
        actorId: input.actorId,
        eventType: 'PAYOUT_PROVIDER_EVENT_REPROCESS_COMPLETED',
        subjectType: 'PAYOUT_PROVIDER_EVENT',
        subjectId: prepared.eventId,
        requestId: input.requestId,
        metadata: { resultStatus: result.status },
      },
    });
    return result;
  }

  private validateAuditInput(actorId: string, requestId: string): void {
    if (!actorId.trim() || actorId.length > 80) {
      throw new BadRequestException('A valid audit actor is required.');
    }
    if (!requestId.trim() || requestId.length > 160) {
      throw new BadRequestException(
        'A valid operational idempotency key is required.',
      );
    }
  }
}
