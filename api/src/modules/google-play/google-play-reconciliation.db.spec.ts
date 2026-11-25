import { createHash, randomUUID } from 'node:crypto';
import { PrismaClient } from '@prisma/client';
import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  GooglePlayDeveloperApiProvider,
  type GooglePlayOrder,
  type GooglePlayProductPurchaseV2,
} from './google-play-developer-api.provider';
import { GooglePlayReconciliationService } from './google-play-reconciliation.service';
import { encryptPurchaseToken, tokenHash } from './google-play-token';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('Google Play refund evidence against Postgres', () => {
  let prisma: PrismaClient;
  let service: GooglePlayReconciliationService;
  const originalEnv = { ...process.env };
  const userId = randomUUID();
  const actorId = randomUUID();
  const token = `refund-test-${randomUUID()}`;
  const digest = tokenHash(token);
  const key = Buffer.alloc(32, 5);
  const orderId = `GPA.${randomUUID()}`;
  const productId = 'coins.refund.test';
  const purchaseId = randomUUID();
  const account = createHash('sha256')
    .update('kyron/google-play/account/v1:', 'utf8')
    .update(userId, 'utf8')
    .digest('hex');
  const provider = {
    isConfigured: jest.fn().mockReturnValue(true),
    getOrder: jest.fn(),
    getProductPurchase: jest.fn(),
    listVoidedPurchases: jest.fn(),
  };

  function observation(remaining: number) {
    const order: GooglePlayOrder = {
      orderId,
      purchaseToken: token,
      state: remaining === 0 ? 'REFUNDED' : 'PARTIALLY_REFUNDED',
      lineItems: [{ productId, oneTimePurchaseDetails: { quantity: 3 } }],
    };
    const purchase: GooglePlayProductPurchaseV2 = {
      orderId,
      obfuscatedExternalAccountId: account,
      purchaseStateContext: { purchaseState: 'PURCHASED' },
      productLineItem: [
        {
          productId,
          productOfferDetails: { quantity: 3, refundableQuantity: remaining },
        },
      ],
    };
    provider.getOrder.mockResolvedValue(order);
    provider.getProductPurchase.mockResolvedValue(purchase);
    provider.listVoidedPurchases.mockResolvedValue({
      voidedPurchases: [
        {
          orderId,
          purchaseToken: token,
          voidedTimeMillis: '1795500000000',
          voidedReason: 7,
          voidedSource: 2,
        },
      ],
    });
  }

  function receipt(hash: string, eventType = 'ONE_TIME_PARTIAL_VOID') {
    return prisma.googlePlayNotification.create({
      data: {
        messageId: randomUUID(),
        eventType,
        purchaseTokenHash: hash,
        payload: {
          packageName: 'so.kyron.app',
          orderId,
          payloadHash: 'a'.repeat(64),
        },
      },
    });
  }

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    process.env.GOOGLE_PLAY_RECONCILIATION_ENABLED = 'true';
    process.env.GOOGLE_PLAY_PACKAGE_NAME = 'so.kyron.app';
    process.env.GOOGLE_PLAY_TOKEN_ENCRYPTION_KEY = key.toString('base64');
    service = new GooglePlayReconciliationService(
      prisma as PrismaService,
      provider as unknown as GooglePlayDeveloperApiProvider,
    );
    await prisma.googlePlayPurchase.create({
      data: {
        id: purchaseId,
        userId,
        purchaseTokenHash: digest,
        encryptedToken: encryptPurchaseToken(token, key),
        productId,
        orderId,
        quantity: 3,
        coinAmount: 120,
        purchaseTime: new Date(),
        acknowledgementState: 1,
        status: 'CONSUMED',
        coinEntryKey: `refund-test:${purchaseId}`,
      },
    });
  });

  afterAll(async () => {
    process.env = originalEnv;
    await prisma?.$disconnect();
  });

  it('retains one cumulative observation under concurrent retries', async () => {
    observation(1);
    const event = await receipt(digest);
    const results = await Promise.all([
      service.reconcile(event.id, actorId),
      service.reconcile(event.id, actorId),
    ]);
    expect(results.map((result) => result.status).sort()).toEqual([
      'DUPLICATE',
      'EVIDENCE_RETAINED',
    ]);
    const source = await prisma.financialSourceRecord.findUniqueOrThrow({
      where: {
        sourceType_sourceId: {
          sourceType: 'GOOGLE_PLAY_REFUND_OBSERVATION',
          sourceId: event.id,
        },
      },
    });
    expect(source.amount).toBeNull();
    expect(source.unitCode).toBeNull();
    expect(source.payload).toMatchObject({
      cumulativeRefundedQuantity: 2,
      cumulativeRefundedCoins: 80,
      voidScan: {
        complete: true,
        matched: [{ voidedReason: 7, voidedSource: 2 }],
      },
    });
    expect(JSON.stringify(source.payload)).not.toContain(token);
    const current = await prisma.googlePlayNotification.findUniqueOrThrow({
      where: { id: event.id },
    });
    expect(current.processedAt).not.toBeNull();
    expect(await prisma.coinEntry.count({ where: { userId } })).toBe(0);
    expect(
      await prisma.googlePlayPurchase.findUnique({
        where: { id: purchaseId },
        select: { status: true, coinAmount: true },
      }),
    ).toEqual({ status: 'CONSUMED', coinAmount: 120 });
  });

  it('leaves a lower cumulative observation pending, then accepts a full refund', async () => {
    const event = await receipt(digest);
    observation(2);
    expect(await service.reconcile(event.id, actorId)).toMatchObject({
      status: 'PENDING',
      reason: 'CUMULATIVE_REGRESSION',
    });
    expect(
      await prisma.googlePlayNotification.findUnique({
        where: { id: event.id },
        select: { processedAt: true },
      }),
    ).toEqual({ processedAt: null });
    observation(0);
    expect(await service.reconcile(event.id, actorId)).toMatchObject({
      status: 'EVIDENCE_RETAINED',
    });
  });

  it('leaves unmatched receipts and provider failures retryable', async () => {
    const unknown = await receipt(tokenHash(randomUUID()));
    expect(await service.reconcile(unknown.id, actorId)).toMatchObject({
      status: 'PENDING',
      reason: 'UNMATCHED_PURCHASE',
    });
    const event = await receipt(digest, 'ONE_TIME_FULL_VOID');
    provider.getOrder.mockRejectedValueOnce(new Error('provider unavailable'));
    expect(await service.reconcile(event.id, actorId)).toMatchObject({
      status: 'PENDING',
      reason: 'PROVIDER_RETRY_REQUIRED',
    });
    const pending = await service.listPending();
    const item = pending.items.find((row) => row.id === event.id);
    expect(item).toBeDefined();
    expect(item).not.toHaveProperty('payload');
    expect(item).not.toHaveProperty('purchaseTokenHash');
    expect(await service.reconcile(event.id, actorId)).toMatchObject({
      status: 'EVIDENCE_RETAINED',
    });
  });
});
