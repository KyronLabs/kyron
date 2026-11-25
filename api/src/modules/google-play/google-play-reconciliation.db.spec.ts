import { createHash, randomUUID } from 'node:crypto';
import { PrismaClient } from '@prisma/client';
import { LedgerService } from '../financial-ledger/ledger.service';
import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  GooglePlayDeveloperApiProvider,
  type GooglePlayOrder,
  type GooglePlayProductPurchaseV2,
} from './google-play-developer-api.provider';
import {
  ChargebackReviewDecision,
  GooglePlayReconciliationService,
} from './google-play-reconciliation.service';
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

  function observation(remaining: number, voidedReason = 7) {
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
          voidedReason,
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
      new LedgerService(prisma as PrismaService),
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
    const chargebacks = await service.listChargebackEvidence();
    expect(chargebacks.items).toContainEqual({
      evidenceId: source.id,
      notificationId: event.id,
      purchaseId,
      observedAt: source.occurredAt,
      review: null,
    });
    const recordReview = (decision: ChargebackReviewDecision) =>
      service.reviewChargebackEvidence(source.id, actorId, decision);
    const decision = ChargebackReviewDecision.ReferForRecovery;
    const [review, retry] = await Promise.all([
      recordReview(decision),
      recordReview(decision),
    ]);
    expect(retry).toEqual(review);
    await expect(
      recordReview(ChargebackReviewDecision.NoAction),
    ).rejects.toThrow('This evidence already has a review decision.');
    expect((await service.listChargebackEvidence()).items).toContainEqual(
      expect.objectContaining({
        evidenceId: source.id,
        review: { reviewId: review.reviewId, decision },
      }),
    );
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
    observation(0, 1);
    expect(await service.reconcile(event.id, actorId)).toMatchObject({
      status: 'EVIDENCE_RETAINED',
    });
    const chargebacks = await service.listChargebackEvidence();
    expect(
      chargebacks.items.some((row) => row.notificationId === event.id),
    ).toBe(false);
  });

  it('previews the highest cumulative refund against purchased coins only', async () => {
    const refundUser = randomUUID();
    const refundPurchase = randomUUID();
    const grantKey = randomUUID();
    await prisma.googlePlayPurchase.create({
      data: {
        id: refundPurchase,
        userId: refundUser,
        purchaseTokenHash: tokenHash(randomUUID()),
        encryptedToken: 'unused-by-preview',
        productId,
        quantity: 3,
        coinAmount: 120,
        purchaseTime: new Date(),
        acknowledgementState: 1,
        coinEntryKey: grantKey,
      },
    });
    await prisma.financialSourceRecord.createMany({
      data: [1, 2, 2].map((quantity) => ({
        sourceType: 'GOOGLE_PLAY_REFUND_OBSERVATION',
        sourceId: randomUUID(),
        eventType: 'GOOGLE_PLAY_REFUND_QUANTITY_OBSERVED',
        beneficiaryId: refundUser,
        relatedIds: { purchaseId: refundPurchase },
        payload: { cumulativeRefundedQuantity: quantity },
        occurredAt: new Date(),
      })),
    });
    await prisma.coinEntry.createMany({
      data: (
        [
          { kind: 'PURCHASE_GRANT', amount: 120 },
          { kind: 'PURCHASE_SPEND', amount: -95 },
          { kind: 'REWARD_GRANT', amount: 200 },
        ] as const
      ).map(({ kind, amount }) => ({
        userId: refundUser,
        kind,
        amount,
        key: kind === 'PURCHASE_GRANT' ? grantKey : randomUUID(),
      })),
    });

    expect(await service.previewRefundReversal(refundPurchase)).toMatchObject({
      purchaseId: refundPurchase,
      refundedQuantity: 2,
      verifiedRefundCoins: 80,
      outstandingRefundCoins: 80,
      purchasedWalletCoins: 25,
      coveredByPurchasedWalletCoins: 25,
      originalOrderCoverage: 25,
      netRecoveredForOrder: 0,
      originalOrderAttributedSpend: 0,
      unattributedPurchasedSpend: 95,
      coinsRequiringAttributionReview: 55,
      uncoveredCoins: 55,
    });
    const otherGrantKey = randomUUID();
    const otherPurchase = await prisma.googlePlayPurchase.create({
      data: {
        userId: refundUser,
        purchaseTokenHash: tokenHash(randomUUID()),
        encryptedToken: 'unused-by-preview',
        productId,
        quantity: 1,
        coinAmount: 100,
        purchaseTime: new Date(),
        acknowledgementState: 1,
        coinEntryKey: otherGrantKey,
      },
    });
    await prisma.coinEntry.create({
      data: {
        userId: refundUser,
        kind: 'PURCHASE_GRANT',
        amount: 100,
        key: otherGrantKey,
      },
    });
    expect(await service.previewRefundReversal(refundPurchase)).toMatchObject({
      purchasedWalletCoins: 125,
      coveredByPurchasedWalletCoins: 80,
      originalOrderCoverage: 25,
      coinsRequiringAttributionReview: 55,
      uncoveredCoins: 0,
    });
    const giftId = randomUUID();
    await prisma.financialSourceRecord.create({
      data: {
        sourceType: 'GIFT_PURCHASE_SPEND_ALLOCATION',
        sourceId: giftId,
        eventType: 'PURCHASED_COINS_SPENT',
        beneficiaryId: refundUser,
        relatedIds: { giftId },
        amount: 95,
        unitCode: 'COIN',
        payload: {
          allocations: [
            { purchaseId: refundPurchase, coins: 20 },
            { purchaseId: otherPurchase.id, coins: 60 },
          ],
          unattributedCoins: 15,
        },
        occurredAt: new Date(),
      },
    });
    expect(await service.previewRefundReversal(refundPurchase)).toMatchObject({
      originalOrderCoverage: 80,
      originalOrderAttributedSpend: 20,
      unattributedPurchasedSpend: 15,
      coinsRequiringAttributionReview: 0,
    });
    await prisma.user.create({
      data: {
        id: refundUser,
        name: 'Refund recovery test',
        email: `${refundUser}@example.test`,
      },
    });
    const ledger = new LedgerService(prisma as PrismaService);
    await prisma.$transaction((tx) =>
      ledger.postInTransaction(tx, {
        idempotencyKey: grantKey,
        eventType: 'GOOGLE_PLAY_COIN_PURCHASE',
        sourceType: 'GOOGLE_PLAY_PURCHASE',
        sourceId: refundPurchase,
        currencyCode: 'KCOIN',
        postings: [
          {
            accountKey: 'SYSTEM:GOOGLE_PLAY:KCOIN:ISSUANCE_CLEARING',
            name: 'Google Play purchased coin issuance clearing',
            accountType: 'ASSET',
            normalSide: 'DEBIT',
            side: 'DEBIT',
            amount: '120',
          },
          {
            accountKey: `USER:${refundUser}:KCOIN:PURCHASED`,
            name: 'Purchased coin wallet liability',
            accountType: 'LIABILITY',
            normalSide: 'CREDIT',
            ownerId: refundUser,
            side: 'CREDIT',
            amount: '120',
          },
        ],
      }),
    );
    const chargeback = await prisma.financialSourceRecord.create({
      data: {
        sourceType: 'GOOGLE_PLAY_REFUND_OBSERVATION',
        sourceId: randomUUID(),
        eventType: 'GOOGLE_PLAY_REFUND_QUANTITY_OBSERVED',
        beneficiaryId: refundUser,
        relatedIds: { purchaseId: refundPurchase },
        payload: {
          cumulativeRefundedQuantity: 3,
          voidScan: { matched: [{ voidedReason: 7 }] },
        },
        occurredAt: new Date(),
      },
    });
    const requestId = randomUUID();
    const noticeId = randomUUID();
    process.env.GOOGLE_PLAY_REFUND_RECOVERY_ENABLED = 'true';
    try {
      const recover = () =>
        service.recoverVerifiedRefund(
          refundPurchase,
          actorId,
          requestId,
          noticeId,
        );
      await expect(recover()).rejects.toThrow(
        'Chargeback evidence requires a recovery referral.',
      );
      await service.reviewChargebackEvidence(
        chargeback.id,
        actorId,
        ChargebackReviewDecision.ReferForRecovery,
      );
      const [posted, replay] = await Promise.all([recover(), recover()]);
      expect(replay).toEqual(posted);
      expect(posted).toMatchObject({ recoveredCoins: 85, shortfallCoins: 35 });
      expect(await service.previewRefundReversal(refundPurchase)).toMatchObject(
        {
          netRecoveredForOrder: 85,
          purchasedWalletCoins: 40,
          originalOrderCoverage: 0,
          outstandingRefundCoins: 35,
        },
      );
      const correctionNotice = randomUUID();
      const correct = () =>
        service.correctRefundRecovery(
          refundPurchase,
          posted.recoveryId,
          actorId,
          correctionNotice,
        );
      const [correction, correctionReplay] = await Promise.all([
        correct(),
        correct(),
      ]);
      expect(correctionReplay).toEqual(correction);
      expect(correction).toMatchObject({ restoredCoins: 85 });
      expect(await service.previewRefundReversal(refundPurchase)).toMatchObject(
        {
          netRecoveredForOrder: 0,
          purchasedWalletCoins: 125,
        },
      );
      await expect(
        service.recoverVerifiedRefund(
          refundPurchase,
          actorId,
          randomUUID(),
          noticeId,
        ),
      ).rejects.toThrow('A corrected recovery requires separate case review.');
    } finally {
      delete process.env.GOOGLE_PLAY_REFUND_RECOVERY_ENABLED;
    }
  });

  it('does not write retry evidence after another worker takes the lease', async () => {
    const event = await receipt(digest);
    const leaseId = randomUUID();
    const replacement = randomUUID();
    await prisma.googlePlayNotification.update({
      where: { id: event.id },
      data: {
        reconciliationLeaseId: leaseId,
        reconciliationLeaseUntil: new Date(Date.now() + 120_000),
      },
    });
    provider.getOrder.mockImplementationOnce(async () => {
      await prisma.googlePlayNotification.update({
        where: { id: event.id },
        data: { reconciliationLeaseId: replacement },
      });
      throw new Error('provider unavailable');
    });

    expect(await service.reconcile(event.id, null, leaseId)).toEqual({
      status: 'SUPERSEDED',
      id: event.id,
    });
    expect(
      await prisma.googlePlayNotification.findUniqueOrThrow({
        where: { id: event.id },
        select: { processingError: true, reconciliationLeaseId: true },
      }),
    ).toEqual({ processingError: null, reconciliationLeaseId: replacement });
    expect(
      await prisma.financialAuditEvent.count({
        where: { subjectId: event.id },
      }),
    ).toBe(0);
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
