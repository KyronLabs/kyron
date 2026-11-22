import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { createHash } from 'node:crypto';
import {
  Prisma,
  type FinancialAccountType,
  type FinancialEntrySide,
} from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';

export interface LedgerAccountInput {
  accountKey: string;
  name: string;
  accountType: FinancialAccountType;
  normalSide: FinancialEntrySide;
  ownerId?: string | null;
}

export interface LedgerPostingInput extends LedgerAccountInput {
  side: FinancialEntrySide;
  /** Decimal string only: do not pass binary floating-point money values. */
  amount: string;
  memo?: string;
}

export interface PostLedgerTransactionInput {
  idempotencyKey: string;
  eventType: string;
  sourceType: string;
  sourceId?: string | null;
  correlationId?: string | null;
  currencyCode: string;
  description?: string | null;
  metadata?: Prisma.InputJsonValue;
  actorId?: string | null;
  effectiveAt?: Date;
  postings: LedgerPostingInput[];
}

type LedgerPostCommand = PostLedgerTransactionInput & {
  /** Internal-only link for a full compensating reversal. */
  reversalOfId?: string | null;
};

type LedgerTransactionRecord = Prisma.LedgerTransactionGetPayload<{
  include: { postings: { include: { account: true } } };
}>;

type LedgerTransactionWithPostings = Omit<
  LedgerTransactionRecord,
  'createdXid' | 'requestHash'
>;

function stableValue(value: unknown): unknown {
  if (value instanceof Date) return value.toISOString();
  if (typeof value === 'bigint') return value.toString();
  if (Array.isArray(value)) return value.map(stableValue);
  if (value && typeof value === 'object') {
    const record = value as Record<string, unknown>;
    return Object.fromEntries(
      Object.keys(record)
        .sort()
        .map((key) => [key, stableValue(record[key])]),
    );
  }
  return value;
}

function requestFingerprint(input: LedgerPostCommand): string {
  const canonical = {
    eventType: input.eventType,
    sourceType: input.sourceType,
    sourceId: input.sourceId ?? null,
    correlationId: input.correlationId ?? null,
    currencyCode: input.currencyCode,
    description: input.description ?? null,
    metadata: input.metadata ?? null,
    actorId: input.actorId ?? null,
    effectiveAt: input.effectiveAt ?? null,
    reversalOfId: input.reversalOfId ?? null,
    postings: input.postings.map((line) => ({
      accountKey: line.accountKey,
      name: line.name,
      accountType: line.accountType,
      normalSide: line.normalSide,
      ownerId: line.ownerId ?? null,
      side: line.side,
      amount: line.amount,
      memo: line.memo ?? null,
    })),
  };

  return createHash('sha256')
    .update(JSON.stringify(stableValue(canonical)))
    .digest('hex');
}

@Injectable()
export class LedgerService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * Posts one balanced event atomically. Account creation, the transaction
   * header and every posting line share one SQL transaction. Database triggers
   * independently enforce the same-currency and balanced-journal invariants.
   */
  async post(
    input: PostLedgerTransactionInput,
  ): Promise<LedgerTransactionWithPostings> {
    return this.postInternal(input, false);
  }

  /**
   * Creates a full compensating reversal. The original event is never edited.
   * The unique reversalOfId constraint prevents a second full reversal.
   */
  async reverse(
    transactionId: string,
    idempotencyKey: string,
    actorId?: string | null,
  ): Promise<LedgerTransactionWithPostings> {
    const original = await this.prisma.ledgerTransaction.findUnique({
      where: { id: transactionId },
      include: { postings: { include: { account: true } } },
    });

    if (!original) {
      throw new NotFoundException('Ledger transaction was not found.');
    }

    return this.postInternal(
      {
        idempotencyKey,
        eventType: 'REVERSAL',
        sourceType: 'LEDGER_REVERSAL',
        sourceId: original.id,
        correlationId: original.correlationId,
        currencyCode: original.currencyCode,
        description: `Reversal of ledger transaction ${original.id}`,
        metadata: {
          reversalOfId: original.id,
          originalEventType: original.eventType,
        },
        actorId: actorId ?? null,
        reversalOfId: original.id,
        postings: original.postings.map((posting) => ({
          accountKey: posting.account.accountKey,
          name: posting.account.name,
          accountType: posting.account.accountType,
          normalSide: posting.account.normalSide,
          ownerId: posting.account.ownerId,
          side: posting.side === 'DEBIT' ? 'CREDIT' : 'DEBIT',
          amount: posting.amount.toString(),
          memo: `Reversal: ${posting.memo ?? original.eventType}`,
        })),
      },
      true,
    );
  }

  private async postInternal(
    request: LedgerPostCommand,
    allowNonActiveAccounts: boolean,
  ): Promise<LedgerTransactionWithPostings> {
    this.validate(request);
    const input: LedgerPostCommand = {
      ...request,
      postings: request.postings.map((line) => ({
        ...line,
        amount: new Prisma.Decimal(line.amount).toFixed(8),
      })),
    };
    const requestHash = requestFingerprint(input);

    try {
      return await this.prisma.$transaction(async (tx) => {
        const accountIds: string[] = [];
        for (const line of input.postings) {
          const account = await tx.ledgerAccount.upsert({
            where: { accountKey: line.accountKey },
            create: {
              accountKey: line.accountKey,
              name: line.name,
              accountType: line.accountType,
              normalSide: line.normalSide,
              currencyCode: input.currencyCode,
              ownerId: line.ownerId ?? null,
            },
            update: {},
          });

          if (
            account.currencyCode !== input.currencyCode ||
            account.accountType !== line.accountType ||
            account.normalSide !== line.normalSide ||
            account.ownerId !== (line.ownerId ?? null)
          ) {
            throw new ConflictException(
              `Ledger account identity mismatch for ${line.accountKey}.`,
            );
          }

          if (!allowNonActiveAccounts && account.status !== 'ACTIVE') {
            throw new ConflictException(
              `Ledger account ${line.accountKey} is not active.`,
            );
          }

          accountIds.push(account.id);
        }

        const transaction = await tx.ledgerTransaction.create({
          data: {
            idempotencyKey: input.idempotencyKey,
            requestHash,
            eventType: input.eventType,
            sourceType: input.sourceType,
            sourceId: input.sourceId ?? null,
            correlationId: input.correlationId ?? null,
            currencyCode: input.currencyCode,
            description: input.description ?? null,
            metadata: input.metadata,
            actorId: input.actorId ?? null,
            effectiveAt: input.effectiveAt,
            reversalOfId: input.reversalOfId ?? null,
          },
        });

        await tx.ledgerPosting.createMany({
          data: input.postings.map((line, index) => ({
            transactionId: transaction.id,
            accountId: accountIds[index],
            lineNumber: index + 1,
            side: line.side,
            amount: line.amount,
            memo: line.memo ?? null,
          })),
        });

        const record = await tx.ledgerTransaction.findUniqueOrThrow({
          where: { id: transaction.id },
          include: { postings: { include: { account: true } } },
        });
        return this.publicTransaction(record);
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        const existing = await this.prisma.ledgerTransaction.findUnique({
          where: { idempotencyKey: input.idempotencyKey },
          include: { postings: { include: { account: true } } },
        });

        if (existing) {
          if (existing.requestHash !== requestHash) {
            throw new ConflictException(
              'The idempotency key was already used for a different ledger event.',
            );
          }
          return this.publicTransaction(existing);
        }

        if (input.reversalOfId) {
          throw new ConflictException(
            'This ledger transaction has already been reversed.',
          );
        }
      }
      throw error;
    }
  }

  private publicTransaction(
    record: LedgerTransactionRecord,
  ): LedgerTransactionWithPostings {
    const { createdXid, requestHash, ...result } = record;
    // These are persistence-only fields and must not leak through service DTOs.
    void createdXid;
    void requestHash;
    return result;
  }

  private validate(input: PostLedgerTransactionInput): void {
    if (!input.idempotencyKey || input.idempotencyKey.length > 200) {
      throw new BadRequestException('A valid idempotency key is required.');
    }
    if (!input.eventType || input.eventType.length > 64) {
      throw new BadRequestException('A valid ledger event type is required.');
    }
    if (!input.sourceType || input.sourceType.length > 64) {
      throw new BadRequestException('A valid ledger source type is required.');
    }
    if (!/^[A-Z][A-Z0-9]{2,11}$/.test(input.currencyCode)) {
      throw new BadRequestException(
        'Currency/unit code must be uppercase and between 3 and 12 characters.',
      );
    }
    if (!Array.isArray(input.postings) || input.postings.length < 2) {
      throw new BadRequestException(
        'A ledger transaction needs at least two posting lines.',
      );
    }

    let debits = new Prisma.Decimal(0);
    let credits = new Prisma.Decimal(0);

    for (const line of input.postings) {
      if (!line.accountKey || line.accountKey.length > 160) {
        throw new BadRequestException(
          'Every posting needs a valid account key.',
        );
      }
      if (!line.name || line.name.length > 120) {
        throw new BadRequestException('Every posting needs an account name.');
      }
      if (line.memo && line.memo.length > 240) {
        throw new BadRequestException('Posting memo is too long.');
      }

      let amount: Prisma.Decimal;
      try {
        amount = new Prisma.Decimal(line.amount);
      } catch {
        throw new BadRequestException(
          'Posting amount must be a decimal string.',
        );
      }

      if (!amount.isFinite() || amount.lte(0)) {
        throw new BadRequestException(
          'Posting amount must be greater than zero.',
        );
      }
      if (amount.decimalPlaces() > 8) {
        throw new BadRequestException(
          'Posting amount supports at most eight decimal places.',
        );
      }
      if (input.currencyCode === 'KCOIN' && !amount.isInteger()) {
        throw new BadRequestException(
          'Virtual coin postings must be whole coins.',
        );
      }

      if (line.side === 'DEBIT') debits = debits.plus(amount);
      else if (line.side === 'CREDIT') credits = credits.plus(amount);
      else {
        throw new BadRequestException(
          'Posting side must be DEBIT or CREDIT.',
        );
      }
    }

    if (!debits.eq(credits)) {
      throw new BadRequestException(
        'Ledger debits and credits must balance exactly.',
      );
    }
  }
}
