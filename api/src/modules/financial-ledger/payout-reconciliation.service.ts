import {
  ConflictException,
  Injectable,
  ServiceUnavailableException,
} from '@nestjs/common';
import { createHash } from 'node:crypto';
import {
  CreatorEarningReservationStatus,
  CreatorWithdrawalStatus,
  PayoutAttemptStatus,
  PayoutProviderEventOutcome,
  Prisma,
} from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

export interface NormalizedPayoutWebhookEvent {
  providerEventId: string;
  eventType: string;
  outcome: PayoutProviderEventOutcome;
  providerTransferRef?: string;
  idempotencyKey?: string;
  amountMinor: bigint;
  currency: string;
  occurredAt: Date;
}

/** Provider adapters authenticate the exact raw bytes before normalizing events. */
export abstract class PayoutWebhookProvider {
  abstract readonly providerCode: string;
  abstract isConfigured(): boolean;
  abstract verifyAndParse(
    rawBody: Uint8Array,
    headers: Record<string, string | string[] | undefined>,
  ): Promise<NormalizedPayoutWebhookEvent>;
}

@Injectable()
export class DisabledPayoutWebhookProvider extends PayoutWebhookProvider {
  readonly providerCode = 'disabled';

  isConfigured(): boolean {
    return false;
  }

  verifyAndParse(
    _rawBody: Uint8Array,
    _headers: Record<string, string | string[] | undefined>,
  ): Promise<NormalizedPayoutWebhookEvent> {
    void _rawBody;
    void _headers;
    return Promise.reject(
      new ServiceUnavailableException(
        'No authenticated payout webhook provider has been configured.',
      ),
    );
  }
}

@Injectable()
export class PayoutReconciliationService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly webhookProvider: PayoutWebhookProvider,
  ) {}

  async ingest(
    providerCode: string,
    rawBody: Uint8Array,
    headers: Record<string, string | string[] | undefined>,
  ) {
    if (
      !providerCode.trim() ||
      providerCode.length > 40 ||
      providerCode !== this.webhookProvider.providerCode
    ) {
      throw new ConflictException('Unknown payout webhook provider.');
    }
    if (!this.webhookProvider.isConfigured()) {
      throw new ServiceUnavailableException(
        'Payout webhook verification is not configured.',
      );
    }
    if (!rawBody.byteLength || rawBody.byteLength > 1_048_576) {
      throw new ConflictException('Payout webhook body size is invalid.');
    }
    // The provider adapter must authenticate rawBody before parsing it.
    const event = await this.webhookProvider.verifyAndParse(rawBody, headers);
    this.validateEvent(event);
    const payloadHash = createHash('sha256').update(rawBody).digest('hex');
    try {
      const created = await this.prisma.payoutProviderEvent.create({
        data: {
          providerCode,
          providerEventId: event.providerEventId,
          eventType: event.eventType,
          payloadHash,
          outcome: event.outcome,
          providerTransferRef: event.providerTransferRef ?? null,
          providerIdempotencyKey: event.idempotencyKey ?? null,
          amountMinor: event.amountMinor,
          currency: event.currency,
          providerOccurredAt: event.occurredAt,
        },
        select: { id: true },
      });
      return { status: 'RECEIVED' as const, eventId: created.id };
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        const existing = await this.prisma.payoutProviderEvent.findUnique({
          where: {
            providerCode_providerEventId: {
              providerCode,
              providerEventId: event.providerEventId,
            },
          },
          select: { id: true, payloadHash: true },
        });
        if (existing && existing.payloadHash === payloadHash) {
          return { status: 'DUPLICATE' as const, eventId: existing.id };
        }
        if (existing) {
          throw new ConflictException(
            'A payout provider event ID was reused with different content.',
          );
        }
      }
      throw error;
    }
  }

  async reconcile(eventId: string) {
    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "PayoutProviderEvent" WHERE id = ${eventId}::uuid FOR UPDATE`;
      const event = await tx.payoutProviderEvent.findUnique({
        where: { id: eventId },
      });
      if (!event)
       throw new ConflictException('Payout provider event not found.');
      if (event.processedAt) return { status: 'DUPLICATE' as const };
      if (
        event.outcome !== PayoutProviderEventOutcome.SUCCEEDED &&
        event.outcome !== PayoutProviderEventOutcome.FAILED
      ) {
        await tx.payoutProviderEvent.update({
          where: { id: event.id },
          data: { processedAt: new Date(), processingError: null },
        });
        return { status: 'NON_TERMINAL' as const };
      }

      const attempt = await tx.payoutAttempt.findFirst({
        where: {
          providerCode: event.providerCode,
          ...(event.providerTransferRef
            ? { providerTransferRef: event.providerTransferRef }
            : { idempotencyKey: event.providerIdempotencyKey ?? '' }),
        },
        include: { withdrawal: true },
      });
      if (!attempt) return { status: 'UNMATCHED' as const };
      if (
        (event.providerTransferRef &&
          attempt.providerTransferRef !== event.providerTransferRef) ||
        (event.providerIdempotencyKey &&
          attempt.idempotencyKey !== event.providerIdempotencyKey)
      ) {
        throw new ConflictException(
          'Payout webhook references do not identify the same attempt.',
        );
      }

      await tx.$queryRaw`SELECT id FROM "PayoutAttempt" WHERE id = ${attempt.id}::uuid FOR UPDATE`;
      const lockedAttempt = await tx.payoutAttempt.findUnique({
        where: { id: attempt.id },
        include: { withdrawal: true },
      });
      if (!lockedAttempt) return { status: 'UNMATCHED' as const };
      const withdrawal = lockedAttempt.withdrawal;
      if (
        event.amountMinor === null ||
        event.amountMinor !== withdrawal.fiatAmountMinor ||
        event.currency !== withdrawal.currency
      ) {
        throw new ConflictException(
          'Payout webhook amount or currency does not match the withdrawal snapshot.',
        );
      }
      const succeeded = event.outcome === PayoutProviderEventOutcome.SUCCEEDED;
      const attemptStatus = succeeded
        ? PayoutAttemptStatus.SUCCEEDED
        : PayoutAttemptStatus.FAILED;
      const withdrawalStatus = succeeded
        ? CreatorWithdrawalStatus.PAID
        : CreatorWithdrawalStatus.FAILED;

      if (
        lockedAttempt.status === attemptStatus &&
        withdrawal.status === withdrawalStatus
      ) {
        await tx.payoutProviderEvent.update({
          where: { id: event.id },
          data: {
            withdrawalId: withdrawal.id,
            processedAt: new Date(),
            processingError: null,
          },
        });
        return {
          status: 'ALREADY_APPLIED' as const,
          withdrawalId: withdrawal.id,
        };
      }
      if (
        lockedAttempt.status !== PayoutAttemptStatus.SUBMITTED &&
        lockedAttempt.status !== PayoutAttemptStatus.UNKNOWN
      ) {
        throw new ConflictException(
          'Only submitted or unknown payout attempts can be reconciled.',
        );
      }
      if (withdrawal.status !== CreatorWithdrawalStatus.PROCESSING) {
        throw new ConflictException(
          'The withdrawal is not in a reconcilable processing state.',
        );
      }
      const reservation = await tx.creatorEarningReservation.findUnique({
        where: { id: withdrawal.reservationId },
      });
      if (
        !reservation ||
        reservation.status !== CreatorEarningReservationStatus.ACTIVE
      ) {
        throw new ConflictException(
          'The creator earnings reservation is not active.',
        );
      }

      const now = new Date();
      await tx.payoutAttempt.update({
        where: { id: lockedAttempt.id },
        data: {
          status: attemptStatus,
          completedAt: now,
          providerErrorCode: succeeded ? null : 'PROVIDER_CONFIRMED_FAILURE',
        },
      });
      await tx.creatorWithdrawal.update({
        where: { id: withdrawal.id },
        data: {
          status: withdrawalStatus,
          completedAt: now,
          failureCode: succeeded ? null : 'PROVIDER_CONFIRMED_FAILURE',
        },
      });
      await tx.creatorEarningReservation.update({
        where: { id: reservation.id },
        data: {
          status: succeeded
            ? CreatorEarningReservationStatus.SETTLED
            : CreatorEarningReservationStatus.RELEASED,
          finalizedAt: now,
        },
      });
      await tx.financialAuditEvent.create({
        data: {
          eventType: succeeded
            ? 'CREATOR_PAYOUT_CONFIRMED_PAID'
            : 'CREATOR_PAYOUT_CONFIRMED_FAILED',
          subjectType: 'CREATOR_WITHDRAWAL',
          subjectId: withdrawal.id,
          metadata: {
            payoutAttemptId: lockedAttempt.id,
            providerCode: event.providerCode,
            providerEventId: event.providerEventId,
            providerTransferRef: lockedAttempt.providerTransferRef ?? null,
            reservationId: reservation.id,
          },
        },
      });
      await tx.financialAuditEvent.create({
        data: {
          eventType: succeeded
            ? 'CREATOR_EARNINGS_RESERVATION_SETTLED'
            : 'CREATOR_EARNINGS_RESERVATION_RELEASED',
          subjectType: 'CREATOR_EARNING_RESERVATION',
          subjectId: reservation.id,
          metadata: {
            amount: reservation.amount,
            payoutAttemptId: lockedAttempt.id,
          },
        },
      });
      await tx.payoutProviderEvent.update({
        where: { id: event.id },
        data: {
          withdrawalId: withdrawal.id,
          processedAt: now,
          processingError: null,
        },
      });
      return {
        status: succeeded ? ('PAID' as const) : ('FAILED' as const),
        withdrawalId: withdrawal.id,
      };
    });
  }

  private validateEvent(event: NormalizedPayoutWebhookEvent): void {
    if (
      !event ||
      !['PENDING', 'SUCCEEDED', 'FAILED'].includes(event.outcome) ||
      !event.providerEventId?.trim() ||
      event.providerEventId.length > 255 ||
      !event.eventType?.trim() ||
      event.eventType.length > 100 ||
      (!event.providerTransferRef?.trim() && !event.idempotencyKey?.trim()) ||
      (event.providerTransferRef?.length ?? 0) > 255 ||
      (event.idempotencyKey?.length ?? 0) > 200 ||
      event.amountMinor <= 0n ||
      event.amountMinor > 9_223_372_036_854_775_807n ||
      !/^[A-Z]{3}$/.test(event.currency) ||
      !(event.occurredAt instanceof Date) ||
      !Number.isFinite(event.occurredAt.getTime())
    ) {
      throw new ConflictException('Payout webhook event is invalid.');
    }
  }
}
