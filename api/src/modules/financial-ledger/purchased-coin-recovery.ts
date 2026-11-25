import type { Prisma } from '@prisma/client';

export const PURCHASE_RECOVERY_SOURCE = 'GOOGLE_PLAY_PURCHASE_RECOVERY';
export const PURCHASE_RECOVERY_CORRECTION =
  'GOOGLE_PLAY_PURCHASE_RECOVERY_CORRECTION';

/** Recovery evidence uses positive debits and negative compensating credits. */
export async function netPurchasedCoinRecovery(
  tx: Prisma.TransactionClient,
  userId: string,
  purchaseId?: string,
): Promise<number> {
  const total = await tx.financialSourceRecord.aggregate({
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
  return total._sum.amount?.toNumber() ?? 0;
}
