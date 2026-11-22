import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import {
  AccountStatus,
  CoinKind,
  Prisma,
  RewardNominationStatus,
  RewardProgramStatus,
} from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { EnforcementService, type Staff } from '../moderation/enforcement.service';
import {
  parsePostRewardPolicy,
  type PromotionalCoinsReward,
} from './post-reward-policy';
import {
  CreateRewardProgramDto,
  UpdateRewardProgramDto,
} from './dto/rewards.dto';

const DAY_MS = 24 * 60 * 60 * 1000;

export interface NominationInput {
  postId: string;
  reason: string;
}

/**
 * Post excellence rewards.
 *
 * Popularity is deliberately not an award rule here. A nomination is a
 * request for human consideration; only a staff decision can create a grant.
 * The programme's versioned policy snapshot makes a nomination stable even
 * if the programme is edited while it waits in the review queue.
 *
 * Reward types are strings in storage and are dispatched through explicit
 * handlers below. JSON cannot name a class, invoke a URL or execute code.
 */
@Injectable()
export class RewardsService {
  constructor(private readonly prisma: PrismaService) {}

  async availablePrograms(now = new Date()) {
    const programs = await this.prisma.postRewardProgram.findMany({
      where: {
        status: RewardProgramStatus.ACTIVE,
        AND: [
          { OR: [{ startsAt: null }, { startsAt: { lte: now } }] },
          { OR: [{ endsAt: null }, { endsAt: { gt: now } }] },
        ],
      },
      orderBy: [{ startsAt: 'asc' }, { createdAt: 'asc' }],
      select: {
        id: true,
        key: true,
        name: true,
        description: true,
        startsAt: true,
        endsAt: true,
      },
    });
    return { items: programs };
  }

  async myRewards(userId: string) {
    const [nominations, awards] = await Promise.all([
      this.prisma.postRewardNomination.findMany({
        where: { nominatorId: userId },
        orderBy: { createdAt: 'desc' },
        take: 100,
        select: {
          id: true,
          reason: true,
          status: true,
          reviewNote: true,
          reviewedAt: true,
          createdAt: true,
          program: { select: { id: true, key: true, name: true } },
          post: {
            select: {
              id: true,
              content: true,
              createdAt: true,
              deletedAt: true,
            },
          },
        },
      }),
      this.prisma.postRewardGrant.findMany({
        where: { recipientId: userId },
        orderBy: { createdAt: 'desc' },
        take: 100,
        select: {
          id: true,
          rewardType: true,
          payload: true,
          createdAt: true,
          program: { select: { id: true, key: true, name: true } },
          post: { select: { id: true, content: true } },
        },
      }),
    ]);
    return { nominations, awards };
  }

  /** Submit a nomination, not an award. No creator can award themselves. */
  async nominate(
    userId: string,
    programId: string,
    input: NominationInput,
    now = new Date(),
  ) {
    try {
      return await this.prisma.$transaction(async (tx) => {
        // Lock and re-read the programme so a concurrent pause or policy
        // edit cannot slip between eligibility checking and nomination.
        await tx.$queryRaw`SELECT id FROM "PostRewardProgram" WHERE id = ${programId}::uuid FOR UPDATE`;
        const program = await tx.postRewardProgram.findFirst({
          where: {
            id: programId,
            status: RewardProgramStatus.ACTIVE,
            AND: [
              { OR: [{ startsAt: null }, { startsAt: { lte: now } }] },
              { OR: [{ endsAt: null }, { endsAt: { gt: now } }] },
            ],
          },
        });
        if (!program) throw new NotFoundException('Reward programme not found.');

        const policy = parsePostRewardPolicy(program.policy);
        if (!policy.nomination.enabled) {
          throw new BadRequestException(
            'This programme is not accepting nominations.',
          );
        }

        // Serialise this account's nomination submissions so parallel
        // requests cannot race past the programme's per-day limit.
        await tx.$queryRaw`SELECT id FROM "User" WHERE id = ${userId}::uuid FOR UPDATE`;

        const post = await tx.post.findFirst({
          where: {
            id: input.postId,
            deletedAt: null,
            author: { status: AccountStatus.ACTIVE },
          },
          select: { id: true, authorId: true, createdAt: true },
        });
        if (!post) throw new NotFoundException('Post not found.');
        if (post.authorId === userId && !policy.nomination.allowSelfNomination) {
          throw new BadRequestException('You cannot nominate your own post.');
        }

        const ageMs = now.getTime() - post.createdAt.getTime();
        if (ageMs < 0) {
          throw new BadRequestException('This post has an invalid creation time.');
        }
        if (ageMs < policy.nomination.minPostAgeHours * 60 * 60 * 1000) {
          throw new BadRequestException('This post is too new to be nominated.');
        }
        if (ageMs > policy.nomination.maxPostAgeDays * DAY_MS) {
          throw new BadRequestException('This post is outside the nomination window.');
        }

        const since = new Date(now.getTime() - DAY_MS);
        const recent = await tx.postRewardNomination.count({
          where: {
            nominatorId: userId,
            programId,
            createdAt: { gte: since },
          },
        });
        if (recent >= policy.nomination.maxPerUserPerDay) {
          throw new BadRequestException(
            'You have reached this programme’s daily nomination limit.',
          );
        }

        const nomination = await tx.postRewardNomination.create({
          data: {
            programId,
            postId: post.id,
            nominatorId: userId,
            reason: input.reason.trim(),
            policyVersion: program.policyVersion,
            policySnapshot: policy as unknown as Prisma.InputJsonValue,
          },
          select: {
            id: true,
            programId: true,
            postId: true,
            reason: true,
            status: true,
            policyVersion: true,
            createdAt: true,
          },
        });

        await tx.postRewardAuditEvent.create({
          data: {
            programId,
            nominationId: nomination.id,
            actorId: userId,
            eventType: 'NOMINATED',
            details: {
              postId: post.id,
              policyVersion: program.policyVersion,
            },
          },
        });
        return nomination;
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new ConflictException(
          'You have already nominated this post for this programme.',
        );
      }
      throw error;
    }
  }

  /** Staff-only programme listing, including its current declarative policy. */
  async staffPrograms(staff: Staff) {
    this.requireStaff(staff);
    const items = await this.prisma.postRewardProgram.findMany({
      orderBy: { createdAt: 'desc' },
      include: { _count: { select: { nominations: true, grants: true } } },
    });
    return { items };
  }

  async createProgram(staff: Staff, input: CreateRewardProgramDto) {
    this.requireStaff(staff);
    const policy = parsePostRewardPolicy(input.policy);
    const startsAt = input.startsAt ? new Date(input.startsAt) : null;
    const endsAt = input.endsAt ? new Date(input.endsAt) : null;
    this.assertDateWindow(startsAt, endsAt);

    const result = await this.prisma.$transaction(async (tx) => {
      const program = await tx.postRewardProgram.create({
        data: {
          key: input.key.toLowerCase(),
          name: input.name.trim(),
          description: input.description?.trim() || null,
          policy: policy as unknown as Prisma.InputJsonValue,
          startsAt,
          endsAt,
          createdById: staff.id,
          updatedById: staff.id,
        },
      });
      await tx.postRewardAuditEvent.create({
        data: {
          programId: program.id,
          actorId: staff.id,
          eventType: 'PROGRAM_CREATED',
          details: { key: program.key, policyVersion: program.policyVersion },
        },
      });
      return program;
    });
    return result;
  }

  async updateProgram(
    staff: Staff,
    programId: string,
    input: UpdateRewardProgramDto,
  ) {
    this.requireStaff(staff);
    return this.prisma.$transaction(async (tx) => {
      // Concurrent policy edits must produce distinct versions, not overwrite
      // one another with two updates based on the same stale row.
      await tx.$queryRaw`SELECT id FROM "PostRewardProgram" WHERE id = ${programId}::uuid FOR UPDATE`;
      const current = await tx.postRewardProgram.findUnique({
        where: { id: programId },
      });
      if (!current) throw new NotFoundException('Reward programme not found.');

      const nextPolicy = input.policy
        ? parsePostRewardPolicy(input.policy)
        : parsePostRewardPolicy(current.policy);
      const startsAt =
        input.startsAt === undefined
          ? current.startsAt
          : input.startsAt
            ? new Date(input.startsAt)
            : null;
      const endsAt =
        input.endsAt === undefined
          ? current.endsAt
          : input.endsAt
            ? new Date(input.endsAt)
            : null;
      this.assertDateWindow(startsAt, endsAt);

      const updated = await tx.postRewardProgram.update({
        where: { id: programId },
        data: {
          ...(input.name === undefined ? {} : { name: input.name.trim() }),
          ...(input.description === undefined
            ? {}
            : { description: input.description?.trim() || null }),
          ...(input.status === undefined ? {} : { status: input.status }),
          ...(input.startsAt === undefined ? {} : { startsAt }),
          ...(input.endsAt === undefined ? {} : { endsAt }),
          ...(input.policy === undefined
            ? {}
            : {
                policy: nextPolicy as unknown as Prisma.InputJsonValue,
                policyVersion: { increment: 1 },
              }),
          updatedById: staff.id,
        },
      });
      await tx.postRewardAuditEvent.create({
        data: {
          programId,
          actorId: staff.id,
          eventType: 'PROGRAM_UPDATED',
          details: {
            changedFields: Object.keys(input),
            policyVersion: updated.policyVersion,
            status: updated.status,
          },
        },
      });
      return updated;
    });
  }

  /** Pending nominations, oldest first so a queue cannot quietly bury them. */
  async nominationQueue(staff: Staff, programId?: string) {
    this.requireStaff(staff);
    const items = await this.prisma.postRewardNomination.findMany({
      where: {
        status: RewardNominationStatus.PENDING,
        ...(programId ? { programId } : {}),
      },
      orderBy: { createdAt: 'asc' },
      take: 100,
      select: {
        id: true,
        reason: true,
        policyVersion: true,
        createdAt: true,
        program: { select: { id: true, key: true, name: true, status: true } },
        nominator: {
          select: {
            id: true,
            name: true,
            username: true,
          },
        },
        post: {
          select: {
            id: true,
            content: true,
            createdAt: true,
            author: {
              select: {
                id: true,
                name: true,
                username: true,
                status: true,
                profile: { select: { avatarUrl: true } },
              },
            },
          },
        },
      },
    });
    return { items };
  }

  /**
   * Approve or decline under a row lock. The decision, reward ledger entries
   * and audit records commit together, so a retry cannot award twice.
   */
  async decide(
    staff: Staff,
    nominationId: string,
    decision: 'APPROVE' | 'DECLINE',
    note?: string,
    now = new Date(),
  ) {
    this.requireStaff(staff);

    return this.prisma.$transaction(async (tx) => {
      await tx.$queryRaw`SELECT id FROM "PostRewardNomination" WHERE id = ${nominationId}::uuid FOR UPDATE`;

      const nomination = await tx.postRewardNomination.findUnique({
        where: { id: nominationId },
        include: {
          program: true,
          post: {
            select: {
              id: true,
              authorId: true,
              deletedAt: true,
              author: { select: { status: true } },
            },
          },
        },
      });
      if (!nomination) throw new NotFoundException('Nomination not found.');
      if (nomination.status !== RewardNominationStatus.PENDING) {
        throw new ConflictException('This nomination has already been decided.');
      }

      if (decision === 'DECLINE') {
        const updated = await tx.postRewardNomination.update({
          where: { id: nominationId },
          data: {
            status: RewardNominationStatus.DECLINED,
            reviewedById: staff.id,
            reviewNote: note?.trim() || null,
            reviewedAt: now,
          },
        });
        await tx.postRewardAuditEvent.create({
          data: {
            programId: nomination.programId,
            nominationId,
            actorId: staff.id,
            eventType: 'NOMINATION_DECLINED',
            details: { note: note?.trim() || null },
          },
        });
        return { nomination: updated, grants: [] };
      }

      if (
        nomination.post.deletedAt ||
        nomination.post.author.status !== AccountStatus.ACTIVE
      ) {
        throw new BadRequestException(
          'This post or its author is no longer eligible for a reward.',
        );
      }

      // Protect award caps from two different nominations being approved
      // concurrently for the same post or creator.
      await tx.$queryRaw`SELECT id FROM "Post" WHERE id = ${nomination.postId}::uuid FOR UPDATE`;
      await tx.$queryRaw`SELECT id FROM "User" WHERE id = ${nomination.post.authorId}::uuid FOR UPDATE`;

      const currentPost = await tx.post.findFirst({
        where: {
          id: nomination.postId,
          deletedAt: null,
          author: { status: AccountStatus.ACTIVE },
        },
        select: { id: true, authorId: true },
      });
      if (!currentPost || currentPost.authorId !== nomination.post.authorId) {
        throw new BadRequestException(
          'This post or its author is no longer eligible for a reward.',
        );
      }
      // Lock and re-read the programme before awarding. A concurrent pause,
      // end date change, or policy edit must not race an approval.
      await tx.$queryRaw`SELECT id FROM "PostRewardProgram" WHERE id = ${nomination.programId}::uuid FOR UPDATE`;
      const currentProgram = await tx.postRewardProgram.findUnique({
        where: { id: nomination.programId },
        select: { status: true, startsAt: true, endsAt: true, policy: true },
      });
      if (
        !currentProgram ||
        currentProgram.status !== RewardProgramStatus.ACTIVE ||
        (currentProgram.startsAt && currentProgram.startsAt > now) ||
        (currentProgram.endsAt && currentProgram.endsAt <= now)
      ) {
        throw new ConflictException(
          'This reward programme is paused, not yet active, or has ended.',
        );
      }

      const policy = parsePostRewardPolicy(nomination.policySnapshot);
      const postAwards = await tx.postRewardGrant.groupBy({
        by: ['nominationId'],
        where: {
          programId: nomination.programId,
          postId: nomination.postId,
        },
      });
      if (postAwards.length >= policy.limits.maxAwardsPerPost) {
        throw new ConflictException(
          'This post has reached the programme’s award limit.',
        );
      }

      const proposedPromotionalCoins = policy.rewards.reduce(
        (total, reward) =>
          total +
          (reward.type === 'PROMOTIONAL_COINS' ? reward.amount : 0),
        0,
      );
      const budgetRows = await tx.$queryRaw<Array<{ total: number }>>`
        SELECT COALESCE(SUM(("payload"->>'amount')::int), 0)::int AS total
        FROM "PostRewardGrant"
        WHERE "programId" = ${nomination.programId}::uuid
          AND "rewardType" = 'PROMOTIONAL_COINS'
      `;
      const alreadyGranted = budgetRows[0]?.total ?? 0;
      // The saved nomination snapshot controls its own award terms, but the
      // current programme policy controls the remaining programme-wide
      // budget. Editing the budget down therefore takes effect immediately.
      const currentBudget = parsePostRewardPolicy(
        currentProgram.policy,
      ).limits.maxTotalPromotionalCoins;
      if (alreadyGranted + proposedPromotionalCoins > currentBudget) {
        throw new ConflictException(
          'This programme has reached its promotional coin budget.',
        );
      }

      const creatorSince = new Date(now.getTime() - 30 * DAY_MS);
      const creatorAwards = await tx.postRewardGrant.groupBy({
        by: ['nominationId'],
        where: {
          programId: nomination.programId,
          recipientId: nomination.post.authorId,
          createdAt: { gte: creatorSince },
        },
      });
      if (
        creatorAwards.length + 1 >
        policy.limits.maxAwardsPerCreatorPer30Days
      ) {
        throw new ConflictException(
          'This creator has reached the programme’s rolling 30-day award limit.',
        );
      }

      const grants = [];
      for (const reward of policy.rewards) {
        const grant = await tx.postRewardGrant.create({
          data: {
            programId: nomination.programId,
            nominationId,
            postId: nomination.postId,
            recipientId: nomination.post.authorId,
            rewardType: reward.type,
            payload: { amount: reward.amount },
            idempotencyKey: `post-reward:${nominationId}:${reward.type}`,
            grantedById: staff.id,
          },
        });
        await this.applyReward(tx, grant.id, grant.recipientId, reward);
        await tx.postRewardAuditEvent.create({
          data: {
            programId: nomination.programId,
            nominationId,
            grantId: grant.id,
            actorId: staff.id,
            eventType: 'REWARD_GRANTED',
            details: {
              rewardType: reward.type,
              payload: { amount: reward.amount },
              postId: nomination.postId,
              recipientId: nomination.post.authorId,
            },
          },
        });
        grants.push(grant);
      }

      const updated = await tx.postRewardNomination.update({
        where: { id: nominationId },
        data: {
          status: RewardNominationStatus.APPROVED,
          reviewedById: staff.id,
          reviewNote: note?.trim() || null,
          reviewedAt: now,
        },
      });
      await tx.postRewardAuditEvent.create({
        data: {
          programId: nomination.programId,
          nominationId,
          actorId: staff.id,
          eventType: 'NOMINATION_APPROVED',
          details: {
            grantIds: grants.map((grant) => grant.id),
            policyVersion: nomination.policyVersion,
          },
        },
      });
      return { nomination: updated, grants };
    });
  }

  private async applyReward(
    tx: Prisma.TransactionClient,
    grantId: string,
    recipientId: string,
    reward: PromotionalCoinsReward,
  ): Promise<void> {
    switch (reward.type) {
      case 'PROMOTIONAL_COINS':
        // This is a non-cash, non-withdrawable grant to the existing virtual
        // gift wallet. Its unique key ties the wallet entry to this grant.
        await tx.coinEntry.create({
          data: {
            userId: recipientId,
            kind: CoinKind.REWARD_GRANT,
            amount: reward.amount,
            key: `reward:${grantId}`,
          },
        });
        return;
      default: {
        const unsupported: never = reward;
        throw new BadRequestException(
          `No reward handler is registered for ${String(unsupported)}.`,
        );
      }
    }
  }

  private requireStaff(staff: Staff): void {
    if (!EnforcementService.isStaff(staff.role)) {
      throw new ForbiddenException('This action is for Kyron staff.');
    }
  }

  private assertDateWindow(startsAt: Date | null, endsAt: Date | null): void {
    if (
      startsAt &&
      endsAt &&
      (!Number.isFinite(startsAt.getTime()) ||
        !Number.isFinite(endsAt.getTime()) ||
        endsAt <= startsAt)
    ) {
      throw new BadRequestException('Programme end time must be after its start time.');
    }
  }
}
