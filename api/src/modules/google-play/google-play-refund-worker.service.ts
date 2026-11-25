import { Injectable, ServiceUnavailableException } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { randomUUID } from 'node:crypto';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { GooglePlayDeveloperApiProvider } from './google-play-developer-api.provider';
import {
  GooglePlayReconciliationService,
  REFUND_EVENTS,
} from './google-play-reconciliation.service';
import { encryptionKey } from './google-play-token';

const LEASE_MS = 120_000;
const BATCH = 2;
const MAX_ATTEMPTS = 31;

interface ClaimedReceipt {
  id: string;
  reconciliationAttemptCount: number;
}

export function refundRetryDelay(attempt: number): number {
  return Math.min(
    86_400_000,
    300_000 * 2 ** Math.min(10, Math.max(0, attempt - 1)),
  );
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
export class GooglePlayRefundWorkerService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly provider: GooglePlayDeveloperApiProvider,
    private readonly reconciliation: GooglePlayReconciliationService,
  ) {}

  async status(now = new Date()) {
    const packageName = packageSetting();
    const enabled =
      process.env.GOOGLE_PLAY_AUTOMATED_RECONCILIATION_ENABLED === 'true' &&
      process.env.GOOGLE_PLAY_RECONCILIATION_ENABLED === 'true';
    if (!packageName) {
      return { enabled, unresolved: 0, due: 0, leased: 0, deferred: 0 };
    }
    const base: Prisma.GooglePlayNotificationWhereInput = {
      processedAt: null,
      eventType: { in: [...REFUND_EVENTS] },
      purchaseTokenHash: { not: null },
      payload: { path: ['packageName'], equals: packageName },
    };
    const available: Prisma.GooglePlayNotificationWhereInput = {
      ...base,
      OR: [
        { reconciliationLeaseUntil: null },
        { reconciliationLeaseUntil: { lte: now } },
      ],
    };
    const [unresolved, due, leased, deferred] = await this.prisma.$transaction([
      this.prisma.googlePlayNotification.count({ where: base }),
      this.prisma.googlePlayNotification.count({
        where: {
          ...available,
          reconciliationNextAttemptAt: { lte: now },
        },
      }),
      this.prisma.googlePlayNotification.count({
        where: { ...base, reconciliationLeaseUntil: { gt: now } },
      }),
      this.prisma.googlePlayNotification.count({
        where: {
          ...available,
          reconciliationNextAttemptAt: { gt: now },
        },
      }),
    ]);
    return { enabled, unresolved, due, leased, deferred };
  }

  async runBatch(now = new Date()) {
    const packageName = packageSetting();
    if (
      process.env.GOOGLE_PLAY_AUTOMATED_RECONCILIATION_ENABLED !== 'true' ||
      process.env.GOOGLE_PLAY_RECONCILIATION_ENABLED !== 'true' ||
      !packageName ||
      !this.provider.isConfigured() ||
      !encryptionKey()
    ) {
      throw new ServiceUnavailableException(
        'Google Play refund verification is not configured.',
      );
    }

    try {
      const leaseId = randomUUID();
      const leaseUntil = new Date(now.getTime() + LEASE_MS);
      // A single atomic statement claims only unprocessed, due receipts.
      // No transaction or lock survives into the provider calls.
      const receipts = await this.prisma.$queryRaw<ClaimedReceipt[]>`
        UPDATE "GooglePlayNotification" AS notice
        SET "reconciliationLeaseId" = ${leaseId}::uuid,
            "reconciliationLeaseUntil" = ${leaseUntil},
            "reconciliationAttemptCount" =
              LEAST(notice."reconciliationAttemptCount" + 1, ${MAX_ATTEMPTS})
        FROM (
          SELECT id FROM "GooglePlayNotification"
          WHERE "processedAt" IS NULL
            AND "eventType" IN (${Prisma.join([...REFUND_EVENTS])})
            AND "purchaseTokenHash" IS NOT NULL
            AND payload->>'packageName' = ${packageName}
            AND "reconciliationNextAttemptAt" <= ${now}
            AND ("reconciliationLeaseUntil" IS NULL
                 OR "reconciliationLeaseUntil" <= ${now})
          ORDER BY "reconciliationNextAttemptAt", "receivedAt", id
          LIMIT ${BATCH}
          FOR UPDATE SKIP LOCKED
        ) AS due
        WHERE notice.id = due.id
        RETURNING notice.id, notice."reconciliationAttemptCount"
      `;
      if (!receipts.length) return { status: 'DRAINED' as const };

      const outcomes = await Promise.allSettled(
        receipts.map((receipt) => this.verify(receipt, leaseId)),
      );
      const summary = {
        status: 'BATCH_COMPLETE' as const,
        claimed: receipts.length,
        verified: 0,
        pending: 0,
        failed: 0,
        superseded: 0,
      };
      for (const outcome of outcomes) {
        if (outcome.status === 'rejected') {
          // A failed completion write leaves its lease reclaimable.
          summary.failed++;
        } else {
          summary[outcome.value]++;
        }
      }
      return summary;
    } catch {
      // Provider bodies and database arguments may contain sensitive data.
      throw new ServiceUnavailableException(
        'Google Play refund verification failed.',
      );
    }
  }

  private async verify(receipt: ClaimedReceipt, leaseId: string) {
    let failed = false;
    try {
      // Null actor is a system action. This is exactly the same evidence
      // reconciliation used by the AAL2 operator endpoint.
      await this.reconciliation.reconcile(receipt.id, null);
    } catch {
      failed = true;
    }

    const nextAttempt = new Date(
      Date.now() + refundRetryDelay(receipt.reconciliationAttemptCount),
    );
    // Fence completion with the lease ID. A worker whose lease expired
    // cannot undo a newer worker's schedule or set errors on processed rows.
    return this.prisma.$transaction(async (tx) => {
      const cleared = await tx.googlePlayNotification.updateMany({
        where: {
          id: receipt.id,
          reconciliationLeaseId: leaseId,
          processedAt: { not: null },
        },
        data: {
          reconciliationLeaseId: null,
          reconciliationLeaseUntil: null,
        },
      });
      if (cleared.count) return 'verified' as const;

      const postponed = await tx.googlePlayNotification.updateMany({
        where: {
          id: receipt.id,
          reconciliationLeaseId: leaseId,
          processedAt: null,
        },
        data: {
          reconciliationLeaseId: null,
          reconciliationLeaseUntil: null,
          reconciliationNextAttemptAt: nextAttempt,
          ...(failed ? { processingError: 'AUTOMATED_RETRY_REQUIRED' } : {}),
        },
      });
      if (postponed.count)
        return failed ? ('failed' as const) : ('pending' as const);

      // An administrator may have processed the receipt between the two
      // updates; clean up only a lease still owned by this worker.
      const completed = await tx.googlePlayNotification.updateMany({
        where: {
          id: receipt.id,
          reconciliationLeaseId: leaseId,
          processedAt: { not: null },
        },
        data: {
          reconciliationLeaseId: null,
          reconciliationLeaseUntil: null,
        },
      });
      return completed.count ? ('verified' as const) : ('superseded' as const);
    });
  }
}
