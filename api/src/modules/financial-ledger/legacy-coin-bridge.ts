import {
  CoinKind,
  type FinancialAccountType,
  type FinancialEntrySide,
} from '@prisma/client';

export const LEGACY_COIN_BUCKETS = [
  'LEGACY_COMPLIMENTARY',
  'REWARD_PROMOTIONAL',
  'CREATOR_PAYABLE',
  'CREATOR_PROMOTIONAL',
  'CREATOR_UNKNOWN',
] as const;

export type LegacyCoinBucket = (typeof LEGACY_COIN_BUCKETS)[number];

export interface LegacyCoinEntryLike {
  id: string;
  userId: string;
  kind: string;
  amount: number;
  key: string;
  giftId: string | null;
  createdAt: Date;
}

export interface LegacyCoinKindMapping {
  bucket: LegacyCoinBucket;
  label: string;
  withdrawable: boolean;
}

export interface LegacyLedgerPostingPlan {
  accountKey: string;
  name: string;
  accountType: FinancialAccountType;
  normalSide: FinancialEntrySide;
  ownerId: string | null;
  side: FinancialEntrySide;
  amount: string;
  memo: string;
}

export interface LegacyLedgerTransactionPlan {
  idempotencyKey: string;
  eventType: 'LEGACY_COIN_ENTRY_IMPORT';
  sourceType: 'LEGACY_COIN_ENTRY';
  sourceId: string;
  currencyCode: 'KCOIN';
  description: string;
  effectiveAt: Date;
  metadata: {
    coinEntryId: string;
    coinEntryKind: string;
    legacyKey: string;
    legacyGiftId: string | null;
    balanceBucket: LegacyCoinBucket;
    withdrawable: boolean;
  };
  postings: [LegacyLedgerPostingPlan, LegacyLedgerPostingPlan];
}

const KIND_MAPPING: Record<CoinKind, LegacyCoinKindMapping> = {
  [CoinKind.GRANT]: {
    bucket: 'LEGACY_COMPLIMENTARY',
    label: 'Grandfathered weekly complimentary coins',
    withdrawable: false,
  },
  [CoinKind.SPEND]: {
    bucket: 'LEGACY_COMPLIMENTARY',
    label: 'Grandfathered weekly complimentary coins',
    withdrawable: false,
  },
  [CoinKind.REWARD_GRANT]: {
    bucket: 'REWARD_PROMOTIONAL',
    label: 'Approved promotional reward coins',
    withdrawable: false,
  },
  [CoinKind.REWARD_SPEND]: {
    bucket: 'REWARD_PROMOTIONAL',
    label: 'Approved promotional reward coins',
    withdrawable: false,
  },
  [CoinKind.PURCHASE_EARN]: {
    bucket: 'CREATOR_PAYABLE',
    label: 'Purchased-coin creator proceeds',
    withdrawable: true,
  },
  [CoinKind.REWARD_EARN]: {
    bucket: 'CREATOR_PAYABLE',
    label: 'Reward-funded creator proceeds',
    withdrawable: true,
  },
  [CoinKind.PROMOTIONAL_EARN]: {
    bucket: 'CREATOR_PROMOTIONAL',
    label: 'Legacy complimentary creator proceeds',
    withdrawable: false,
  },
  [CoinKind.EARN]: {
    bucket: 'CREATOR_UNKNOWN',
    label: 'Creator proceeds with unknown legacy provenance',
    withdrawable: false,
  },
};

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const GIFT_KEY =
  /^gift:([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}):/i;
const REWARD_KEY =
  /^reward:([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})$/i;

export function mapLegacyCoinKind(
  kind: string,
): LegacyCoinKindMapping | null {
  return KIND_MAPPING[kind as CoinKind] ?? null;
}

/**
 * Produces a deterministic, balanced two-line opening-history transaction.
 * Positive CoinEntry amounts credit the user's liability; negative amounts
 * debit it. The offset account makes each imported row balance independently.
 * This function only describes a posting: it never writes to the database.
 */
export function planLegacyCoinEntry(
  entry: LegacyCoinEntryLike,
): LegacyLedgerTransactionPlan | null {
  const mapping = mapLegacyCoinKind(entry.kind);
  if (!mapping || entry.amount === 0) return null;

  const positive = entry.amount > 0;
  const userSide: FinancialEntrySide = positive ? 'CREDIT' : 'DEBIT';
  const offsetSide: FinancialEntrySide = positive ? 'DEBIT' : 'CREDIT';
  const amount = String(Math.abs(entry.amount));
  const userAccountKey = `USER:${entry.userId}:KCOIN:${mapping.bucket}`;
  const offsetAccountKey = `SYSTEM:LEGACY_COIN_BRIDGE:KCOIN:${mapping.bucket}:OFFSET`;

  return {
    idempotencyKey: `legacy-coin-entry:${entry.id}`,
    eventType: 'LEGACY_COIN_ENTRY_IMPORT',
    sourceType: 'LEGACY_COIN_ENTRY',
    sourceId: entry.id,
    currencyCode: 'KCOIN',
    description: `Legacy coin history: ${mapping.label}`,
    effectiveAt: entry.createdAt,
    metadata: {
      coinEntryId: entry.id,
      coinEntryKind: entry.kind,
      legacyKey: entry.key,
      legacyGiftId: entry.giftId,
      balanceBucket: mapping.bucket,
      withdrawable: mapping.withdrawable,
    },
    postings: [
      {
        accountKey: userAccountKey,
        name: mapping.label,
        accountType: 'LIABILITY',
        normalSide: 'CREDIT',
        ownerId: entry.userId,
        side: userSide,
        amount,
        memo: `Imported CoinEntry ${entry.id}`,
      },
      {
        accountKey: offsetAccountKey,
        name: `Legacy coin bridge offset — ${mapping.label}`,
        accountType: 'EQUITY',
        normalSide: 'CREDIT',
        ownerId: null,
        side: offsetSide,
        amount,
        memo: `Offset for CoinEntry ${entry.id}`,
      },
    ],
  };
}

export function giftIdFromCoinEntryKey(key: string): string | null {
  const match = GIFT_KEY.exec(key);
  return match?.[1] ?? null;
}

export function rewardGrantIdFromCoinEntryKey(key: string): string | null {
  const match = REWARD_KEY.exec(key);
  return match?.[1] ?? null;
}

export function isUuid(value: string): boolean {
  return UUID.test(value);
}
