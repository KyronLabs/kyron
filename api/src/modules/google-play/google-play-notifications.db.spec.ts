import {
  ConflictException,
  ServiceUnavailableException,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import { randomUUID } from 'node:crypto';
import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  GooglePlayNotificationAuth,
  GooglePlayNotificationsService,
} from './google-play-notifications.service';

const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('Google Play durable notification receipt', () => {
  let prisma: PrismaClient;
  let service: GooglePlayNotificationsService;
  let auth: GooglePlayNotificationAuth;
  const originalEnv = { ...process.env };
  const messageId = `rtdn-${randomUUID()}`;
  const subscription = 'projects/project/subscriptions/play';

  function body(id: string, refundType = 1) {
    const data = {
      version: '1.0',
      packageName: 'so.kyron.app',
      eventTimeMillis: '1795500000000',
      voidedPurchaseNotification: {
        purchaseToken: 'integration-purchase-token',
        orderId: 'GPA.integration',
        productType: 2,
        refundType,
      },
    };
    return {
      subscription,
      message: {
        messageId: id,
        data: Buffer.from(JSON.stringify(data)).toString('base64'),
      },
    };
  }

  beforeAll(() => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    auth = new GooglePlayNotificationAuth();
    jest.spyOn(auth, 'verify').mockResolvedValue(undefined);
    service = new GooglePlayNotificationsService(
      prisma as PrismaService,
      auth,
    );
    process.env.GOOGLE_PLAY_RTDN_ENABLED = 'true';
    process.env.GOOGLE_PLAY_RTDN_AUDIENCE = 'test-audience';
    process.env.GOOGLE_PLAY_RTDN_SERVICE_ACCOUNT_EMAIL =
      'push@project.iam.gserviceaccount.com';
    process.env.GOOGLE_PLAY_RTDN_SERVICE_ACCOUNT_SUBJECT = '123456789';
    process.env.GOOGLE_PLAY_RTDN_SUBSCRIPTION = subscription;
    process.env.GOOGLE_PLAY_PACKAGE_NAME = 'so.kyron.app';
    process.env.GOOGLE_PLAY_TOKEN_ENCRYPTION_KEY = Buffer.alloc(32, 9).toString(
      'base64',
    );
  });

  afterAll(async () => {
    process.env = originalEnv;
    jest.restoreAllMocks();
    await prisma?.$disconnect();
  });

  it('commits once under concurrent delivery and does not process money', async () => {
    const [a, b] = await Promise.all([
      service.ingest('Bearer test', body(messageId)),
      service.ingest('Bearer test', body(messageId)),
    ]);
    expect([a.status, b.status].sort()).toEqual(['DUPLICATE', 'RECEIVED']);
    expect(a.eventId).toBe(b.eventId);
    const event = await prisma.googlePlayNotification.findUniqueOrThrow({
      where: { messageId },
    });
    expect(event.eventType).toBe('ONE_TIME_FULL_VOID');
    expect(event.processedAt).toBeNull();
    expect(event.processingError).toBeNull();
    expect(JSON.stringify(event.payload)).not.toContain(
      'integration-purchase-token',
    );
    await expect(
      service.ingest('Bearer test', body(messageId, 2)),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(
      await prisma.googlePlayNotification.count({ where: { messageId } }),
    ).toBe(1);
  });

  it('rejects unauthenticated and disabled deliveries without inserting', async () => {
    const deniedId = `rtdn-denied-${randomUUID()}`;
    jest
      .spyOn(auth, 'verify')
      .mockRejectedValueOnce(new UnauthorizedException());
    await expect(
      service.ingest('Bearer test', body(deniedId)),
    ).rejects.toBeInstanceOf(UnauthorizedException);
    process.env.GOOGLE_PLAY_RTDN_ENABLED = 'false';
    try {
      await expect(
        service.ingest('Bearer test', body(deniedId)),
      ).rejects.toBeInstanceOf(ServiceUnavailableException);
    } finally {
      process.env.GOOGLE_PLAY_RTDN_ENABLED = 'true';
    }
    expect(
      await prisma.googlePlayNotification.count({
        where: { messageId: deniedId },
      }),
    ).toBe(0);
  });
});
