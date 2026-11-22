import { BadRequestException } from '@nestjs/common';

/**
 * Reward policy is declarative data, never executable code. A versioned
 * parser keeps old nominations attached to the exact rules under which they
 * were submitted, while allowing a future policy version to add new ideas.
 */
export const POST_REWARD_POLICY_VERSION = 1;

export interface PromotionalCoinsReward {
  type: 'PROMOTIONAL_COINS';
  amount: number;
}

export interface PostRewardPolicyV1 {
  version: 1;
  nomination: {
    enabled: boolean;
    minPostAgeHours: number;
    maxPostAgeDays: number;
    maxPerUserPerDay: number;
    allowSelfNomination: boolean;
  };
  limits: {
    maxAwardsPerPost: number;
    maxAwardsPerCreatorPer30Days: number;
  };
  rewards: PromotionalCoinsReward[];
}

function record(value: unknown): Record<string, unknown> | null {
  return value !== null && typeof value === 'object' && !Array.isArray(value)
    ? (value as Record<string, unknown>)
    : null;
}

function integer(
  value: unknown,
  name: string,
  min: number,
  max: number,
): number {
  if (!Number.isInteger(value) || (value as number) < min || (value as number) > max) {
    throw new BadRequestException(
      `Reward policy ${name} must be a whole number from ${min} to ${max}.`,
    );
  }
  return value as number;
}

function boolean(value: unknown, name: string): boolean {
  if (typeof value !== 'boolean') {
    throw new BadRequestException(`Reward policy ${name} must be true or false.`);
  }
  return value;
}

/**
 * The first registered reward effect is PROMOTIONAL_COINS. New reward types
 * are added by registering a handler in RewardsService, not by trusting a
 * client-provided effect name or running code from JSON.
 */
export function parsePostRewardPolicy(value: unknown): PostRewardPolicyV1 {
  const root = record(value);
  if (!root || root.version !== POST_REWARD_POLICY_VERSION) {
    throw new BadRequestException(
      `Reward policy version must be ${POST_REWARD_POLICY_VERSION}.`,
    );
  }

  const nomination = record(root.nomination);
  const limits = record(root.limits);
  if (!nomination || !limits || !Array.isArray(root.rewards)) {
    throw new BadRequestException(
      'Reward policy needs nomination, limits and rewards sections.',
    );
  }

  if (root.rewards.length < 1 || root.rewards.length > 3) {
    throw new BadRequestException('A reward programme must define 1 to 3 rewards.');
  }

  const rewards = root.rewards.map((raw, index): PromotionalCoinsReward => {
    const item = record(raw);
    if (!item || item.type !== 'PROMOTIONAL_COINS') {
      throw new BadRequestException(
        `Reward ${index + 1} has an unsupported type. PROMOTIONAL_COINS is the only reward handler currently enabled.`,
      );
    }
    return {
      type: 'PROMOTIONAL_COINS',
      amount: integer(item.amount, `rewards[${index}].amount`, 1, 10_000),
    };
  });

  const rewardTypes = rewards.map((reward) => reward.type);
  if (new Set(rewardTypes).size !== rewardTypes.length) {
    throw new BadRequestException(
      'A programme can only grant each reward type once per nomination.',
    );
  }

  return {
    version: 1,
    nomination: {
      enabled: boolean(nomination.enabled, 'nomination.enabled'),
      minPostAgeHours: integer(
        nomination.minPostAgeHours,
        'nomination.minPostAgeHours',
        0,
        24 * 30,
      ),
      maxPostAgeDays: integer(
        nomination.maxPostAgeDays,
        'nomination.maxPostAgeDays',
        1,
        365,
      ),
      maxPerUserPerDay: integer(
        nomination.maxPerUserPerDay,
        'nomination.maxPerUserPerDay',
        1,
        20,
      ),
      allowSelfNomination: boolean(
        nomination.allowSelfNomination,
        'nomination.allowSelfNomination',
      ),
    },
    limits: {
      maxAwardsPerPost: integer(
        limits.maxAwardsPerPost,
        'limits.maxAwardsPerPost',
        1,
        10,
      ),
      maxAwardsPerCreatorPer30Days: integer(
        limits.maxAwardsPerCreatorPer30Days,
        'limits.maxAwardsPerCreatorPer30Days',
        1,
        30,
      ),
    },
    rewards,
  };
}

/** A conservative template; programmes are created as drafts, never seeded active. */
export const DEFAULT_POST_REWARD_POLICY: PostRewardPolicyV1 = {
  version: 1,
  nomination: {
    enabled: true,
    minPostAgeHours: 24,
    maxPostAgeDays: 30,
    maxPerUserPerDay: 3,
    allowSelfNomination: false,
  },
  limits: {
    maxAwardsPerPost: 1,
    maxAwardsPerCreatorPer30Days: 2,
  },
  rewards: [{ type: 'PROMOTIONAL_COINS', amount: 50 }],
};
