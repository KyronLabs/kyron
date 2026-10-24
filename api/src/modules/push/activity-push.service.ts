import { Injectable } from '@nestjs/common';
import { AccountStatus } from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { type PushText, say } from './push-text';
import type { PushMessage } from './push.service';

/** Something one person did that another hears about. */
export interface Activity {
  kind: 'like' | 'comment' | 'repost' | 'follow';
  actorId: string;
  /** The post it happened to, for everything but a follow. */
  postId?: string;
  /** What was written, for a reply. */
  text?: string;
}

/** How far back "and others" counts when the screen was never opened. */
const WINDOW_DAYS = 90;

/** Enough of a post or a reply to say which one, on one line. */
const SNIPPET = 80;

/**
 * What a push about somebody's activity says: who, what, and on what.
 *
 * It used to be "Kyron" over "Somebody liked your post." -- the app's name
 * where the person belongs and nothing to say which post -- because naming
 * the actor costs a query, and a like should not wait on one. It does not:
 * this runs after the socket has been told, off the request's path
 * (DeliveryService.tellActivity).
 *
 * One notification stands for each post and kind on the phone (see
 * PushService.tagFor), so a newer like replaces the one before. Saying
 * "and 2 others" keeps the replaced ones counted rather than dropped.
 */
@Injectable()
export class ActivityPushService {
  constructor(private readonly prisma: PrismaService) {}

  /** The push for [activity], or null when there should be none: the actor
   * is gone, banned, or blocked either way. */
  async message(
    recipientId: string,
    activity: Activity,
  ): Promise<PushMessage | null> {
    const [actor, recipient, blocked] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: activity.actorId },
        select: {
          name: true,
          username: true,
          status: true,
          deletedAt: true,
          profile: { select: { avatarUrl: true } },
        },
      }),
      this.prisma.user.findUnique({
        where: { id: recipientId },
        select: { notificationsSeenAt: true },
      }),
      this.blockedIds(recipientId),
    ]);
    if (
      !actor ||
      actor.deletedAt ||
      actor.status === AccountStatus.BANNED ||
      actor.status === AccountStatus.DELETED ||
      blocked.includes(activity.actorId)
    ) {
      return null;
    }

    const since =
      recipient?.notificationsSeenAt ??
      new Date(Date.now() - WINDOW_DAYS * 86_400_000);
    const notThem = [activity.actorId, recipientId, ...blocked];
    const [others, snippet] = await Promise.all([
      this.others(activity, recipientId, since, notThem),
      this.snippetFor(activity),
    ]);

    const avatar = actor.profile?.avatarUrl ?? null;
    return {
      ...activityCopy({
        kind: activity.kind,
        actor: displayName(actor),
        others,
        snippet,
      }),
      ...(avatar && /^https:\/\//.test(avatar) ? { image: avatar } : {}),
      data: {
        type: 'notification',
        kind: activity.kind,
        actorId: activity.actorId,
        ...(activity.postId ? { postId: activity.postId } : {}),
      },
    };
  }

  /** How many others did the same since the reader last looked: the ones a
   * newer notification replaced on the phone. Not for replies, where each
   * one's words are the point and a count of them says little. */
  private others(
    activity: Activity,
    recipientId: string,
    since: Date,
    notThem: string[],
  ): Promise<number> {
    const createdAt = { gt: since };
    switch (activity.kind) {
      case 'like':
        return activity.postId
          ? this.prisma.postLike.count({
              where: {
                postId: activity.postId,
                createdAt,
                userId: { notIn: notThem },
              },
            })
          : Promise.resolve(0);
      case 'repost':
        return activity.postId
          ? this.prisma.repost.count({
              where: {
                postId: activity.postId,
                createdAt,
                userId: { notIn: notThem },
              },
            })
          : Promise.resolve(0);
      case 'follow':
        return this.prisma.follow.count({
          where: {
            followingId: recipientId,
            createdAt,
            followerId: { notIn: notThem },
          },
        });
      case 'comment':
        return Promise.resolve(0);
    }
  }

  /** The reply's words, or the start of the post it was about. */
  private async snippetFor(activity: Activity): Promise<string | null> {
    if (activity.kind === 'comment') return snippetOf(activity.text);
    if (!activity.postId) return null;
    const post = await this.prisma.post.findUnique({
      where: { id: activity.postId },
      select: { content: true },
    });
    return snippetOf(post?.content);
  }

  private async blockedIds(userId: string): Promise<string[]> {
    const rows = await this.prisma.block.findMany({
      where: { OR: [{ blockerId: userId }, { blockedId: userId }] },
      select: { blockerId: true, blockedId: true },
    });
    return rows.map((r) =>
      r.blockerId === userId ? r.blockedId : r.blockerId,
    );
  }
}

/** A person as a notification names them: what they call themselves, or
 * their handle -- or, with neither, "Someone" in the reader's language. */
export function displayName(user: {
  name: string | null;
  username: string | null;
}): PushText {
  const name = user.name?.trim();
  if (name) return name;
  return user.username ? `@${user.username}` : say('someone');
}

/** One line of somebody's words, cut at a word where it can be. */
export function snippetOf(text: string | null | undefined): string | null {
  const flat = (text ?? '').replace(/\s+/g, ' ').trim();
  if (!flat) return null;
  if (flat.length <= SNIPPET) return flat;
  const cut = flat.slice(0, SNIPPET);
  const space = cut.lastIndexOf(' ');
  return `${(space > SNIPPET / 2 ? cut.slice(0, space) : cut).trimEnd()}…`;
}

/** The words of an activity push. The person is the title, as on every
 * other app's notification about a person; what they did is the body. Said
 * in each phone's language when it is sent. */
export function activityCopy(input: {
  kind: Activity['kind'];
  actor: PushText;
  others: number;
  snippet: string | null;
}): { title: PushText; body: PushText } {
  const { kind, actor, others, snippet } = input;
  const title =
    others > 0
      ? say(others === 1 ? 'and_one_other' : 'and_others', {
          name: actor,
          count: others,
        })
      : actor;
  const quoted = snippet ? { snippet } : null;
  switch (kind) {
    case 'follow':
      return { title, body: say('followed') };
    case 'like':
      return {
        title,
        body: quoted ? say('liked_quote', quoted) : say('liked'),
      };
    case 'repost':
      return {
        title,
        body: quoted ? say('reposted_quote', quoted) : say('reposted'),
      };
    case 'comment':
      return {
        title,
        body: quoted ? say('replied_quote', quoted) : say('replied'),
      };
  }
}
