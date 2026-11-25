import {
  ConflictException,
  Injectable,
  NotFoundException,
  ServiceUnavailableException,
} from '@nestjs/common';
import { CoinKind, type GooglePlayPurchase, type Prisma } from '@prisma/client';
import { createHash } from 'node:crypto';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { LedgerService } from '../financial-ledger/ledger.service';
import {
  netPurchasedCoinRecovery,
  PURCHASE_RECOVERY_CORRECTION,
  PURCHASE_RECOVERY_SOURCE,
} from '../financial-ledger/purchased-coin-recovery';
import {
  GooglePlayDeveloperApiProvider,
  type GooglePlayOrder,
  type GooglePlayProductPurchaseV2,
} from './google-play-developer-api.provider';
import {
  decryptPurchaseToken,
  encryptionKey,
  tokenHash,
} from './google-play-token';

const SOURCE = 'GOOGLE_PLAY_REFUND_OBSERVATION';
const CHARGEBACK_REVIEW_SOURCE = 'GOOGLE_PLAY_CHARGEBACK_REVIEW';
const CHARGEBACK_REASON = 7; // Google Play Voided Purchases API
const CHARGEBACK_PAGE_SIZE = 100;
export const REFUND_EVENTS = new Set([
  'ONE_TIME_FULL_VOID',
  'ONE_TIME_PARTIAL_VOID',
  'ONE_TIME_CANCELED',
  'ONE_TIME_VOID_RECOVERED',
]);
const PAGE_LIMIT = 3;
const DAY_MS = 86_400_000;

function jsonRecord(value: unknown): Record<string, unknown> {
  return value && typeof value === 'object' && !Array.isArray(value)
    ? (value as Record<string, unknown>)
    : {};
}

function accountId(userId: string): string {
  return createHash('sha256')
    .update('kyron/google-play/account/v1:', 'utf8')
    .update(userId, 'utf8')
    .digest('hex');
}

export interface RefundObservation {
  orderState: 'REFUNDED' | 'PARTIALLY_REFUNDED';
  originalQuantity: number;
  remainingRefundableQuantity: number;
  cumulativeRefundedQuantity: number;
  cumulativeRefundedCoins: number;
}

/** A snapshot, not an event delta or permission to debit any account. */
export function observeRefund(
  local: Pick<
    GooglePlayPurchase,
    'orderId' | 'productId' | 'userId' | 'quantity' | 'coinAmount'
  >,
  token: string,
  order: GooglePlayOrder,
  purchase: GooglePlayProductPurchaseV2,
  eventType: string,
): RefundObservation | null {
  const orderLine = order.lineItems?.[0];
  const purchaseLine = purchase.productLineItem?.[0];
  const remaining = purchaseLine?.productOfferDetails?.refundableQuantity;
  const state = order.state;
  if (
    !local.orderId ||
    order.orderId !== local.orderId ||
    order.purchaseToken !== token ||
    purchase.orderId !== local.orderId ||
    purchase.obfuscatedExternalAccountId !== accountId(local.userId) ||
    order.lineItems?.length !== 1 ||
    purchase.productLineItem?.length !== 1 ||
    orderLine?.productId !== local.productId ||
    purchaseLine?.productId !== local.productId ||
    !orderLine.oneTimePurchaseDetails ||
    (orderLine.oneTimePurchaseDetails.quantity ?? 1) !== local.quantity ||
    (purchaseLine.productOfferDetails?.quantity ?? 1) !== local.quantity ||
    !Number.isSafeInteger(local.quantity) ||
    local.quantity <= 0 ||
    !Number.isSafeInteger(local.coinAmount) ||
    local.coinAmount <= 0 ||
    local.coinAmount % local.quantity !== 0 ||
    typeof remaining !== 'number' ||
    !Number.isSafeInteger(remaining) ||
    remaining < 0 ||
    remaining >= local.quantity
  ) {
    return null;
  }
  if (
    (state !== 'REFUNDED' && state !== 'PARTIALLY_REFUNDED') ||
    (state === 'REFUNDED' && remaining !== 0) ||
    (state === 'PARTIALLY_REFUNDED' &&
      (remaining === 0 || eventType === 'ONE_TIME_FULL_VOID')) ||
    (state === 'PARTIALLY_REFUNDED' &&
      purchase.purchaseStateContext?.purchaseState !== 'PURCHASED') ||
    (state === 'REFUNDED' &&
      !['PURCHASED', 'CANCELLED'].includes(
        purchase.purchaseStateContext?.purchaseState ?? '',
      ))
  ) {
    return null;
  }
  const refunded = local.quantity - remaining;
  return {
    orderState: state,
    originalQuantity: local.quantity,
    remainingRefundableQuantity: remaining,
    cumulativeRefundedQuantity: refunded,
    cumulativeRefundedCoins: (local.coinAmount / local.quantity) * refunded,
  };
}

export enum ChargebackReviewDecision {
  NoAction = 'NO_ACTION',
  ReferForRecovery = 'REFER_FOR_RECOVERY',
}

const chargebackEvidenceFilter = {
  sourceType: SOURCE,
  eventType: 'GOOGLE_PLAY_REFUND_QUANTITY_OBSERVED',
  payload: {
    path: ['voidScan', 'matched'],
    array_contains: [{ voidedReason: CHARGEBACK_REASON }],
  },
} satisfies Prisma.FinancialSourceRecordWhereInput;

@Injectable()
export class GooglePlayReconciliationService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly googlePlay: GooglePlayDeveloperApiProvider,
    private readonly ledger: LedgerService,
  ) {}

  async listChargebackEvidence(after?: string) {
    const rows = await this.prisma.financialSourceRecord.findMany({
      where: {
        ...chargebackEvidenceFilter,
        ...(after ? { id: { gt: after } } : {}),
      },
      orderBy: { id: 'asc' },
      take: CHARGEBACK_PAGE_SIZE + 1,
      select: { id: true, sourceId: true, relatedIds: true, occurredAt: true },
    });

    const page = rows.slice(0, CHARGEBACK_PAGE_SIZE);
    const reviews = await this.prisma.financialSourceRecord.findMany({
      where: {
        sourceType: CHARGEBACK_REVIEW_SOURCE,
        sourceId: { in: page.map((row) => row.id) },
      },
      select: { id: true, sourceId: true, eventType: true },
    });
    const reviewsByEvidence = new Map(
      reviews.map(({ id, sourceId, eventType }) => [
        sourceId,
        { reviewId: id, decision: eventType },
      ]),
    );
    const items = page.map((row) => {
      const { purchaseId } = jsonRecord(row.relatedIds);
      return {
        evidenceId: row.id,
        notificationId: row.sourceId,
        purchaseId: typeof purchaseId === 'string' ? purchaseId : null,
        observedAt: row.occurredAt,
        review: reviewsByEvidence.get(row.id) ?? null,
      };
    });

    // Each item is a refund observation. Multiple observations can refer to
    // the same purchase and must not be treated as independent debits.
    return {
      items,
      nextAfter:
        rows.length > CHARGEBACK_PAGE_SIZE
          ? items[items.length - 1].evidenceId
          : null,
    };
  }

  reviewChargebackEvidence(
    evidenceId: string,
    actorId: string,
    decision: ChargebackReviewDecision,
  ) {
    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "FinancialSourceRecord" WHERE id = ${evidenceId}::uuid AND "sourceType" = ${SOURCE} FOR UPDATE`;
      const evidence = await tx.financialSourceRecord.findFirst({
        where: { ...chargebackEvidenceFilter, id: evidenceId },
        select: { id: true },
      });
      if (!evidence) {
        throw new NotFoundException('Chargeback evidence not found.');
      }

      const key = {
        sourceType: CHARGEBACK_REVIEW_SOURCE,
        sourceId: evidence.id,
      };
      const previous = await tx.financialSourceRecord.findUnique({
        where: { sourceType_sourceId: key },
        select: { id: true, eventType: true },
      });
      if (previous) {
        if (previous.eventType !== String(decision)) {
          throw new ConflictException(
            'This evidence already has a review decision.',
          );
        }
        return { evidenceId, reviewId: previous.id, decision };
      }

      const now = new Date();
      const review = await tx.financialSourceRecord.create({
        data: {
          ...key,
          eventType: decision,
          actorId,
          relatedIds: { evidenceId },
          payload: {},
          occurredAt: now,
        },
        select: { id: true },
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId,
          eventType: 'GOOGLE_PLAY_CHARGEBACK_EVIDENCE_REVIEWED',
          subjectType: 'GOOGLE_PLAY_CHARGEBACK_EVIDENCE',
          subjectId: evidenceId,
          requestId: review.id,
          metadata: { decision },
        },
      });
      return { evidenceId, reviewId: review.id, decision };
    });
  }

  previewRefundReversal(purchaseId: string) {
    return this.prisma.$transaction(
      (tx) => this.calculateRefundReversal(tx, purchaseId),
      { isolationLevel: 'RepeatableRead' },
    );
  }

  private async calculateRefundReversal(
    tx: Prisma.TransactionClient,
    purchaseId: string,
  ) {
    const purchase = await tx.googlePlayPurchase.findUnique({
      where: { id: purchaseId },
      select: {
        userId: true,
        quantity: true,
        coinAmount: true,
        coinEntryKey: true,
      },
    });
    if (!purchase)
      throw new NotFoundException('Google Play purchase not found.');

    const evidence = await tx.financialSourceRecord.findMany({
      where: {
        sourceType: SOURCE,
        eventType: 'GOOGLE_PLAY_REFUND_QUANTITY_OBSERVED',
        beneficiaryId: purchase.userId,
        relatedIds: { path: ['purchaseId'], equals: purchaseId },
      },
      select: { id: true, payload: true },
      orderBy: { id: 'asc' },
    });
    if (!evidence.length) {
      throw new NotFoundException('Verified refund evidence not found.');
    }

    let refundedQuantity = 0;
    let refundEvidenceId = evidence[0].id;
    for (const row of evidence) {
      const quantity = jsonRecord(row.payload).cumulativeRefundedQuantity;
      if (
        typeof quantity !== 'number' ||
        !Number.isSafeInteger(quantity) ||
        quantity < 1 ||
        quantity > purchase.quantity
      ) {
        throw new ConflictException(
          'Refund quantity evidence is inconsistent.',
        );
      }
      if (quantity > refundedQuantity) {
        refundedQuantity = quantity;
        refundEvidenceId = row.id;
      }
    }
    if (
      purchase.quantity < 1 ||
      purchase.coinAmount < 1 ||
      purchase.coinAmount % purchase.quantity !== 0
    ) {
      throw new ConflictException('Purchase coin allocation is inconsistent.');
    }

    const verifiedRefundCoins =
      (purchase.coinAmount / purchase.quantity) * refundedQuantity;
    const balance = await tx.coinEntry.aggregate({
      where: {
        userId: purchase.userId,
        kind: { in: [CoinKind.PURCHASE_GRANT, CoinKind.PURCHASE_SPEND] },
      },
      _sum: { amount: true },
    });
    const netRecoveredForOrder = await netPurchasedCoinRecovery(
      tx,
      purchase.userId,
      purchaseId,
    );
    const netRecoveredFromWallet = await netPurchasedCoinRecovery(
      tx,
      purchase.userId,
    );
    const purchasedWalletCoins = Math.max(
      0,
      (balance._sum.amount ?? 0) - netRecoveredFromWallet,
    );
    const outstandingRefundCoins = Math.max(
      0,
      verifiedRefundCoins - netRecoveredForOrder,
    );
    const coveredByPurchasedWalletCoins = Math.min(
      outstandingRefundCoins,
      purchasedWalletCoins,
    );
    const grant = await tx.coinEntry.findUnique({
      where: { key: purchase.coinEntryKey },
      select: { userId: true, kind: true, amount: true },
    });
    if (
      grant?.userId !== purchase.userId ||
      grant.kind !== CoinKind.PURCHASE_GRANT ||
      grant.amount !== purchase.coinAmount
    ) {
      throw new ConflictException('Purchase credit could not be verified.');
    }
    const spend = await tx.coinEntry.aggregate({
      where: {
        userId: purchase.userId,
        kind: CoinKind.PURCHASE_SPEND,
        amount: { lt: 0 },
      },
      _sum: { amount: true },
    });
    const [attribution] = await tx.$queryRaw<
      { total: bigint; originalOrder: bigint }[]
    >`
      SELECT COALESCE(SUM(item.coins), 0) AS total,
             COALESCE(SUM(item.coins) FILTER (
               WHERE item."purchaseId" = ${purchaseId}::uuid
             ), 0) AS "originalOrder"
      FROM "FinancialSourceRecord" evidence
      CROSS JOIN LATERAL jsonb_to_recordset(evidence.payload->'allocations')
        AS item("purchaseId" uuid, coins integer)
      WHERE evidence."sourceType" = 'GIFT_PURCHASE_SPEND_ALLOCATION'
        AND evidence."beneficiaryId" = ${purchase.userId}::uuid
    `;
    const purchasedSpend = -(spend._sum.amount ?? 0);
    const attributedSpend = Number(attribution.total);
    const originalOrderAttributedSpend = Number(attribution.originalOrder);
    if (
      !Number.isSafeInteger(purchasedSpend) ||
      !Number.isSafeInteger(attributedSpend) ||
      attributedSpend < 0 ||
      attributedSpend > purchasedSpend ||
      originalOrderAttributedSpend < 0 ||
      originalOrderAttributedSpend > Math.min(attributedSpend, grant.amount)
    ) {
      throw new ConflictException(
        'Purchased coin spend attribution is inconsistent.',
      );
    }
    // Only spending explicitly linked to another order can be excluded
    // from this order’s conservative estimate.
    const unattributedPurchasedSpend = purchasedSpend - attributedSpend;
    const conservativelyUnspentOrderCoins = Math.max(
      0,
      grant.amount -
        originalOrderAttributedSpend -
        unattributedPurchasedSpend -
        netRecoveredForOrder,
    );
    const originalOrderCoverage = Math.min(
      coveredByPurchasedWalletCoins,
      conservativelyUnspentOrderCoins,
    );
    return {
      purchaseId,
      refundedQuantity,
      verifiedRefundCoins,
      outstandingRefundCoins,
      refundEvidenceId,
      purchasedWalletCoins,
      coveredByPurchasedWalletCoins,
      originalOrderCoverage,
      netRecoveredForOrder,
      originalOrderAttributedSpend,
      unattributedPurchasedSpend,
      coinsRequiringAttributionReview:
        outstandingRefundCoins - originalOrderCoverage,
      uncoveredCoins: outstandingRefundCoins - coveredByPurchasedWalletCoins,
    };
  }

  async listRefundRecoveries(query: {
    after?: string;
    purchaseId?: string;
    shortfallOnly?: boolean;
  }) {
    const pageSize = 100;
    const rows = await this.prisma.financialSourceRecord.findMany({
      where: {
        sourceType: PURCHASE_RECOVERY_SOURCE,
        ...(query.after ? { id: { gt: query.after } } : {}),
        ...(query.purchaseId
          ? { relatedIds: { path: ['purchaseId'], equals: query.purchaseId } }
          : {}),
        ...(query.shortfallOnly
          ? { payload: { path: ['shortfallCoins'], gt: 0 } }
          : {}),
      },
      orderBy: { id: 'asc' },
      take: pageSize + 1,
      select: {
        id: true,
        amount: true,
        occurredAt: true,
        relatedIds: true,
        payload: true,
      },
    });
    const page = rows.slice(0, pageSize);
    const corrections = await this.prisma.financialSourceRecord.findMany({
      where: {
        sourceType: PURCHASE_RECOVERY_CORRECTION,
        sourceId: { in: page.map(({ id }) => id) },
      },
      select: {
        id: true,
        sourceId: true,
        amount: true,
        occurredAt: true,
        payload: true,
      },
    });
    const correctionsByRecovery = new Map(
      corrections.map((correction) => [correction.sourceId, correction]),
    );
    const items = page.map((row) => {
      const { purchaseId } = jsonRecord(row.relatedIds);
      const {
        verifiedRefundCoins,
        refundEvidenceId,
        shortfallCoins,
        ledgerTransactionId,
      } = jsonRecord(row.payload);
      const correction = correctionsByRecovery.get(row.id);
      const correctionPosting = jsonRecord(
        correction?.payload,
      ).ledgerTransactionId;
      return {
        recoveryId: row.id,
        noticeId: row.id,
        purchaseId: typeof purchaseId === 'string' ? purchaseId : null,
        refundEvidenceId:
          typeof refundEvidenceId === 'string' ? refundEvidenceId : null,
        verifiedRefundCoins:
          typeof verifiedRefundCoins === 'number' ? verifiedRefundCoins : null,
        recoveredCoins: row.amount?.toNumber() ?? 0,
        recordedShortfallCoins:
          typeof shortfallCoins === 'number' ? shortfallCoins : null,
        ledgerTransactionId:
          typeof ledgerTransactionId === 'string' ? ledgerTransactionId : null,
        occurredAt: row.occurredAt,
        correction: correction
          ? {
              correctionId: correction.id,
              noticeId: correction.id,
              restoredCoins: correction.amount?.toNumber() ?? 0,
              ledgerTransactionId:
                typeof correctionPosting === 'string'
                  ? correctionPosting
                  : null,
              occurredAt: correction.occurredAt,
            }
          : null,
      };
    });
    return {
      items,
      nextAfter: rows.length > pageSize ? page[page.length - 1].id : null,
    };
  }

  recoverVerifiedRefund(
    purchaseId: string,
    actorId: string,
    requestId: string,
  ) {
    this.requireRecoveryEnabled();
    return this.prisma.$transaction(async (tx) => {
      const purchase = await this.lockRecoveryWallet(tx, purchaseId);
      const sourceId = `${purchaseId}:${requestId}`;
      const replay = await tx.financialSourceRecord.findUnique({
        where: {
          sourceType_sourceId: {
            sourceType: PURCHASE_RECOVERY_SOURCE,
            sourceId,
          },
        },
      });
      if (replay) {
        return {
          ...jsonRecord(replay.payload),
          recoveryId: replay.id,
          noticeId: replay.id,
        };
      }

      const evidenceScope = {
        beneficiaryId: purchase.userId,
        relatedIds: { path: ['purchaseId'], equals: purchaseId },
      };
      const correction = await tx.financialSourceRecord.findFirst({
        where: { ...evidenceScope, sourceType: PURCHASE_RECOVERY_CORRECTION },
        select: { id: true },
      });
      if (correction) {
        throw new ConflictException(
          'A corrected recovery requires separate case review.',
        );
      }
      const chargebacks = await tx.financialSourceRecord.findMany({
        where: { ...chargebackEvidenceFilter, ...evidenceScope },
        select: { id: true },
      });
      if (chargebacks.length) {
        const referrals = await tx.financialSourceRecord.count({
          where: {
            sourceType: CHARGEBACK_REVIEW_SOURCE,
            sourceId: { in: chargebacks.map(({ id }) => id) },
            eventType: ChargebackReviewDecision.ReferForRecovery,
          },
        });
        if (referrals !== chargebacks.length) {
          throw new ConflictException(
            'Chargeback evidence requires a recovery referral.',
          );
        }
      }

      const preview = await this.calculateRefundReversal(tx, purchaseId);
      const outstanding = preview.outstandingRefundCoins;
      if (!outstanding) {
        throw new ConflictException(
          'The verified refund is already recovered.',
        );
      }
      // Only proven credit from this order is eligible for this operation.
      const recoveredCoins = Math.min(
        outstanding,
        preview.originalOrderCoverage,
      );
      const original = await tx.ledgerTransaction.findUnique({
        where: { idempotencyKey: purchase.coinEntryKey },
        select: { id: true, sourceId: true, eventType: true },
      });
      if (
        original?.sourceId !== purchaseId ||
        original.eventType !== 'GOOGLE_PLAY_COIN_PURCHASE'
      ) {
        throw new ConflictException(
          'The original purchase posting could not be verified.',
        );
      }
      const posting = recoveredCoins
        ? await this.postRecoveryLedger(tx, {
            sourceType: PURCHASE_RECOVERY_SOURCE,
            sourceId,
            purchaseId,
            userId: purchase.userId,
            actorId,
            coins: recoveredCoins,
            originalPostingId: original.id,
          })
        : null;
      const payload = {
        verifiedRefundCoins: preview.verifiedRefundCoins,
        refundEvidenceId: preview.refundEvidenceId,
        recoveredCoins,
        shortfallCoins: outstanding - recoveredCoins,
        ledgerTransactionId: posting?.id ?? null,
      };
      const recovery = await this.writeRecoveryEvidence(tx, {
        sourceType: PURCHASE_RECOVERY_SOURCE,
        sourceId,
        purchaseId,
        userId: purchase.userId,
        actorId,
        coins: recoveredCoins,
        payload,
      });
      return { recoveryId: recovery.id, noticeId: recovery.id, ...payload };
    });
  }

  correctRefundRecovery(
    purchaseId: string,
    recoveryId: string,
    actorId: string,
  ) {
    this.requireRecoveryEnabled();
    return this.prisma.$transaction(async (tx) => {
      const purchase = await this.lockRecoveryWallet(tx, purchaseId);
      const recovery = await tx.financialSourceRecord.findFirst({
        where: {
          id: recoveryId,
          sourceType: PURCHASE_RECOVERY_SOURCE,
          beneficiaryId: purchase.userId,
          relatedIds: { path: ['purchaseId'], equals: purchaseId },
        },
      });
      if (!recovery)
        throw new NotFoundException('Purchase recovery not found.');
      const existing = await tx.financialSourceRecord.findUnique({
        where: {
          sourceType_sourceId: {
            sourceType: PURCHASE_RECOVERY_CORRECTION,
            sourceId: recoveryId,
          },
        },
      });
      if (existing) {
        return {
          ...jsonRecord(existing.payload),
          correctionId: existing.id,
          noticeId: existing.id,
        };
      }
      const restoredCoins = recovery.amount?.toNumber() ?? 0;
      const { ledgerTransactionId } = jsonRecord(recovery.payload);
      if (
        !Number.isSafeInteger(restoredCoins) ||
        restoredCoins <= 0 ||
        typeof ledgerTransactionId !== 'string'
      ) {
        throw new ConflictException('This recovery has no debit to correct.');
      }
      const posting = await this.postRecoveryLedger(tx, {
        sourceType: PURCHASE_RECOVERY_CORRECTION,
        sourceId: recoveryId,
        purchaseId,
        userId: purchase.userId,
        actorId,
        coins: -restoredCoins,
        originalPostingId: ledgerTransactionId,
      });
      const payload = {
        restoredCoins,
        ledgerTransactionId: posting.id,
      };
      const correction = await this.writeRecoveryEvidence(tx, {
        sourceType: PURCHASE_RECOVERY_CORRECTION,
        sourceId: recoveryId,
        purchaseId,
        userId: purchase.userId,
        actorId,
        coins: -restoredCoins,
        payload,
      });
      return {
        correctionId: correction.id,
        noticeId: correction.id,
        ...payload,
      };
    });
  }

  private requireRecoveryEnabled() {
    if (process.env.GOOGLE_PLAY_REFUND_RECOVERY_ENABLED !== 'true') {
      throw new ServiceUnavailableException(
        'Refund recovery posting is disabled.',
      );
    }
  }

  private async lockRecoveryWallet(
    tx: Prisma.TransactionClient,
    purchaseId: string,
  ) {
    const purchase = await tx.googlePlayPurchase.findUnique({
      where: { id: purchaseId },
      select: { userId: true, coinEntryKey: true },
    });
    if (!purchase)
      throw new NotFoundException('Google Play purchase not found.');
    const owner = await tx.$queryRaw<{ id: string }[]>`
      SELECT id FROM "User" WHERE id = ${purchase.userId}::uuid FOR UPDATE
    `;
    if (!owner.length)
      throw new NotFoundException('Purchase wallet not found.');
    await tx.$queryRaw`SELECT id FROM "GooglePlayPurchase" WHERE id = ${purchaseId}::uuid FOR UPDATE`;
    return purchase;
  }

  private postRecoveryLedger(
    tx: Prisma.TransactionClient,
    input: {
      sourceType: string;
      sourceId: string;
      purchaseId: string;
      userId: string;
      actorId: string;
      coins: number;
      originalPostingId: string;
    },
  ) {
    const amount = String(Math.abs(input.coins));
    return this.ledger.postInTransaction(tx, {
      idempotencyKey: `${input.sourceType}:${input.sourceId}`,
      eventType: input.sourceType,
      sourceType: input.sourceType,
      sourceId: input.sourceId,
      currencyCode: 'KCOIN',
      actorId: input.actorId,
      metadata: {
        purchaseId: input.purchaseId,
        originalPostingId: input.originalPostingId,
      },
      postings: [
        {
          accountKey: `USER:${input.userId}:KCOIN:PURCHASED`,
          name: 'Purchased coin wallet liability',
          accountType: 'LIABILITY',
          normalSide: 'CREDIT',
          ownerId: input.userId,
          side: input.coins > 0 ? 'DEBIT' : 'CREDIT',
          amount,
        },
        {
          accountKey: 'SYSTEM:GOOGLE_PLAY:KCOIN:ISSUANCE_CLEARING',
          name: 'Google Play purchased coin issuance clearing',
          accountType: 'ASSET',
          normalSide: 'DEBIT',
          side: input.coins > 0 ? 'CREDIT' : 'DEBIT',
          amount,
        },
      ],
    });
  }

  private async writeRecoveryEvidence(
    tx: Prisma.TransactionClient,
    input: {
      sourceType: string;
      sourceId: string;
      purchaseId: string;
      userId: string;
      actorId: string;
      coins: number;
      payload: Prisma.InputJsonObject;
    },
  ) {
    const evidence = await tx.financialSourceRecord.create({
      data: {
        sourceType: input.sourceType,
        sourceId: input.sourceId,
        eventType: input.sourceType,
        actorId: input.actorId,
        beneficiaryId: input.userId,
        relatedIds: { purchaseId: input.purchaseId },
        amount: Math.abs(input.coins),
        unitCode: 'COIN',
        payload: input.payload,
        occurredAt: new Date(),
      },
      select: { id: true },
    });
    await tx.financialAuditEvent.create({
      data: {
        actorId: input.actorId,
        eventType: input.sourceType,
        subjectType: 'GOOGLE_PLAY_PURCHASE',
        subjectId: input.purchaseId,
        requestId: evidence.id,
        metadata: input.payload,
      },
    });
    return evidence;
  }

  async listPending(after?: string) {
    const rows = await this.prisma.googlePlayNotification.findMany({
      where: {
        processedAt: null,
        ...(after ? { id: { gt: after } } : {}),
      },
      orderBy: { id: 'asc' },
      take: 101,
      select: {
        id: true,
        eventType: true,
        receivedAt: true,
        processingError: true,
        reconciliationAttemptCount: true,
        reconciliationNextAttemptAt: true,
      },
    });
    const items = rows.slice(0, 100);
    return {
      items,
      nextAfter: rows.length > 100 ? items[items.length - 1].id : null,
    };
  }

  async reconcile(id: string, actorId: string | null, leaseId?: string) {
    const key = encryptionKey();
    const packageName = process.env.GOOGLE_PLAY_PACKAGE_NAME?.trim();
    if (
      process.env.GOOGLE_PLAY_RECONCILIATION_ENABLED !== 'true' ||
      !this.googlePlay.isConfigured() ||
      !packageName ||
      !key
    ) {
      throw new ServiceUnavailableException(
        'Google Play reconciliation is not configured.',
      );
    }

    const event = await this.prisma.googlePlayNotification.findUnique({
      where: { id },
    });
    if (!event) throw new NotFoundException('Google Play receipt not found.');
    if (event.processedAt) return { status: 'DUPLICATE' as const, id };
    if (leaseId && event.reconciliationLeaseId !== leaseId) {
      return { status: 'SUPERSEDED' as const, id };
    }
    if (!REFUND_EVENTS.has(event.eventType) || !event.purchaseTokenHash) {
      return this.pending(id, actorId, 'NOT_A_ONE_TIME_REFUND', leaseId);
    }

    const payload = jsonRecord(event.payload);
    const local = await this.prisma.googlePlayPurchase.findUnique({
      where: { purchaseTokenHash: event.purchaseTokenHash },
    });
    if (!local) return this.pending(id, actorId, 'UNMATCHED_PURCHASE', leaseId);
    if (
      payload.packageName !== packageName ||
      !local.orderId ||
      typeof payload.payloadHash !== 'string' ||
      !/^[a-f0-9]{64}$/.test(payload.payloadHash) ||
      (event.eventType === 'ONE_TIME_CANCELED'
        ? payload.productId !== local.productId
        : payload.orderId !== local.orderId)
    ) {
      return this.pending(id, actorId, 'RECEIPT_IDENTITY_MISMATCH', leaseId);
    }

    let token: string;
    try {
      token = decryptPurchaseToken(local.encryptedToken, key);
      if (tokenHash(token) !== local.purchaseTokenHash) {
        throw new Error('Token digest mismatch.');
      }
    } catch {
      return this.pending(id, actorId, 'TOKEN_UNAVAILABLE', leaseId);
    }

    let observation: RefundObservation | null;
    let supporting: Awaited<
      ReturnType<GooglePlayReconciliationService['voidEvidence']>
    >;
    const observedAt = new Date();
    try {
      const [order, purchase] = await Promise.all([
        this.googlePlay.getOrder(local.orderId),
        this.googlePlay.getProductPurchase(token),
      ]);
      observation = observeRefund(
        local,
        token,
        order,
        purchase,
        event.eventType,
      );
      if (!observation) {
        return this.pending(id, actorId, 'REFUND_NOT_CONFIRMED', leaseId);
      }
      supporting = await this.voidEvidence(
        token,
        local.orderId,
        local.quantity,
      );
    } catch {
      // Never expose the provider response, bearer, token or exception details.
      return this.pending(id, actorId, 'PROVIDER_RETRY_REQUIRED', leaseId);
    }
    const confirmed = observation;

    return this.prisma.$transaction(async (tx) => {
      // Serialize evidence per purchase. No network I/O in the transaction.
      await tx.$queryRaw`SELECT id FROM "GooglePlayPurchase" WHERE id = ${local.id}::uuid FOR UPDATE`;
      await tx.$queryRaw`SELECT id FROM "GooglePlayNotification" WHERE id = ${id}::uuid FOR UPDATE`;
      const current = await tx.googlePlayNotification.findUniqueOrThrow({
        where: { id },
      });
      if (current.processedAt) return { status: 'DUPLICATE' as const, id };
      if (leaseId && current.reconciliationLeaseId !== leaseId) {
        return { status: 'SUPERSEDED' as const, id };
      }
      const purchase = await tx.googlePlayPurchase.findUniqueOrThrow({
        where: { id: local.id },
      });
      if (
        purchase.userId !== local.userId ||
        purchase.orderId !== local.orderId ||
        purchase.productId !== local.productId ||
        purchase.purchaseTokenHash !== local.purchaseTokenHash ||
        purchase.quantity !== local.quantity ||
        purchase.coinAmount !== local.coinAmount ||
        current.purchaseTokenHash !== event.purchaseTokenHash ||
        current.eventType !== event.eventType ||
        jsonRecord(current.payload).payloadHash !== payload.payloadHash
      ) {
        return this.recordPending(tx, id, actorId, 'EVIDENCE_CHANGED');
      }

      const prior = await tx.financialSourceRecord.findMany({
        where: {
          sourceType: SOURCE,
          beneficiaryId: local.userId,
          relatedIds: { path: ['purchaseId'], equals: local.id },
        },
        select: { payload: true },
      });
      if (
        prior.some((item) => {
          const quantity = jsonRecord(item.payload).cumulativeRefundedQuantity;
          return (
            typeof quantity !== 'number' ||
            !Number.isSafeInteger(quantity) ||
            quantity > confirmed.cumulativeRefundedQuantity
          );
        })
      ) {
        return this.recordPending(tx, id, actorId, 'CUMULATIVE_REGRESSION');
      }

      const evidence = await tx.financialSourceRecord.create({
        data: {
          sourceType: SOURCE,
          sourceId: id,
          eventType: 'GOOGLE_PLAY_REFUND_QUANTITY_OBSERVED',
          actorId,
          beneficiaryId: local.userId,
          relatedIds: {
            purchaseId: local.id,
            orderId: local.orderId,
            notificationId: id,
          },
          // No amount/unit: this is cumulative evidence, not a posting.
          payload: {
            ...confirmed,
            productId: local.productId,
            eventType: event.eventType,
            observedAt: observedAt.toISOString(),
            voidScan: supporting,
          },
          occurredAt: observedAt,
        },
        select: { id: true },
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId,
          eventType: 'GOOGLE_PLAY_REFUND_EVIDENCE_RETAINED',
          subjectType: 'GOOGLE_PLAY_NOTIFICATION',
          subjectId: id,
          requestId: id,
          metadata: { evidenceId: evidence.id, purchaseId: local.id },
        },
      });
      await tx.googlePlayNotification.update({
        where: { id },
        data: { processedAt: new Date(), processingError: null },
      });
      return {
        status: 'EVIDENCE_RETAINED' as const,
        id,
        evidenceId: evidence.id,
      };
    });
  }

  private pending(
    id: string,
    actorId: string | null,
    reason: string,
    leaseId?: string,
  ) {
    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "GooglePlayNotification" WHERE id = ${id}::uuid FOR UPDATE`;
      const event = await tx.googlePlayNotification.findUniqueOrThrow({
        where: { id },
        select: { processedAt: true, reconciliationLeaseId: true },
      });
      if (event.processedAt) return { status: 'DUPLICATE' as const, id };
      if (leaseId && event.reconciliationLeaseId !== leaseId) {
        return { status: 'SUPERSEDED' as const, id };
      }
      return this.recordPending(tx, id, actorId, reason);
    });
  }

  private async recordPending(
    tx: Prisma.TransactionClient,
    id: string,
    actorId: string | null,
    reason: string,
  ) {
    await tx.googlePlayNotification.update({
      where: { id },
      data: { processingError: reason },
    });
    await tx.financialAuditEvent.create({
      data: {
        actorId,
        eventType: 'GOOGLE_PLAY_REFUND_EVIDENCE_PENDING',
        subjectType: 'GOOGLE_PLAY_NOTIFICATION',
        subjectId: id,
        requestId: id,
        metadata: { reason },
      },
    });
    return { status: 'PENDING' as const, id, reason };
  }

  private async voidEvidence(token: string, orderId: string, quantity: number) {
    const endTime = Date.now();
    const startTime = endTime - 29 * DAY_MS;
    const matched: Array<{
      voidedTimeMillis: string;
      voidedQuantity: number | null;
      voidedReason: number | null;
      voidedSource: number | null;
    }> = [];
    let pageToken: string | undefined;
    const seen = new Set<string>();
    let complete = false;
    let pages = 0;
    for (let page = 0; page < PAGE_LIMIT; page++) {
      const result = await this.googlePlay.listVoidedPurchases(
        startTime,
        endTime,
        pageToken,
      );
      pages++;
      if (
        !result ||
        typeof result !== 'object' ||
        (result.voidedPurchases !== undefined &&
          !Array.isArray(result.voidedPurchases))
      ) {
        throw new Error('Malformed voided purchase page.');
      }
      for (const item of result.voidedPurchases ?? []) {
        if (item.orderId !== orderId || item.purchaseToken !== token) continue;
        if (
          typeof item.voidedTimeMillis !== 'string' ||
          !/^\d{1,16}$/.test(item.voidedTimeMillis) ||
          (item.voidedQuantity !== undefined &&
            (!Number.isSafeInteger(item.voidedQuantity) ||
              item.voidedQuantity <= 0 ||
              item.voidedQuantity > quantity))
        ) {
          throw new Error('Malformed matching void evidence.');
        }
        matched.push({
          voidedTimeMillis: item.voidedTimeMillis,
          voidedQuantity: item.voidedQuantity ?? null,
          voidedReason: Number.isInteger(item.voidedReason)
            ? (item.voidedReason ?? null)
            : null,
          voidedSource: Number.isInteger(item.voidedSource)
            ? (item.voidedSource ?? null)
            : null,
        });
      }
      const next = result.tokenPagination?.nextPageToken;
      if (!next) {
        complete = true;
        break;
      }
      if (typeof next !== 'string' || next.length > 4096 || seen.has(next)) {
        throw new Error('Invalid void pagination.');
      }
      seen.add(next);
      pageToken = next;
    }
    return { startTime, endTime, complete, pages, matched };
  }
}
