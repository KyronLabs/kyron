import { CoinKind } from '@prisma/client';

import {
  giftIdFromCoinEntryKey,
  isUuid,
  mapLegacyCoinKind,
  planLegacyCoinEntry,
  rewardGrantIdFromCoinEntryKey,
} from './legacy-coin-bridge';

describe('legacy coin bridge mapping', () => {
  const createdAt = new Date('2026-10-01T12:00:00.000Z');
  const entry = {
    id: '6f9c5b08-a409-4268-a7d2-8d6f9a1e2b50',
    userId: '9b7e5f2d-2b24-4d80-9dc5-9a2db2f08c11',
    kind: CoinKind.GRANT,
    amount: 12,
    key: 'legacy-grant:fixture',
    giftId: null,
    createdAt,
  };

  it.each([
    [CoinKind.GRANT, 'LEGACY_COMPLIMENTARY', false],
    [CoinKind.SPEND, 'LEGACY_COMPLIMENTARY', false],
    [CoinKind.REWARD_GRANT, 'REWARD_PROMOTIONAL', false],
    [CoinKind.REWARD_SPEND, 'REWARD_PROMOTIONAL', false],
    [CoinKind.PURCHASE_EARN, 'CREATOR_PAYABLE', true],
    [CoinKind.REWARD_EARN, 'CREATOR_PAYABLE', true],
    [CoinKind.PROMOTIONAL_EARN, 'CREATOR_PROMOTIONAL', false],
    [CoinKind.EARN, 'CREATOR_UNKNOWN', false],
  ] as const)(
    'maps %s without changing its eligibility',
    (kind, bucket, withdrawable) => {
      expect(mapLegacyCoinKind(kind)).toMatchObject({ bucket, withdrawable });
    },
  );

  it('plans a positive liability credit with a balancing offset debit', () => {
    const plan = planLegacyCoinEntry(entry);

    expect(plan).toMatchObject({
      idempotencyKey: `legacy-coin-entry:${entry.id}`,
      sourceType: 'LEGACY_COIN_ENTRY',
      sourceId: entry.id,
      currencyCode: 'KCOIN',
      effectiveAt: createdAt,
      postings: [
        {
          accountKey: `USER:${entry.userId}:KCOIN:LEGACY_COMPLIMENTARY`,
          accountType: 'LIABILITY',
          normalSide: 'CREDIT',
          side: 'CREDIT',
          amount: '12',
        },
        {
          accountKey:
            'SYSTEM:LEGACY_COIN_BRIDGE:KCOIN:LEGACY_COMPLIMENTARY:OFFSET',
          accountType: 'EQUITY',
          side: 'DEBIT',
          amount: '12',
        },
      ],
    });
  });

  it('debits the user liability for a negative spend and keeps the offset balanced', () => {
    const plan = planLegacyCoinEntry({
      ...entry,
      kind: CoinKind.REWARD_SPEND,
      amount: -7,
    });

    expect(plan?.postings).toMatchObject([
      {
        accountKey: `USER:${entry.userId}:KCOIN:REWARD_PROMOTIONAL`,
        side: 'DEBIT',
        amount: '7',
      },
      {
        accountKey:
          'SYSTEM:LEGACY_COIN_BRIDGE:KCOIN:REWARD_PROMOTIONAL:OFFSET',
        side: 'CREDIT',
        amount: '7',
      },
    ]);
  });

  it('does not make unknown or legacy promotional proceeds withdrawable', () => {
    expect(
      planLegacyCoinEntry({
        ...entry,
        kind: CoinKind.EARN,
        amount: 5,
      })?.metadata.withdrawable,
    ).toBe(false);
    expect(
      planLegacyCoinEntry({
        ...entry,
        kind: CoinKind.PROMOTIONAL_EARN,
        amount: 5,
      })?.metadata.balanceBucket,
    ).toBe('CREATOR_PROMOTIONAL');
    expect(
      planLegacyCoinEntry({
        ...entry,
        kind: CoinKind.REWARD_EARN,
        amount: 5,
      })?.metadata.withdrawable,
    ).toBe(true);
  });

  it('refuses to plan zero-amount and unknown-kind rows', () => {
    expect(planLegacyCoinEntry({ ...entry, amount: 0 })).toBeNull();
    expect(
      planLegacyCoinEntry({ ...entry, kind: 'FUTURE_KIND', amount: 1 }),
    ).toBeNull();
    expect(mapLegacyCoinKind('FUTURE_KIND')).toBeNull();
  });

  it('validates owner UUIDs before accepting an operator scope', () => {
    expect(isUuid(entry.userId)).toBe(true);
    expect(isUuid('not-a-uuid')).toBe(false);
  });

  it('extracts source IDs from the idempotency keys used by current writers', () => {
    const giftId = '0c3f4c62-42c5-4d10-a11a-1185d2139de4';
    const grantId = '4dfe11f2-dede-4351-a7a7-3d06db8db913';

    expect(giftIdFromCoinEntryKey(`gift:${giftId}:reward-spend`)).toBe(
      giftId,
    );
    expect(
      rewardGrantIdFromCoinEntryKey(`reward:${grantId}`),
    ).toBe(grantId);
    expect(giftIdFromCoinEntryKey('not-a-gift-key')).toBeNull();
    expect(rewardGrantIdFromCoinEntryKey(`reward:${grantId}:extra`)).toBeNull();
  });
});
