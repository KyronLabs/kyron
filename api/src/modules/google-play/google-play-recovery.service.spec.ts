import { NotFoundException } from '@nestjs/common';
import { requireRecoveryKey } from './google-play-recovery.controller';
import {
  normalizeRecoveredVoid,
  recoveryWindow,
} from './google-play-recovery.service';
import { decryptPurchaseToken } from './google-play-token';

const key = Buffer.alloc(32, 5);
const day = 86_400_000;
const now = new Date('2026-11-25T12:00:00Z');
const base = {
  coveredThrough: null,
  windowStart: null,
  windowEnd: null,
};
const item = {
  purchaseToken: 'secret-purchase-token',
  orderId: 'GPA.test',
  voidedTimeMillis: '1795500000000',
  voidedQuantity: 2,
  voidedReason: 7,
  voidedSource: 0,
};

describe('Google Play recovery window', () => {
  it('starts with 29 days and overlaps completed windows by 48 hours', () => {
    const initial = recoveryWindow(now, base);
    expect(initial?.end.getTime()).toBe(now.getTime() - 300_000);
    expect(initial?.start.getTime()).toBe(
      now.getTime() - 300_000 - 29 * day,
    );
    const coveredThrough = new Date(now.getTime() - day);
    const resumed = recoveryWindow(now, { ...base, coveredThrough });
    expect(resumed?.start.getTime()).toBe(now.getTime() - 3 * day);
  });

  it('never regresses coverage when the clock moves backwards', () => {
    expect(
      recoveryWindow(now, {
        ...base,
        coveredThrough: new Date(now.getTime() + day),
      }),
    ).toBeNull();
    expect(
      recoveryWindow(now, {
        ...base,
        windowStart: new Date(now.getTime() - day),
        windowEnd: new Date(now.getTime() + day),
      }),
    ).toBeNull();
  });

  it('keeps the exact open window and fails closed on expired coverage', () => {
    const windowStart = new Date(now.getTime() - 2 * day);
    const windowEnd = new Date(now.getTime() - day);
    expect(recoveryWindow(now, { ...base, windowStart, windowEnd })).toEqual({
      start: windowStart,
      end: windowEnd,
    });
    expect(
      recoveryWindow(now, {
        ...base,
        coveredThrough: new Date(now.getTime() - 31 * day),
      }),
    ).toBeNull();
  });
});

describe('Google Play recovery evidence', () => {
  it('deduplicates exact provider records and encrypts the purchase token', () => {
    const a = normalizeRecoveredVoid(item, 'so.kyron.app', key);
    const b = normalizeRecoveredVoid(item, 'so.kyron.app', key);
    expect(a.messageId).toBe(b.messageId);
    expect(a.payload.encryptedPurchaseToken).not.toBe(
      b.payload.encryptedPurchaseToken,
    );
    expect(
      decryptPurchaseToken(a.payload.encryptedPurchaseToken, key),
    ).toBe(item.purchaseToken);
    expect(JSON.stringify(a)).not.toContain(item.purchaseToken);
    expect(a.payload.voidedSource).toBe(0);
    expect(
      normalizeRecoveredVoid(
        { ...item, voidedQuantity: 1 },
        'so.kyron.app',
        key,
      ).messageId,
    ).not.toBe(a.messageId);
  });

  it.each([0, -1, 1.5, '2'])('rejects invalid quantity %s', (quantity) => {
    expect(() =>
      normalizeRecoveredVoid(
        { ...item, voidedQuantity: quantity },
        'so.kyron.app',
        key,
      ),
    ).toThrow();
  });
});

describe('Google Play recovery scheduler authentication', () => {
  const previous = process.env.GOOGLE_PLAY_RECOVERY_CRON_KEY;
  afterEach(() => {
    if (previous === undefined) {
      delete process.env.GOOGLE_PLAY_RECOVERY_CRON_KEY;
    } else {
      process.env.GOOGLE_PLAY_RECOVERY_CRON_KEY = previous;
    }
  });

  it('requires the dedicated configured secret', () => {
    delete process.env.GOOGLE_PLAY_RECOVERY_CRON_KEY;
    expect(() => requireRecoveryKey('anything')).toThrow(NotFoundException);
    const secret = 'x'.repeat(32);
    process.env.GOOGLE_PLAY_RECOVERY_CRON_KEY = secret;
    expect(() => requireRecoveryKey(undefined)).toThrow(NotFoundException);
    expect(() => requireRecoveryKey('incorrect')).toThrow(NotFoundException);
    expect(() => requireRecoveryKey(secret)).not.toThrow();
  });
});
