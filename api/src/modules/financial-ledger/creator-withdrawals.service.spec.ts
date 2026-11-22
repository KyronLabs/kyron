import { ServiceUnavailableException } from '@nestjs/common';

import {
  DisabledBankPayoutProvider,
  DisabledFxQuoteProvider,
  readCreatorWithdrawalPolicy,
} from './creator-withdrawals.service';

describe('creator withdrawal policy', () => {
  it('keeps withdrawals disabled when no configuration is supplied', () => {
    expect(readCreatorWithdrawalPolicy({} as NodeJS.ProcessEnv)).toEqual({
      enabled: false,
      minimumCoins: null,
    });
  });

  it('does not enable withdrawals without a valid positive minimum', () => {
    expect(
      readCreatorWithdrawalPolicy({
        CREATOR_WITHDRAWALS_ENABLED: 'true',
        CREATOR_WITHDRAWAL_MIN_COINS: '0',
      } as NodeJS.ProcessEnv).enabled,
    ).toBe(false);
    expect(
      readCreatorWithdrawalPolicy({
        CREATOR_WITHDRAWALS_ENABLED: 'true',
        CREATOR_WITHDRAWAL_MIN_COINS: 'not-a-number',
      } as NodeJS.ProcessEnv).enabled,
    ).toBe(false);
  });

  it('requires both the explicit feature flag and a configured minimum', () => {
    expect(
      readCreatorWithdrawalPolicy({
        CREATOR_WITHDRAWALS_ENABLED: 'true',
        CREATOR_WITHDRAWAL_MIN_COINS: '500',
      } as NodeJS.ProcessEnv),
    ).toEqual({ enabled: true, minimumCoins: 500 });
  });
});

describe('disabled payout adapters', () => {
  it('reports that the FX provider is not configured', () => {
    expect(new DisabledFxQuoteProvider().isConfigured()).toBe(false);
  });

  it('refuses to create FX quotes without a configured provider', async () => {
    await expect(new DisabledFxQuoteProvider().quote()).rejects.toBeInstanceOf(
      ServiceUnavailableException,
    );
  });

  it('reports that the bank payout provider is not configured', () => {
    expect(new DisabledBankPayoutProvider().isConfigured()).toBe(false);
  });

  it('refuses to submit bank payouts without a configured provider', async () => {
    await expect(new DisabledBankPayoutProvider().submit()).rejects.toBeInstanceOf(
      ServiceUnavailableException,
    );
  });
});
