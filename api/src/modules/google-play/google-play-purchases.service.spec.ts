import { createHash } from 'node:crypto';
import { BadRequestException } from '@nestjs/common';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { LedgerService } from '../financial-ledger/ledger.service';
import {
  GooglePlayDeveloperApiProvider,
  type GooglePlayOrder,
  type GooglePlayProductPurchaseV2,
} from './google-play-developer-api.provider';
import { GooglePlayPurchasesService } from './google-play-purchases.service';

const userId = 'e8f2a2d8-8d4d-4a3b-b8e2-6f6c0c05bcb7';
const purchaseToken = 'test-purchase-token-that-is-long-enough-to-validate';
const obfuscatedId = createHash('sha256')
  .update('kyron/google-play/account/v1:')
  .update(userId)
  .digest('hex');

const purchased: GooglePlayProductPurchaseV2 = {
  orderId: 'GPA.1234-5678-9012-34567',
  purchaseCompletionTime: '2026-11-23T12:00:00Z',
  obfuscatedExternalAccountId: obfuscatedId,
  acknowledgementState: 'ACKNOWLEDGEMENT_STATE_PENDING',
  purchaseStateContext: { purchaseState: 'PURCHASED' },
  productLineItem: [
    {
      productId: 'coins.test.small',
      productOfferDetails: {
        quantity: 2,
        refundableQuantity: 2,
        consumptionState: 'CONSUMPTION_STATE_YET_TO_BE_CONSUMED',
      },
    },
  ],
};

const order: GooglePlayOrder = {
  orderId: 'GPA.1234-5678-9012-34567',
  purchaseToken,
  state: 'PROCESSED',
  lineItems: [
    {
      productId: 'coins.test.small',
      oneTimePurchaseDetails: { quantity: 2 },
      total: {
        currencyCode: 'USD',
        units: '15',
        nanos: 250_000_000,
      },
    },
  ],
  total: {
    currencyCode: 'USD',
    units: '15',
    nanos: 250_000_000,
  },
  developerRevenueInBuyerCurrency: {
    currencyCode: 'USD',
    units: '10',
    nanos: 125_000_000,
  },
};

interface CoinEntryCreateInput {
  data: {
    userId: string;
    kind: string;
    amount: number;
    key: string;
  };
}

interface LedgerPostInput {
  currencyCode: string;
  idempotencyKey: string;
  postings: Array<{
    side: string;
    accountType: string;
    ownerId?: string;
    amount: string;
  }>;
}

interface PurchaseTransactionMock {
  $queryRaw: jest.Mock;
  user: { findUnique: jest.Mock };
  googlePlayPurchase: {
    findUnique: jest.Mock;
    create: jest.Mock;
    updateMany: jest.Mock;
  };
  coinEntry: {
    create: jest.Mock<Promise<unknown>, [CoinEntryCreateInput]>;
  };
  financialSourceRecord: { create: jest.Mock };
  financialAuditEvent: { create: jest.Mock };
}

interface PurchasePrismaMock {
  googlePlayPurchase: { findUnique: jest.Mock };
  $transaction: jest.Mock;
}

describe('GooglePlayPurchasesService', () => {
  const originalEnv = { ...process.env };
  let service: GooglePlayPurchasesService;
  let prisma: PurchasePrismaMock;
  let tx: PurchaseTransactionMock;
  let ledger: {
    postInTransaction: jest.Mock<
      Promise<{ id: string }>,
      [unknown, LedgerPostInput]
    >;
  };
  let googlePlay: {
    isConfigured: jest.Mock;
    getProductPurchase: jest.Mock;
    getOrder: jest.Mock;
    consume: jest.Mock;
  };
  let createdPurchaseData: Record<string, unknown> | null;

  beforeEach(() => {
    createdPurchaseData = null;
    process.env.GOOGLE_PLAY_PURCHASES_ENABLED = 'true';
    process.env.GOOGLE_PLAY_PACKAGE_NAME = 'so.kyron.app';
    process.env.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON = JSON.stringify({
      client_email: 'kyron-test@project.iam.gserviceaccount.com',
      private_key:
        '-----BEGIN PRIVATE KEY-----\\ntest\\n-----END PRIVATE KEY-----',
    });
    process.env.GOOGLE_PLAY_TOKEN_ENCRYPTION_KEY = Buffer.alloc(32, 7).toString(
      'base64',
    );
    process.env.GOOGLE_PLAY_COIN_PRODUCTS = JSON.stringify([
      { productId: 'coins.test.small', coins: 100 },
    ]);

    const createPurchase = jest
      .fn()
      .mockImplementation(({ data }: { data: Record<string, unknown> }) => {
        createdPurchaseData = data;
        return Promise.resolve({
          id: 'purchase-row-1',
          ...data,
          status: 'VERIFIED',
        });
      });
    tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: userId }]),
      user: {
        findUnique: jest.fn().mockResolvedValue({ status: 'ACTIVE' }),
      },
      googlePlayPurchase: {
        findUnique: jest.fn().mockResolvedValue(null),
        create: createPurchase,
        updateMany: jest.fn().mockResolvedValue({ count: 1 }),
      },
      coinEntry: {
        create: jest
          .fn<Promise<unknown>, [CoinEntryCreateInput]>()
          .mockResolvedValue({}),
      },
      financialSourceRecord: { create: jest.fn().mockResolvedValue({}) },
      financialAuditEvent: { create: jest.fn().mockResolvedValue({}) },
    };
    prisma = {
      googlePlayPurchase: {
        findUnique: jest.fn().mockResolvedValue(null),
      },
      $transaction: jest.fn((work: (client: unknown) => unknown) => work(tx)),
    };
    ledger = {
      postInTransaction: jest
        .fn<Promise<{ id: string }>, [unknown, LedgerPostInput]>()
        .mockResolvedValue({ id: 'ledger-transaction-1' }),
    };
    googlePlay = {
      isConfigured: jest.fn().mockReturnValue(true),
      getProductPurchase: jest.fn().mockResolvedValue(purchased),
      getOrder: jest.fn().mockResolvedValue(order),
      consume: jest.fn().mockResolvedValue(undefined),
    };

    service = new GooglePlayPurchasesService(
      prisma as unknown as PrismaService,
      ledger as unknown as LedgerService,
      googlePlay as unknown as GooglePlayDeveloperApiProvider,
    );
  });

  afterEach(() => {
    process.env = { ...originalEnv };
    jest.clearAllMocks();
  });

  it('keeps the catalogue empty when the purchase feature flag is closed', () => {
    process.env.GOOGLE_PLAY_PURCHASES_ENABLED = 'false';

    expect(service.catalogue(userId)).toEqual({
      enabled: false,
      packageName: 'so.kyron.app',
      accountObfuscationId: null,
      products: [],
    });
  });

  it('does not invent a product catalogue when the server mapping is invalid', () => {
    process.env.GOOGLE_PLAY_COIN_PRODUCTS =
      '[{"productId":"coins.test.small","coins":0}]';

    expect(service.catalogue(userId)).toMatchObject({
      enabled: false,
      accountObfuscationId: null,
      products: [],
    });
  });

  it('returns an obfuscated account binding only for a fully configured catalogue', () => {
    expect(service.catalogue(userId)).toEqual({
      enabled: true,
      packageName: 'so.kyron.app',
      accountObfuscationId: obfuscatedId,
      products: [{ productId: 'coins.test.small', coins: 100 }],
    });
  });

  it('requires Play purchase ownership to match the authenticated account', async () => {
    googlePlay.getProductPurchase.mockResolvedValue({
      ...purchased,
      obfuscatedExternalAccountId: 'another-account',
    });

    await expect(
      service.verify(userId, 'coins.test.small', purchaseToken),
    ).rejects.toBeInstanceOf(BadRequestException);

    expect(tx.googlePlayPurchase.create).not.toHaveBeenCalled();
    expect(tx.coinEntry.create).not.toHaveBeenCalled();
    expect(ledger.postInTransaction).not.toHaveBeenCalled();
    expect(googlePlay.consume).not.toHaveBeenCalled();
  });

  it('rejects a processed order whose purchase token does not match', async () => {
    googlePlay.getOrder.mockResolvedValue({
      ...order,
      purchaseToken: 'a-different-purchase-token',
    });

    await expect(
      service.verify(userId, 'coins.test.small', purchaseToken),
    ).rejects.toThrow(/has not confirmed this order as processed/i);

    expect(tx.googlePlayPurchase.create).not.toHaveBeenCalled();
    expect(tx.coinEntry.create).not.toHaveBeenCalled();
    expect(ledger.postInTransaction).not.toHaveBeenCalled();
  });

  it('rejects an order response with a mismatched order identifier', async () => {
    googlePlay.getOrder.mockResolvedValue({
      ...order,
      orderId: 'GPA.9999-9999-9999-99999',
    });

    await expect(
      service.verify(userId, 'coins.test.small', purchaseToken),
    ).rejects.toThrow(/has not confirmed this order as processed/i);

    expect(tx.googlePlayPurchase.create).not.toHaveBeenCalled();
    expect(ledger.postInTransaction).not.toHaveBeenCalled();
  });

  it('rejects an order response that omits its purchase token', async () => {
    const withoutToken: GooglePlayOrder = {
      orderId: order.orderId,
      state: order.state,
      lineItems: order.lineItems,
      total: order.total,
      developerRevenueInBuyerCurrency: order.developerRevenueInBuyerCurrency,
    };
    googlePlay.getOrder.mockResolvedValue(withoutToken);

    await expect(
      service.verify(userId, 'coins.test.small', purchaseToken),
    ).rejects.toThrow(/has not confirmed this order as processed/i);

    expect(tx.coinEntry.create).not.toHaveBeenCalled();
    expect(ledger.postInTransaction).not.toHaveBeenCalled();
  });

  it('does not credit a pending Play purchase', async () => {
    googlePlay.getProductPurchase.mockResolvedValue({
      ...purchased,
      purchaseStateContext: { purchaseState: 'PENDING' },
    });

    await expect(
      service.verify(userId, 'coins.test.small', purchaseToken),
    ).rejects.toBeInstanceOf(BadRequestException);

    expect(tx.coinEntry.create).not.toHaveBeenCalled();
    expect(ledger.postInTransaction).not.toHaveBeenCalled();
  });

  it('credits once, journals balanced KCOIN and consumes only after the commit', async () => {
    const result = await service.verify(
      userId,
      'coins.test.small',
      purchaseToken,
    );

    expect(result).toMatchObject({
      purchaseId: 'purchase-row-1',
      productId: 'coins.test.small',
      quantity: 2,
      coinsGranted: 200,
      status: 'CONSUMED',
      consumed: true,
      duplicate: false,
    });

    expect(createdPurchaseData).toMatchObject({
      userId,
      productId: 'coins.test.small',
      quantity: 2,
      coinAmount: 200,
      orderId: order.orderId,
      purchaseCurrencyCode: 'USD',
      grossAmountNanos: 15_250_000_000n,
      developerRevenueNanos: 10_125_000_000n,
      status: 'VERIFIED',
    });
    expect(String(createdPurchaseData?.encryptedToken)).toMatch(/^v1\./);
    expect(String(createdPurchaseData?.encryptedToken)).not.toContain(
      purchaseToken,
    );

    expect(tx.coinEntry.create).toHaveBeenCalledTimes(1);
    const coinEntryCall = tx.coinEntry.create.mock.calls[0]?.[0];
    expect(coinEntryCall?.data.userId).toBe(userId);
    expect(coinEntryCall?.data.kind).toBe('PURCHASE_GRANT');
    expect(coinEntryCall?.data.amount).toBe(200);
    expect(coinEntryCall?.data.key).toMatch(
      /^google-play-purchase:[a-f0-9]{64}$/,
    );

    expect(ledger.postInTransaction).toHaveBeenCalledTimes(1);
    const ledgerCall = ledger.postInTransaction.mock.calls[0]?.[1];
    expect(ledgerCall?.currencyCode).toBe('KCOIN');
    expect(ledgerCall?.idempotencyKey).toMatch(
      /^google-play-purchase:[a-f0-9]{64}$/,
    );
    expect(ledgerCall?.postings).toMatchObject([
      {
        side: 'DEBIT',
        accountType: 'ASSET',
        amount: '200',
      },
      {
        side: 'CREDIT',
        accountType: 'LIABILITY',
        ownerId: userId,
        amount: '200',
      },
    ]);
    expect(tx.financialSourceRecord.create).toHaveBeenCalled();
    expect(tx.financialAuditEvent.create).toHaveBeenCalled();
    expect(googlePlay.consume).toHaveBeenCalledWith(
      'coins.test.small',
      purchaseToken,
    );
    expect(tx.googlePlayPurchase.updateMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { id: 'purchase-row-1', status: 'VERIFIED' },
        data: { status: 'CONSUMED', acknowledgementState: 1 },
      }),
    );
  });

  it('does not grant an externally consumed token unless Kyron already recorded it', async () => {
    googlePlay.getProductPurchase.mockResolvedValue({
      ...purchased,
      productLineItem: [
        {
          productId: 'coins.test.small',
          productOfferDetails: {
            quantity: 2,
            consumptionState: 'CONSUMPTION_STATE_CONSUMED',
          },
        },
      ],
    });

    await expect(
      service.verify(userId, 'coins.test.small', purchaseToken),
    ).rejects.toThrow(/consumed before Kyron recorded/i);

    expect(tx.coinEntry.create).not.toHaveBeenCalled();
    expect(ledger.postInTransaction).not.toHaveBeenCalled();
  });

  it('refuses a token already attributed to another account', async () => {
    prisma.googlePlayPurchase.findUnique.mockResolvedValue({
      id: 'existing-purchase',
      userId: 'different-user',
      productId: 'coins.test.small',
      status: 'CONSUMED',
    });

    await expect(
      service.verify(userId, 'coins.test.small', purchaseToken),
    ).rejects.toThrow(/already been used/i);

    expect(googlePlay.getProductPurchase).not.toHaveBeenCalled();
    expect(ledger.postInTransaction).not.toHaveBeenCalled();
  });

  it('leaves an already-committed grant retryable when Play consumption is unavailable', async () => {
    googlePlay.consume.mockRejectedValue(
      new Error('temporary provider failure'),
    );

    const result = await service.verify(
      userId,
      'coins.test.small',
      purchaseToken,
    );

    expect(result).toMatchObject({
      coinsGranted: 200,
      status: 'VERIFIED',
      consumed: false,
    });
    expect(tx.coinEntry.create).toHaveBeenCalledTimes(1);
    expect(ledger.postInTransaction).toHaveBeenCalledTimes(1);
  });
});
