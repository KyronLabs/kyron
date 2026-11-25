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
