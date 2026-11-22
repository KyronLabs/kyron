import { BadRequestException } from '@nestjs/common';
import { CoinKind, CreatorEarningSource } from '@prisma/client';

import { planCreatorEarning } from './creator-earnings.service';

describe('creator earning provenance', () => {
  const base = {
    userId: '00000000-0000-4000-8000-000000000001',
    amount: 12,
    key: 'gift:00000000-0000-4000-8000-000000000002:earn',
    giftId: '00000000-0000-4000-8000-000000000002',
  };

  it('marks purchased proceeds withdrawable', () => {
    expect(
      planCreatorEarning({ ...base, kind: CoinKind.PURCHASE_EARN }),
    ).toMatchObject({
      source: CreatorEarningSource.PURCHASE,
      amount: 12,
      withdrawable: true,
    });
  });

  it('marks approved reward proceeds withdrawable on the same terms', () => {
    expect(
      planCreatorEarning({ ...base, kind: CoinKind.REWARD_EARN }),
    ).toMatchObject({
      source: CreatorEarningSource.APPROVED_REWARD,
      amount: 12,
      withdrawable: true,
    });
  });

  it('keeps retired promotional and unknown legacy proceeds non-withdrawable', () => {
    expect(
      planCreatorEarning({ ...base, kind: CoinKind.PROMOTIONAL_EARN }),
    ).toMatchObject({
      source: CreatorEarningSource.LEGACY_PROMOTIONAL,
      withdrawable: false,
    });
    expect(planCreatorEarning({ ...base, kind: CoinKind.EARN })).toMatchObject({
      source: CreatorEarningSource.UNKNOWN,
      withdrawable: false,
    });
  });

  it('rejects spend entries and non-positive values', () => {
    expect(() =>
      planCreatorEarning({ ...base, kind: CoinKind.REWARD_SPEND }),
    ).toThrow(BadRequestException);
    expect(() =>
      planCreatorEarning({
        ...base,
        kind: CoinKind.REWARD_EARN,
        amount: 0,
      }),
    ).toThrow(BadRequestException);
  });
});
