import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CommunityChatWriters, CommunityRole, Prisma } from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { MessagesService } from '../messages/messages.service';
import { DeliveryService } from '../push/delivery.service';

/** A community chat, as the community's list and the chat's header need it. */
export interface CommunityChatSummary {
  id: string;
  community: {
    id: string;
    slug: string;
    name: string;
    avatarUrl: string | null;
  };
  name: string;
  description: string | null;
  writers: CommunityChatWriters;
  slowModeSeconds: number;
  position: number;
  /** How many people have joined it. */
  joinedCount: number;
  /** The reader has joined it. */
  joined: boolean;
  /** The reader may write in it now: joined, and allowed by [writers]. */
  canWrite: boolean;
  /** The reader runs it: the community's owner or one of its moderators. */
  canModerate: boolean;
  /** The reader's place in the community, so the app offers only what the
   * server would allow -- an owner may take down a moderator's message, a
   * moderator may not. */
  role: CommunityRole;
  /** Messages from other people since the reader last read it. 0 when they
   * have not joined it. */
  unread: number;
  lastMessageAt: Date | null;
  createdAt: Date;
}

/** Somebody who wrote in a community chat. */
export interface CommunityChatPerson {
  id: string;
  name: string | null;
  username: string | null;
  avatarUrl: string | null;
  verified: boolean;
  /** Their place in the community now; null once they have left it. */
  role: CommunityRole | null;
}

/** One message in a community chat. */
export interface CommunityChatMessageItem {
  id: string;
  chatId: string;
  body: string;
  sender: CommunityChatPerson;
  /** What it answers. `unavailable` when that message is gone, or written by
   * somebody the reader cannot see. */
  replyTo:
    | {
        id: string;
        unavailable: false;
        senderName: string | null;
        body: string;
      }
    | { id: string; unavailable: true }
    | null;
  /** Each emoji and how many reacted with it, most first. Counts, not
   * names: in a room of strangers, who reacted is not the reader's to list. */
  reactions: { emoji: string; count: number }[];
  /** The reader's own reaction, if any. */
  mine: string | null;
  createdAt: Date;
}

/** A chat with its pinned message, for the chat's own screen. */
export interface CommunityChatDetail extends CommunityChatSummary {
  pinned: CommunityChatMessageItem | null;
}

/** One of the reader's joined chats, across all their communities. */
export interface JoinedCommunityChat extends CommunityChatSummary {
  lastMessage: {
    senderName: string | null;
    body: string;
    mine: boolean;
  } | null;
}

const PAGE = 40;

/** How much of a quoted message rides along with a reply. */
const QUOTE_LENGTH = 160;

/**
 * Chat rooms inside a community. A community can have several.
 *
 * Not end-to-end encrypted -- see the CommunityChat model -- so the rules that
 * keep it to the right people are all here, and all are checked against the
 * database on every call: being in the community decides whether a chat can
 * be read at all, so somebody removed from it is out on their next request,
 * not when some copy of their membership expires. Nothing here touches the
 * direct-message tables.
 */
@Injectable()
export class CommunityChatsService {
  private readonly logger = new Logger(CommunityChatsService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly delivery: DeliveryService,
  ) {}

  static readonly maxChats = 20;
  static readonly maxName = 40;
  static readonly maxDescription = 200;
  static readonly maxBody = 2000;

  /** The most messages one person may send in one chat in [burstWindowMs]. */
  static readonly burst = 5;
  static readonly burstWindowMs = 10_000;

  /** The longest slow mode a moderator can set: an hour between messages. */
  static readonly maxSlowModeSeconds = 3600;

  // ---- Reading -------------------------------------------------------------

  /** A community's chats, for its members. */
  async list(
    viewerId: string,
    slug: string,
  ): Promise<{ items: CommunityChatSummary[] }> {
    const community = await this.community(slug);
    const role = await this.requireMember(viewerId, community.id);
    const chats = await this.prisma.communityChat.findMany({
      where: { communityId: community.id, deletedAt: null },
      orderBy: [{ position: 'asc' }, { createdAt: 'asc' }],
      select: this.chatShape(viewerId),
    });
    return {
      items: await Promise.all(
        chats.map((chat) => this.summarize(viewerId, chat, community, role)),
      ),
    };
  }

  /** One chat, with its pinned message. */
  async get(viewerId: string, chatId: string): Promise<CommunityChatDetail> {
    const { chat, role } = await this.access(viewerId, chatId);
    const row = await this.prisma.communityChat.findUniqueOrThrow({
      where: { id: chat.id },
      select: this.chatShape(viewerId),
    });
    const summary = await this.summarize(viewerId, row, chat.community, role);
    const blocked = await this.blockedWith(viewerId);
    const pinned =
      row.pinnedMessageId === null
        ? []
        : await this.items(
            viewerId,
            {
              id: row.pinnedMessageId,
              chatId: chat.id,
              deletedAt: null,
              // Pinned or not, somebody the reader cannot see stays unseen.
              ...(blocked.size > 0
                ? { senderId: { notIn: [...blocked] } }
                : {}),
            },
            blocked,
            1,
          );
    return { ...summary, pinned: pinned[0] ?? null };
  }

  /** A page of a chat's messages, newest first. */
  async messages(
    viewerId: string,
    chatId: string,
    { limit = PAGE, cursor }: { limit?: number; cursor?: string } = {},
  ): Promise<{ items: CommunityChatMessageItem[]; nextCursor: string | null }> {
    const { chat } = await this.access(viewerId, chatId);
    const blocked = await this.blockedWith(viewerId);
    const take = Math.min(Math.max(limit, 1), 100);
    const where: Prisma.CommunityChatMessageWhereInput = {
      chatId: chat.id,
      deletedAt: null,
      ...(blocked.size > 0 ? { senderId: { notIn: [...blocked] } } : {}),
    };
    const rows = await this.items(viewerId, where, blocked, take + 1, cursor);
    const page = rows.slice(0, take);
    return {
      items: page,
      nextCursor: rows.length > take ? page[page.length - 1].id : null,
    };
  }

  /** Every chat the reader has joined, in communities they are still in. */
  async joined(viewerId: string): Promise<{ items: JoinedCommunityChat[] }> {
    const memberships = await this.prisma.communityChatMember.findMany({
      where: {
        userId: viewerId,
        chat: {
          deletedAt: null,
          community: {
            deletedAt: null,
            // Joined once, and since removed from the community: not theirs
            // to read any more, whatever this row still says.
            members: { some: { userId: viewerId } },
          },
        },
      },
      select: {
        chat: {
          select: {
            ...this.chatShape(viewerId),
            community: {
              select: {
                id: true,
                slug: true,
                name: true,
                avatarUrl: true,
                members: {
                  where: { userId: viewerId },
                  select: { role: true },
                },
              },
            },
          },
        },
      },
      take: 100,
    });
    const blocked = await this.blockedWith(viewerId);

    const items = await Promise.all(
      memberships.map(async ({ chat }) => {
        const role = chat.community.members[0]?.role ?? CommunityRole.MEMBER;
        const summary = await this.summarize(
          viewerId,
          chat,
          chat.community,
          role,
        );
        const last = await this.prisma.communityChatMessage.findFirst({
          where: {
            chatId: chat.id,
            deletedAt: null,
            ...(blocked.size > 0 ? { senderId: { notIn: [...blocked] } } : {}),
          },
          orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
          select: {
            body: true,
            senderId: true,
            sender: { select: { name: true, username: true } },
          },
        });
        return {
          ...summary,
          lastMessage: last
            ? {
                senderName: last.sender.name ?? last.sender.username,
                body: last.body.slice(0, QUOTE_LENGTH),
                mine: last.senderId === viewerId,
              }
            : null,
        };
      }),
    );
    items.sort(
      (a, b) =>
        (b.lastMessageAt ?? b.createdAt).getTime() -
        (a.lastMessageAt ?? a.createdAt).getTime(),
    );
    return { items };
  }

  // ---- Running chats -------------------------------------------------------

  /** Opens a chat in a community. Its owner and moderators only. */
  async create(
    viewerId: string,
    slug: string,
    input: {
      name: string;
      description?: string;
      writers?: CommunityChatWriters;
    },
  ): Promise<CommunityChatSummary> {
    const community = await this.community(slug);
    const role = await this.requireModerator(viewerId, community.id);
    const name = CommunityChatsService.chatName(input.name);
    const description = CommunityChatsService.description(input.description);

    const chat = await this.prisma.$transaction(async (tx) => {
      await CommunityChatsService.takeTurns(tx, `chats:${community.id}`);
      const live = await tx.communityChat.findMany({
        where: { communityId: community.id, deletedAt: null },
        select: { name: true, position: true },
      });
      if (live.length >= CommunityChatsService.maxChats) {
        throw new ForbiddenException(
          `A community can have at most ${CommunityChatsService.maxChats} chats.`,
        );
      }
      if (live.some((c) => c.name.toLowerCase() === name.toLowerCase())) {
        throw new ConflictException(
          'This community already has a chat by that name.',
        );
      }
      return tx.communityChat.create({
        data: {
          communityId: community.id,
          name,
          description,
          writers: input.writers ?? CommunityChatWriters.MEMBERS,
          position: Math.max(-1, ...live.map((c) => c.position)) + 1,
          createdById: viewerId,
          // Whoever opens it is in it.
          members: { create: { userId: viewerId, lastReadAt: new Date() } },
        },
        select: this.chatShape(viewerId),
      });
    });
    this.logger.log(
      `chat ${chat.id} opened in ${community.slug} by ${viewerId}`,
    );
    return this.summarize(viewerId, chat, community, role);
  }

  /** Renames a chat, or changes who may write in it, how often, or where it
   * sits. Its community's owner and moderators only. */
  async update(
    viewerId: string,
    chatId: string,
    patch: {
      name?: string;
      description?: string | null;
      writers?: CommunityChatWriters;
      slowModeSeconds?: number;
      position?: number;
    },
  ): Promise<CommunityChatDetail> {
    const { chat } = await this.access(viewerId, chatId);
    await this.requireModerator(viewerId, chat.community.id);

    const data: Prisma.CommunityChatUpdateInput = {};
    const name =
      patch.name === undefined
        ? undefined
        : CommunityChatsService.chatName(patch.name);
    if (name !== undefined) data.name = name;
    if (patch.description !== undefined) {
      data.description = CommunityChatsService.description(patch.description);
    }
    if (patch.writers !== undefined) data.writers = patch.writers;
    if (patch.slowModeSeconds !== undefined) {
      const seconds = patch.slowModeSeconds;
      if (
        !Number.isInteger(seconds) ||
        seconds < 0 ||
        seconds > CommunityChatsService.maxSlowModeSeconds
      ) {
        throw new BadRequestException(
          'Slow mode is between 0 seconds and an hour.',
        );
      }
      data.slowModeSeconds = seconds;
    }
    if (patch.position !== undefined) data.position = patch.position;

    await this.prisma.$transaction(async (tx) => {
      if (name !== undefined) {
        await CommunityChatsService.takeTurns(tx, `chats:${chat.community.id}`);
        const clash = await tx.communityChat.findFirst({
          where: {
            communityId: chat.community.id,
            deletedAt: null,
            id: { not: chat.id },
            name: { equals: name, mode: 'insensitive' },
          },
          select: { id: true },
        });
        if (clash) {
          throw new ConflictException(
            'This community already has a chat by that name.',
          );
        }
      }
      await tx.communityChat.update({ where: { id: chat.id }, data });
    });
    await this.tellChat(chat.id, {
      type: 'community.chat.updated',
      chatId: chat.id,
    });
    return this.get(viewerId, chat.id);
  }

  /**
   * Closes a chat. Its messages stay, shown to nobody, so a report already
   * made about one of them can still be reviewed.
   */
  async remove(viewerId: string, chatId: string): Promise<{ ok: true }> {
    const { chat } = await this.access(viewerId, chatId);
    await this.requireModerator(viewerId, chat.community.id);
    await this.prisma.communityChat.update({
      where: { id: chat.id },
      data: { deletedAt: new Date(), pinnedMessageId: null },
    });
    await this.tellChat(chat.id, {
      type: 'community.chat.updated',
      chatId: chat.id,
    });
    this.logger.log(`chat ${chat.id} closed by ${viewerId}`);
    return { ok: true };
  }

  /** Holds one message at the top of a chat, or lets it go. */
  async pin(
    viewerId: string,
    chatId: string,
    messageId: string | null,
  ): Promise<CommunityChatDetail> {
    const { chat } = await this.access(viewerId, chatId);
    await this.requireModerator(viewerId, chat.community.id);
    if (messageId !== null) {
      await this.liveMessage(chat.id, messageId);
    }
    await this.prisma.communityChat.update({
      where: { id: chat.id },
      data: { pinnedMessageId: messageId },
    });
    await this.tellChat(chat.id, {
      type: 'community.chat.updated',
      chatId: chat.id,
    });
    return this.get(viewerId, chat.id);
  }

  // ---- Taking part ---------------------------------------------------------

  /** Joins a chat: it goes in the reader's list, and they may write in it. */
  async join(viewerId: string, chatId: string): Promise<CommunityChatDetail> {
    const { chat } = await this.access(viewerId, chatId);
    await this.prisma.communityChatMember.upsert({
      where: { chatId_userId: { chatId: chat.id, userId: viewerId } },
      // Read up to now: joining is not a backlog of "unread".
      create: { chatId: chat.id, userId: viewerId, lastReadAt: new Date() },
      update: {},
    });
    return this.get(viewerId, chat.id);
  }

  /** Leaves a chat. Being in the community still lets them read it. */
  async leave(viewerId: string, chatId: string): Promise<{ ok: true }> {
    await this.prisma.communityChatMember.deleteMany({
      where: { chatId, userId: viewerId },
    });
    return { ok: true };
  }

  async markRead(viewerId: string, chatId: string): Promise<{ ok: true }> {
    const { chat } = await this.access(viewerId, chatId);
    await this.prisma.communityChatMember.updateMany({
      where: { chatId: chat.id, userId: viewerId },
      data: { lastReadAt: new Date() },
    });
    return { ok: true };
  }

  /** Says something in a chat. */
  async send(
    viewerId: string,
    chatId: string,
    input: { body: string; replyToId?: string },
    now: Date = new Date(),
  ): Promise<CommunityChatMessageItem> {
    const { chat, role } = await this.access(viewerId, chatId);
    const moderator = CommunityChatsService.moderates(role);

    const joined = await this.prisma.communityChatMember.findUnique({
      where: { chatId_userId: { chatId: chat.id, userId: viewerId } },
      select: { userId: true },
    });
    if (!joined) {
      throw new ForbiddenException('Join this chat to write in it.');
    }
    if (chat.writers === CommunityChatWriters.MODERATORS && !moderator) {
      throw new ForbiddenException('Only moderators can write in this chat.');
    }

    const body = CommunityChatsService.body(input.body);

    if (input.replyToId) {
      const answered = await this.prisma.communityChatMessage.findFirst({
        where: { id: input.replyToId, chatId: chat.id, deletedAt: null },
        select: { id: true },
      });
      if (!answered) {
        throw new BadRequestException(
          'That message is no longer here to reply to.',
        );
      }
    }

    const message = await this.prisma.$transaction(async (tx) => {
      // Requests sent side by side take turns here, so each one counts the
      // messages before it. Otherwise fifty at once would each find none.
      await CommunityChatsService.takeTurns(tx, `send:${chat.id}:${viewerId}`);
      await CommunityChatsService.throttle(tx, viewerId, chat, moderator, now);
      const made = await tx.communityChatMessage.create({
        data: {
          chatId: chat.id,
          senderId: viewerId,
          body,
          replyToId: input.replyToId ?? null,
          createdAt: now,
        },
        select: { id: true },
      });
      await tx.communityChat.update({
        where: { id: chat.id },
        data: { lastMessageAt: now },
      });
      // Their own message is not unread to them.
      await tx.communityChatMember.updateMany({
        where: { chatId: chat.id, userId: viewerId },
        data: { lastReadAt: now },
      });
      return made;
    });

    await this.tellChat(chat.id, {
      type: 'community.chat.message',
      chatId: chat.id,
      messageId: message.id,
    });
    const [item] = await this.items(
      viewerId,
      { id: message.id },
      new Set<string>(),
      1,
    );
    return item;
  }

  /**
   * Takes a message down.
   *
   * By its author, who also empties it: it was theirs to say and is theirs to
   * unsay. Or by the community's owner or a moderator, who keep its words
   * for review -- a moderator only over members' messages, as with removing
   * people; the owner over anybody's.
   */
  async deleteMessage(
    viewerId: string,
    chatId: string,
    messageId: string,
  ): Promise<{ ok: true }> {
    const { chat, role } = await this.access(viewerId, chatId);
    const message = await this.liveMessage(chat.id, messageId);
    const own = message.senderId === viewerId;

    if (!own) {
      if (!CommunityChatsService.moderates(role)) {
        throw new ForbiddenException('You can only delete your own messages.');
      }
      if (role !== CommunityRole.OWNER) {
        const author = await this.prisma.communityMember.findUnique({
          where: {
            communityId_userId: {
              communityId: chat.community.id,
              userId: message.senderId,
            },
          },
          select: { role: true },
        });
        if (author && author.role !== CommunityRole.MEMBER) {
          throw new ForbiddenException(
            "Only the owner can delete a moderator's messages.",
          );
        }
      }
    }

    await this.prisma.$transaction([
      this.prisma.communityChatMessage.update({
        where: { id: message.id },
        data: {
          deletedAt: new Date(),
          deletedById: viewerId,
          ...(own ? { body: '' } : {}),
        },
      }),
      this.prisma.communityChat.updateMany({
        where: { id: chat.id, pinnedMessageId: message.id },
        data: { pinnedMessageId: null },
      }),
    ]);
    await this.tellChat(chat.id, {
      type: 'community.chat.message.deleted',
      chatId: chat.id,
      messageId: message.id,
    });
    return { ok: true };
  }

  /** Reacts to a message, in place of the reader's earlier reaction. Anyone
   * in the community may: a spectator can react without joining. */
  async react(
    viewerId: string,
    chatId: string,
    messageId: string,
    emoji: string,
  ): Promise<{ ok: true }> {
    const { chat } = await this.access(viewerId, chatId);
    if (!MessagesService.isReactionEmoji(emoji)) {
      throw new BadRequestException('A reaction is a single emoji.');
    }
    const message = await this.liveMessage(chat.id, messageId);
    // A message the reader cannot see is not one they can react to.
    if ((await this.blockedWith(viewerId)).has(message.senderId)) {
      throw new NotFoundException('That message is no longer here.');
    }
    await this.prisma.communityChatReaction.upsert({
      where: { messageId_userId: { messageId: message.id, userId: viewerId } },
      create: { messageId: message.id, userId: viewerId, emoji },
      update: { emoji },
    });
    await this.tellChat(chat.id, {
      type: 'community.chat.reaction',
      chatId: chat.id,
      messageId: message.id,
    });
    return { ok: true };
  }

  async unreact(
    viewerId: string,
    chatId: string,
    messageId: string,
  ): Promise<{ ok: true }> {
    const { chat } = await this.access(viewerId, chatId);
    const { count } = await this.prisma.communityChatReaction.deleteMany({
      where: { messageId, userId: viewerId, message: { chatId: chat.id } },
    });
    if (count > 0) {
      await this.tellChat(chat.id, {
        type: 'community.chat.reaction',
        chatId: chat.id,
        messageId,
      });
    }
    return { ok: true };
  }

  // ---- What the community module calls --------------------------------------

  /**
   * Takes somebody out of every chat in a community, when they leave it or
   * are removed from it. Reading is already refused by then -- that is
   * decided by the community membership -- but this keeps the "joined"
   * counts honest and their list clear.
   */
  static leaveAllIn(
    tx: Prisma.TransactionClient | PrismaService,
    communityId: string,
    userId: string,
  ) {
    return tx.communityChatMember.deleteMany({
      where: { userId, chat: { communityId } },
    });
  }

  // ---- Rules -----------------------------------------------------------------

  /** A chat's name: trimmed, single-spaced, not empty, not too long. */
  static chatName(raw: string): string {
    const name = (raw ?? '').trim().replace(/\s+/g, ' ');
    if (!name) throw new BadRequestException('A chat needs a name.');
    if (name.length > CommunityChatsService.maxName) {
      throw new BadRequestException(
        `A chat's name can be at most ${CommunityChatsService.maxName} characters.`,
      );
    }
    return name;
  }

  static description(raw: string | null | undefined): string | null {
    const description = raw?.trim() ?? '';
    if (description.length > CommunityChatsService.maxDescription) {
      throw new BadRequestException(
        `A description can be at most ${CommunityChatsService.maxDescription} characters.`,
      );
    }
    return description || null;
  }

  /** A message's words: trimmed, not empty, not too long. */
  static body(raw: string): string {
    const body = (raw ?? '').trim();
    if (!body) throw new BadRequestException('Write something first.');
    if (body.length > CommunityChatsService.maxBody) {
      throw new BadRequestException(
        `A message can be at most ${CommunityChatsService.maxBody} characters.`,
      );
    }
    return body;
  }

  static moderates(role: CommunityRole | null): boolean {
    return role === CommunityRole.OWNER || role === CommunityRole.MODERATOR;
  }

  /**
   * Refuses a message sent too soon: more than [burst] in [burstWindowMs]
   * from anybody, or inside the chat's slow mode from anybody who is not a
   * moderator. Counted from the messages themselves, so it holds across every
   * instance of the API without a store of its own.
   */
  /**
   * Holds [key] until the transaction ends. A check followed by a write --
   * how many chats a community has, how fast somebody is sending -- is only
   * a limit if two requests cannot both pass the check before either writes.
   * Transaction-scoped, so it is let go however the transaction ends, and
   * safe behind a transaction-mode pooler.
   */
  private static async takeTurns(
    tx: Prisma.TransactionClient,
    key: string,
  ): Promise<void> {
    await tx.$executeRaw`SELECT pg_advisory_xact_lock(hashtextextended(${`community-chat:${key}`}, 0))`;
  }

  private static async throttle(
    tx: Prisma.TransactionClient,
    viewerId: string,
    chat: { id: string; slowModeSeconds: number },
    moderator: boolean,
    now: Date,
  ): Promise<void> {
    const recent = await tx.communityChatMessage.findMany({
      where: {
        chatId: chat.id,
        senderId: viewerId,
        createdAt: {
          gt: new Date(now.getTime() - CommunityChatsService.burstWindowMs),
        },
      },
      select: { id: true },
      take: CommunityChatsService.burst,
    });
    if (recent.length >= CommunityChatsService.burst) {
      throw new HttpException(
        'You are sending messages too quickly. Wait a few seconds.',
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }
    if (moderator || chat.slowModeSeconds <= 0) return;
    const last = await tx.communityChatMessage.findFirst({
      where: { chatId: chat.id, senderId: viewerId },
      orderBy: { createdAt: 'desc' },
      select: { createdAt: true },
    });
    if (!last) return;
    const wait = Math.ceil(
      (last.createdAt.getTime() + chat.slowModeSeconds * 1000 - now.getTime()) /
        1000,
    );
    if (wait > 0) {
      throw new HttpException(
        `Slow mode is on. You can send again in ${wait} seconds.`,
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }
  }

  // ---- Access ----------------------------------------------------------------

  private async community(slug: string): Promise<{
    id: string;
    slug: string;
    name: string;
    avatarUrl: string | null;
  }> {
    const community = await this.prisma.community.findFirst({
      where: { slug: slug.trim().toLowerCase(), deletedAt: null },
      select: { id: true, slug: true, name: true, avatarUrl: true },
    });
    if (!community)
      throw new NotFoundException('That community does not exist.');
    return community;
  }

  /** The reader's role in a community, or refused if they are not in it. */
  private async requireMember(
    viewerId: string,
    communityId: string,
  ): Promise<CommunityRole> {
    const member = await this.prisma.communityMember.findUnique({
      where: { communityId_userId: { communityId, userId: viewerId } },
      select: { role: true },
    });
    if (!member) {
      throw new ForbiddenException('Join this community to see its chats.');
    }
    return member.role;
  }

  private async requireModerator(
    viewerId: string,
    communityId: string,
  ): Promise<CommunityRole> {
    const role = await this.requireMember(viewerId, communityId);
    if (!CommunityChatsService.moderates(role)) {
      throw new ForbiddenException(
        'Only the owner and moderators can do that.',
      );
    }
    return role;
  }

  /**
   * The chat, if it is open, its community is open, and the reader is in
   * that community. Every route but leaving goes through here.
   */
  private async access(
    viewerId: string,
    chatId: string,
  ): Promise<{
    chat: {
      id: string;
      writers: CommunityChatWriters;
      slowModeSeconds: number;
      community: {
        id: string;
        slug: string;
        name: string;
        avatarUrl: string | null;
      };
    };
    role: CommunityRole;
  }> {
    const chat = await this.prisma.communityChat.findFirst({
      where: { id: chatId, deletedAt: null, community: { deletedAt: null } },
      select: {
        id: true,
        writers: true,
        slowModeSeconds: true,
        community: {
          select: { id: true, slug: true, name: true, avatarUrl: true },
        },
      },
    });
    if (!chat) throw new NotFoundException('That chat does not exist.');
    const role = await this.requireMember(viewerId, chat.community.id);
    return { chat, role };
  }

  private async liveMessage(
    chatId: string,
    messageId: string,
  ): Promise<{ id: string; senderId: string }> {
    const message = await this.prisma.communityChatMessage.findFirst({
      where: { id: messageId, chatId, deletedAt: null },
      select: { id: true, senderId: true },
    });
    if (!message)
      throw new NotFoundException('That message is no longer here.');
    return message;
  }

  /** Everybody the reader has blocked or been blocked by. Their messages are
   * not shown, either way round. */
  private async blockedWith(viewerId: string): Promise<Set<string>> {
    const rows = await this.prisma.block.findMany({
      where: { OR: [{ blockerId: viewerId }, { blockedId: viewerId }] },
      select: { blockerId: true, blockedId: true },
    });
    return new Set(
      rows.map((r) => (r.blockerId === viewerId ? r.blockedId : r.blockerId)),
    );
  }

  /**
   * Tells everyone who has joined a chat -- and is still in its community --
   * that something in it changed. Ids only; no push: a busy room is not
   * worth a buzz per message.
   */
  private async tellChat(
    chatId: string,
    event:
      | { type: 'community.chat.updated'; chatId: string }
      | {
          type:
            | 'community.chat.message'
            | 'community.chat.message.deleted'
            | 'community.chat.reaction';
          chatId: string;
          messageId: string;
        },
  ): Promise<void> {
    const rows = await this.prisma.communityChatMember.findMany({
      where: {
        chatId,
        user: {
          communities: {
            some: { community: { chats: { some: { id: chatId } } } },
          },
        },
      },
      select: { userId: true },
    });
    if (rows.length === 0) return;
    this.delivery.tellMany(
      rows.map((r) => r.userId),
      event,
    );
  }

  // ---- Shaping ---------------------------------------------------------------

  private chatShape(viewerId: string) {
    return {
      id: true,
      name: true,
      description: true,
      writers: true,
      slowModeSeconds: true,
      position: true,
      pinnedMessageId: true,
      lastMessageAt: true,
      createdAt: true,
      _count: { select: { members: true } },
      members: {
        where: { userId: viewerId },
        select: { joinedAt: true, lastReadAt: true },
      },
    } as const;
  }

  private async summarize(
    viewerId: string,
    chat: {
      id: string;
      name: string;
      description: string | null;
      writers: CommunityChatWriters;
      slowModeSeconds: number;
      position: number;
      lastMessageAt: Date | null;
      createdAt: Date;
      _count: { members: number };
      members: { joinedAt: Date; lastReadAt: Date | null }[];
    },
    community: {
      id: string;
      slug: string;
      name: string;
      avatarUrl: string | null;
    },
    role: CommunityRole,
  ): Promise<CommunityChatSummary> {
    const membership = chat.members[0];
    const moderator = CommunityChatsService.moderates(role);
    const unread = membership
      ? await this.prisma.communityChatMessage.count({
          where: {
            chatId: chat.id,
            deletedAt: null,
            senderId: { not: viewerId },
            createdAt: { gt: membership.lastReadAt ?? membership.joinedAt },
          },
        })
      : 0;
    return {
      id: chat.id,
      community: {
        id: community.id,
        slug: community.slug,
        name: community.name,
        avatarUrl: community.avatarUrl,
      },
      name: chat.name,
      description: chat.description,
      writers: chat.writers,
      slowModeSeconds: chat.slowModeSeconds,
      position: chat.position,
      joinedCount: chat._count.members,
      joined: Boolean(membership),
      canWrite:
        Boolean(membership) &&
        (chat.writers === CommunityChatWriters.MEMBERS || moderator),
      canModerate: moderator,
      role,
      unread,
      lastMessageAt: chat.lastMessageAt,
      createdAt: chat.createdAt,
    };
  }

  /** Messages matching [where], shaped for the reader. */
  private async items(
    viewerId: string,
    where: Prisma.CommunityChatMessageWhereInput,
    blocked: Set<string>,
    take: number,
    cursor?: string,
  ): Promise<CommunityChatMessageItem[]> {
    const rows = await this.prisma.communityChatMessage.findMany({
      where,
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      take,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
      select: {
        id: true,
        chatId: true,
        body: true,
        createdAt: true,
        senderId: true,
        sender: {
          select: {
            id: true,
            name: true,
            username: true,
            verifiedAt: true,
            profile: { select: { avatarUrl: true } },
          },
        },
        chat: { select: { communityId: true } },
        replyTo: {
          select: {
            id: true,
            body: true,
            deletedAt: true,
            senderId: true,
            sender: { select: { name: true, username: true } },
          },
        },
      },
    });
    if (rows.length === 0) return [];

    const ids = rows.map((r) => r.id);
    const [counts, mine, roles] = await Promise.all([
      this.prisma.communityChatReaction.groupBy({
        by: ['messageId', 'emoji'],
        where: { messageId: { in: ids } },
        _count: { _all: true },
      }),
      this.prisma.communityChatReaction.findMany({
        where: { messageId: { in: ids }, userId: viewerId },
        select: { messageId: true, emoji: true },
      }),
      this.prisma.communityMember.findMany({
        where: {
          communityId: rows[0].chat.communityId,
          userId: { in: [...new Set(rows.map((r) => r.senderId))] },
        },
        select: { userId: true, role: true },
      }),
    ]);
    const roleOf = new Map(roles.map((r) => [r.userId, r.role]));
    const mineOf = new Map(mine.map((r) => [r.messageId, r.emoji]));
    const reactionsOf = new Map<string, { emoji: string; count: number }[]>();
    for (const row of counts) {
      const list = reactionsOf.get(row.messageId) ?? [];
      list.push({ emoji: row.emoji, count: row._count._all });
      reactionsOf.set(row.messageId, list);
    }

    return rows.map((row) => {
      const reply = row.replyTo;
      return {
        id: row.id,
        chatId: row.chatId,
        body: row.body,
        sender: {
          id: row.sender.id,
          name: row.sender.name,
          username: row.sender.username,
          avatarUrl: row.sender.profile?.avatarUrl ?? null,
          verified: Boolean(row.sender.verifiedAt),
          role: roleOf.get(row.senderId) ?? null,
        },
        replyTo: !reply
          ? null
          : reply.deletedAt !== null || blocked.has(reply.senderId)
            ? { id: reply.id, unavailable: true as const }
            : {
                id: reply.id,
                unavailable: false as const,
                senderName: reply.sender.name ?? reply.sender.username,
                body: reply.body.slice(0, QUOTE_LENGTH),
              },
        reactions: (reactionsOf.get(row.id) ?? []).sort(
          (a, b) => b.count - a.count,
        ),
        mine: mineOf.get(row.id) ?? null,
        createdAt: row.createdAt,
      };
    });
  }
}
