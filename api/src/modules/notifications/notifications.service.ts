import { Injectable } from '@nestjs/common';
import {
  AppealStatus,
  MediaKind,
  Prisma,
  ModerationKind,
  ReportReason,
  ReportStatus,
  ReportTarget,
} from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { giftType } from '../gifts/gift-catalogue';

export type NotificationKind =
  | 'like'
  | 'comment'
  | 'follow'
  | 'repost'
  /** Somebody wrote @you in a post or a reply. */
  | 'mention'
  /** Something the team decided about this account, an appeal answered, or
   * a decision reversed. */
  | 'account'
  /** What came of something this account reported. */
  | 'report'
  /** Somebody sent a gift to one of this account's posts. */
  | 'gift';

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
  /** The post's first picture -- a photo, a GIF, or a video's still -- so
   * the row can show it at its end. Null for a post of words alone. */
  postImage: string | null;
  /** What was written, for a comment or a mention. */
  content: string | null;
  createdAt: Date;
  /** Nothing this new had been seen last time the screen was opened. */
  unread: boolean;
  account?: AccountNotice;
  report?: ReportOutcome;
  /** Which gift, for a gift row: named here so the app need not keep its
   * own copy of the catalogue. */
  gift?: { type: string; coins: number; name: string; emoji: string };
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
      /** Mentions too, asked for for the same reason. */
      mentions?: boolean;
      /** Gifts too, asked for for the same reason. */
      gifts?: boolean;
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
    const optIn: Partial<Record<NotificationKind, boolean | undefined>> = {
      account: options.moderation,
      report: options.moderation,
      mention: options.mentions,
      gift: options.gifts,
    };
    const wanted = (kind: NotificationKind) =>
      (kind in optIn ? optIn[kind] === true : true) &&
      (!options.kind || options.kind === kind);

    const [likes, comments, reposts, follows, mentions, gifts] =
      await Promise.all([
        wanted('like')
          ? this.prisma.postLike.findMany({
              where: {
                createdAt: when,
                post: { authorId: userId },
                ...notMine,
              },
              orderBy: { createdAt: 'desc' },
              take: limit,
              select: {
                id: true,
                createdAt: true,
                postId: true,
                user: { select: this.actorFields },
                post: { select: this.postFields },
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
                post: { select: this.postFields },
              },
            })
          : [],
        wanted('repost')
          ? this.prisma.repost.findMany({
              where: {
                createdAt: when,
                post: { authorId: userId },
                ...notMine,
              },
              orderBy: { createdAt: 'desc' },
              take: limit,
              select: {
                id: true,
                createdAt: true,
                postId: true,
                user: { select: this.actorFields },
                post: { select: this.postFields },
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
        wanted('mention') ? this.mentionRows(userId, when, blocked, limit) : [],
        wanted('gift')
          ? this.prisma.gift.findMany({
              where: {
                createdAt: when,
                recipientId: userId,
                // Null once the sender deleted their account: nobody to name.
                senderId: { not: null, notIn: [userId, ...blocked] },
              },
              orderBy: { createdAt: 'desc' },
              take: limit,
              select: {
                id: true,
                createdAt: true,
                postId: true,
                type: true,
                coins: true,
                sender: { select: this.actorFields },
                post: { select: this.postFields },
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
        postImage: this.picture(row.post),
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
        postImage: this.picture(row.post),
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
        postImage: this.picture(row.post),
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
        postImage: null,
        content: null,
        createdAt: row.createdAt,
        unread: this.isUnread(row.createdAt, seenAt),
      })),
      ...mentions.map((row) => ({
        id: `mention:${row.id}`,
        kind: 'mention' as const,
        actor: this.actor(row.author),
        postId: row.postId,
        postSnippet: this.snippet(row.post?.content),
        postImage: this.picture(row.post),
        // Where they named you: the reply's words, or the post's.
        content: this.snippet(row.comment?.content ?? row.post?.content),
        createdAt: row.createdAt,
        unread: this.isUnread(row.createdAt, seenAt),
      })),
      ...gifts.flatMap((row) =>
        row.sender
          ? [
              {
                id: `gift:${row.id}`,
                kind: 'gift' as const,
                actor: this.actor(row.sender),
                postId: row.postId,
                postSnippet: this.snippet(row.post?.content),
                postImage: this.picture(row.post),
                content: null,
                createdAt: row.createdAt,
                unread: this.isUnread(row.createdAt, seenAt),
                gift: {
                  type: row.type,
                  coins: row.coins,
                  // A gift since dropped from the catalogue still says what
                  // it was, if not by its own name.
                  name: giftType(row.type)?.name ?? 'Gift',
                  emoji: giftType(row.type)?.emoji ?? '🎁',
                },
              },
            ]
          : [],
      ),
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
    options: { moderation?: boolean; mentions?: boolean; gifts?: boolean } = {},
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

    const [likes, comments, reposts, follows, mentions, gifts] =
      await Promise.all([
        this.prisma.postLike.count({
          where: { ...fresh, ...mine, ...notMine },
        }),
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
        options.mentions
          ? this.prisma.mention.count({
              where: { ...fresh, ...this.liveMention(userId, blocked) },
            })
          : 0,
        options.gifts
          ? this.prisma.gift.count({
              where: {
                ...fresh,
                recipientId: userId,
                senderId: { not: null, notIn: [userId, ...blocked] },
              },
            })
          : 0,
      ]);

    const moderation = options.moderation
      ? (
          await this.moderationRows(userId, { gt: since }, 50, {
            account: true,
            report: true,
          })
        ).length
      : 0;

    return {
      count:
        likes + comments + reposts + follows + mentions + gifts + moderation,
    };
  }

  /**
   * Where somebody wrote @this-account, newest first.
   *
   * Only while what they wrote still stands: a deleted post or reply takes
   * its mention with it, as a deleted comment takes its row off the screen.
   */
  private mentionRows(
    userId: string,
    when: { gte?: Date; gt?: Date; lt?: Date },
    blocked: string[],
    limit: number,
  ) {
    return this.prisma.mention.findMany({
      where: { createdAt: when, ...this.liveMention(userId, blocked) },
      orderBy: { createdAt: 'desc' },
      take: limit,
      select: {
        id: true,
        createdAt: true,
        postId: true,
        author: { select: this.actorFields },
        post: { select: this.postFields },
        comment: { select: { content: true } },
      },
    });
  }

  /** A mention of [userId] that still counts: by somebody not blocked
   * either way, in a post and reply that are both still there. */
  private liveMention(userId: string, blocked: string[]) {
    return {
      userId,
      authorId: { not: userId, notIn: blocked },
      post: { deletedAt: null },
      OR: [{ commentId: null }, { comment: { deletedAt: null } }],
    } satisfies Prisma.MentionWhereInput;
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
        postImage: null,
        createdAt: a.createdAt,
        account: notice(a, 'decision'),
      })),
      ...appeals.map((ap) => ({
        ...quiet,
        id: `account:appeal:${ap.id}`,
        kind: 'account' as const,
        postSnippet: null,
        postImage: null,
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
        postImage: null,
        createdAt: a.reversedAt!,
        account: notice(a, 'reversal'),
      })),
      ...reports.map((r) => ({
        ...quiet,
        id: `report:${r.id}`,
        kind: 'report' as const,
        postSnippet: this.snippet(readable(r.snapshot)),
        postImage: null,
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

  /** What is read of a post for its row: its words, and its first picture. */
  private readonly postFields = {
    content: true,
    media: {
      where: {
        kind: { in: [MediaKind.IMAGE, MediaKind.GIF, MediaKind.VIDEO] },
      },
      orderBy: { position: 'asc' as const },
      take: 1,
      select: { url: true, thumbnailUrl: true, kind: true },
    },
  };

  /** A post's first picture, as a row shows it: a video by its still, and
   * nothing for one without (a row cannot play it). */
  private picture(
    post:
      | {
          media?: {
            url: string;
            thumbnailUrl: string | null;
            kind: MediaKind;
          }[];
        }
      | null
      | undefined,
  ): string | null {
    const first = post?.media?.[0];
    if (!first) return null;
    if (first.kind === MediaKind.VIDEO) return first.thumbnailUrl || null;
    return first.thumbnailUrl || first.url || null;
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
