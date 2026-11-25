import { BadRequestException, UnauthorizedException } from '@nestjs/common';
import {
  createLocalJWKSet,
  exportJWK,
  generateKeyPair,
  SignJWT,
} from 'jose';
import { createHash } from 'node:crypto';
import {
  normalizeGooglePlayPush,
  verifyGooglePushIdentity,
} from './google-play-notifications.service';

const settings = {
  audience: 'https://api.example.test/google-play/notifications',
  email: 'push@project.iam.gserviceaccount.com',
  subject: '123456789',
  packageName: 'so.kyron.app',
  subscription: 'projects/project/subscriptions/play',
  key: Buffer.alloc(32, 7),
};

const token = 'purchase-token-for-tests';
const baseEvent = {
  version: '1.0',
  packageName: settings.packageName,
  eventTimeMillis: '1795500000000',
};

function envelope(event: Record<string, unknown>) {
  return {
    subscription: settings.subscription,
    message: {
      messageId: '12345',
      data: Buffer.from(JSON.stringify({ ...baseEvent, ...event })).toString(
        'base64',
      ),
    },
  };
}

describe('Google Play notification normalization', () => {
  it.each([
    [1, 'ONE_TIME_FULL_VOID'],
    [2, 'ONE_TIME_PARTIAL_VOID'],
  ])('distinguishes refund type %s', (refundType, eventType) => {
    const result = normalizeGooglePlayPush(
      envelope({
        voidedPurchaseNotification: {
          purchaseToken: token,
          orderId: 'GPA.example',
          productType: 2,
          refundType,
        },
      }),
      settings,
    );
    expect(result.eventType).toBe(eventType);
    expect(result.purchaseTokenHash).toBe(
      createHash('sha256').update(token).digest('hex'),
    );
    expect(JSON.stringify(result)).not.toContain(token);
    expect(result.payload).toMatchObject({
      orderId: 'GPA.example',
      refundType,
    });
  });

  it('retains pending refund reviews separately from completed voids', () => {
    const result = normalizeGooglePlayPush(
      envelope({
        pendingRefundReviewNotification: {
          pendingRefundToken: 'pending-review-secret',
          orderId: 'GPA.example',
          refundReason: 7,
        },
      }),
      settings,
    );
    expect(result.eventType).toBe('PENDING_REFUND_REVIEW');
    expect(result.purchaseTokenHash).toBeNull();
    expect(JSON.stringify(result)).not.toContain('pending-review-secret');
    expect(result.payload).toMatchObject({
      orderId: 'GPA.example',
      refundReason: 7,
    });
  });

  it('rejects mixed event types and another application', () => {
    expect(() =>
      normalizeGooglePlayPush(
        envelope({ testNotification: {}, subscriptionNotification: {} }),
        settings,
      ),
    ).toThrow(BadRequestException);
    expect(() =>
      normalizeGooglePlayPush(
        envelope({ packageName: 'other.app', testNotification: {} }),
        settings,
      ),
    ).toThrow(BadRequestException);
  });

  it('rejects another subscription and invalid base64', () => {
    const body = envelope({ testNotification: {} });
    expect(() =>
      normalizeGooglePlayPush({ ...body, subscription: 'other' }, settings),
    ).toThrow(BadRequestException);
    body.message.data = 'not base64!';
    expect(() => normalizeGooglePlayPush(body, settings)).toThrow(
      BadRequestException,
    );
  });
});

describe('Google Play signed push identity', () => {
  it('accepts the pinned identity and rejects altered claims and signatures', async () => {
    const { privateKey, publicKey } = await generateKeyPair('RS256', {
      extractable: true,
    });
    const keys = createLocalJWKSet({
      keys: [{ ...(await exportJWK(publicKey)), kid: 'test' }],
    });
    const sign = (
      audience: string,
      email: string,
      subject: string,
      verified: boolean,
      expires: number | string = '1h',
    ) =>
      new SignJWT({ email, email_verified: verified })
        .setProtectedHeader({ alg: 'RS256', kid: 'test' })
        .setIssuer('https://accounts.google.com')
        .setAudience(audience)
        .setSubject(subject)
        .setIssuedAt()
        .setExpirationTime(expires)
        .sign(privateKey);
    const valid = await sign(
      settings.audience,
      settings.email,
      settings.subject,
      true,
    );
    await expect(
      verifyGooglePushIdentity(`Bearer ${valid}`, settings, keys),
    ).resolves.toBeUndefined();

    const wrongClaims = [
      await sign('wrong', settings.email, settings.subject, true),
      await sign(settings.audience, 'wrong', settings.subject, true),
      await sign(settings.audience, settings.email, 'wrong', true),
      await sign(settings.audience, settings.email, settings.subject, false),
      await sign(settings.audience, settings.email, settings.subject, true, 1),
    ];
    for (const invalid of wrongClaims) {
      await expect(
        verifyGooglePushIdentity(`Bearer ${invalid}`, settings, keys),
      ).rejects.toBeInstanceOf(UnauthorizedException);
    }

    const signatureOffset = valid.lastIndexOf('.') + 1;
    const altered = [
      valid.slice(0, signatureOffset),
      valid[signatureOffset] === 'A' ? 'B' : 'A',
      valid.slice(signatureOffset + 1),
    ].join('');
    await expect(
      verifyGooglePushIdentity(`Bearer ${altered}`, settings, keys),
    ).rejects.toBeInstanceOf(UnauthorizedException);
    await expect(
      verifyGooglePushIdentity(undefined, settings, keys),
    ).rejects.toBeInstanceOf(UnauthorizedException);
  });
});
