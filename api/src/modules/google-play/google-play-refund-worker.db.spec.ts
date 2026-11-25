import { ServiceUnavailableException } from '@nestjs/common';
import { randomUUID } from 'node:crypto';
import { PrismaClient } from '@prisma/client';
import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { GooglePlayDeveloperApiProvider } from './google-play-developer-api.provider';
import type { GooglePlayReconciliationService } from './google-play-reconciliation.service';
import { GooglePlayRefundWorkerService } from './google-play-refund-worker.service';
import { tokenHash } from './google-play-token';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('Google Play refund worker against Postgres', () => {
  let prisma: PrismaClient;
  let worker: GooglePlayRefundWorkerService;
  let packageName: string;
  const env = { ...process.env };
  const provider = { isConfigured: jest.fn().mockReturnValue(true) };
  const reconciliation = { reconcile: jest.fn() };

  beforeAll(() => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    worker = new GooglePlayRefundWorkerService(
      prisma as PrismaService,
      provider as unknown as GooglePlayDeveloperApiProvider,
      reconciliation as unknown as GooglePlayReconciliationService,
    );
  });

  beforeEach(() => {
    packageName = `so.kyron.test.a${randomUUID().replace(/-/g, '')}`;
    process.env.GOOGLE_PLAY_PACKAGE_NAME = packageName;
    process.env.GOOGLE_PLAY_AUTOMATED_RECONCILIATION_ENABLED = 'true';
    process.env.GOOGLE_PLAY_RECONCILIATION_ENABLED = 'true';
    process.env.GOOGLE_PLAY_TOKEN_ENCRYPTION_KEY = Buffer.alloc(32, 3).toString(
      'base64',
    );
    reconciliation.reconcile.mockReset();
  });

  afterAll(async () => {
    process.env = env;
    await prisma?.$disconnect();
  });

  function receipt(eventType = 'ONE_TIME_VOID_RECOVERED') {
    return prisma.googlePlayNotification.create({
      data: {
        messageId: randomUUID(),
        eventType,
        purchaseTokenHash: tokenHash(randomUUID()),
        payload: { packageName },
        reconciliationNextAttemptAt: new Date(Date.now() - 1000),
      },
    });
  }

  function get(id: string) {
    return prisma.googlePlayNotification.findUniqueOrThrow({ where: { id } });
  }

  it('claims a receipt only once across workers and uses a system actor', async () => {
    const event = await receipt();
    const review = await receipt('PENDING_REFUND_REVIEW');
    reconciliation.reconcile.mockImplementation(async (id: string) => {
      await prisma.googlePlayNotification.update({
        where: { id },
        data: { processedAt: new Date() },
      });
      return { status: 'EVIDENCE_RETAINED', id };
    });
    const results = await Promise.all([worker.runBatch(), worker.runBatch()]);
    expect(reconciliation.reconcile).toHaveBeenCalledTimes(1);
    expect(reconciliation.reconcile).toHaveBeenCalledWith(
      event.id,
      null,
      expect.any(String),
    );
    expect(results).toContainEqual({
      status: 'BATCH_COMPLETE',
      claimed: 1,
      verified: 1,
      pending: 0,
      failed: 0,
      superseded: 0,
    });
    expect((await get(event.id)).reconciliationLeaseId).toBeNull();
    expect((await get(review.id)).reconciliationAttemptCount).toBe(0);
  });

  it('persists a retry delay without marking unresolved receipts processed', async () => {
    const event = await receipt();
    reconciliation.reconcile.mockResolvedValue({
      status: 'PENDING',
      id: event.id,
    });
    expect(await worker.runBatch()).toMatchObject({ pending: 1 });
    const pending = await get(event.id);
    expect(pending.processedAt).toBeNull();
    expect(pending.reconciliationLeaseId).toBeNull();
    expect(pending.reconciliationAttemptCount).toBe(1);
    expect(pending.reconciliationNextAttemptAt.getTime()).toBeGreaterThan(
      Date.now(),
    );
    expect(await worker.runBatch()).toEqual({ status: 'DRAINED' });
    expect(await worker.status()).toMatchObject({ unresolved: 1, deferred: 1 });
  });

  it('reclaims an expired lease but does not claim an active lease', async () => {
    const expired = await receipt();
    const active = await receipt();
    await prisma.googlePlayNotification.update({
      where: { id: expired.id },
      data: {
        reconciliationLeaseId: randomUUID(),
        reconciliationLeaseUntil: new Date(Date.now() - 1000),
        reconciliationAttemptCount: 31,
      },
    });
    await prisma.googlePlayNotification.update({
      where: { id: active.id },
      data: {
        reconciliationLeaseId: randomUUID(),
        reconciliationLeaseUntil: new Date(Date.now() + 120_000),
      },
    });
    reconciliation.reconcile.mockRejectedValue(new Error('unavailable'));
    expect(await worker.runBatch()).toMatchObject({ claimed: 1, failed: 1 });
    expect(reconciliation.reconcile).toHaveBeenCalledWith(
      expired.id,
      null,
      expect.any(String),
    );
    expect(reconciliation.reconcile).toHaveBeenCalledTimes(1);
    const retried = await get(expired.id);
    expect(retried.reconciliationAttemptCount).toBe(31);
    expect(retried.processingError).toBe('AUTOMATED_RETRY_REQUIRED');
    expect(retried.processedAt).toBeNull();
    expect((await get(active.id)).reconciliationAttemptCount).toBe(0);
  });

  it('cannot overwrite retry scheduling after losing its lease', async () => {
    const event = await receipt();
    const newLease = randomUUID();
    const newTime = new Date(Date.now() + 600_000);
    reconciliation.reconcile.mockImplementation(async () => {
      await prisma.googlePlayNotification.update({
        where: { id: event.id },
        data: {
          reconciliationLeaseId: newLease,
          reconciliationLeaseUntil: newTime,
          reconciliationNextAttemptAt: newTime,
        },
      });
      throw new Error('stale worker');
    });
    expect(await worker.runBatch()).toMatchObject({ superseded: 1 });
    const current = await get(event.id);
    expect(current.reconciliationLeaseId).toBe(newLease);
    expect(current.reconciliationNextAttemptAt).toEqual(newTime);
    expect(current.processingError).toBeNull();
  });

  it('does not claim work when disabled', async () => {
    const event = await receipt();
    process.env.GOOGLE_PLAY_AUTOMATED_RECONCILIATION_ENABLED = 'false';
    await expect(worker.runBatch()).rejects.toBeInstanceOf(
      ServiceUnavailableException,
    );
    expect((await get(event.id)).reconciliationAttemptCount).toBe(0);
  });
});
