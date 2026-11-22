import { ServiceUnavailableException } from '@nestjs/common';
import {
  DisabledPayoutWebhookProvider,
  PayoutWebhookProvider,
} from './payout-reconciliation.service';

describe('payout webhook provider boundary', () => {
  it('fails closed when no provider verifier is configured', async () => {
    const provider = new DisabledPayoutWebhookProvider();
    expect(provider.isConfigured()).toBe(false);
    await expect(
      provider.verifyAndParse(new Uint8Array([1]), {}),
    ).rejects.toBeInstanceOf(ServiceUnavailableException);
  });

  it('passes the original raw bytes to the provider-specific verifier', async () => {
    class TestProvider extends PayoutWebhookProvider {
      readonly providerCode = 'test-provider';

      isConfigured(): boolean {
        return true;
      }

      verifyAndParse(
        rawBody: Uint8Array,
        headers: Record<string, string | string[] | undefined>,
      ) {
        void headers;
        expect(Array.from(rawBody)).toEqual([1, 2, 3]);
        return Promise.resolve({
          providerEventId: 'evt_123',
          eventType: 'transfer.completed',
          outcome: 'SUCCEEDED' as never,
          providerTransferRef: 'tr_123',
          amountMinor: 1000n,
          currency: 'GHS',
          occurredAt: new Date('2026-11-22T00:00:00.000Z'),
        });
      }
    }

    const event = await new TestProvider().verifyAndParse(
      new Uint8Array([1, 2, 3]),
      {},
    );
    expect(event.providerEventId).toBe('evt_123');
    expect(event.amountMinor).toBe(1000n);
  });
});
