import {
  BadRequestException,
  ConflictException,
  Injectable,
  ServiceUnavailableException,
  UnauthorizedException,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { createRemoteJWKSet, jwtVerify, type JWTVerifyGetKey } from 'jose';
import { createHash } from 'node:crypto';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  encryptionKey,
  encryptPurchaseToken,
  tokenHash,
} from './google-play-token';

const GOOGLE_KEYS = new URL('https://www.googleapis.com/oauth2/v3/certs');
const EVENT_FIELDS = [
  'oneTimeProductNotification',
  'voidedPurchaseNotification',
  'pendingRefundReviewNotification',
  'subscriptionNotification',
  'testNotification',
] as const;

interface PushIdentity {
  audience: string;
  email: string;
  subject: string;
}

interface PushConfig extends PushIdentity {
  packageName: string;
  subscription: string;
  key: Buffer;
}

function config(): PushConfig {
  const audience = process.env.GOOGLE_PLAY_RTDN_AUDIENCE?.trim();
  const email = process.env.GOOGLE_PLAY_RTDN_SERVICE_ACCOUNT_EMAIL?.trim();
  const subject = process.env.GOOGLE_PLAY_RTDN_SERVICE_ACCOUNT_SUBJECT?.trim();
  const subscription = process.env.GOOGLE_PLAY_RTDN_SUBSCRIPTION?.trim();
  const packageName = process.env.GOOGLE_PLAY_PACKAGE_NAME?.trim();
  const key = encryptionKey();
  if (
    process.env.GOOGLE_PLAY_RTDN_ENABLED !== 'true' ||
    !audience ||
    audience.length > 512 ||
    !email ||
    !/^[^@\s]+@[^@\s]+\.gserviceaccount\.com$/.test(email) ||
    !subject ||
    !/^\d{1,32}$/.test(subject) ||
    !subscription ||
    !/^projects\/[^/\s]+\/subscriptions\/[^/\s]+$/.test(subscription) ||
    !packageName ||
    packageName.length > 255 ||
    !/^[A-Za-z][A-Za-z0-9_]*(?:\.[A-Za-z][A-Za-z0-9_]*)+$/.test(packageName) ||
    !key
  ) {
    throw new ServiceUnavailableException(
      'Google Play notification receipt is not configured.',
    );
  }
  return { audience, email, subject, subscription, packageName, key };
}

/** The dedicated Google push identity is the only authorized event sender. */
export async function verifyGooglePushIdentity(
  authorization: string | undefined,
  identity: PushIdentity,
  keys: JWTVerifyGetKey,
): Promise<void> {
  const token = /^Bearer ([A-Za-z0-9_.-]+)$/.exec(authorization ?? '')?.[1];
  if (!token || token.length > 8192) {
    throw new UnauthorizedException('Invalid Google Play push identity.');
  }
  try {
    const { payload } = await jwtVerify(token, keys, {
      algorithms: ['RS256'],
      issuer: ['https://accounts.google.com', 'accounts.google.com'],
      audience: identity.audience,
      subject: identity.subject,
      requiredClaims: ['exp', 'iat', 'email', 'email_verified'],
      maxTokenAge: '1h',
      clockTolerance: 5,
    });
    if (
      payload.aud !== identity.audience ||
      payload.email !== identity.email ||
      payload.email_verified !== true
    ) {
      throw new Error('Unexpected Google push identity.');
    }
  } catch {
    // Never echo the bearer token, provider payload or JOSE error details.
    throw new UnauthorizedException('Invalid Google Play push identity.');
  }
}

@Injectable()
export class GooglePlayNotificationAuth {
  private readonly keys = createRemoteJWKSet(GOOGLE_KEYS, {
    timeoutDuration: 5000,
  });

  verify(authorization: string | undefined, identity: PushIdentity) {
    return verifyGooglePushIdentity(authorization, identity, this.keys);
  }
}

function record(value: unknown): Record<string, unknown> {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    throw new BadRequestException('Invalid Google Play notification.');
  }
  return value as Record<string, unknown>;
}

function boundedString(value: unknown, max: number): string {
  if (
    typeof value !== 'string' ||
    !value.length ||
    value.length > max ||
    Array.from(value).some((char) => {
      const code = char.charCodeAt(0);
      return code < 32 || code === 127;
    })
  ) {
    throw new BadRequestException('Invalid Google Play notification.');
  }
  return value;
}

function positiveInteger(value: unknown): number {
  if (
    typeof value !== 'number' ||
    !Number.isSafeInteger(value) ||
    value < 1 ||
    value > 2_147_483_647
  ) {
    throw new BadRequestException('Invalid Google Play notification.');
  }
  return value;
}

export function normalizeGooglePlayPush(body: unknown, settings: PushConfig) {
  const envelope = record(body);
  if (envelope.subscription !== settings.subscription) {
    throw new BadRequestException('Unexpected Google Play subscription.');
  }
  const message = record(envelope.message);
  const messageId = boundedString(message.messageId, 200);
  if (message.message_id !== undefined && message.message_id !== messageId) {
    throw new BadRequestException('Invalid Google Play message identity.');
  }
  const encoded = boundedString(message.data, 65_536);
  if (!/^[A-Za-z0-9+/]+={0,2}$/.test(encoded)) {
    throw new BadRequestException('Invalid Google Play message data.');
  }
  const decoded = Buffer.from(encoded, 'base64');
  if (
    decoded.toString('base64').replace(/=+$/, '') !== encoded.replace(/=+$/, '')
  ) {
    throw new BadRequestException('Invalid Google Play message data.');
  }

  let data: Record<string, unknown>;
  try {
    const parsed: unknown = JSON.parse(
      new TextDecoder('utf-8', { fatal: true }).decode(decoded),
    );
    data = record(parsed);
  } catch {
    throw new BadRequestException('Invalid Google Play message data.');
  }

  if (data.version !== '1.0' || data.packageName !== settings.packageName) {
    throw new BadRequestException('Unexpected Google Play application.');
  }
  const millis = data.eventTimeMillis;
  const timestamp =
    typeof millis === 'string' && /^\d{1,16}$/.test(millis)
      ? Number(millis)
      : millis;
  if (
    typeof timestamp !== 'number' ||
    !Number.isSafeInteger(timestamp) ||
    timestamp <= 0 ||
    !Number.isFinite(new Date(timestamp).getTime())
  ) {
    throw new BadRequestException('Invalid Google Play event time.');
  }

  const present = EVENT_FIELDS.filter((field) => data[field] !== undefined);
  if (present.length !== 1) {
    throw new BadRequestException('Unsupported Google Play event.');
  }
  const field = present[0];
  const event = record(data[field]);
  let eventType: string;
  let purchaseTokenHash: string | null = null;
  const payload = {
    packageName: settings.packageName,
    subscription: settings.subscription,
    eventTimeMillis: String(timestamp),
    payloadHash: createHash('sha256').update(decoded).digest('hex'),
    notificationVersion: '1.0',
  };
  const details: Record<string, string | number> = {};

  if (field === 'testNotification') {
    eventType = 'TEST';
  } else if (field === 'pendingRefundReviewNotification') {
    eventType = 'PENDING_REFUND_REVIEW';
    details.orderId = boundedString(event.orderId, 160);
    details.refundReason = positiveInteger(event.refundReason);
    const reviewToken = boundedString(event.pendingRefundToken, 4096);
    details.pendingRefundTokenHash = tokenHash(reviewToken);
    details.encryptedPendingRefundToken = encryptPurchaseToken(
      reviewToken,
      settings.key,
    );
  } else {
    const token = boundedString(event.purchaseToken, 4096);
    purchaseTokenHash = tokenHash(token);
    details.encryptedPurchaseToken = encryptPurchaseToken(token, settings.key);
    if (field === 'oneTimeProductNotification') {
      const type = positiveInteger(event.notificationType);
      if (type !== 1 && type !== 2) {
        throw new BadRequestException('Unsupported Google Play product event.');
      }
      eventType = type === 1 ? 'ONE_TIME_PURCHASED' : 'ONE_TIME_CANCELED';
      details.notificationType = type;
      details.productId = boundedString(event.sku, 160);
    } else if (field === 'voidedPurchaseNotification') {
      const productType = positiveInteger(event.productType);
      const refundType = positiveInteger(event.refundType);
      if (![1, 2].includes(productType) || ![1, 2].includes(refundType)) {
        throw new BadRequestException('Unsupported Google Play void event.');
      }
      eventType =
        productType === 1
          ? 'SUBSCRIPTION_VOIDED'
          : refundType === 1
            ? 'ONE_TIME_FULL_VOID'
            : 'ONE_TIME_PARTIAL_VOID';
      details.orderId = boundedString(event.orderId, 160);
      details.productType = productType;
      details.refundType = refundType;
    } else {
      eventType = 'SUBSCRIPTION_NOTIFICATION';
      details.notificationType = positiveInteger(event.notificationType);
    }
  }

  return {
    messageId,
    eventType,
    purchaseTokenHash,
    payload: { ...payload, ...details },
  };
}

@Injectable()
export class GooglePlayNotificationsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly auth: GooglePlayNotificationAuth,
  ) {}

  async ingest(authorization: string | undefined, body: unknown) {
    const settings = config();
    await this.auth.verify(authorization, settings);
    const normalized = normalizeGooglePlayPush(body, settings);
    try {
      const created = await this.prisma.googlePlayNotification.create({
        data: normalized,
        select: { id: true },
      });
      return { status: 'RECEIVED' as const, eventId: created.id };
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        const existing = await this.prisma.googlePlayNotification.findUnique({
          where: { messageId: normalized.messageId },
          select: { id: true, payload: true },
        });
        if (existing) {
          const payload = record(existing.payload);
          if (payload.payloadHash === normalized.payload.payloadHash) {
            return { status: 'DUPLICATE' as const, eventId: existing.id };
          }
          throw new ConflictException(
            'Google Play message ID was reused with different content.',
          );
        }
      }
      throw error;
    }
  }
}
