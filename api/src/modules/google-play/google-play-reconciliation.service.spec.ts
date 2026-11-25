import { createHash } from 'node:crypto';
import type {
  GooglePlayOrder,
  GooglePlayProductPurchaseV2,
} from './google-play-developer-api.provider';
import { observeRefund } from './google-play-reconciliation.service';
import {
  decryptPurchaseToken,
  encryptPurchaseToken,
} from './google-play-token';

const local = {
  userId: '11111111-1111-4111-8111-111111111111',
  orderId: 'GPA.test',
  productId: 'coins.test',
  quantity: 3,
  coinAmount: 120,
};
const token = 'test-purchase-token';
const account = createHash('sha256')
  .update('kyron/google-play/account/v1:', 'utf8')
  .update(local.userId, 'utf8')
  .digest('hex');

function order(state: string): GooglePlayOrder {
  return {
    orderId: local.orderId,
    purchaseToken: token,
    state,
    lineItems: [
      {
        productId: local.productId,
        oneTimePurchaseDetails: { quantity: 3 },
      },
    ],
  };
}

function purchase(remaining?: number): GooglePlayProductPurchaseV2 {
  return {
    orderId: local.orderId,
    obfuscatedExternalAccountId: account,
    purchaseStateContext: { purchaseState: 'PURCHASED' },
    productLineItem: [
      {
        productId: local.productId,
        productOfferDetails: { quantity: 3, refundableQuantity: remaining },
      },
    ],
  };
}

describe('Google Play refund quantity evidence', () => {
  it('uses original purchased coins and cumulative refunded quantity', () => {
    expect(
      observeRefund(
        local,
        token,
        order('PARTIALLY_REFUNDED'),
        purchase(1),
        'ONE_TIME_PARTIAL_VOID',
      ),
    ).toEqual({
      orderState: 'PARTIALLY_REFUNDED',
      originalQuantity: 3,
      remainingRefundableQuantity: 1,
      cumulativeRefundedQuantity: 2,
      cumulativeRefundedCoins: 80,
    });
  });

  it('allows a late partial notification to observe a completed full refund', () => {
    expect(
      observeRefund(
        local,
        token,
        order('REFUNDED'),
        purchase(0),
        'ONE_TIME_PARTIAL_VOID',
      ),
    ).toMatchObject({ cumulativeRefundedQuantity: 3 });
  });

  it.each([undefined, -1, 1.5, 3, 4])(
    'rejects missing, invalid or unchanged refundable quantity %s',
    (remaining) => {
      expect(
        observeRefund(
          local,
          token,
          order('PARTIALLY_REFUNDED'),
          purchase(remaining),
          'ONE_TIME_PARTIAL_VOID',
        ),
      ).toBeNull();
    },
  );

  it('does not treat a pending or inconsistent refund as complete', () => {
    for (const state of ['PENDING_REFUND', 'PROCESSED', 'CANCELED']) {
      expect(
        observeRefund(
          local,
          token,
          order(state),
          purchase(0),
          'ONE_TIME_FULL_VOID',
        ),
      ).toBeNull();
    }
    expect(
      observeRefund(
        local,
        token,
        order('PARTIALLY_REFUNDED'),
        purchase(1),
        'ONE_TIME_FULL_VOID',
      ),
    ).toBeNull();
  });

  it('rejects token, account and order mismatches', () => {
    const validOrder = order('REFUNDED');
    const validPurchase = purchase(0);
    expect(
      observeRefund(
        local,
        'other-token',
        validOrder,
        validPurchase,
        'ONE_TIME_FULL_VOID',
      ),
    ).toBeNull();
    expect(
      observeRefund(
        local,
        token,
        validOrder,
        { ...validPurchase, obfuscatedExternalAccountId: 'other' },
        'ONE_TIME_FULL_VOID',
      ),
    ).toBeNull();
    expect(
      observeRefund(
        local,
        token,
        { ...validOrder, orderId: 'other' },
        validPurchase,
        'ONE_TIME_FULL_VOID',
      ),
    ).toBeNull();
  });
});

describe('Google Play encrypted token decoding', () => {
  it('round trips the v1 envelope and rejects tampering and wrong keys', () => {
    const key = Buffer.alloc(32, 7);
    const encrypted = encryptPurchaseToken(token, key);
    expect(decryptPurchaseToken(encrypted, key)).toBe(token);
    expect(() => decryptPurchaseToken(encrypted, Buffer.alloc(32, 8))).toThrow(
      'Google Play token could not be decrypted.',
    );
    const parts = encrypted.split('.');
    parts[3] = (parts[3][0] === 'A' ? 'B' : 'A') + parts[3].slice(1);
    expect(() => decryptPurchaseToken(parts.join('.'), key)).toThrow(
      'Google Play token could not be decrypted.',
    );
    expect(() => decryptPurchaseToken('v2.a.b.c', key)).toThrow(
      'Google Play token could not be decrypted.',
    );
  });
});
