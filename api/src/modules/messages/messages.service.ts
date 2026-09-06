import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { MediaKind, Prisma } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/** The other person in a conversation, as a list row needs them. */
export interface MessagePerson {
  id: string;
  name: string | null;
  username: string | null;
  avatarUrl: string | null;
}

/** One conversation, as the list shows it. */
export interface ConversationSummary {
  id: string;
  /** Everyone in it but the reader. One person today; a list, so groups later
   * do not change the shape the client already renders. */
  people: MessagePerson[];
  lastMessage: {
    id: string;
    body: string;
    senderId: string;
    createdAt: Date;
  } | null;
  /** Messages from the other side the reader has not seen. */
  unread: number;
  lastMessageAt: Date;
}

/** One attachment on a message. The same shape a post's carries. */
export interface MessageMedia {
  id: string;
  kind: MediaKind;
  url: string;
  width: number | null;
  height: number | null;
  alt: string | null;
  durationMs: number | null;
  waveform: number[];
  thumbnailUrl: string | null;
}

export interface MessageItem {
  id: string;
  body: string;
  senderId: string;
  createdAt: Date;
  /** True once the other side has read past it. Drawn as a tick. */
  seen: boolean;
  media: MessageMedia[];
}

/** One attachment as the client sends it, after uploading the file. */
export interface MessageMediaInput {
  /** Defaults to an image, which is what an unlabelled upload is. */
  kind?: MediaKind;
  url: string;
  width?: number;
  height?: number;
  alt?: string;
  durationMs?: number;
  waveform?: number[];
  thumbnailUrl?: string;
}

const DEFAULT_LIMIT = 30;

/**
 * Direct messages.
 *
 * Every read is scoped by membership rather than by an id the caller supplies:
 * a conversation id is a UUID somebody could guess at, and "you are in it" is
 * the only thing that should decide whether it opens.
 */
@Injectable()
export class MessagesService {
  private readonly logger = new Logger(MessagesService.name);

  constructor(private readonly prisma: PrismaService) {}

  /** The longest one message may be. */
  static readonly maxBody = 4000;

  /** How many attachments one message may carry. Same as a post's. */
  static readonly maxMedia = 4;

  private readonly personShape = {
    id: true,
    name: true,
    username: true,
    profile: { select: { avatarUrl: true } },
  } as const;

  /** The reader's conversations, whichever moved last at the top. */
  async list(
    viewerId: string,
    { limit = DEFAULT_LIMIT, cursor, unreadOnly = false } = {} as {
      limit?: number;
      cursor?: string;
      unreadOnly?: boolean;
    },
  ) {
    // Narrowed before paging, not after. Filtering a page down afterwards
    // gives short pages and an "Unread" tab that looks empty while there is
    // more behind the cursor.
    const only = unreadOnly ? await this.unreadConversationIds(viewerId) : null;
    if (only !== null && only.length === 0) {
      return { items: [] as ConversationSummary[], nextCursor: null };
    }

    const rows = await this.prisma.conversation.findMany({
      where: {
        ...(only ? { id: { in: only } } : {}),
        members: { some: { userId: viewerId, hiddenAt: null } },
        // A conversation nobody has said anything in yet is a draft, not a
        // thread, and it should not sit at the top of the list.
        messages: { some: { deletedAt: null } },
      },
      orderBy: [{ lastMessageAt: 'desc' }, { id: 'desc' }],
      take: limit + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
      select: {
        id: true,
        lastMessageAt: true,
        members: {
          select: {
            userId: true,
            lastReadAt: true,
            user: { select: this.personShape },
          },
        },
        messages: {
          where: { deletedAt: null },
          orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
          take: 1,
          select: { id: true, body: true, senderId: true, createdAt: true },
        },
      },
    });

    const page = rows.slice(0, limit);
    if (page.length === 0) {
      return { items: [] as ConversationSummary[], nextCursor: null };
    }

    const mine = new Map(
      page.map((row) => [
        row.id,
        row.members.find((m) => m.userId === viewerId)?.lastReadAt ?? null,
      ]),
    );

    // One grouped count rather than a count per row.
    const unreadCounts = await this.prisma.message.groupBy({
      by: ['conversationId'],
      where: {
        conversationId: { in: page.map((row) => row.id) },
        deletedAt: null,
        senderId: { not: viewerId },
        OR: page.map((row) => ({
          conversationId: row.id,
          ...(mine.get(row.id)
            ? { createdAt: { gt: mine.get(row.id) as Date } }
            : {}),
        })),
      },
      _count: { id: true },
    });
    const unreadOf = new Map(
      unreadCounts.map((row) => [row.conversationId, row._count.id]),
    );

    const items: ConversationSummary[] = page.map((row) => ({
      id: row.id,
      people: row.members
        .filter((m) => m.userId !== viewerId)
        .map((m) => this.toPerson(m.user)),
      lastMessage: row.messages[0] ?? null,
      unread: unreadOf.get(row.id) ?? 0,
      lastMessageAt: row.lastMessageAt,
    }));

    return {
      items,
      nextCursor: rows.length > limit ? page[page.length - 1].id : null,
    };
  }

  /**
   * Which of the reader's conversations hold something they have not read.
   *
   * Distinct rather than counted: what the caller wants is the set, and one
   * row per conversation is all it takes to answer that.
   */
  private async unreadConversationIds(viewerId: string): Promise<string[]> {
    const memberships = await this.prisma.conversationMember.findMany({
      where: { userId: viewerId, hiddenAt: null },
      select: { conversationId: true, lastReadAt: true },
    });
    if (memberships.length === 0) return [];

    const rows = await this.prisma.message.findMany({
      where: {
        deletedAt: null,
        senderId: { not: viewerId },
        OR: memberships.map((row) => ({
          conversationId: row.conversationId,
          ...(row.lastReadAt ? { createdAt: { gt: row.lastReadAt } } : {}),
        })),
      },
      distinct: ['conversationId'],
      select: { conversationId: true },
    });
    return rows.map((row) => row.conversationId);
  }

  /** How many conversations have something in them the reader has not read. */
  async unreadCount(viewerId: string) {
    const ids = await this.unreadConversationIds(viewerId);
    return { conversations: ids.length };
  }

  /**
   * The conversation with one other person, opening it if there is not one.
   *
   * Idempotent on purpose: "message this person" is a thing you can do twice,
   * and it should land in the same thread both times rather than splitting the
   * history in two.
   */
  async openWith(viewerId: string, otherId: string) {
    if (otherId === viewerId) {
      throw new BadRequestException('You cannot message yourself.');
    }
    const other = await this.prisma.user.findFirst({
      where: { id: otherId, deletedAt: null },
      select: { id: true },
    });
    if (!other) throw new NotFoundException('That account does not exist.');
    await this.requireNoBlock(viewerId, otherId);

    const existing = await this.prisma.conversation.findFirst({
      where: {
        AND: [
          { members: { some: { userId: viewerId } } },
          { members: { some: { userId: otherId } } },
        ],
      },
      select: { id: true },
    });

    if (existing) {
      // Reopening one they had removed from their list.
      await this.prisma.conversationMember.updateMany({
        where: { conversationId: existing.id, userId: viewerId },
        data: { hiddenAt: null },
      });
      return { id: existing.id };
    }

    const created = await this.prisma.conversation.create({
      data: {
        members: {
          create: [{ userId: viewerId }, { userId: otherId }],
        },
      },
      select: { id: true },
    });
    this.logger.log(`conversation ${created.id} opened by ${viewerId}`);
    return { id: created.id };
  }

  /** One conversation's messages, newest first. */
  async messages(
    viewerId: string,
    conversationId: string,
    { limit = DEFAULT_LIMIT, cursor }: { limit?: number; cursor?: string } = {},
  ) {
    const conversation = await this.requireMembership(viewerId, conversationId);

    // Seen means everyone else has read past it, so the earliest of their read
    // marks is the one that decides. Anyone who has never opened the thread
    // makes the whole thing unseen.
    const others = conversation.members.filter((m) => m.userId !== viewerId);
    const allOpened =
      others.length > 0 && others.every((m) => m.lastReadAt !== null);
    const otherRead = allOpened
      ? others.reduce<Date>(
          (earliest, m) =>
            (m.lastReadAt as Date) < earliest
              ? (m.lastReadAt as Date)
              : earliest,
          others[0].lastReadAt as Date,
        )
      : null;

    const rows = await this.prisma.message.findMany({
      where: { conversationId, deletedAt: null },
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      take: limit + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
      select: {
        id: true,
        body: true,
        senderId: true,
        createdAt: true,
        media: { select: this.mediaShape, orderBy: { position: 'asc' } },
      },
    });

    const page = rows.slice(0, limit);
    const items: MessageItem[] = page.map((row) => ({
      ...row,
      seen:
        row.senderId === viewerId &&
        otherRead !== null &&
        row.createdAt <= otherRead,
    }));

    return {
      items,
      nextCursor: rows.length > limit ? page[page.length - 1].id : null,
      people: conversation.members
        .filter((m) => m.userId !== viewerId)
        .map((m) => this.toPerson(m.user)),
      // So the thread's menu can offer Mute or Unmute rather than both, which
      // is a menu that cannot say which state the reader is already in.
      muted:
        conversation.members.find((m) => m.userId === viewerId)?.mutedAt !=
        null,
    };
  }

  /** Says something. */
  async send(
    viewerId: string,
    conversationId: string,
    body: string,
    media: MessageMediaInput[] = [],
  ) {
    const text = body.trim();
    // A picture with no words is a message; an empty box is not.
    if (!text && media.length === 0) {
      throw new BadRequestException('A message needs something in it.');
    }
    if (media.length > MessagesService.maxMedia) {
      throw new BadRequestException(
        `A message can carry at most ${MessagesService.maxMedia} attachments.`,
      );
    }
    if (text.length > MessagesService.maxBody) {
      throw new BadRequestException(
        `A message cannot exceed ${MessagesService.maxBody} characters.`,
      );
    }

    const conversation = await this.requireMembership(viewerId, conversationId);
    for (const member of conversation.members) {
      if (member.userId !== viewerId) {
        await this.requireNoBlock(viewerId, member.userId);
      }
    }

    const [message] = await this.prisma.$transaction([
      this.prisma.message.create({
        data: {
          conversationId,
          senderId: viewerId,
          body: text,
          ...(media.length > 0
            ? {
                media: {
                  create: media.map((item, index) => ({
                    kind: item.kind ?? MediaKind.IMAGE,
                    url: item.url,
                    width: item.width ?? null,
                    height: item.height ?? null,
                    alt: item.alt ?? null,
                    durationMs: item.durationMs ?? null,
                    waveform: item.waveform ?? [],
                    thumbnailUrl: item.thumbnailUrl ?? null,
                    position: index,
                  })),
                },
              }
            : {}),
        },
        select: {
          id: true,
          body: true,
          senderId: true,
          createdAt: true,
          media: { select: this.mediaShape, orderBy: { position: 'asc' } },
        },
      }),
      this.prisma.conversation.update({
        where: { id: conversationId },
        data: { lastMessageAt: new Date() },
      }),
      // Sending is reading: the sender is looking at the thread.
      this.prisma.conversationMember.updateMany({
        where: { conversationId, userId: viewerId },
        data: { lastReadAt: new Date(), hiddenAt: null },
      }),
      // A thread the other side had removed comes back when somebody writes
      // in it. Otherwise a reply lands somewhere they cannot see.
      this.prisma.conversationMember.updateMany({
        where: { conversationId, userId: { not: viewerId } },
        data: { hiddenAt: null },
      }),
    ]);

    return { ...message, seen: false };
  }

  /** What a message's attachments look like on the wire. */
  private get mediaShape() {
    return {
      id: true,
      kind: true,
      url: true,
      width: true,
      height: true,
      alt: true,
      durationMs: true,
      waveform: true,
      thumbnailUrl: true,
    } as const;
  }

  /** Marks everything in a conversation as read. */
  async markRead(viewerId: string, conversationId: string) {
    await this.requireMembership(viewerId, conversationId);
    await this.prisma.conversationMember.updateMany({
      where: { conversationId, userId: viewerId },
      data: { lastReadAt: new Date() },
    });
    return { ok: true };
  }

  /**
   * Takes a conversation out of the reader's list.
   *
   * Their own row only. The messages are the other side's history too, and
   * deleting them would be deciding that for both people.
   */
  async hide(viewerId: string, conversationId: string) {
    await this.requireMembership(viewerId, conversationId);
    await this.prisma.conversationMember.updateMany({
      where: { conversationId, userId: viewerId },
      data: { hiddenAt: new Date() },
    });
    return { ok: true };
  }

  /** Removes one of the reader's own messages. */
  async remove(viewerId: string, messageId: string) {
    const message = await this.prisma.message.findFirst({
      where: { id: messageId, deletedAt: null },
      select: { id: true, senderId: true, conversationId: true },
    });
    if (!message) throw new NotFoundException('That message is already gone.');
    if (message.senderId !== viewerId) {
      throw new ForbiddenException('That is not your message.');
    }
    await this.prisma.message.update({
      where: { id: messageId },
      data: { deletedAt: new Date() },
    });
    return { ok: true };
  }

  private toPerson(user: {
    id: string;
    name: string | null;
    username: string | null;
    profile: { avatarUrl: string | null } | null;
  }): MessagePerson {
    return {
      id: user.id,
      name: user.name,
      username: user.username,
      avatarUrl: user.profile?.avatarUrl ?? null,
    };
  }

  /**
   * The conversation, if the reader is in it.
   *
   * Not found rather than forbidden for one they are not in: whether a given
   * id names a real conversation is not something a stranger should learn.
   */
  private async requireMembership(viewerId: string, conversationId: string) {
    const conversation = await this.prisma.conversation.findFirst({
      where: { id: conversationId, members: { some: { userId: viewerId } } },
      select: {
        id: true,
        members: {
          select: {
            userId: true,
            lastReadAt: true,
            mutedAt: true,
            user: { select: this.personShape },
          },
        },
      },
    });
    if (!conversation) {
      throw new NotFoundException('That conversation does not exist.');
    }
    return conversation;
  }

  /** Blocking closes a conversation in both directions. */
  /**
   * Silences a conversation, or unsilences it.
   *
   * The reader's own setting: muting somebody is not something they should be
   * able to see or undo, so it lives on the membership rather than the thread.
   */
  async setMuted(
    viewerId: string,
    conversationId: string,
    muted: boolean,
  ): Promise<{ id: string; muted: boolean }> {
    await this.requireMembership(viewerId, conversationId);
    await this.prisma.conversationMember.updateMany({
      where: { conversationId, userId: viewerId },
      data: { mutedAt: muted ? new Date() : null },
    });
    return { id: conversationId, muted };
  }

  /**
   * Blocks the other person in a conversation, and hides it.
   *
   * One call rather than two, because blocking somebody you are talking to and
   * leaving the thread in your list is not a state anybody wants: the block
   * stops the messages and this takes the thread out of the way with it.
   */
  async blockOther(
    viewerId: string,
    conversationId: string,
  ): Promise<{ ok: true; blockedId: string }> {
    const conversation = await this.requireMembership(viewerId, conversationId);
    const other = conversation.members.find((m) => m.userId !== viewerId);
    if (!other) {
      throw new BadRequestException('There is nobody else in this thread.');
    }

    await this.prisma.$transaction([
      this.prisma.block.upsert({
        where: {
          blockerId_blockedId: {
            blockerId: viewerId,
            blockedId: other.userId,
          },
        },
        create: { blockerId: viewerId, blockedId: other.userId },
        update: {},
      }),
      this.prisma.conversationMember.updateMany({
        where: { conversationId, userId: viewerId },
        data: { hiddenAt: new Date() },
      }),
    ]);

    return { ok: true, blockedId: other.userId };
  }

  private async requireNoBlock(viewerId: string, otherId: string) {
    const block = await this.prisma.block.findFirst({
      where: {
        OR: [
          { blockerId: viewerId, blockedId: otherId },
          { blockerId: otherId, blockedId: viewerId },
        ] as Prisma.BlockWhereInput[],
      },
      select: { blockerId: true },
    });
    if (!block) return;
    throw new ForbiddenException(
      block.blockerId === viewerId
        ? 'You have blocked this account.'
        : 'You cannot message this account.',
    );
  }
}
