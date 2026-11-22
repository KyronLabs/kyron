import { BadRequestException } from '@nestjs/common';

import {
  DEFAULT_POST_REWARD_POLICY,
  parsePostRewardPolicy,
} from './post-reward-policy';

describe('post reward policy', () => {
  it('accepts and normalises the current manual-review policy', () => {
    expect(parsePostRewardPolicy(DEFAULT_POST_REWARD_POLICY)).toEqual(
      DEFAULT_POST_REWARD_POLICY,
    );
  });

  it('rejects an unknown policy version rather than guessing', () => {
    expect(() =>
      parsePostRewardPolicy({ ...DEFAULT_POST_REWARD_POLICY, version: 2 }),
    ).toThrow(BadRequestException);
  });

  it('rejects executable or unregistered reward types', () => {
    expect(() =>
      parsePostRewardPolicy({
        ...DEFAULT_POST_REWARD_POLICY,
        rewards: [{ type: 'RUN_URL', url: 'https://example.invalid' }],
      }),
    ).toThrow('unsupported type');
  });

  it('bounds promotional coin grants', () => {
    expect(() =>
      parsePostRewardPolicy({
        ...DEFAULT_POST_REWARD_POLICY,
        rewards: [{ type: 'PROMOTIONAL_COINS', amount: 10001 }],
      }),
    ).toThrow('whole number from 1 to 10000');
  });

  it('requires nomination and award limits', () => {
    expect(() =>
      parsePostRewardPolicy({
        version: 1,
        nomination: { enabled: true },
        limits: {},
        rewards: [],
      }),
    ).toThrow(BadRequestException);
  });
});
