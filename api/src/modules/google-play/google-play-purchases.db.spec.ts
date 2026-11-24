import { createHash, randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { LedgerService } from '../financial-ledger/ledger.service';
import {
  GooglePlayDeveloperApiProvider,
  type GooglePlayOrder,
  type GooglePlayProductPurchaseV2,
} from './google-play-developer-api.provider';
import { GooglePlayPurchasesService } from './google-play-purchases.service';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('Google Play purchase credit, against a real database', () => {
  let prisma: PrismaClient;
  let service: GooglePlayPurchasesService;
  let userId: string;
  let purchaseToken: string;
  let purchaseTokenHash: string;
  let productPurchase: GooglePlayProductPurchaseV2;
  let provider: {
    isConfigured: jest.Mock;
    getProductPurchase: jest.Mock;
    getOrder: jest.Mock;
    consume: jest.Mock;
  };

  const accountId = (id: string) =>
    createHash('sha256')
      .update('kyron/google-play/account/v1:')
      .update(id)
      .digest('hex');

  const order = (token: string): GooglePlayOrder => ({
    orderId: `GPA.${randomUUID()}`,
    purchaseToken: token,
    state: 'PROCESSED',
    lineItems: [
      {
        productId: 'coins.db.test',
        oneTimePurchaseDetails: { quantity: 1 },
        total: { currencyCode: 'GHS', units: '10', nanos: 0 },
      },
    ],
    total: { currencyCode: 'GHS', units: '10', nanos: 0 },
    developerRevenueInBuyerCurrency: {
      currencyCode: 'GHS',
      units: '7',
      nanos: 500_000_000,
    },
  });

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    userId = randomUUID();
    purchaseToken = `integration-purchase-${randomUUID()}`;
    purchaseTokenHash = createHash('sha256')
      .update(purchaseToken)
      .digest('hex');

    await prisma.user.create({
      data: {
        id: userId,
        name: 'Google Play purchase test owner',
        email: `google-play-purchase-${userId}@example.test`,
      },
    });

    process.env.GOOGLE_PLAY_PURCHASES_ENABLED = 'true';
    process.env.GOOGLE_PLAY_PACKAGE_NAME = 'so.kyron.app';
    process.env.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON = JSON.stringify({
      client_email: 'kyron-test@project.iam.gserviceaccount.com',
      private_key:
        '-----BEGIN PRIVATE KEY-----\\ntest\\n-----END PRIVATE KEY-----',
    });
    process.env.GOOGLE_PLAY_TOKEN_ENCRYPTION_KEY = Buffer.alloc(32, 9).toString(
      'base64',
    );
    process.env.GOOGLE_PLAY_COIN_PRODUCTS = JSON.stringify([
      { productId: 'coins.db.test', coins: 40 },
    ]);

    productPurchase = {
      orderId: `GPA.${randomUUID()}`,
      purchaseCompletionTime: '2026-11-23T12:00:00Z',
      obfuscatedExternalAccountId: accountId(userId),
      acknowledgementState: 'ACKNOWLEDGEMENT_STATE_PENDING',
      purchaseStateContext: { purchaseState: 'PURCHASED' },
      productLineItem: [
        {
          productId: 'coins.db.test',
          productOfferDetails: {
            quantity: 1,
            refundableQuantity: 1,
            consumptionState: 'CONSUMPTION_STATE_YET_TO_BE_CONSUMED',
          },
        },
      ],
    };

    const processedOrder = order(purchaseToken);
    processedOrder.orderId = productPurchase.orderId;
    provider = {
      isConfigured: jest.fn().mockReturnValue(true),
      getProductPurchase: jest
        .fn()
        .mockResolvedValueOnce(productPurchase)
        .mockResolvedValue({
          ...productPurchase,
          productLineItem: [
            {
              productId: 'coins.db.test',
              productOfferDetails: {
                quantity: 1,
                refundableQuantity: 1,
                consumptionState: 'CONSUMPTION_STATE_CONSUMED',
              },
            },
          ],
          acknowledgementState: 'ACKNOWLEDGEMENT_STATE_ACKNOWLEDGED',
        }),
      getOrder: jest.fn().mockResolvedValue(processedOrder),
      consume: jest.fn().mockResolvedValue(undefined),
    };

    service = new GooglePlayPurchasesService(
      prisma as PrismaService,
      new LedgerService(prisma as PrismaService),
      provider as unknown as GooglePlayDeveloperApiProvider,
    );
  });

  afterAll(async () => {
    if (userId) await prisma.user.deleteMany({ where: { id: userId } });
    await prisma?.$disconnect();
  });

  it('commits the purchase, wallet credit and balanced ledger as one event', async () => {
    const first = await service.verify(userId, 'coins.db.test', purchaseToken);

    expect(first).toMatchObject({
      productId: 'coins.db.test',
      quantity: 1,
      coinsGranted: 40,
      status: 'CONSUMED',
      consumed: true,
    });

    const purchase = await prisma.googlePlayPurchase.findUniqueOrThrow({
      where: { purchaseTokenHash },
    });
    const coin = await prisma.coinEntry.findUniqueOrThrow({
      where: { key: purchase.coinEntryKey },
    });
    const journal = await prisma.ledgerTransaction.findUniqueOrThrow({
      where: { idempotencyKey: `google-play-purchase:${purchaseTokenHash}` },
      include: { postings: true },
    });
    const source = await prisma.financialSourceRecord.findUniqueOrThrow({
      where: {
        sourceType_sourceId: {
          sourceType: 'GOOGLE_PLAY_PURCHASE',
          sourceId: purchase.id,
        },
      },
    });

    expect(purchase).toMatchObject({
      userId,
      productId: 'coins.db.test',
      coinAmount: 40,
      status: 'CONSUMED',
      purchaseCurrencyCode: 'GHS',
    });
    expect(purchase.encryptedToken).not.toContain(purchaseToken);
    expect(coin).toMatchObject({
      userId,
      kind: 'PURCHASE_GRANT',
      amount: 40,
      key: purchase.coinEntryKey,
    });
    expect(journal.postings).toHaveLength(2);
    const debit = journal.postings.find((line) => line.side === 'DEBIT');
    const credit = journal.postings.find((line) => line.side === 'CREDIT');
    expect(debit?.amount.toString()).toBe('40');
    expect(credit?.amount.toString()).toBe('40');
    expect(source).toMatchObject({
      sourceType: 'GOOGLE_PLAY_PURCHASE',
      sourceId: purchase.id,
      beneficiaryId: userId,
      amount: 40,
      unitCode: 'KCOIN',
    });
  });

  it('re-verifies a consumed token without issuing a second coin grant', async () => {
    const before = await prisma.coinEntry.count({
      where: { userId, kind: 'PURCHASE_GRANT' },
    });

    const retry = await service.verify(userId, 'coins.db.test', purchaseToken);

    const after = await prisma.coinEntry.count({
      where: { userId, kind: 'PURCHASE_GRANT' },
    });
    expect(retry).toMatchObject({
      coinsGranted: 40,
      status: 'CONSUMED',
      consumed: true,
      duplicate: true,
    });
    expect(after).toBe(before);
    expect(provider.consume).toHaveBeenCalledTimes(1);
    expect(
      await prisma.ledgerTransaction.count({
        where: {
          idempotencyKey: `google-play-purchase:${purchaseTokenHash}`,
        },
      }),
    ).toBe(1);
  });
});
