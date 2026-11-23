import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
  ServiceUnavailableException,
} from '@nestjs/common';
import {
  CreatorEarningReservationStatus,
  CreatorWithdrawalStatus,
  FxQuoteStatus,
  PayoutAttemptStatus,
  PayoutDestinationStatus,
} from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { CreatorEarningsService } from './creator-earnings.service';

export interface FxQuoteResult {
  providerCode: string;
  providerQuoteRef?: string;
  currency: string;
  targetAmountMinor: bigint;
  rateNumerator: bigint;
  rateDenominator: bigint;
  expiresAt: Date;
}

export abstract class FxQuoteProvider {
  abstract isConfigured(): boolean;

  abstract quote(input: {
    creatorId: string;
    coinAmount: number;
    targetCurrency: string;
  }): Promise<FxQuoteResult>;
}

export interface BankPayoutResult {
  accepted: boolean;
  providerTransferRef?: string;
  errorCode?: string;
}

export abstract class BankPayoutProvider {
  abstract isConfigured(): boolean;

  abstract submit(input: {
    providerCode: string;
    providerRecipientRef: string;
    currency: string;
    amountMinor: bigint;
    idempotencyKey: string;
  }): Promise<BankPayoutResult>;
}

@Injectable()
export class DisabledFxQuoteProvider extends FxQuoteProvider {
  isConfigured(): boolean {
    return false;
  }

  quote(): Promise<FxQuoteResult> {
    return Promise.reject(
      new ServiceUnavailableException(
        'No foreign-exchange quote provider has been configured.',
      ),
    );
  }
}

@Injectable()
export class DisabledBankPayoutProvider extends BankPayoutProvider {
  isConfigured(): boolean {
    return false;
  }

  submit(): Promise<BankPayoutResult> {
    return Promise.reject(
      new ServiceUnavailableException(
        'No bank payout provider has been configured.',
      ),
    );
  }
}

const MAX_POSTGRES_INT = 2_147_483_647;
const MAX_POSTGRES_BIGINT = 9_223_372_036_854_775_807n;

export interface CreatorWithdrawalPolicy {
  enabled: boolean;
  minimumCoins: number | null;
}

export interface CreatorPayoutSubmissionPolicy {
  enabled: boolean;
}

/**
 * Independent kill switch for bank transfers. Withdrawal requests and payout
 * submissions have separate operational approvals; submissions default closed.
 */
export function readCreatorPayoutSubmissionPolicy(
  env: NodeJS.ProcessEnv = process.env,
): CreatorPayoutSubmissionPolicy {
  return {
    enabled: env.CREATOR_PAYOUT_SUBMISSIONS_ENABLED === 'true',
  };
}

export function readCreatorWithdrawalPolicy(
  env: NodeJS.ProcessEnv = process.env,
): CreatorWithdrawalPolicy {
  const rawMinimum = env.CREATOR_WITHDRAWAL_MIN_COINS;
  const parsedMinimum =
    rawMinimum && /^\d+$/.test(rawMinimum) ? Number(rawMinimum) : NaN;
  const minimumCoins =
    Number.isSafeInteger(parsedMinimum) &&
    parsedMinimum > 0 &&
    parsedMinimum <= MAX_POSTGRES_INT
      ? parsedMinimum
      : null;

  return {
    enabled:
      env.CREATOR_WITHDRAWALS_ENABLED === 'true' && minimumCoins !== null,
    minimumCoins,
  };
}

@Injectable()
export class CreatorWithdrawalsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly earnings: CreatorEarningsService,
    private readonly fxProvider: FxQuoteProvider,
    private readonly payoutProvider: BankPayoutProvider,
  ) {}

  policy(): CreatorWithdrawalPolicy {
    return readCreatorWithdrawalPolicy();
  }

  async request(input: {
    creatorId: string;
    destinationId: string;
    coinAmount: number;
    idempotencyKey: string;
  }) {
    const policy = this.policy();
    if (!policy.enabled || policy.minimumCoins === null) {
      throw new ServiceUnavailableException(
        'Creator withdrawals are not enabled.',
      );
    }
    if (
      !Number.isSafeInteger(input.coinAmount) ||
      input.coinAmount <= 0 ||
      input.coinAmount > MAX_POSTGRES_INT ||
      input.coinAmount < policy.minimumCoins
    ) {
      throw new BadRequestException(
        'The withdrawal amount is below the configured minimum or invalid.',
      );
    }
    if (!input.idempotencyKey.trim() || input.idempotencyKey.length > 160) {
      throw new BadRequestException(
        'A valid withdrawal idempotency key is required.',
      );
    }

    const existing = await this.prisma.creatorWithdrawal.findUnique({
      where: { idempotencyKey: input.idempotencyKey },
    });
    if (existing) {
      if (
        existing.creatorId !== input.creatorId ||
        existing.destinationId !== input.destinationId ||
        existing.coinAmount !== input.coinAmount
      ) {
        throw new ConflictException(
          'The withdrawal idempotency key was already used for another request.',
        );
      }
      return existing;
    }

    if (!this.fxProvider.isConfigured()) {
      throw new ServiceUnavailableException(
        'No foreign-exchange quote provider has been configured.',
      );
    }

    const destination = await this.prisma.payoutDestination.findFirst({
      where: {
        id: input.destinationId,
        creatorId: input.creatorId,
        status: PayoutDestinationStatus.ACTIVE,
      },
    });
    if (!destination) {
      throw new NotFoundException(
        'An active payout destination was not found.',
      );
    }

    const quote = await this.fxProvider.quote({
      creatorId: input.creatorId,
      coinAmount: input.coinAmount,
      targetCurrency: destination.currency,
    });
    const now = new Date();
    if (
      quote.currency !== destination.currency ||
      !/^[A-Z]{3}$/.test(quote.currency) ||
      !quote.providerCode.trim() ||
      quote.providerCode.length > 40 ||
      (quote.providerQuoteRef?.length ?? 0) > 255 ||
      quote.targetAmountMinor <= 0n ||
      quote.targetAmountMinor > MAX_POSTGRES_BIGINT ||
      quote.rateNumerator <= 0n ||
      quote.rateNumerator > MAX_POSTGRES_BIGINT ||
      quote.rateDenominator <= 0n ||
      quote.rateDenominator > MAX_POSTGRES_BIGINT ||
      !Number.isFinite(quote.expiresAt.getTime()) ||
      quote.expiresAt <= now
    ) {
      throw new BadRequestException(
        'The FX provider returned an invalid quote.',
      );
    }

    const reservation = await this.earnings.reserve({
      creatorId: input.creatorId,
      amount: input.coinAmount,
      idempotencyKey: `withdrawal:${input.idempotencyKey}`,
      expiresAt: quote.expiresAt,
      actorId: input.creatorId,
      now,
    });

    if (
      reservation.status !== CreatorEarningReservationStatus.ACTIVE ||
      !reservation.expiresAt ||
      reservation.expiresAt <= now
    ) {
      throw new ConflictException(
        'The earnings reservation has expired or is no longer active.',
      );
    }
    const quoteExpiresAt =
      reservation.expiresAt < quote.expiresAt
        ? reservation.expiresAt
        : quote.expiresAt;

    return this.prisma.$transaction(async (tx) => {
      const fxQuote = await tx.fxQuote.create({
        data: {
          creatorId: input.creatorId,
          coinAmount: input.coinAmount,
          targetCurrency: destination.currency,
          targetAmountMinor: quote.targetAmountMinor,
          rateNumerator: quote.rateNumerator,
          rateDenominator: quote.rateDenominator,
          providerCode: quote.providerCode,
          providerQuoteRef: quote.providerQuoteRef,
          expiresAt: quoteExpiresAt,
        },
      });
      const withdrawal = await tx.creatorWithdrawal.create({
        data: {
          creatorId: input.creatorId,
          reservationId: reservation.id,
          destinationId: destination.id,
          fxQuoteId: fxQuote.id,
          idempotencyKey: input.idempotencyKey,
          coinAmount: input.coinAmount,
          currency: destination.currency,
          fiatAmountMinor: quote.targetAmountMinor,
        },
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId: input.creatorId,
          eventType: 'CREATOR_WITHDRAWAL_REQUESTED',
          subjectType: 'CREATOR_WITHDRAWAL',
          subjectId: withdrawal.id,
          requestId: input.idempotencyKey,
          metadata: {
            coinAmount: input.coinAmount,
            currency: destination.currency,
            fiatAmountMinor: quote.targetAmountMinor.toString(),
            fxQuoteId: fxQuote.id,
            reservationId: reservation.id,
          },
        },
      });
      return withdrawal;
    });
  }

  /**
   * First-person approval request. The withdrawal remains REQUESTED/UNDER_REVIEW;
   * this records the initiating administrator but does not approve or submit it.
   */
  async requestApproval(input: {
    withdrawalId: string;
    actorId: string;
    requestId: string;
  }) {
    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "CreatorWithdrawal" WHERE id = ${input.withdrawalId}::uuid FOR UPDATE`;
      const withdrawal = await tx.creatorWithdrawal.findUnique({
        where: { id: input.withdrawalId },
      });
      if (!withdrawal) {
        throw new NotFoundException('Creator withdrawal not found.');
      }
      if (withdrawal.approvalRequestId) {
        if (
          withdrawal.approvalRequestId === input.requestId &&
          withdrawal.approvalRequestedById === input.actorId
        ) {
          return withdrawal;
        }
        throw new ConflictException(
          'A dual-control approval request is already pending.',
        );
      }
      if (
        withdrawal.status !== CreatorWithdrawalStatus.REQUESTED &&
        withdrawal.status !== CreatorWithdrawalStatus.UNDER_REVIEW
      ) {
        throw new ConflictException(
          'This withdrawal cannot enter approval from its current state.',
        );
      }

      const requestedAt = new Date();
      const updated = await tx.creatorWithdrawal.update({
        where: { id: withdrawal.id },
        data: {
          approvalRequestId: input.requestId,
          approvalRequestedById: input.actorId,
          approvalRequestedAt: requestedAt,
        },
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId: input.actorId,
          eventType: 'CREATOR_WITHDRAWAL_APPROVAL_REQUESTED',
          subjectType: 'CREATOR_WITHDRAWAL',
          subjectId: withdrawal.id,
          requestId: input.requestId,
          metadata: {
            priorStatus: withdrawal.status,
            requiresDifferentAdministrator: true,
          },
        },
      });
      return updated;
    });
  }

  /**
   * Second-person approval. The request key and distinct actor are both checked
   * while holding the withdrawal row lock, so concurrent approvals serialize.
   */
  async approve(withdrawalId: string, actorId: string, requestId: string) {
    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "CreatorWithdrawal" WHERE id = ${withdrawalId}::uuid FOR UPDATE`;
      const withdrawal = await tx.creatorWithdrawal.findUnique({
        where: { id: withdrawalId },
      });
      if (!withdrawal) {
        throw new NotFoundException('Creator withdrawal not found.');
      }
      if (
        withdrawal.status === CreatorWithdrawalStatus.APPROVED &&
        withdrawal.approvalRequestId === requestId &&
        withdrawal.approvedById === actorId
      ) {
        return withdrawal;
      }
      if (
        withdrawal.status !== CreatorWithdrawalStatus.REQUESTED &&
        withdrawal.status !== CreatorWithdrawalStatus.UNDER_REVIEW
      ) {
        throw new ConflictException(
          'This withdrawal cannot be approved from its current state.',
        );
      }
      if (
        !withdrawal.approvalRequestId ||
        withdrawal.approvalRequestId !== requestId ||
        !withdrawal.approvalRequestedById
      ) {
        throw new ConflictException(
          'A matching dual-control approval request is required.',
        );
      }
      if (withdrawal.approvalRequestedById === actorId) {
        throw new ConflictException(
          'The administrator who requested approval cannot approve the same withdrawal.',
        );
      }

      const approvedAt = new Date();
      const approved = await tx.creatorWithdrawal.update({
        where: { id: withdrawal.id },
        data: {
          status: CreatorWithdrawalStatus.APPROVED,
          approvedAt,
          approvedById: actorId,
        },
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId,
          eventType: 'CREATOR_WITHDRAWAL_APPROVED',
          subjectType: 'CREATOR_WITHDRAWAL',
          subjectId: withdrawal.id,
          requestId,
          metadata: {
            approvalRequestedById: withdrawal.approvalRequestedById,
            approvedById: actorId,
            approvalRequestId: requestId,
          },
        },
      });
      return approved;
    });
  }

  /**
   * Read-only preflight for an operator. It deliberately does not reserve,
   * create attempts, consume FX quotes or call the payout provider.
   */
  async getSubmissionReadinessForOperator(
    withdrawalId: string,
    actorId: string,
    now = new Date(),
  ) {
    const withdrawal = await this.prisma.creatorWithdrawal.findUnique({
      where: { id: withdrawalId },
      select: {
        id: true,
        creatorId: true,
        coinAmount: true,
        currency: true,
        fiatAmountMinor: true,
        status: true,
        approvalRequestId: true,
        approvalRequestedById: true,
        approvalRequestedAt: true,
        approvedById: true,
        approvedAt: true,
        destination: {
          select: {
            creatorId: true,
            status: true,
          },
        },
        fxQuote: {
          select: {
            creatorId: true,
            coinAmount: true,
            targetCurrency: true,
            targetAmountMinor: true,
            status: true,
            expiresAt: true,
          },
        },
        reservation: {
          select: {
            status: true,
          },
        },
        attempts: {
          select: {
            status: true,
          },
        },
      },
    });
    if (!withdrawal) {
      throw new NotFoundException('Creator withdrawal not found.');
    }

    const withdrawalPolicy = this.policy();
    const submissionPolicy = readCreatorPayoutSubmissionPolicy();
    const blockers: string[] = [];

    if (!submissionPolicy.enabled) {
      blockers.push('PAYOUT_SUBMISSIONS_DISABLED');
    }
    if (!withdrawalPolicy.enabled) {
      blockers.push('CREATOR_WITHDRAWALS_DISABLED');
    }
    if (withdrawalPolicy.minimumCoins === null) {
      blockers.push('WITHDRAWAL_MINIMUM_NOT_CONFIGURED');
    }
    if (!this.payoutProvider.isConfigured()) {
      blockers.push('BANK_PAYOUT_PROVIDER_NOT_CONFIGURED');
    }
    if (withdrawal.status !== CreatorWithdrawalStatus.APPROVED) {
      blockers.push('WITHDRAWAL_NOT_APPROVED');
    }
    if (
      !withdrawal.approvalRequestId ||
      !withdrawal.approvalRequestedById ||
      !withdrawal.approvalRequestedAt ||
      !withdrawal.approvedById ||
      !withdrawal.approvedAt ||
      withdrawal.approvalRequestedById === withdrawal.approvedById
    ) {
      blockers.push('DUAL_CONTROL_APPROVAL_INCOMPLETE');
    }
    if (
      withdrawalPolicy.minimumCoins !== null &&
      withdrawal.coinAmount < withdrawalPolicy.minimumCoins
    ) {
      blockers.push('BELOW_WITHDRAWAL_MINIMUM');
    }
    if (
      withdrawal.destination.status !== PayoutDestinationStatus.ACTIVE ||
      withdrawal.destination.creatorId !== withdrawal.creatorId
    ) {
      blockers.push('PAYOUT_DESTINATION_INVALID');
    }
    if (
      withdrawal.fxQuote.creatorId !== withdrawal.creatorId ||
      withdrawal.fxQuote.coinAmount !== withdrawal.coinAmount ||
      withdrawal.fxQuote.targetCurrency !== withdrawal.currency ||
      withdrawal.fxQuote.targetAmountMinor !== withdrawal.fiatAmountMinor ||
      withdrawal.fxQuote.status !== FxQuoteStatus.ACTIVE ||
      withdrawal.fxQuote.expiresAt <= now
    ) {
      blockers.push('FX_QUOTE_INVALID_OR_EXPIRED');
    }
    if (
      withdrawal.reservation.status !== CreatorEarningReservationStatus.ACTIVE
    ) {
      blockers.push('EARNINGS_RESERVATION_NOT_ACTIVE');
    }
    if (
      withdrawal.attempts.some(
        (attempt) =>
          attempt.status === PayoutAttemptStatus.CREATED ||
          attempt.status === PayoutAttemptStatus.SUBMITTED ||
          attempt.status === PayoutAttemptStatus.UNKNOWN,
      )
    ) {
      blockers.push('PAYOUT_ATTEMPT_REQUIRES_RECONCILIATION');
    }

    const ready = blockers.length === 0;
    const result = {
      withdrawalId: withdrawal.id,
      ready,
      blockers,
      coinAmount: withdrawal.coinAmount,
      currency: withdrawal.currency,
      fiatAmountMinor: withdrawal.fiatAmountMinor.toString(),
      checkedAt: now.toISOString(),
    };

    await this.prisma.financialAuditEvent.create({
      data: {
        actorId,
        eventType: 'CREATOR_PAYOUT_SUBMISSION_PREFLIGHT_VIEWED',
        subjectType: 'CREATOR_WITHDRAWAL',
        subjectId: withdrawal.id,
        metadata: {
          ready,
          blockerCodes: blockers,
        },
      },
    });

    return result;
  }

  /**
   * Submits only an approved withdrawal. A provider timeout is UNKNOWN, never
   * treated as a definite failure and never blindly retried.
   */
  async submitApproved(withdrawalId: string) {
    if (!readCreatorPayoutSubmissionPolicy().enabled) {
      throw new ServiceUnavailableException(
        'Creator payout submissions are disabled by server policy.',
      );
    }

    const policy = this.policy();
    if (!policy.enabled) {
      throw new ServiceUnavailableException(
        'Creator withdrawals are not enabled.',
      );
    }

    if (!this.payoutProvider.isConfigured()) {
      throw new ServiceUnavailableException(
        'No bank payout provider has been configured.',
      );
    }

    const prepared = await this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "CreatorWithdrawal" WHERE id = ${withdrawalId}::uuid FOR UPDATE`;
      const withdrawal = await tx.creatorWithdrawal.findUnique({
        where: { id: withdrawalId },
        include: {
          destination: true,
          fxQuote: true,
          attempts: true,
          reservation: true,
        },
      });
      if (!withdrawal) {
        throw new NotFoundException('Creator withdrawal not found.');
      }
      if (withdrawal.status !== CreatorWithdrawalStatus.APPROVED) {
        throw new ConflictException(
          'Only an approved withdrawal can be submitted.',
        );
      }
      if (
        !withdrawal.approvalRequestId ||
        !withdrawal.approvalRequestedById ||
        !withdrawal.approvalRequestedAt ||
        !withdrawal.approvedById ||
        !withdrawal.approvedAt ||
        withdrawal.approvalRequestedById === withdrawal.approvedById
      ) {
        throw new ConflictException(
          'A complete dual-control approval by two different administrators is required before payout submission.',
        );
      }
      if (
        withdrawal.reservation.status !== CreatorEarningReservationStatus.ACTIVE
      ) {
        throw new ConflictException(
          'The creator earnings reservation must be active before payout submission.',
        );
      }
      if (
        withdrawal.coinAmount <
          (policy.minimumCoins ?? Number.MAX_SAFE_INTEGER) ||
        withdrawal.destination.status !== PayoutDestinationStatus.ACTIVE ||
        withdrawal.destination.creatorId !== withdrawal.creatorId ||
        withdrawal.fxQuote.creatorId !== withdrawal.creatorId ||
        withdrawal.fxQuote.coinAmount !== withdrawal.coinAmount ||
        withdrawal.fxQuote.targetCurrency !== withdrawal.currency ||
        withdrawal.fxQuote.targetAmountMinor !== withdrawal.fiatAmountMinor ||
        withdrawal.fxQuote.status !== FxQuoteStatus.ACTIVE ||
        withdrawal.fxQuote.expiresAt <= new Date()
      ) {
        throw new ConflictException(
          'The withdrawal destination or FX quote is invalid, expired or consumed.',
        );
      }
      const priorUnresolved = withdrawal.attempts.some(
        (attempt) =>
          attempt.status === PayoutAttemptStatus.CREATED ||
          attempt.status === PayoutAttemptStatus.SUBMITTED ||
          attempt.status === PayoutAttemptStatus.UNKNOWN,
      );
      if (priorUnresolved) {
        throw new ConflictException(
          'An existing payout attempt must be reconciled before another submission.',
        );
      }
      const attempt = await tx.payoutAttempt.create({
        data: {
          withdrawalId: withdrawal.id,
          providerCode: withdrawal.destination.providerCode,
          idempotencyKey: `payout:${withdrawal.id}`,
        },
      });
      await tx.creatorWithdrawal.update({
        where: { id: withdrawal.id },
        data: { status: CreatorWithdrawalStatus.PROCESSING },
      });
      await tx.fxQuote.update({
        where: { id: withdrawal.fxQuoteId },
        data: { status: FxQuoteStatus.CONSUMED },
      });
      return { withdrawal, attempt };
    });

    let result: BankPayoutResult;
    try {
      result = await this.payoutProvider.submit({
        providerCode: prepared.withdrawal.destination.providerCode,
        providerRecipientRef:
          prepared.withdrawal.destination.providerRecipientRef,
        currency: prepared.withdrawal.currency,
        amountMinor: prepared.withdrawal.fiatAmountMinor,
        idempotencyKey: prepared.attempt.idempotencyKey,
      });
    } catch (error) {
      await this.prisma.payoutAttempt.update({
        where: { id: prepared.attempt.id },
        data: {
          status: PayoutAttemptStatus.UNKNOWN,
          providerErrorCode: 'PROVIDER_OUTCOME_UNKNOWN',
        },
      });
      throw error;
    }

    if (!result.accepted) {
      const providerErrorCode = result.errorCode ?? 'PROVIDER_REJECTED';
      await this.prisma.$transaction(async (tx) => {
        await tx.$queryRaw`SELECT id FROM "CreatorEarningReservation" WHERE id = ${prepared.withdrawal.reservationId}::uuid FOR UPDATE`;
        const reservation = await tx.creatorEarningReservation.findUnique({
          where: { id: prepared.withdrawal.reservationId },
        });
        if (
          !reservation ||
          reservation.status !== CreatorEarningReservationStatus.ACTIVE
        ) {
          throw new ConflictException(
            'The provider rejected the payout, but its earnings reservation is no longer active; manual reconciliation is required.',
          );
        }

        const completedAt = new Date();
        await tx.payoutAttempt.update({
          where: { id: prepared.attempt.id },
          data: {
            status: PayoutAttemptStatus.FAILED,
            completedAt,
            providerErrorCode,
          },
        });
        await tx.creatorWithdrawal.update({
          where: { id: prepared.withdrawal.id },
          data: {
            status: CreatorWithdrawalStatus.FAILED,
            completedAt,
            failureCode: providerErrorCode,
          },
        });
        await tx.creatorEarningReservation.update({
          where: { id: reservation.id },
          data: {
            status: CreatorEarningReservationStatus.RELEASED,
            finalizedAt: completedAt,
          },
        });
        await tx.financialAuditEvent.create({
          data: {
            eventType: 'CREATOR_PAYOUT_REJECTED',
            subjectType: 'CREATOR_WITHDRAWAL',
            subjectId: prepared.withdrawal.id,
            metadata: {
              payoutAttemptId: prepared.attempt.id,
              providerErrorCode,
              reservationId: reservation.id,
            },
          },
        });
        await tx.financialAuditEvent.create({
          data: {
            actorId: prepared.withdrawal.creatorId,
            eventType: 'CREATOR_EARNINGS_RESERVATION_RELEASED',
            subjectType: 'CREATOR_EARNING_RESERVATION',
            subjectId: reservation.id,
            metadata: {
              amount: reservation.amount,
              payoutAttemptId: prepared.attempt.id,
              reason: 'PROVIDER_REJECTED',
            },
          },
        });
      });
      return { status: 'FAILED' as const };
    }

    if (!result.providerTransferRef?.trim()) {
      await this.prisma.payoutAttempt.update({
        where: { id: prepared.attempt.id },
        data: {
          status: PayoutAttemptStatus.UNKNOWN,
          providerErrorCode: 'PROVIDER_ACCEPTED_WITHOUT_TRANSFER_REFERENCE',
        },
      });
      throw new Error(
        'Provider accepted a payout without a transfer reference.',
      );
    }

    try {
      await this.prisma.$transaction(async (tx) => {
        await tx.payoutAttempt.update({
          where: { id: prepared.attempt.id },
          data: {
            status: PayoutAttemptStatus.SUBMITTED,
            submittedAt: new Date(),
            providerTransferRef: result.providerTransferRef,
          },
        });
        await tx.financialAuditEvent.create({
          data: {
            eventType: 'CREATOR_PAYOUT_SUBMITTED',
            subjectType: 'CREATOR_WITHDRAWAL',
            subjectId: prepared.withdrawal.id,
            metadata: {
              payoutAttemptId: prepared.attempt.id,
              providerTransferRef: result.providerTransferRef,
            },
          },
        });
      });
    } catch (error) {
      await this.prisma.payoutAttempt.update({
        where: { id: prepared.attempt.id },
        data: {
          status: PayoutAttemptStatus.UNKNOWN,
          providerErrorCode: 'PROVIDER_OUTCOME_PERSISTENCE_UNKNOWN',
        },
      });
      throw error;
    }

    return { status: 'SUBMITTED' as const };
  }
}
