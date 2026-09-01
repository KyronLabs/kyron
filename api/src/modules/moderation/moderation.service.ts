import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import {
  InterestKind,
  MuteKind,
  ReportReason,
  ReportTarget,
} from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/** Everything one reader has asked not to see, read in a single round trip. */
export interface FeedFilters {
  blockedUserIds: string[];
  mutedUserIds: string[];
  mutedPostIds: string[];
  hiddenPostIds: string[];
  mutedPhrases: string[];
}

@Injectable()
export class ModerationService {
  private readonly logger = new Logger(ModerationService.name);

  constructor(private readonly prisma: PrismaService) {}

  /**
   * The reader's filters, gathered once per feed request.
   *
   * Applied in the query rather than in the client. Hiding a blocked account's
   * posts after they have been sent is not blocking -- the content still
   * arrived, and anything that reads the response can see it.
   */
  async filtersFor(userId: string): Promise<FeedFilters> {
    const [blocks, blockedBy, mutes, hidden] = await Promise.all([
      this.prisma.block.findMany({
        where: { blockerId: userId },
        select: { blockedId: true },
      }),
      // Blocking cuts both ways: someone who blocked you does not appear in
      // your feed either, or blocking would be a one-way mute.
      this.prisma.block.findMany({
        where: { blockedId: userId },
        select: { blockerId: true },
      }),
      this.prisma.mute.findMany({
        where: { userId },
        select: {
          kind: true,
          targetUserId: true,
          targetPostId: true,
          phrase: true,
        },
      }),
      this.prisma.hiddenPost.findMany({
        where: { userId },
        select: { postId: true },
      }),
    ]);

    return {
      blockedUserIds: [
        ...blocks.map((b) => b.blockedId),
        ...blockedBy.map((b) => b.blockerId),
      ],
      mutedUserIds: mutes
        .filter((m) => m.kind === MuteKind.USER && m.targetUserId)
        .map((m) => m.targetUserId as string),
      mutedPostIds: mutes
        .filter((m) => m.kind === MuteKind.THREAD && m.targetPostId)
        .map((m) => m.targetPostId as string),
      mutedPhrases: mutes
        .filter((m) => m.kind === MuteKind.WORD && m.phrase)
        .map((m) => m.phrase as string),
      hiddenPostIds: hidden.map((h) => h.postId),
    };
  }

  async setBlocked(userId: string, targetId: string, blocked: boolean) {
    if (userId === targetId) {
      throw new NotFoundException('You cannot block yourself.');
    }

    if (blocked) {
      await this.prisma.block.upsert({
        where: {
          blockerId_blockedId: { blockerId: userId, blockedId: targetId },
        },
        create: { blockerId: userId, blockedId: targetId },
        update: {},
      });
      // Blocking severs the follow in both directions, or the block would
      // leave a follower who cannot see anything but is still counted.
      await this.prisma.follow.deleteMany({
        where: {
          OR: [
            { followerId: userId, followingId: targetId },
            { followerId: targetId, followingId: userId },
          ],
        },
      });
    } else {
      await this.prisma.block.deleteMany({
        where: { blockerId: userId, blockedId: targetId },
      });
    }

    return { blocked };
  }

  async muteUser(userId: string, targetId: string, muted: boolean) {
    if (userId === targetId) {
      throw new NotFoundException('You cannot mute yourself.');
    }
    return this.setMute(
      userId,
      MuteKind.USER,
      { targetUserId: targetId },
      muted,
    );
  }

  async muteThread(userId: string, postId: string, muted: boolean) {
    return this.setMute(
      userId,
      MuteKind.THREAD,
      { targetPostId: postId },
      muted,
    );
  }

  /** Words and tags share a mechanism: both are matched against post text. */
  async mutePhrase(userId: string, phrase: string, muted: boolean) {
    const normalised = phrase.trim().toLowerCase();
    if (!normalised) throw new NotFoundException('Nothing to mute.');
    return this.setMute(userId, MuteKind.WORD, { phrase: normalised }, muted);
  }

  async listMutedPhrases(userId: string) {
    const rows = await this.prisma.mute.findMany({
      where: { userId, kind: MuteKind.WORD },
      select: { id: true, phrase: true, createdAt: true },
      orderBy: { createdAt: 'desc' },
    });
    return { items: rows };
  }

  async listMutedUsers(userId: string) {
    const rows = await this.prisma.mute.findMany({
      where: { userId, kind: MuteKind.USER },
      select: {
        id: true,
        createdAt: true,
        targetUser: {
          select: {
            id: true,
            name: true,
            username: true,
            profile: { select: { avatarUrl: true } },
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });

    return {
      items: rows
        .filter((row) => row.targetUser)
        .map((row) => ({
          id: row.targetUser!.id,
          name: row.targetUser!.name,
          username: row.targetUser!.username,
          avatarUrl: row.targetUser!.profile?.avatarUrl ?? null,
          mutedAt: row.createdAt,
        })),
    };
  }

  async listBlockedUsers(userId: string) {
    const rows = await this.prisma.block.findMany({
      where: { blockerId: userId },
      select: {
        createdAt: true,
        blocked: {
          select: {
            id: true,
            name: true,
            username: true,
            profile: { select: { avatarUrl: true } },
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });

    return {
      items: rows.map((row) => ({
        id: row.blocked.id,
        name: row.blocked.name,
        username: row.blocked.username,
        avatarUrl: row.blocked.profile?.avatarUrl ?? null,
        blockedAt: row.createdAt,
      })),
    };
  }

  async setHidden(userId: string, postId: string, hidden: boolean) {
    if (hidden) {
      await this.prisma.hiddenPost.upsert({
        where: { userId_postId: { userId, postId } },
        create: { userId, postId },
        update: {},
      });
    } else {
      await this.prisma.hiddenPost.deleteMany({ where: { userId, postId } });
    }
    return { hidden };
  }

  /**
   * "Show more of this" or "show less of this".
   *
   * Recorded even though the feed is chronological today. A signal thrown away
   * is one that cannot inform ranking later, and the alternative -- a button
   * that does nothing at all -- is worse. "Less" also hides the post that
   * prompted it, which is the part the reader can see working.
   */
  async setInterest(userId: string, postId: string, kind: InterestKind) {
    await this.prisma.interestSignal.upsert({
      where: { userId_postId: { userId, postId } },
      create: { userId, postId, kind },
      update: { kind },
    });

    if (kind === InterestKind.LESS) {
      await this.setHidden(userId, postId, true);
    }
    return { kind };
  }

  private async setMute(
    userId: string,
    kind: MuteKind,
    target: { targetUserId?: string; targetPostId?: string; phrase?: string },
    muted: boolean,
  ) {
    const where = {
      userId,
      kind,
      targetUserId: target.targetUserId ?? null,
      targetPostId: target.targetPostId ?? null,
      phrase: target.phrase ?? null,
    };

    if (muted) {
      // deleteMany then create rather than upsert: the unique index spans four
      // nullable columns, and Prisma cannot address a compound unique whose
      // members are null.
      await this.prisma.mute.deleteMany({ where });
      await this.prisma.mute.create({ data: where });
    } else {
      await this.prisma.mute.deleteMany({ where });
    }
    return { muted };
  }

  /**
   * Files a report.
   *
   * The reported content is copied into the report as it stood. Without that a
   * report becomes unreviewable the moment its subject edits or deletes what
   * was reported, which is the first thing anyone does.
   */
  async report(
    reporterId: string,
    target: ReportTarget,
    targetId: string,
    reason: ReportReason,
    detail?: string,
  ) {
    const snapshot = await this.snapshotOf(target, targetId);
    if (snapshot === null) throw new NotFoundException('Nothing to report.');

    const report = await this.prisma.report.upsert({
      where: {
        reporterId_target_targetId: { reporterId, target, targetId },
      },
      // A second report of the same thing by the same person is the same
      // complaint. Updating rather than inserting keeps one report per person,
      // so a repeat cannot make one objection look like many.
      create: { reporterId, target, targetId, reason, detail, snapshot },
      update: { reason, detail },
      select: { id: true, status: true, createdAt: true },
    });

    this.logger.log(`report ${report.id}: ${target} ${targetId} (${reason})`);
    return report;
  }

  private async snapshotOf(
    target: ReportTarget,
    targetId: string,
  ): Promise<string | null> {
    if (target === ReportTarget.POST) {
      const post = await this.prisma.post.findUnique({
        where: { id: targetId },
        select: { content: true, authorId: true },
      });
      return post ? `post by ${post.authorId}: ${post.content}` : null;
    }
    if (target === ReportTarget.COMMENT) {
      const comment = await this.prisma.comment.findUnique({
        where: { id: targetId },
        select: { content: true, authorId: true },
      });
      return comment
        ? `comment by ${comment.authorId}: ${comment.content}`
        : null;
    }
    const user = await this.prisma.user.findUnique({
      where: { id: targetId },
      select: { username: true, name: true },
    });
    return user
      ? `account @${user.username ?? '?'} (${user.name ?? '?'})`
      : null;
  }
}
