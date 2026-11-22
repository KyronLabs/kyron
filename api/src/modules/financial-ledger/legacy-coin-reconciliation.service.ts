import { Injectable } from '@nestjs/common';
import { CoinKind, Prisma } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  isUuid,
  giftIdFromCoinEntryKey,
  mapLegacyCoinKind,
  planLegacyCoinEntry,
  rewardGrantIdFromCoinEntryKey,
  type LegacyCoinBucket,
  type LegacyCoinEntryLike,
  type LegacyLedgerTransactionPlan,
} from './legacy-coin-bridge';

type Tx = Prisma.TransactionClient;

type CoinEntryRow = LegacyCoinEntryLike;

type SourceSnapshot = {
  sourceId: string;
  actorId: string | null;
  beneficiaryId: string | null;
  amount: Prisma.Decimal | null;
  unitCode: string | null;
  payload: Prisma.JsonValue;
};

type ExistingLedgerTransaction = {
  id: string;
  sourceType: string;
  sourceId: string | null;
  idempotencyKey: string;
  eventType: string;
  currencyCode: string;
  postings: Array<{
    lineNumber: number;
    side: string;
    amount: Prisma.Decimal;
    account: {
      accountKey: string;
      accountType: string;
      normalSide: string;
      currencyCode: string;
      ownerId: string | null;
    };
  }>;
};

type IssueSeverity = 'BLOCKER' | 'WARNING' | 'INFO';

export interface LegacyCoinReconciliationIssue {
  code: string;
  severity: IssueSeverity;
  message: string;
  entryId?: string;
  sourceId?: string;
  userId?: string;
}

interface MutableKindTotals {
  entries: number;
  net: Prisma.Decimal;
  positive: Prisma.Decimal;
  negative: Prisma.Decimal;
}

interface GiftRollup {
  giftId: string;
  spendTotal: Prisma.Decimal;
  creatorTotal: Prisma.Decimal;
  spenderIds: Set<string>;
  creatorIds: Set<string>;
}

export interface LegacyCoinReconciliationOptions {
  pageSize?: number;
  includeUserBalances?: boolean;
  /** Optional operator/test scope. An omitted list scans every CoinEntry. */
  userIds?: string[];
}

export interface LegacyCoinReconciliationReport {
  mode: 'DRY_RUN';
  readOnly: true;
  mutationCount: 0;
  isolationLevel: 'RepeatableRead';
  scope: 'ALL_USERS' | 'SELECTED_USERS';
  pageSize: number;
  generatedAt: string;
  summary: {
    coinEntries: number;
    users: number;
    mappedEntries: number;
    unmappedEntries: number;
    zeroAmountEntries: number;
    eligibleTransactions: number;
    alreadyImportedEntries: number;
    newTransactions: number;
    debitTotal: string;
    creditTotal: string;
    buckets: Record<
      LegacyCoinBucket,
      { ownerAccounts: number; net: string }
    >;
    byKind: Record<
      string,
      { entries: number; net: string; positive: string; negative: string }
    >;
    issues: {
      total: number;
      blockers: number;
      warnings: number;
      info: number;
      samplesTruncated: boolean;
      byCode: Record<string, number>;
    };
  };
  issues: LegacyCoinReconciliationIssue[];
  userBalances?: Array<{
    userId: string;
    buckets: Record<LegacyCoinBucket, string>;
  }>;
}

const DEFAULT_PAGE_SIZE = 500;
const MAX_PAGE_SIZE = 2000;
const ISSUE_SAMPLE_LIMIT = 500;
const SOURCE_QUERY_BATCH_SIZE = 400;
const GIFT_LINKED_KINDS = new Set<string>([
  CoinKind.SPEND,
  CoinKind.REWARD_SPEND,
  CoinKind.PURCHASE_EARN,
  CoinKind.PROMOTIONAL_EARN,
  CoinKind.REWARD_EARN,
]);

function zeroKindTotals(): MutableKindTotals {
  return {
    entries: 0,
    net: new Prisma.Decimal(0),
    positive: new Prisma.Decimal(0),
    negative: new Prisma.Decimal(0),
  };
}

function zeroUserBuckets(): Record<LegacyCoinBucket, Prisma.Decimal> {
  return {
    LEGACY_COMPLIMENTARY: new Prisma.Decimal(0),
    REWARD_PROMOTIONAL: new Prisma.Decimal(0),
    CREATOR_PAYABLE: new Prisma.Decimal(0),
    CREATOR_PROMOTIONAL: new Prisma.Decimal(0),
    CREATOR_UNKNOWN: new Prisma.Decimal(0),
  };
}

function chunks<T>(values: T[], size: number): T[][] {
  const result: T[][] = [];
  for (let index = 0; index < values.length; index += size) {
    result.push(values.slice(index, index + size));
  }
  return result;
}

function jsonObject(
  value: Prisma.JsonValue,
): Record<string, Prisma.JsonValue> | null {
  if (value === null || Array.isArray(value) || typeof value !== 'object') {
    return null;
  }
  return value as Record<string, Prisma.JsonValue>;
}

function decimalsEqual(
  left: Prisma.Decimal | null,
  right: Prisma.Decimal,
): boolean {
  return left !== null && left.eq(right);
}

function importedTransactionMatchesPlan(
  transaction: ExistingLedgerTransaction,
  plan: LegacyLedgerTransactionPlan,
): boolean {
  if (
    transaction.eventType !== plan.eventType ||
    transaction.currencyCode !== plan.currencyCode ||
    transaction.postings.length !== plan.postings.length
  ) {
    return false;
  }

  return plan.postings.every((expected, index) => {
    const actual = transaction.postings[index];
    return (
      actual.lineNumber === index + 1 &&
      actual.side === expected.side &&
      actual.amount.eq(expected.amount) &&
      actual.account.accountKey === expected.accountKey &&
      actual.account.accountType === expected.accountType &&
      actual.account.normalSide === expected.normalSide &&
      actual.account.currencyCode === plan.currencyCode &&
      actual.account.ownerId === expected.ownerId
    );
  });
}

@Injectable()
export class LegacyCoinReconciliationService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * Read-only inventory and reconciliation of the legacy CoinEntry ledger.
   *
   * The SQL transaction is explicitly marked READ ONLY and uses a repeatable
   * snapshot. This service intentionally has no posting or mutation method.
   * Each supported CoinEntry gets a deterministic two-line posting plan, but
   * no LedgerAccount, LedgerTransaction or LedgerPosting is created.
   */
  async dryRun(
    options: LegacyCoinReconciliationOptions = {},
  ): Promise<LegacyCoinReconciliationReport> {
    const pageSize = options.pageSize ?? DEFAULT_PAGE_SIZE;
    if (
      !Number.isInteger(pageSize) ||
      pageSize < 1 ||
      pageSize > MAX_PAGE_SIZE
    ) {
      throw new Error(`pageSize must be between 1 and ${MAX_PAGE_SIZE}.`);
    }

    const userIds = options.userIds
      ? Array.from(new Set(options.userIds))
      : undefined;
    if (
      options.userIds &&
      (userIds?.length === 0 || userIds?.some((id) => !isUuid(id)))
    ) {
      throw new Error('userIds must contain one or more valid UUIDs.');
    }

    return this.prisma.$transaction(
      async (tx) => {
        await tx.$executeRaw`SET TRANSACTION READ ONLY`;

        const issues: LegacyCoinReconciliationIssue[] = [];
        const issueCounts = new Map<string, number>();
        let totalIssues = 0;
        let blockerIssues = 0;
        let warningIssues = 0;
        let infoIssues = 0;

        const addIssue = (issue: LegacyCoinReconciliationIssue): void => {
          totalIssues += 1;
          if (issue.severity === 'BLOCKER') blockerIssues += 1;
          else if (issue.severity === 'WARNING') warningIssues += 1;
          else infoIssues += 1;
          issueCounts.set(issue.code, (issueCounts.get(issue.code) ?? 0) + 1);
          if (issues.length < ISSUE_SAMPLE_LIMIT) issues.push(issue);
        };

        const byKind = new Map<string, MutableKindTotals>();
        for (const kind of Object.values(CoinKind)) {
          byKind.set(kind, zeroKindTotals());
        }

        const seenUsers = new Set<string>();
        const userBuckets = new Map<
          string,
          Record<LegacyCoinBucket, Prisma.Decimal>
        >();
        const giftRollups = new Map<string, GiftRollup>();
        const rewardGrantRows = new Map<string, CoinEntryRow[]>();
        const giftSources = new Map<string, SourceSnapshot>();
        const rewardSources = new Map<string, SourceSnapshot>();

        let coinEntries = 0;
        let mappedEntries = 0;
        let unmappedEntries = 0;
        let zeroAmountEntries = 0;
        let eligibleTransactions = 0;
        let alreadyImportedEntries = 0;
        let newTransactions = 0;
        let debitTotal = new Prisma.Decimal(0);
        let creditTotal = new Prisma.Decimal(0);
        let cursor: string | undefined;

        while (true) {
          const where = {
            ...(cursor ? { id: { gt: cursor } } : {}),
            ...(userIds ? { userId: { in: userIds } } : {}),
          };
          const rows = await tx.coinEntry.findMany({
            ...(Object.keys(where).length > 0 ? { where } : {}),
            orderBy: { id: 'asc' },
            take: pageSize,
            select: {
              id: true,
              userId: true,
              kind: true,
              amount: true,
              key: true,
              giftId: true,
              createdAt: true,
            },
          });
          if (rows.length === 0) break;

          coinEntries += rows.length;
          const rowIds = rows.map((row) => row.id);
          const expectedKeys = rows.map(
            (row) => `legacy-coin-entry:${row.id}`,
          );

          const existing = await tx.ledgerTransaction.findMany({
            where: {
              OR: [
                {
                  sourceType: 'LEGACY_COIN_ENTRY',
                  sourceId: { in: rowIds },
                },
                { idempotencyKey: { in: expectedKeys } },
              ],
            },
            select: {
              id: true,
              sourceType: true,
              sourceId: true,
              idempotencyKey: true,
              eventType: true,
              currencyCode: true,
              postings: {
                orderBy: { lineNumber: 'asc' },
                select: {
                  lineNumber: true,
                  side: true,
                  amount: true,
                  account: {
                    select: {
                      accountKey: true,
                      accountType: true,
                      normalSide: true,
                      currencyCode: true,
                      ownerId: true,
                    },
                  },
                },
              },
            },
          });

          const existingBySource = new Map<
            string,
            ExistingLedgerTransaction[]
          >();
          const existingByKey = new Map<
            string,
            ExistingLedgerTransaction[]
          >();
          for (const transaction of existing) {
            if (transaction.sourceId) {
              const matches = existingBySource.get(transaction.sourceId) ?? [];
              matches.push(transaction);
              existingBySource.set(transaction.sourceId, matches);
            }
            const keyMatches =
              existingByKey.get(transaction.idempotencyKey) ?? [];
            keyMatches.push(transaction);
            existingByKey.set(transaction.idempotencyKey, keyMatches);
          }

          for (const row of rows) {
            const kindTotals = byKind.get(row.kind) ?? zeroKindTotals();
            byKind.set(row.kind, kindTotals);
            kindTotals.entries += 1;
            kindTotals.net = kindTotals.net.plus(row.amount);
            if (row.amount > 0) {
              kindTotals.positive = kindTotals.positive.plus(row.amount);
            } else if (row.amount < 0) {
              kindTotals.negative = kindTotals.negative.plus(
                Math.abs(row.amount),
              );
            }

            seenUsers.add(row.userId);
            const mapping = mapLegacyCoinKind(row.kind);
            const plan = planLegacyCoinEntry(row);
            if (!mapping) {
              unmappedEntries += 1;
              addIssue({
                code: 'UNMAPPED_COIN_KIND',
                severity: 'BLOCKER',
                message: `CoinEntry kind "${row.kind}" has no approved ledger mapping.`,
                entryId: row.id,
              });
              continue;
            }

            mappedEntries += 1;
            const balances =
              userBuckets.get(row.userId) ?? zeroUserBuckets();
            balances[mapping.bucket] = balances[mapping.bucket].plus(
              row.amount,
            );
            userBuckets.set(row.userId, balances);

            if (row.kind === CoinKind.EARN) {
              addIssue({
                code: 'UNKNOWN_PROVENANCE_EARN',
                severity: 'WARNING',
                message:
                  'Legacy EARN is retained in a non-withdrawable unknown-provenance account.',
                entryId: row.id,
                userId: row.userId,
              });
            }

            if (!plan) {
              zeroAmountEntries += 1;
              addIssue({
                code: 'ZERO_AMOUNT',
                severity: 'BLOCKER',
                message: 'Zero-value CoinEntry rows cannot be imported as ledger postings.',
                entryId: row.id,
                userId: row.userId,
              });
            } else {
              eligibleTransactions += 1;
              const sourceMatches = existingBySource.get(row.id) ?? [];
              const keyMatches =
                existingByKey.get(plan.idempotencyKey) ?? [];
              const exactMatch = sourceMatches.find(
                (transaction) =>
                  transaction.sourceType === plan.sourceType &&
                  transaction.sourceId === plan.sourceId &&
                  transaction.idempotencyKey === plan.idempotencyKey,
              );

              if (sourceMatches.length > 1) {
                addIssue({
                  code: 'DUPLICATE_LEDGER_IMPORT',
                  severity: 'BLOCKER',
                  message:
                    'More than one ledger transaction already references this CoinEntry.',
                  entryId: row.id,
                });
              } else if (exactMatch && keyMatches.length === 1) {
                if (importedTransactionMatchesPlan(exactMatch, plan)) {
                  alreadyImportedEntries += 1;
                } else {
                  addIssue({
                    code: 'IMPORTED_LEDGER_MISMATCH',
                    severity: 'BLOCKER',
                    message:
                      'An existing ledger transaction references this CoinEntry but its event or postings do not match the deterministic import plan.',
                    entryId: row.id,
                  });
                }
              } else if (sourceMatches.length > 0 || keyMatches.length > 0) {
                addIssue({
                  code: 'IDEMPOTENCY_COLLISION',
                  severity: 'BLOCKER',
                  message:
                    'A legacy source ID or deterministic idempotency key is already used by a different ledger transaction.',
                  entryId: row.id,
                });
              } else {
                const absolute = new Prisma.Decimal(plan.postings[0].amount);
                debitTotal = debitTotal.plus(absolute);
                creditTotal = creditTotal.plus(absolute);
                newTransactions += 1;
              }
            }

            const parsedGiftId = giftIdFromCoinEntryKey(row.key);
            if (
              row.giftId &&
              parsedGiftId &&
              row.giftId.toLowerCase() !== parsedGiftId.toLowerCase()
            ) {
              addIssue({
                code: 'GIFT_REFERENCE_MISMATCH',
                severity: 'BLOCKER',
                message:
                  'CoinEntry.giftId disagrees with the gift ID encoded in its idempotency key.',
                entryId: row.id,
                sourceId: row.giftId,
                userId: row.userId,
              });
            }

            const giftId = row.giftId ?? parsedGiftId;
            if (GIFT_LINKED_KINDS.has(row.kind) && !giftId) {
              addIssue({
                code: 'MISSING_GIFT_REFERENCE',
                severity: 'BLOCKER',
                message:
                  'Gift-funded CoinEntry has neither giftId nor a recognised gift idempotency key.',
                entryId: row.id,
                userId: row.userId,
              });
            }
            if (giftId) {
              const rollup = giftRollups.get(giftId) ?? {
                giftId,
                spendTotal: new Prisma.Decimal(0),
                creatorTotal: new Prisma.Decimal(0),
                spenderIds: new Set<string>(),
                creatorIds: new Set<string>(),
              };
              if (
                row.kind === CoinKind.SPEND ||
                row.kind === CoinKind.REWARD_SPEND
              ) {
                if (row.amount >= 0) {
                  addIssue({
                    code: 'GIFT_SPEND_SIGN_MISMATCH',
                    severity: 'BLOCKER',
                    message: 'Gift spend entries must be negative.',
                    entryId: row.id,
                    sourceId: giftId,
                    userId: row.userId,
                  });
                }
                rollup.spendTotal = rollup.spendTotal.plus(
                  new Prisma.Decimal(row.amount).abs(),
                );
                rollup.spenderIds.add(row.userId);
              } else if (
                row.kind === CoinKind.PROMOTIONAL_EARN ||
                row.kind === CoinKind.PURCHASE_EARN ||
                row.kind === CoinKind.REWARD_EARN ||
                row.kind === CoinKind.EARN
              ) {
                if (row.amount <= 0) {
                  addIssue({
                    code: 'GIFT_EARN_SIGN_MISMATCH',
                    severity: 'BLOCKER',
                    message: 'Creator proceeds entries must be positive.',
                    entryId: row.id,
                    sourceId: giftId,
                    userId: row.userId,
                  });
                }
                rollup.creatorTotal = rollup.creatorTotal.plus(row.amount);
                rollup.creatorIds.add(row.userId);
              }
              giftRollups.set(giftId, rollup);
            }

            if (row.kind === CoinKind.REWARD_GRANT) {
              const grantId = rewardGrantIdFromCoinEntryKey(row.key);
              if (!grantId) {
                addIssue({
                  code: 'MISSING_REWARD_REFERENCE',
                  severity: 'BLOCKER',
                  message:
                    'Reward grant key does not contain a recognised grant UUID.',
                  entryId: row.id,
                  userId: row.userId,
                });
              } else {
                const grantRows = rewardGrantRows.get(grantId) ?? [];
                grantRows.push(row);
                rewardGrantRows.set(grantId, grantRows);
              }
            }
          }

          const giftIds = Array.from(
            new Set(
              rows
                .map(
                  (row) =>
                    row.giftId ?? giftIdFromCoinEntryKey(row.key),
                )
                .filter((id): id is string => id !== null),
            ),
          );
          const grantIds = rows
            .filter((row) => row.kind === CoinKind.REWARD_GRANT)
            .map((row) => rewardGrantIdFromCoinEntryKey(row.key))
            .filter((id): id is string => id !== null);

          for (const giftIdBatch of chunks(giftIds, SOURCE_QUERY_BATCH_SIZE)) {
            const snapshots = await tx.financialSourceRecord.findMany({
              where: {
                sourceType: 'GIFT',
                sourceId: { in: giftIdBatch },
              },
              select: {
                sourceId: true,
                actorId: true,
                beneficiaryId: true,
                amount: true,
                unitCode: true,
                payload: true,
              },
            });
            for (const snapshot of snapshots) {
              giftSources.set(snapshot.sourceId, snapshot);
            }
          }

          for (const grantIdBatch of chunks(grantIds, SOURCE_QUERY_BATCH_SIZE)) {
            const snapshots = await tx.financialSourceRecord.findMany({
              where: {
                sourceType: 'POST_REWARD_GRANT',
                sourceId: { in: grantIdBatch },
              },
              select: {
                sourceId: true,
                actorId: true,
                beneficiaryId: true,
                amount: true,
                unitCode: true,
                payload: true,
              },
            });
            for (const snapshot of snapshots) {
              rewardSources.set(snapshot.sourceId, snapshot);
            }
          }

          cursor = rows[rows.length - 1].id;
          if (rows.length < pageSize) break;
        }

        for (const [giftId, rollup] of giftRollups) {
          const source = giftSources.get(giftId);
          if (!source) {
            addIssue({
              code: 'MISSING_GIFT_SNAPSHOT',
              severity: 'BLOCKER',
              message:
                'Gift CoinEntry history has no retained FinancialSourceRecord snapshot.',
              sourceId: giftId,
            });
            continue;
          }

          if (
            source.unitCode !== 'COIN' &&
            source.unitCode !== 'KCOIN'
          ) {
            addIssue({
              code: 'GIFT_UNIT_MISMATCH',
              severity: 'BLOCKER',
              message: `Gift source snapshot uses unexpected unit "${source.unitCode ?? 'null'}".`,
              sourceId: giftId,
            });
          }
          if (source.amount === null) {
            addIssue({
              code: 'GIFT_SOURCE_AMOUNT_MISSING',
              severity: 'BLOCKER',
              message: 'Gift source snapshot has no coin amount.',
              sourceId: giftId,
            });
          } else {
            if (!rollup.spendTotal.eq(source.amount)) {
              addIssue({
                code: 'GIFT_SPEND_TOTAL_MISMATCH',
                severity: 'BLOCKER',
                message:
                  'The total legacy spend entries do not equal the immutable gift amount.',
                sourceId: giftId,
              });
            }
            if (!rollup.creatorTotal.eq(source.amount)) {
              addIssue({
                code: 'GIFT_EARN_TOTAL_MISMATCH',
                severity: 'BLOCKER',
                message:
                  'The total creator proceeds entries do not equal the immutable gift amount.',
                sourceId: giftId,
              });
            }
          }
          if (
            source.actorId &&
            (rollup.spenderIds.size !== 1 ||
              !rollup.spenderIds.has(source.actorId))
          ) {
            addIssue({
              code: 'GIFT_SENDER_MISMATCH',
              severity: 'BLOCKER',
              message:
                'The sender in the immutable gift snapshot does not match the CoinEntry spend owner.',
              sourceId: giftId,
            });
          }
          if (
            source.beneficiaryId &&
            (rollup.creatorIds.size !== 1 ||
              !rollup.creatorIds.has(source.beneficiaryId))
          ) {
            addIssue({
              code: 'GIFT_RECIPIENT_MISMATCH',
              severity: 'BLOCKER',
              message:
                'The recipient in the immutable gift snapshot does not match the CoinEntry proceeds owner.',
              sourceId: giftId,
            });
          }
          if (rollup.spenderIds.size !== 1 || rollup.creatorIds.size !== 1) {
            addIssue({
              code: 'GIFT_COUNTERPARTY_COUNT_MISMATCH',
              severity: 'BLOCKER',
              message:
                'A gift must reconcile to exactly one sender and one creator proceeds owner.',
              sourceId: giftId,
            });
          }
        }

        for (const [grantId, grantRows] of rewardGrantRows) {
          const source = rewardSources.get(grantId);
          if (!source) {
            addIssue({
              code: 'MISSING_REWARD_SNAPSHOT',
              severity: 'BLOCKER',
              message:
                'Reward grant CoinEntry history has no retained reward source snapshot.',
              sourceId: grantId,
            });
            continue;
          }

          if (
            source.unitCode !== 'COIN' &&
            source.unitCode !== 'KCOIN'
          ) {
            addIssue({
              code: 'REWARD_UNIT_MISMATCH',
              severity: 'BLOCKER',
              message: `Reward source snapshot uses unexpected unit "${source.unitCode ?? 'null'}".`,
              sourceId: grantId,
            });
          }

          const payload = jsonObject(source.payload);
          if (payload?.rewardType !== 'PROMOTIONAL_COINS') {
            addIssue({
              code: 'REWARD_KIND_MISMATCH',
              severity: 'BLOCKER',
              message:
                'A REWARD_GRANT CoinEntry must resolve to a PROMOTIONAL_COINS source grant.',
              sourceId: grantId,
            });
          }

          if (grantRows.length !== 1) {
            addIssue({
              code: 'DUPLICATE_REWARD_GRANT_ENTRIES',
              severity: 'BLOCKER',
              message:
                'A single reward source must have exactly one REWARD_GRANT CoinEntry.',
              sourceId: grantId,
            });
          }

          for (const row of grantRows) {
            if (
              source.beneficiaryId &&
              source.beneficiaryId !== row.userId
            ) {
              addIssue({
                code: 'REWARD_BENEFICIARY_MISMATCH',
                severity: 'BLOCKER',
                message:
                  'The reward source beneficiary does not match the CoinEntry owner.',
                entryId: row.id,
                sourceId: grantId,
                userId: row.userId,
              });
            }
            if (!decimalsEqual(source.amount, new Prisma.Decimal(row.amount))) {
              addIssue({
                code: 'REWARD_AMOUNT_MISMATCH',
                severity: 'BLOCKER',
                message:
                  'The reward source amount does not match the REWARD_GRANT CoinEntry.',
                entryId: row.id,
                sourceId: grantId,
                userId: row.userId,
              });
            }
          }
        }

        const bucketTotals = {
          LEGACY_COMPLIMENTARY: {
            ownerAccounts: 0,
            net: new Prisma.Decimal(0),
          },
          REWARD_PROMOTIONAL: {
            ownerAccounts: 0,
            net: new Prisma.Decimal(0),
          },
          CREATOR_PAYABLE: {
            ownerAccounts: 0,
            net: new Prisma.Decimal(0),
          },
          CREATOR_PROMOTIONAL: {
            ownerAccounts: 0,
            net: new Prisma.Decimal(0),
          },
          CREATOR_UNKNOWN: {
            ownerAccounts: 0,
            net: new Prisma.Decimal(0),
          },
        };

        for (const [userId, balances] of userBuckets) {
          for (const bucket of Object.keys(bucketTotals) as LegacyCoinBucket[]) {
            const balance = balances[bucket];
            const totals = bucketTotals[bucket];
            if (!balance.isZero()) totals.ownerAccounts += 1;
            totals.net = totals.net.plus(balance);
            if (balance.lt(0)) {
              addIssue({
                code: 'NEGATIVE_OWNER_BALANCE',
                severity: 'BLOCKER',
                message: `The projected ${bucket} liability is negative for this owner.`,
                userId,
              });
            }
          }
        }

        const byKindOutput = Object.fromEntries(
          Array.from(byKind.entries())
            .sort(([left], [right]) => left.localeCompare(right))
            .map(([kind, totals]) => [
              kind,
              {
                entries: totals.entries,
                net: totals.net.toFixed(0),
                positive: totals.positive.toFixed(0),
                negative: totals.negative.toFixed(0),
              },
            ]),
        );

        const bucketOutput = Object.fromEntries(
          Object.entries(bucketTotals).map(([bucket, totals]) => [
            bucket,
            {
              ownerAccounts: totals.ownerAccounts,
              net: totals.net.toFixed(0),
            },
          ]),
        ) as LegacyCoinReconciliationReport['summary']['buckets'];

        const report: LegacyCoinReconciliationReport = {
          mode: 'DRY_RUN',
          readOnly: true,
          mutationCount: 0,
          isolationLevel: 'RepeatableRead',
          scope: userIds ? 'SELECTED_USERS' : 'ALL_USERS',
          pageSize,
          generatedAt: new Date().toISOString(),
          summary: {
            coinEntries,
            users: seenUsers.size,
            mappedEntries,
            unmappedEntries,
            zeroAmountEntries,
            eligibleTransactions,
            alreadyImportedEntries,
            newTransactions,
            debitTotal: debitTotal.toFixed(0),
            creditTotal: creditTotal.toFixed(0),
            buckets: bucketOutput,
            byKind: byKindOutput,
            issues: {
              total: totalIssues,
              blockers: blockerIssues,
              warnings: warningIssues,
              info: infoIssues,
              samplesTruncated: totalIssues > issues.length,
              byCode: Object.fromEntries(
                Array.from(issueCounts.entries()).sort(([a], [b]) =>
                  a.localeCompare(b),
                ),
              ),
            },
          },
          issues,
        };

        if (options.includeUserBalances) {
          report.userBalances = Array.from(userBuckets.entries())
            .sort(([left], [right]) => left.localeCompare(right))
            .map(([userId, balances]) => ({
              userId,
              buckets: {
                LEGACY_COMPLIMENTARY:
                  balances.LEGACY_COMPLIMENTARY.toFixed(0),
                REWARD_PROMOTIONAL: balances.REWARD_PROMOTIONAL.toFixed(0),
                CREATOR_PAYABLE: balances.CREATOR_PAYABLE.toFixed(0),
                CREATOR_PROMOTIONAL:
                  balances.CREATOR_PROMOTIONAL.toFixed(0),
                CREATOR_UNKNOWN: balances.CREATOR_UNKNOWN.toFixed(0),
              },
            }));
        }

        return report;
      },
      {
        isolationLevel: Prisma.TransactionIsolationLevel.RepeatableRead,
        timeout: 120_000,
      },
    );
  }
}
