import {
  Injectable,
  NotFoundException,
  ServiceUnavailableException,
} from '@nestjs/common';
import type { GooglePlayPurchase, Prisma } from '@prisma/client';
import { createHash } from 'node:crypto';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
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
const REFUND_EVENTS = new Set([
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

@Injectable()
export class GooglePlayReconciliationService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly googlePlay: GooglePlayDeveloperApiProvider,
  ) {}

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
      },
    });
    const items = rows.slice(0, 100);
    return {
      items,
      nextAfter: rows.length > 100 ? items[items.length - 1].id : null,
    };
  }

  async reconcile(id: string, actorId: string) {
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
    if (!REFUND_EVENTS.has(event.eventType) || !event.purchaseTokenHash) {
      return this.pending(id, actorId, 'NOT_A_ONE_TIME_REFUND');
    }

    const payload = jsonRecord(event.payload);
    const local = await this.prisma.googlePlayPurchase.findUnique({
      where: { purchaseTokenHash: event.purchaseTokenHash },
    });
    if (!local) return this.pending(id, actorId, 'UNMATCHED_PURCHASE');
    if (
      payload.packageName !== packageName ||
      !local.orderId ||
      typeof payload.payloadHash !== 'string' ||
      !/^[a-f0-9]{64}$/.test(payload.payloadHash) ||
      (event.eventType === 'ONE_TIME_CANCELED'
        ? payload.productId !== local.productId
        : payload.orderId !== local.orderId)
    ) {
      return this.pending(id, actorId, 'RECEIPT_IDENTITY_MISMATCH');
    }

    let token: string;
    try {
      token = decryptPurchaseToken(local.encryptedToken, key);
      if (tokenHash(token) !== local.purchaseTokenHash) {
        throw new Error('Token digest mismatch.');
      }
    } catch {
      return this.pending(id, actorId, 'TOKEN_UNAVAILABLE');
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
        return this.pending(id, actorId, 'REFUND_NOT_CONFIRMED');
      }
      supporting = await this.voidEvidence(
        token,
        local.orderId,
        local.quantity,
      );
    } catch {
      // Never expose the provider response, bearer, token or exception details.
      return this.pending(id, actorId, 'PROVIDER_RETRY_REQUIRED');
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

  private pending(id: string, actorId: string, reason: string) {
    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "GooglePlayNotification" WHERE id = ${id}::uuid FOR UPDATE`;
      const event = await tx.googlePlayNotification.findUniqueOrThrow({
        where: { id },
        select: { processedAt: true },
      });
      if (event.processedAt) return { status: 'DUPLICATE' as const, id };
      return this.recordPending(tx, id, actorId, reason);
    });
  }

  private async recordPending(
    tx: Prisma.TransactionClient,
    id: string,
    actorId: string,
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
