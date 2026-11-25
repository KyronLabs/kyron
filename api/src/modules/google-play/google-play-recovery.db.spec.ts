import { BadRequestException, ServiceUnavailableException } from '@nestjs/common';
import { randomUUID } from 'node:crypto';
import { PrismaClient } from '@prisma/client';
import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { GooglePlayDeveloperApiProvider } from './google-play-developer-api.provider';
import { GooglePlayRecoveryService } from './google-play-recovery.service';
import { tokenHash } from './google-play-token';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('Google Play durable void recovery against Postgres', () => {
  let prisma: PrismaClient;
  let service: GooglePlayRecoveryService;
  const env = { ...process.env };
  const now = new Date();
  const packageName = `so.kyron.test.a${randomUUID().replace(/-/g, '')}`;
  const token = `recovery-${randomUUID()}`;
  const digest = tokenHash(token);
  const item = {
    purchaseToken: token,
    orderId: `GPA.${randomUUID()}`,
    voidedTimeMillis: String(now.getTime() - 60_000),
    voidedQuantity: 1,
  };
  const provider = {
    isConfigured: jest.fn().mockReturnValue(true),
    listVoidedPurchases: jest.fn(),
  };

  const checkpoint = () =>
    prisma.googlePlayRecoveryCheckpoint.findUniqueOrThrow({
      where: { packageName },
    });
  const receipts = () =>
    prisma.googlePlayNotification.count({
      where: { purchaseTokenHash: digest },
    });

  beforeAll(() => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    process.env.GOOGLE_PLAY_RECOVERY_ENABLED = 'true';
    process.env.GOOGLE_PLAY_PACKAGE_NAME = packageName;
    process.env.GOOGLE_PLAY_TOKEN_ENCRYPTION_KEY = Buffer.alloc(32, 9).toString(
      'base64',
    );
    service = new GooglePlayRecoveryService(
      prisma as PrismaService,
      provider as unknown as GooglePlayDeveloperApiProvider,
    );
  });

  afterAll(async () => {
    process.env = env;
    await prisma?.$disconnect();
  });

  it('retains a page and cursor without claiming coverage until the last page', async () => {
    provider.listVoidedPurchases.mockResolvedValueOnce({
      voidedPurchases: [item],
      tokenPagination: { nextPageToken: 'provider-next-page' },
    });
    expect(await service.runPage(now)).toMatchObject({
      status: 'PAGE_RETAINED',
      inserted: 1,
    });
    const first = await checkpoint();
    expect(first.coveredThrough).toBeNull();
    expect(first.pagesInWindow).toBe(1);
    expect(first.encryptedPageToken).not.toContain('provider-next-page');

    provider.listVoidedPurchases.mockResolvedValueOnce({
      voidedPurchases: [item],
    });
    expect(await service.runPage(now)).toMatchObject({
      status: 'WINDOW_COMPLETE',
      inserted: 0,
    });
    expect(provider.listVoidedPurchases).toHaveBeenLastCalledWith(
      first.windowStart?.getTime(),
      first.windowEnd?.getTime(),
      'provider-next-page',
    );
    const final = await checkpoint();
    expect(final.coveredThrough).toEqual(first.windowEnd);
    expect(final.windowStart).toBeNull();
    expect(final.encryptedPageToken).toBeNull();
    expect(await receipts()).toBe(1);
    const status = await service.status();
    expect(status.pending).toBe(1);
    expect(status.checkpoint).not.toHaveProperty('encryptedPageToken');
  });

  it('leaves coverage unchanged on a malformed page or provider failure', async () => {
    const previous = (await checkpoint()).coveredThrough;
    provider.listVoidedPurchases.mockResolvedValueOnce({
      voidedPurchases: [item, { orderId: 'bad' }],
    });
    expect(await service.runPage(now)).toMatchObject({
      status: 'RETRY_REQUIRED',
      reason: 'MALFORMED_PROVIDER_PAGE',
    });
    expect((await checkpoint()).coveredThrough).toEqual(previous);
    expect(await receipts()).toBe(1);

    provider.listVoidedPurchases.mockRejectedValueOnce(new Error('offline'));
    expect(await service.runPage(now)).toMatchObject({
      status: 'RETRY_REQUIRED',
      reason: 'PROVIDER_RETRY',
    });
    expect((await checkpoint()).coveredThrough).toEqual(previous);
  });

  it('replays an expired cursor and deduplicates concurrent page commits', async () => {
    provider.listVoidedPurchases.mockResolvedValueOnce({
      voidedPurchases: [item],
      tokenPagination: { nextPageToken: 'expired-cursor' },
    });
    await service.runPage(now);
    const opened = await checkpoint();
    provider.listVoidedPurchases.mockRejectedValueOnce(
      new BadRequestException(),
    );
    expect(await service.runPage(now)).toMatchObject({
      status: 'RETRY_REQUIRED',
      reason: 'CURSOR_RESTART_REQUIRED',
    });
    const reset = await checkpoint();
    expect(reset.windowStart).toEqual(opened.windowStart);
    expect(reset.coveredThrough).toEqual(opened.coveredThrough);
    expect(reset.encryptedPageToken).toBeNull();

    provider.listVoidedPurchases.mockResolvedValue({
      voidedPurchases: [item],
    });
    const results = await Promise.all([
      service.runPage(now),
      service.runPage(now),
    ]);
    expect(results.map((result) => result.status)).toContain('WINDOW_COMPLETE');
    expect(await receipts()).toBe(1);
    expect((await checkpoint()).encryptedPageToken).toBeNull();
  });

  it('does not advance an expired checkpoint or run when disabled', async () => {
    const old = new Date(now.getTime() - 31 * 86_400_000);
    await prisma.googlePlayRecoveryCheckpoint.update({
      where: { packageName },
      data: {
        coveredThrough: old,
        windowStart: null,
        windowEnd: null,
        encryptedPageToken: null,
        pagesInWindow: 0,
      },
    });
    expect(await service.runPage(now)).toMatchObject({
      status: 'RETRY_REQUIRED',
      reason: 'RETENTION_GAP_OR_CLOCK_REGRESSION',
    });
    expect((await checkpoint()).coveredThrough).toEqual(old);
    process.env.GOOGLE_PLAY_RECOVERY_ENABLED = 'false';
    await expect(service.runPage(now)).rejects.toBeInstanceOf(
      ServiceUnavailableException,
    );
  });
});
