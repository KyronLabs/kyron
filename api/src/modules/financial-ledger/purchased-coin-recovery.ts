import type { Prisma } from '@prisma/client';

export const PURCHASE_RECOVERY_SOURCE = 'GOOGLE_PLAY_PURCHASE_RECOVERY';
export const PURCHASE_RECOVERY_CORRECTION =
  'GOOGLE_PLAY_PURCHASE_RECOVERY_CORRECTION';

/** Evidence amounts are unsigned. The source type determines direction. */
export async function netPurchasedCoinRecovery(
  tx: Prisma.TransactionClient,
  userId: string,
  purchaseId?: string,
): Promise<number> {
  const total = await tx.financialSourceRecord.groupBy({
    by: ['sourceType'],
    where: {
      sourceType: {
        in: [PURCHASE_RECOVERY_SOURCE, PURCHASE_RECOVERY_CORRECTION],
      },
      beneficiaryId: userId,
      ...(purchaseId
        ? { relatedIds: { path: ['purchaseId'], equals: purchaseId } }
        : {}),
    },
    _sum: { amount: true },
  });
  return total.reduce((net, row) => {
    const amount = row._sum.amount?.toNumber() ?? 0;
    return row.sourceType === PURCHASE_RECOVERY_SOURCE
      ? net + amount
      : net - amount;
  }, 0);
}

/** Buyer-visible notices derived from committed wallet adjustments. */
export async function listPurchasedCoinNotices(
  tx: Prisma.TransactionClient,
  userId: string,
) {
  const rows = await tx.financialSourceRecord.findMany({
    where: {
      sourceType: {
        in: [PURCHASE_RECOVERY_SOURCE, PURCHASE_RECOVERY_CORRECTION],
      },
      beneficiaryId: userId,
    },
    orderBy: [{ occurredAt: 'desc' }, { id: 'desc' }],
    take: 20,
    select: {
      id: true,
      sourceType: true,
      relatedIds: true,
      payload: true,
      amount: true,
      occurredAt: true,
    },
  });
  const jsonObject = (value: Prisma.JsonValue) =>
    value && typeof value === 'object' && !Array.isArray(value) ? value : {};
  const purchaseIds = rows.flatMap(({ relatedIds }) => {
    const { purchaseId } = jsonObject(relatedIds);
    return typeof purchaseId === 'string' ? [purchaseId] : [];
  });
  const orders = await tx.googlePlayPurchase.findMany({
    where: { id: { in: purchaseIds }, userId },
    select: { id: true, orderId: true },
  });
  const orderIds = new Map(orders.map(({ id, orderId }) => [id, orderId]));
  return rows.map((row) => {
    const { purchaseId } = jsonObject(row.relatedIds);
    const correction = row.sourceType === PURCHASE_RECOVERY_CORRECTION;
    const { verifiedRefundCoins } = jsonObject(row.payload);
    return {
      id: row.id,
      kind: correction ? 'CORRECTION' : 'RECOVERY',
      orderReference:
        typeof purchaseId === 'string'
          ? (orderIds.get(purchaseId) ?? null)
          : null,
      coins: row.amount?.toNumber() ?? 0,
      verifiedRefundCoins:
        !correction && typeof verifiedRefundCoins === 'number'
          ? verifiedRefundCoins
          : null,
      occurredAt: row.occurredAt,
    };
  });
}
