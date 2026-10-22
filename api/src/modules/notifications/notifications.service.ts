import { Injectable } from '@nestjs/common';
import {
  AppealStatus,
  ModerationKind,
  ReportReason,
  ReportStatus,
  ReportTarget,
} from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

export type NotificationKind =
  | 'like'
  | 'comment'
  | 'follow'
  | 'repost'
  /** Something the team decided about this account, an appeal answered, or
   * a decision reversed. */
  | 'account'
  /** What came of something this account reported. */
  | 'report';

/** The words of an account row are the app's, in the reader's language:
 * this says what happened, not how to say it. */
export interface AccountNotice {
  event: 'decision' | 'appeal' | 'reversal';
  actionId: string;
  /** The case number, which every notice and appeal names. */
  number: number;
  kind: ModerationKind;
  rule: ReportReason;
  target: ReportTarget | null;
  endsAt: Date | null;
  /** For an appeal: accepted, and the decision undone. */
  overturned?: boolean;
}

/** What came of a report, and what it was about. Never who looked at it. */
export interface ReportOutcome {
  outcome: 'ACTIONED' | 'DISMISSED';
  target: ReportTarget;
  reason: ReportReason;
}

/** Who did the thing. */
export interface NotificationActor {
  id: string;
  name: string | null;
  username: string | null;
  avatarUrl: string | null;
  /** Somebody on the team checked it is who it says it is. */
  verified: boolean;
}

/** One row on the notifications screen. */
export interface NotificationItem {
  /** Unique across kinds: two tables can share a row id. */
  id: string;
  kind: NotificationKind;
  /** Null for what the team did: a decision is Kyron's, not a person's. */
  actor: NotificationActor | null;
  /** The post it happened to, for a like, a comment or a repost. */
  postId: string | null;
  /** The start of that post, so the row says which one without a fetch. */
  postSnippet: string | null;
  /** What was written, for a comment. */
  content: string | null;
  createdAt: Date;
  /** Nothing this new had been seen last time the screen was opened. */
  unread: boolean;
  account?: AccountNotice;
  report?: ReportOutcome;
}

const DEFAULT_LIMIT = 30;
const SNIPPET = 90;

/** How far back the screen goes. Older than this is not worth the query. */
const WINDOW_DAYS = 90;

/**
 * What other people did to your posts and your account.
 *
 * Derived from the likes, comments, reposts and follows themselves rather than
 * written into a table of its own as they happen. A fan-out table has to be
 * kept in step with every write path that could ever produce a notification,
 * and drifts the moment one of them forgets; this cannot drift, because it is
 * reading the same rows the counts are read from.
 *
 * What that costs is per-row read state, which would need somewhere to live.
 * Instead the account carries one watermark -- the last time the screen was
 * opened -- and anything newer is unread. That is what the badge needs, and it
 * survives reading on one device and picking up the phone on another.
 */
@Injectable()
export class NotificationsService {
  constructor(private readonly prisma: PrismaService) {}

  async list(
    userId: string,
    options: {
      limit?: number;
      cursor?: string;
      kind?: NotificationKind;
      /** Decisions and report outcomes too. Asked for, because an app from
       * before them reads an unknown row as "Someone liked your post". */
      moderation?: boolean;
    } = {},
  ): Promise<{ items: NotificationItem[]; nextCursor: string | null }> {
    const limit = options.limit ?? DEFAULT_LIMIT;
    const before = options.cursor ? new Date(options.cursor) : null;
    const since = new Date(Date.now() - WINDOW_DAYS * 86_400_000);

    const [me, blocked] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: { notificationsSeenAt: true },
      }),
      this.blockedIds(userId),
    ]);
    const seenAt = me?.notificationsSeenAt ?? null;

    // Each kind is asked for a full page of its own. Merging then trimming is
    // what makes the union orderable: whichever kind happens to be busiest
    // cannot crowd the others out of the page, because every one of them
    // brought enough rows to fill it alone.
    const when = { gte: since, ...(before ? { lt: before } : {}) };
    const notMine = { userId: { not: userId, notIn: blocked } };
    const wanted = (kind: NotificationKind) =>
      kind === 'account' || kind === 'report'
        ? options.moderation === true &&
          (!options.kind || options.kind === kind)
        : !options.kind || options.kind === kind;

    const [likes, comments, reposts, follows] = await Promise.all([
      wanted('like')
        ? this.prisma.postLike.findMany({
            where: { createdAt: when, post: { authorId: userId }, ...notMine },
            orderBy: { createdAt: 'desc' },
            take: limit,
            select: {
              id: true,
              createdAt: true,
              postId: true,
              user: { select: this.actorFields },
              post: { select: { content: true } },
            },
          })
        : [],
      wanted('comment')
        ? this.prisma.comment.findMany({
            where: {
              createdAt: when,
              deletedAt: null,
              post: { authorId: userId },
              authorId: { not: userId, notIn: blocked },
            },
            orderBy: { createdAt: 'desc' },
            take: limit,
            select: {
              id: true,
              createdAt: true,
              postId: true,
              content: true,
              author: { select: this.actorFields },
              post: { select: { content: true } },
            },
          })
        : [],
      wanted('repost')
        ? this.prisma.repost.findMany({
            where: { createdAt: when, post: { authorId: userId }, ...notMine },
            orderBy: { createdAt: 'desc' },
            take: limit,
            select: {
              id: true,
              createdAt: true,
              postId: true,
              user: { select: this.actorFields },
              post: { select: { content: true } },
            },
          })
        : [],
      wanted('follow')
        ? this.prisma.follow.findMany({
            where: {
              createdAt: when,
              followingId: userId,
              followerId: { not: userId, notIn: blocked },
            },
            orderBy: { createdAt: 'desc' },
            take: limit,
            select: {
              id: true,
              createdAt: true,
              follower: { select: this.actorFields },
            },
          })
        : [],
    ]);

    const moderation = await this.moderationRows(userId, when, limit, {
      account: wanted('account'),
      report: wanted('report'),
    });

    const merged: NotificationItem[] = [
      ...likes.map((row) => ({
        id: `like:${row.id}`,
        kind: 'like' as const,
        actor: this.actor(row.user),
        postId: row.postId,
        postSnippet: this.snippet(row.post?.content),
        content: null,
        createdAt: row.createdAt,
        unread: this.isUnread(row.createdAt, seenAt),
      })),
      ...comments.map((row) => ({
        id: `comment:${row.id}`,
        kind: 'comment' as const,
        actor: this.actor(row.author),
        postId: row.postId,
        postSnippet: this.snippet(row.post?.content),
        content: this.snippet(row.content),
        createdAt: row.createdAt,
        unread: this.isUnread(row.createdAt, seenAt),
      })),
      ...reposts.map((row) => ({
        id: `repost:${row.id}`,
        kind: 'repost' as const,
        actor: this.actor(row.user),
        postId: row.postId,
        postSnippet: this.snippet(row.post?.content),
        content: null,
        createdAt: row.createdAt,
        unread: this.isUnread(row.createdAt, seenAt),
      })),
      ...follows.map((row) => ({
        id: `follow:${row.id}`,
        kind: 'follow' as const,
        actor: this.actor(row.follower),
        postId: null,
        postSnippet: null,
        content: null,
        createdAt: row.createdAt,
        unread: this.isUnread(row.createdAt, seenAt),
      })),
      ...moderation.map((row) => ({
        ...row,
        unread: this.isUnread(row.createdAt, seenAt),
      })),
    ]
      .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime())
      .slice(0, limit);

    // A full page means there is very likely another. An exhausted one ends
    // the list rather than offering a cursor that returns nothing.
    const nextCursor =
      merged.length === limit
        ? merged[merged.length - 1].createdAt.toISOString()
        : null;

    return { items: merged, nextCursor };
  }

  /** What the tab bar's badge counts. */
  async unreadCount(
    userId: string,
    options: { moderation?: boolean } = {},
  ): Promise<{ count: number }> {
    const me = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { notificationsSeenAt: true },
    });
    const since = new Date(
      Math.max(
        Date.now() - WINDOW_DAYS * 86_400_000,
        me?.notificationsSeenAt?.getTime() ?? 0,
      ),
    );
    const blocked = await this.blockedIds(userId);
    const mine = { post: { authorId: userId } };
    const fresh = { createdAt: { gt: since } };
    const notMine = { userId: { not: userId, notIn: blocked } };

    const [likes, comments, reposts, follows] = await Promise.all([
      this.prisma.postLike.count({ where: { ...fresh, ...mine, ...notMine } }),
      this.prisma.comment.count({
        where: {
          ...fresh,
          ...mine,
          deletedAt: null,
          authorId: { not: userId, notIn: blocked },
        },
      }),
      this.prisma.repost.count({ where: { ...fresh, ...mine, ...notMine } }),
      this.prisma.follow.count({
        where: {
          ...fresh,
          followingId: userId,
          followerId: { not: userId, notIn: blocked },
        },
      }),
    ]);

    const moderation = options.moderation
      ? (
          await this.moderationRows(userId, { gt: since }, 50, {
            account: true,
            report: true,
          })
        ).length
      : 0;

    return { count: likes + comments + reposts + follows + moderation };
  }

  /**
   * Decisions about this account, appeals answered, reversals, and what came
   * of what it reported, each at the moment it happened.
   *
   * Read from the decisions and reports themselves, like every other row
   * here. Each is already pushed when it happens; without a row, a push
   * missed or dismissed left nothing in the app to find it by but a screen
   * in Settings.
   */
  private async moderationRows(
    userId: string,
    when: { gte?: Date; gt?: Date; lt?: Date },
    limit: number,
    wanted: { account: boolean; report: boolean },
  ): Promise<Omit<NotificationItem, 'unread'>[]> {
    const action = {
      id: true,
      number: true,
      kind: true,
      rule: true,
      target: true,
      endsAt: true,
    } as const;
    const [decisions, appeals, reversals, reports] = await Promise.all([
      wanted.account
        ? this.prisma.moderationAction.findMany({
            where: { subjectId: userId, createdAt: when },
            orderBy: { createdAt: 'desc' },
            take: limit,
            select: { ...action, createdAt: true, snapshot: true },
          })
        : [],
      wanted.account
        ? this.prisma.appeal.findMany({
            where: { userId, decidedAt: when },
            orderBy: { decidedAt: 'desc' },
            take: limit,
            select: {
              id: true,
              status: true,
              decidedAt: true,
              action: { select: action },
            },
          })
        : [],
      wanted.account
        ? this.prisma.moderationAction.findMany({
            where: {
              subjectId: userId,
              reversedAt: when,
              // Reversed by accepting an appeal: the appeal's row says so.
              OR: [
                { appeal: null },
                { appeal: { status: { not: AppealStatus.OVERTURNED } } },
              ],
            },
            orderBy: { reversedAt: 'desc' },
            take: limit,
            select: { ...action, reversedAt: true },
          })
        : [],
      wanted.report
        ? this.prisma.report.findMany({
            where: {
              reporterId: userId,
              resolvedAt: when,
              status: { in: [ReportStatus.ACTIONED, ReportStatus.DISMISSED] },
            },
            orderBy: { resolvedAt: 'desc' },
            take: limit,
            select: {
              id: true,
              status: true,
              target: true,
              reason: true,
              snapshot: true,
              resolvedAt: true,
            },
          })
        : [],
    ]);

    const notice = (
      a: (typeof decisions)[number] | (typeof reversals)[number],
      event: AccountNotice['event'],
    ): AccountNotice => ({
      event,
      actionId: a.id,
      number: a.number,
      kind: a.kind,
      rule: a.rule,
      target: a.target,
      endsAt: a.endsAt,
    });
    const quiet = {
      actor: null,
      postId: null,
      content: null,
    };

    return [
      ...decisions.map((a) => ({
        ...quiet,
        id: `account:decision:${a.id}`,
        kind: 'account' as const,
        postSnippet: this.snippet(readable(a.snapshot)),
        createdAt: a.createdAt,
        account: notice(a, 'decision'),
      })),
      ...appeals.map((ap) => ({
        ...quiet,
        id: `account:appeal:${ap.id}`,
        kind: 'account' as const,
        postSnippet: null,
        createdAt: ap.decidedAt!,
        account: {
          ...notice(
            { ...ap.action, createdAt: ap.decidedAt!, snapshot: null },
            'appeal',
          ),
          overturned: ap.status === AppealStatus.OVERTURNED,
        },
      })),
      ...reversals.map((a) => ({
        ...quiet,
        id: `account:reversal:${a.id}`,
        kind: 'account' as const,
        postSnippet: null,
        createdAt: a.reversedAt!,
        account: notice(a, 'reversal'),
      })),
      ...reports.map((r) => ({
        ...quiet,
        id: `report:${r.id}`,
        kind: 'report' as const,
        postSnippet: this.snippet(readable(r.snapshot)),
        createdAt: r.resolvedAt!,
        report: {
          outcome:
            r.status === ReportStatus.ACTIONED
              ? ('ACTIONED' as const)
              : ('DISMISSED' as const),
          target: r.target,
          reason: r.reason,
        },
      })),
    ];
  }

  /** Opening the screen clears the badge. */
  async markSeen(userId: string): Promise<{ seenAt: Date }> {
    const seenAt = new Date();
    await this.prisma.user.update({
      where: { id: userId },
      data: { notificationsSeenAt: seenAt },
    });
    return { seenAt };
  }

  private readonly actorFields = {
    id: true,
    name: true,
    username: true,
    verifiedAt: true,
    profile: { select: { avatarUrl: true } },
  } as const;

  private actor(row: {
    id: string;
    name: string | null;
    username: string | null;
    verifiedAt?: Date | null;
    profile: { avatarUrl: string | null } | null;
  }): NotificationActor {
    return {
      id: row.id,
      name: row.name,
      username: row.username,
      avatarUrl: row.profile?.avatarUrl ?? null,
      verified: !!row.verifiedAt,
    };
  }

  private isUnread(at: Date, seenAt: Date | null): boolean {
    return seenAt === null || at.getTime() > seenAt.getTime();
  }

  private snippet(text: string | null | undefined): string | null {
    const trimmed = text?.trim();
    if (!trimmed) return null;
    return trimmed.length > SNIPPET
      ? `${trimmed.slice(0, SNIPPET).trimEnd()}…`
      : trimmed;
  }

  /** Both directions: blocking somebody also stops hearing from them. */
  private async blockedIds(userId: string): Promise<string[]> {
    const rows = await this.prisma.block.findMany({
      where: { OR: [{ blockerId: userId }, { blockedId: userId }] },
      select: { blockerId: true, blockedId: true },
    });
    const ids = new Set<string>();
    for (const row of rows) {
      ids.add(row.blockerId === userId ? row.blockedId : row.blockerId);
    }
    return [...ids];
  }
}

/**
 * A snapshot as a person would read it. Snapshots lead with the author's id
 * ("post by <uuid>: ..."), which is for the record and not for the person
 * who wrote it or the person who reported it.
 */
function readable(snapshot: string | null): string | null {
  if (!snapshot) return null;
  return snapshot
    .replace(/^(post|comment) by [0-9a-f-]{36}: /, '')
    .replace(/^community chat message by [0-9a-f-]{36} in [^:]*: /, '');
}
