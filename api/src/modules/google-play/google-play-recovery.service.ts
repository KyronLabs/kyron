import {
  BadRequestException,
  Injectable,
  ServiceUnavailableException,
} from '@nestjs/common';
import type { GooglePlayRecoveryCheckpoint } from '@prisma/client';
import { createHash } from 'node:crypto';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { GooglePlayDeveloperApiProvider } from './google-play-developer-api.provider';
import {
  decryptPurchaseToken,
  encryptionKey,
  encryptPurchaseToken,
  tokenHash,
} from './google-play-token';

const DAY = 86_400_000;
const OVERLAP = 2 * DAY;
const INITIAL_LOOKBACK = 29 * DAY;
const MAX_WINDOW_AGE = 30 * DAY - 3_600_000;
const SAFETY_DELAY = 300_000;
const MAX_PAGES = 10_000;
const RECOVERED = 'ONE_TIME_VOID_RECOVERED';

function record(value: unknown): Record<string, unknown> {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    throw new Error('Invalid provider object.');
  }
  return value as Record<string, unknown>;
}

function text(value: unknown, max: number): string {
  if (
    typeof value !== 'string' ||
    value.length === 0 ||
    value.length > max ||
    Array.from(value).some((char) => char.charCodeAt(0) < 32)
  ) {
    throw new Error('Invalid provider field.');
  }
  return value;
}

function millis(value: unknown): string {
  const raw = text(value, 16);
  if (!/^\d+$/.test(raw) || !Number.isSafeInteger(Number(raw))) {
    throw new Error('Invalid provider timestamp.');
  }
  if (Number(raw) <= 0 || !Number.isFinite(new Date(Number(raw)).getTime())) {
    throw new Error('Invalid provider timestamp.');
  }
  return String(Number(raw));
}

function optionalInteger(value: unknown, minimum: number): number | null {
  if (value === undefined) return null;
  if (
    typeof value !== 'number' ||
    !Number.isSafeInteger(value) ||
    value < minimum ||
    value > 2_147_483_647
  ) {
    throw new Error('Invalid provider integer.');
  }
  return value;
}

export function recoveryWindow(
  now: Date,
  checkpoint: Pick<
    GooglePlayRecoveryCheckpoint,
    'coveredThrough' | 'windowStart' | 'windowEnd'
  >,
) {
  const end = now.getTime() - SAFETY_DELAY;
  const start =
    checkpoint.windowStart?.getTime() ??
    (checkpoint.coveredThrough
      ? checkpoint.coveredThrough.getTime() - OVERLAP
      : end - INITIAL_LOOKBACK);
  const windowEnd = checkpoint.windowEnd?.getTime() ?? end;
  if (
    start < now.getTime() - MAX_WINDOW_AGE ||
    start >= windowEnd ||
    windowEnd > end ||
    (checkpoint.coveredThrough &&
      windowEnd < checkpoint.coveredThrough.getTime())
  ) {
    return null;
  }
  return { start: new Date(start), end: new Date(windowEnd) };
}

/** The void timestamp is evidence, not the API's visibility-time cursor. */
export function normalizeRecoveredVoid(
  value: unknown,
  packageName: string,
  key: Buffer,
) {
  const item = record(value);
  const token = text(item.purchaseToken, 4096);
  const digest = tokenHash(token);
  const metadata = {
    packageName,
    orderId: text(item.orderId, 160),
    voidedTimeMillis: millis(item.voidedTimeMillis),
    voidedQuantity: optionalInteger(item.voidedQuantity, 1),
    voidedSource: optionalInteger(item.voidedSource, 0),
    voidedReason: optionalInteger(item.voidedReason, 0),
    purchaseTokenHash: digest,
  };
  const fingerprint = createHash('sha256')
    .update(JSON.stringify(metadata))
    .digest('hex');
  return {
    messageId: `void-recovery:v1:${fingerprint}`,
    eventType: RECOVERED,
    purchaseTokenHash: digest,
    payload: {
      ...metadata,
      payloadHash: fingerprint,
      receiptSource: 'VOIDED_PURCHASES_API',
      eventTimeMillis: metadata.voidedTimeMillis,
      encryptedPurchaseToken: encryptPurchaseToken(token, key),
    },
  };
}

function packageSetting(): string | null {
  const name = process.env.GOOGLE_PLAY_PACKAGE_NAME?.trim();
  return name &&
    name.length <= 255 &&
    /^[A-Za-z][A-Za-z0-9_]*(?:\.[A-Za-z][A-Za-z0-9_]*)+$/.test(name)
    ? name
    : null;
}

@Injectable()
export class GooglePlayRecoveryService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly googlePlay: GooglePlayDeveloperApiProvider,
  ) {}

  async status() {
    const packageName = packageSetting();
    const enabled = process.env.GOOGLE_PLAY_RECOVERY_ENABLED === 'true';
    if (!packageName) return { enabled, checkpoint: null, pending: 0 };
    const [checkpoint, pending] = await Promise.all([
      this.prisma.googlePlayRecoveryCheckpoint.findUnique({
        where: { packageName },
        select: {
          packageName: true,
          coveredThrough: true,
          windowStart: true,
          windowEnd: true,
          pagesInWindow: true,
          lastAttemptAt: true,
          lastSuccessAt: true,
          lastError: true,
        },
      }),
      this.prisma.googlePlayNotification.count({
        where: {
          eventType: RECOVERED,
          processedAt: null,
          payload: { path: ['packageName'], equals: packageName },
        },
      }),
    ]);
    return { enabled, checkpoint, pending };
  }

  async runPage(now = new Date()) {
    const packageName = packageSetting();
    const key = encryptionKey();
    if (
      process.env.GOOGLE_PLAY_RECOVERY_ENABLED !== 'true' ||
      !packageName ||
      !key ||
      !this.googlePlay.isConfigured()
    ) {
      throw new ServiceUnavailableException(
        'Google Play void recovery is not configured.',
      );
    }
    try {
      return await this.recoverPage(packageName, key, now);
    } catch {
      // Do not log provider payloads, cursors or database query arguments.
      throw new ServiceUnavailableException('Google Play void recovery failed.');
    }
  }

  private async recoverPage(packageName: string, key: Buffer, now: Date) {
    await this.prisma.googlePlayRecoveryCheckpoint.createMany({
      data: [{ packageName }],
      skipDuplicates: true,
    });
    let state = await this.prisma.googlePlayRecoveryCheckpoint.findUniqueOrThrow(
      { where: { packageName } },
    );
    const window = recoveryWindow(now, state);
    if (!window) {
      return this.fail(state, now, 'RETENTION_GAP_OR_CLOCK_REGRESSION');
    }
    if (!state.windowStart) {
      const opened = await this.prisma.googlePlayRecoveryCheckpoint.updateMany({
        where: { packageName, revision: state.revision },
        data: {
          revision: { increment: 1 },
          windowStart: window.start,
          windowEnd: window.end,
          lastAttemptAt: now,
        },
      });
      if (!opened.count) return { status: 'SUPERSEDED' as const };
      state = await this.prisma.googlePlayRecoveryCheckpoint.findUniqueOrThrow({
        where: { packageName },
      });
      // Another caller may already have advanced the window after opening it.
      if (
        state.windowStart?.getTime() !== window.start.getTime() ||
        state.windowEnd?.getTime() !== window.end.getTime()
      ) {
        return { status: 'SUPERSEDED' as const };
      }
    }
    if (state.pagesInWindow >= MAX_PAGES) {
      return this.fail(state, now, 'PAGE_LIMIT_REACHED');
    }
    let cursor: string | undefined;
    try {
      if (state.encryptedPageToken) {
        cursor = decryptPurchaseToken(state.encryptedPageToken, key);
      }
    } catch {
      return this.fail(state, now, 'CURSOR_DECRYPTION_FAILED');
    }

    let response: unknown;
    try {
      response = await this.googlePlay.listVoidedPurchases(
        window.start.getTime(),
        window.end.getTime(),
        cursor,
      );
    } catch (error) {
      // A rejected continuation may have expired. Replay the same fixed
      // window, never advance across a page that was not committed.
      const rejected = error instanceof BadRequestException;
      return this.fail(
        state,
        now,
        rejected && cursor ? 'CURSOR_RESTART_REQUIRED' : 'PROVIDER_RETRY',
        !!cursor && rejected,
      );
    }

    let receipts: ReturnType<typeof normalizeRecoveredVoid>[];
    let next: string | null;
    try {
      const result = record(response);
      const items =
        result.voidedPurchases === undefined ? [] : result.voidedPurchases;
      if (!Array.isArray(items) || items.length > 100) {
        throw new Error('Invalid provider page size.');
      }
      receipts = (items as unknown[]).map((item) =>
        normalizeRecoveredVoid(item, packageName, key),
      );
      const pagination =
        result.tokenPagination === undefined
          ? {}
          : record(result.tokenPagination);
      next =
        pagination.nextPageToken === undefined ||
        pagination.nextPageToken === ''
          ? null
          : text(pagination.nextPageToken, 4096);
      if (next && next === cursor) {
        return this.fail(state, now, 'REPEATED_CURSOR', true);
      }
    } catch {
      return this.fail(state, now, 'MALFORMED_PROVIDER_PAGE');
    }

    const encryptedNext = next ? encryptPurchaseToken(next, key) : null;
    return this.prisma.$transaction(async (tx) => {
      const moved = await tx.googlePlayRecoveryCheckpoint.updateMany({
        where: { packageName, revision: state.revision },
        data: {
          revision: { increment: 1 },
          lastAttemptAt: now,
          lastSuccessAt: new Date(),
          lastError: null,
          ...(encryptedNext
            ? {
                encryptedPageToken: encryptedNext,
                pagesInWindow: { increment: 1 },
              }
            : {
                coveredThrough: window.end,
                windowStart: null,
                windowEnd: null,
                encryptedPageToken: null,
                pagesInWindow: 0,
              }),
        },
      });
      if (!moved.count) return { status: 'SUPERSEDED' as const };
      const inserted = await tx.googlePlayNotification.createMany({
        data: receipts,
        skipDuplicates: true,
      });
      await tx.financialAuditEvent.create({
        data: {
          eventType: 'GOOGLE_PLAY_VOID_RECOVERY_PAGE_RETAINED',
          subjectType: 'GOOGLE_PLAY_RECOVERY',
          subjectId: packageName,
          metadata: {
            windowStart: window.start.toISOString(),
            windowEnd: window.end.toISOString(),
            returned: receipts.length,
            inserted: inserted.count,
            complete: !encryptedNext,
          },
        },
      });
      return {
        status: encryptedNext
          ? ('PAGE_RETAINED' as const)
          : ('WINDOW_COMPLETE' as const),
        inserted: inserted.count,
        returned: receipts.length,
      };
    });
  }

  private async fail(
    state: GooglePlayRecoveryCheckpoint,
    now: Date,
    reason: string,
    resetCursor = false,
  ) {
    return this.prisma.$transaction(async (tx) => {
      const updated = await tx.googlePlayRecoveryCheckpoint.updateMany({
        where: { packageName: state.packageName, revision: state.revision },
        data: {
          revision: { increment: 1 },
          lastAttemptAt: now,
          lastError: reason,
          ...(resetCursor
            ? { encryptedPageToken: null, pagesInWindow: 0 }
            : {}),
        },
      });
      if (!updated.count) return { status: 'SUPERSEDED' as const };
      await tx.financialAuditEvent.create({
        data: {
          eventType: 'GOOGLE_PLAY_VOID_RECOVERY_RETRY_REQUIRED',
          subjectType: 'GOOGLE_PLAY_RECOVERY',
          subjectId: state.packageName,
          metadata: { reason },
        },
      });
      return { status: 'RETRY_REQUIRED' as const, reason };
    });
  }
}
