import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import {
  CoinKind,
  CreatorEarningReservationStatus,
  CreatorEarningSource,
  Prisma,
} from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';

type Tx = Prisma.TransactionClient;

export interface CreatorEarningCoinEntry {
  userId: string;
  kind: CoinKind;
  amount: number;
  key: string;
  giftId: string | null;
}

export function planCreatorEarning(
  entry: CreatorEarningCoinEntry,
): Prisma.CreatorEarningCreateManyInput {
  if (!Number.isInteger(entry.amount) || entry.amount <= 0) {
    throw new BadRequestException('Creator earning amounts must be positive whole coins.');
  }

  const sourceByKind: Partial<Record<CoinKind, CreatorEarningSource>> = {
    [CoinKind.PURCHASE_EARN]: CreatorEarningSource.PURCHASE,
    [CoinKind.REWARD_EARN]: CreatorEarningSource.APPROVED_REWARD,
    [CoinKind.PROMOTIONAL_EARN]: CreatorEarningSource.LEGACY_PROMOTIONAL,
    [CoinKind.EARN]: CreatorEarningSource.UNKNOWN,
  };
  const source = sourceByKind[entry.kind];
  if (!source) {
    throw new BadRequestException(
      `Coin entry kind ${entry.kind} is not a creator-proceeds entry.`,
    );
  }

  return {
    creatorId: entry.userId,
    sourceCoinEntryKey: entry.key,
    giftId: entry.giftId,
    source,
    amount: entry.amount,
    withdrawable:
      source === CreatorEarningSource.PURCHASE ||
      source === CreatorEarningSource.APPROVED_REWARD,
  };
}

export interface CreatorEarningBalance {
  withdrawableCoins: number;
  heldCoins: number;
  reservedCoins: number;
  availableCoins: number;
}

interface ReservationCandidate {
  id: string;
  amount: number;
  reservedAmount: number;
}

@Injectable()
export class CreatorEarningsService {
  constructor(private readonly prisma: PrismaService) {}

  /** Idempotently materializes an immutable proceeds row from its CoinEntry. */
  async recordFromCoinEntry(
    tx: Tx,
    entry: CreatorEarningCoinEntry,
  ): Promise<void> {
    const data = planCreatorEarning(entry);
    await tx.creatorEarning.upsert({
      where: { sourceCoinEntryKey: data.sourceCoinEntryKey },
      create: data,
      update: {},
    });
  }

  /** Place an auditable hold on one withdrawable earning. */
  async placeHold(input: {
    earningId: string;
    reasonCode: string;
    note?: string;
    actorId: string;
  }) {
    if (!input.reasonCode.trim() || input.reasonCode.length > 80) {
      throw new BadRequestException('A valid creator-earning hold reason is required.');
    }
    return this.prisma.$transaction(async (tx) => {
      const snapshot = await tx.creatorEarning.findUnique({
        where: { id: input.earningId },
      });
      if (!snapshot) throw new NotFoundException('Creator earning not found.');
      // Serialize hold placement with reservation creation for this creator.
      await tx.$queryRaw`SELECT id FROM "User" WHERE id = ${snapshot.creatorId}::uuid FOR UPDATE`;
      await tx.$queryRaw`SELECT id FROM "CreatorEarning" WHERE id = ${input.earningId}::uuid FOR UPDATE`;
      const earning = await tx.creatorEarning.findUniqueOrThrow({
        where: { id: input.earningId },
      });
      if (!earning.withdrawable) {
        throw new BadRequestException('Non-withdrawable creator proceeds cannot enter payout holds.');
      }

      const hold = await tx.creatorEarningHold.create({
        data: {
          earningId: earning.id,
          reasonCode: input.reasonCode.trim(),
          note: input.note?.trim() || null,
          placedById: input.actorId,
        },
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId: input.actorId,
          eventType: 'CREATOR_EARNING_HOLD_PLACED',
          subjectType: 'CREATOR_EARNING',
          subjectId: earning.id,
          metadata: {
            holdId: hold.id,
            reasonCode: hold.reasonCode,
          },
        },
      });
      return hold;
    });
  }

  /** Release is a one-way transition; the original hold evidence is retained. */
  async releaseHold(input: {
    holdId: string;
    actorId: string;
    note?: string;
  }) {
    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "CreatorEarningHold" WHERE id = ${input.holdId}::uuid FOR UPDATE`;
      const hold = await tx.creatorEarningHold.findUnique({
        where: { id: input.holdId },
      });
      if (!hold) throw new NotFoundException('Creator earning hold not found.');
      if (hold.releasedAt) return hold;

      const released = await tx.creatorEarningHold.update({
        where: { id: hold.id },
        data: {
          releasedAt: new Date(),
          releasedById: input.actorId,
          releaseNote: input.note?.trim() || null,
        },
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId: input.actorId,
          eventType: 'CREATOR_EARNING_HOLD_RELEASED',
          subjectType: 'CREATOR_EARNING',
          subjectId: hold.earningId,
          metadata: { holdId: hold.id },
        },
      });
      return released;
    });
  }

  /**
   * Returns only proceeds which are withdrawable, currently available and
   * not held. Active and settled reservations both reduce the remaining value.
   */
  async balance(creatorId: string, now = new Date()): Promise<CreatorEarningBalance> {
    const [row] = await this.prisma.$queryRaw<
      Array<{
        withdrawableCoins: number;
        heldCoins: number;
        reservedCoins: number;
        availableCoins: number;
      }>
    >`
      SELECT
        COALESCE(SUM(e."amount"), 0)::int AS "withdrawableCoins",
        COALESCE(SUM(CASE WHEN EXISTS (
          SELECT 1 FROM "CreatorEarningHold" h
          WHERE h."earningId" = e."id" AND h."releasedAt" IS NULL
        ) THEN e."amount" ELSE 0 END), 0)::int AS "heldCoins",
        COALESCE(SUM((
          SELECT COALESCE(SUM(l."amount"), 0)
          FROM "CreatorEarningReservationLine" l
          JOIN "CreatorEarningReservation" r ON r."id" = l."reservationId"
          WHERE l."earningId" = e."id" AND r."status" IN ('ACTIVE', 'SETTLED')
        )), 0)::int AS "reservedCoins",
        COALESCE(SUM(CASE WHEN NOT EXISTS (
          SELECT 1 FROM "CreatorEarningHold" h
          WHERE h."earningId" = e."id" AND h."releasedAt" IS NULL
        ) THEN GREATEST(e."amount" - (
          SELECT COALESCE(SUM(l."amount"), 0)
          FROM "CreatorEarningReservationLine" l
          JOIN "CreatorEarningReservation" r ON r."id" = l."reservationId"
          WHERE l."earningId" = e."id" AND r."status" IN ('ACTIVE', 'SETTLED')
        ), 0) ELSE 0 END), 0)::int AS "availableCoins"
      FROM "CreatorEarning" e
      WHERE e."creatorId" = ${creatorId}::uuid
        AND e."withdrawable" = TRUE
        AND e."availableAt" <= ${now}
    `;
    return row ?? {
      withdrawableCoins: 0,
      heldCoins: 0,
      reservedCoins: 0,
      availableCoins: 0,
    };
  }

  /**
   * Reserves available earnings FIFO. The per-creator row lock serializes
   * concurrent reservations; earning row locks protect allocations against
   * simultaneous hold placement.
   */
  async reserve(input: {
    creatorId: string;
    amount: number;
    idempotencyKey: string;
    expiresAt?: Date;
    actorId?: string;
    now?: Date;
  }) {
    if (!Number.isInteger(input.amount) || input.amount <= 0) {
      throw new BadRequestException('Reservation amount must be positive whole coins.');
    }
    if (!input.idempotencyKey || input.idempotencyKey.length > 200) {
      throw new BadRequestException('A valid reservation idempotency key is required.');
    }
    const now = input.now ?? new Date();
    if (input.expiresAt && input.expiresAt <= now) {
      throw new BadRequestException('Reservation expiry must be in the future.');
    }

    return this.prisma.$transaction(async (tx) => {
      const lockedCreator = await tx.$queryRaw<Array<{ id: string }>>`
        SELECT id FROM "User" WHERE id = ${input.creatorId}::uuid FOR UPDATE
      `;
      if (lockedCreator.length === 0) {
        throw new NotFoundException("Creator account not found.");
      }
      const existing = await tx.creatorEarningReservation.findUnique({
        where: { idempotencyKey: input.idempotencyKey },
        include: { lines: true },
      });
      if (existing) {
        if (existing.creatorId !== input.creatorId || existing.amount !== input.amount) {
          throw new ConflictException(
            'The reservation idempotency key was already used for another request.',
          );
        }
        return existing;
      }

      const candidates = await tx.$queryRaw<ReservationCandidate[]>`
        SELECT
          e."id",
          e."amount",
          COALESCE((
            SELECT SUM(l."amount")
            FROM "CreatorEarningReservationLine" l
            JOIN "CreatorEarningReservation" r ON r."id" = l."reservationId"
            WHERE l."earningId" = e."id"
              AND r."status" IN ('ACTIVE', 'SETTLED')
          ), 0)::int AS "reservedAmount"
        FROM "CreatorEarning" e
        WHERE e."creatorId" = ${input.creatorId}::uuid
          AND e."withdrawable" = TRUE
          AND e."availableAt" <= ${now}
          AND NOT EXISTS (
            SELECT 1 FROM "CreatorEarningHold" h
            WHERE h."earningId" = e."id" AND h."releasedAt" IS NULL
          )
        ORDER BY e."availableAt" ASC, e."createdAt" ASC, e."id" ASC
        FOR UPDATE OF e
      `;

      let remaining = input.amount;
      const allocations: Array<{ earningId: string; amount: number }> = [];
      for (const candidate of candidates) {
        const available = candidate.amount - Number(candidate.reservedAmount);
        if (available <= 0) continue;
        const allocated = Math.min(available, remaining);
        allocations.push({ earningId: candidate.id, amount: allocated });
        remaining -= allocated;
        if (remaining === 0) break;
      }
      if (remaining > 0) {
        throw new BadRequestException(
          'The creator does not have enough available withdrawable earnings.',
        );
      }

      const reservation = await tx.creatorEarningReservation.create({
        data: {
          creatorId: input.creatorId,
          idempotencyKey: input.idempotencyKey,
          amount: input.amount,
          expiresAt: input.expiresAt ?? null,
        },
      });
      await tx.creatorEarningReservationLine.createMany({
        data: allocations.map((line) => ({
          reservationId: reservation.id,
          earningId: line.earningId,
          amount: line.amount,
        })),
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId: input.actorId ?? input.creatorId,
          eventType: 'CREATOR_EARNINGS_RESERVED',
          subjectType: 'CREATOR_EARNING_RESERVATION',
          subjectId: reservation.id,
          requestId: input.idempotencyKey,
          metadata: {
            amount: input.amount,
            allocationCount: allocations.length,
          },
        },
      });
      return tx.creatorEarningReservation.findUniqueOrThrow({
        where: { id: reservation.id },
        include: { lines: true },
      });
    });
  }

  /** Release returns reserved value to availability; settle consumes it. */
  async finalizeReservation(input: {
    reservationId: string;
    status: Extract<
      CreatorEarningReservationStatus,
      'RELEASED' | 'SETTLED'
    >;
    actorId: string;
    now?: Date;
  }) {
    if (
      input.status !== CreatorEarningReservationStatus.RELEASED &&
      input.status !== CreatorEarningReservationStatus.SETTLED
    ) {
      throw new BadRequestException('Reservation final state is invalid.');
    }
    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "CreatorEarningReservation" WHERE id = ${input.reservationId}::uuid FOR UPDATE`;
      const reservation = await tx.creatorEarningReservation.findUnique({
        where: { id: input.reservationId },
      });
      if (!reservation) {
        throw new NotFoundException('Creator earning reservation not found.');
      }
      if (reservation.status === input.status) return reservation;
      if (reservation.status !== CreatorEarningReservationStatus.ACTIVE) {
        throw new ConflictException('This reservation has already been finalized.');
      }
      const finalized = await tx.creatorEarningReservation.update({
        where: { id: reservation.id },
        data: { status: input.status, finalizedAt: input.now ?? new Date() },
      });
      await tx.financialAuditEvent.create({
        data: {
          actorId: input.actorId,
          eventType:
            input.status === CreatorEarningReservationStatus.SETTLED
              ? 'CREATOR_EARNINGS_RESERVATION_SETTLED'
              : 'CREATOR_EARNINGS_RESERVATION_RELEASED',
          subjectType: 'CREATOR_EARNING_RESERVATION',
          subjectId: reservation.id,
          metadata: { amount: reservation.amount },
        },
      });
      return finalized;
    });
  }
}
