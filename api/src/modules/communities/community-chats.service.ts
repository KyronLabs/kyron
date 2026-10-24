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
import {
  CommunityChatWriters,
  CommunityRole,
  MediaKind,
  Prisma,
} from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { MediaService } from '../media/media.service';
import { MessagesService } from '../messages/messages.service';
import { DeliveryService } from '../push/delivery.service';
import { type PushText, say } from '../push/push-text';
import { assertRoomForPin } from '../messages/pins';

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
   * have not joined it. Not counting people the reader cannot see. */
  unread: number;
  /** The reader has muted it: no pushes, and not in the Messages badge. */
  muted: boolean;
  /** When the reader pinned it to the top of Messages, or null. */
  pinnedAt: Date | null;
  lastMessageAt: Date | null;
  createdAt: Date;
}

/** A photo, clip or voice note sent in a community chat. [url] lasts an
 * hour, and only people who can read the chat are given one. */
export interface CommunityChatMediaItem {
  id: string;
  kind: MediaKind;
  url: string;
  width: number | null;
  height: number | null;
  durationMs: number | null;
  waveform: number[];
}

/** A poll asked in a chat. What was asked is the message's body. Counts,
 * never names. */
export interface CommunityChatPollItem {
  id: string;
  multiple: boolean;
  closed: boolean;
  options: { id: string; text: string; votes: number }[];
  /** How many people have answered, whatever they chose. */
  voters: number;
  /** What the reader chose. */
  mine: string[];
}

/** An attachment as a message is sent with it: a reference into the
 * private bucket, from POST /media/chat, and what the phone measured. */
export interface CommunityChatMediaInput {
  ref: string;
  width?: number;
  height?: number;
  durationMs?: number;
  waveform?: number[];
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
  /** When its author last changed its words; null if never. */
  editedAt: Date | null;
  /** Until when the reader may still edit it: theirs, not a poll, and
   * inside [CommunityChatsService.editWindowMs]. Null otherwise. */
  editableUntil: Date | null;
  media: CommunityChatMediaItem[];
  poll: CommunityChatPollItem | null;
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
    /** What it carried, for a preview with no words of its own. */
    media: MediaKind | null;
    poll: boolean;
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
    private readonly supabase: SupabaseService,
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

  /** How long after sending a message its author may still change it. */
  static readonly editWindowMs = 15 * 60_000;

  /** How many times one message may be changed. Each is kept. */
  static readonly maxEdits = 10;

  /** Attachments on one message. A voice note goes alone. */
  static readonly maxMedia = 4;

  static readonly minPollOptions = 2;
  static readonly maxPollOptions = 10;
  static readonly maxPollOption = 100;

  /** How long a link to something sent in a chat works. */
  static readonly mediaLinkSeconds = 3600;

  /** Bars in a voice note's waveform, as the phone samples it. */
  static readonly maxWaveform = 200;

  /** The longest search a chat will run. */
  static readonly maxQuery = 100;

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
    const blocked = await this.blockedWith(viewerId);
    return {
      items: await Promise.all(
        chats.map((chat) =>
          this.summarize(viewerId, chat, community, role, blocked),
        ),
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
    const blocked = await this.blockedWith(viewerId);
    const summary = await this.summarize(
      viewerId,
      row,
      chat.community,
      role,
      blocked,
    );
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
      // The liveliest hundred, not any hundred: taken before ordering, the
      // cap kept whichever rows the database met first, and somebody in many
      // chats could find the one they were just talking in missing. Pinned
      // ones before any of them, however quiet, so the cap never drops one.
      orderBy: [
        { pinnedAt: { sort: 'desc', nulls: 'last' } },
        { chat: { lastMessageAt: { sort: 'desc', nulls: 'last' } } },
      ],
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
          blocked,
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
            media: {
              orderBy: { position: 'asc' },
              take: 1,
              select: { kind: true },
            },
            poll: { select: { id: true } },
          },
        });
        return {
          ...summary,
          lastMessage: last
            ? {
                senderName: last.sender.name ?? last.sender.username,
                body: last.body.slice(0, QUOTE_LENGTH),
                mine: last.senderId === viewerId,
                media: last.media[0]?.kind ?? null,
                poll: last.poll !== null,
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
    // New: nothing in it yet, from anybody.
    return this.summarize(viewerId, chat, community, role, new Set());
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

  /**
   * Says something in a chat: words, up to [maxMedia] photos or clips (or
   * one voice note) with or without words, or a poll -- [input.body] being
   * its question.
   */
  async send(
    viewerId: string,
    chatId: string,
    input: {
      body?: string;
      replyToId?: string;
      media?: CommunityChatMediaInput[];
      poll?: { options: string[]; multiple?: boolean };
    },
    now: Date = new Date(),
  ): Promise<CommunityChatMessageItem> {
    const { chat, role } = await this.access(viewerId, chatId);
    const moderator = await this.requireWriter(viewerId, chat, role);

    const attachments = CommunityChatsService.attachments(
      viewerId,
      input.media ?? [],
    );
    const options = input.poll
      ? CommunityChatsService.pollOptions(input.poll.options)
      : null;
    if (options && attachments.length > 0) {
      throw new BadRequestException('A poll goes on its own.');
    }
    // A picture can go without words; anything else needs some.
    const body =
      attachments.length > 0
        ? CommunityChatsService.caption(input.body ?? '')
        : CommunityChatsService.body(input.body ?? '');

    let repliedTo: string | null = null;
    if (input.replyToId) {
      const answered = await this.prisma.communityChatMessage.findFirst({
        where: { id: input.replyToId, chatId: chat.id, deletedAt: null },
        select: { id: true, senderId: true },
      });
      if (!answered) {
        throw new BadRequestException(
          'That message is no longer here to reply to.',
        );
      }
      repliedTo = answered.senderId;
    }

    const message = await this.prisma.$transaction(async (tx) => {
      // Requests sent side by side take turns here, so each one counts the
      // messages before it. Otherwise fifty at once would each find none.
      await CommunityChatsService.takeTurns(tx, `send:${chat.id}:${viewerId}`);
      if (attachments.length > 0) {
        // Each upload goes in one message. Twice, and taking one down --
        // which deletes its file -- would leave the other pointing at
        // nothing. Only its uploader can send a file, so their sends with
        // files take turns, in whichever chat, and each sees the one before.
        await CommunityChatsService.takeTurns(tx, `media:${viewerId}`);
        const used = await tx.media.count({
          where: { privatePath: { in: attachments.map((a) => a.ref) } },
        });
        if (used > 0) {
          // 409, not 400: most likely this very message, sent before and
          // its answer lost on the way back.
          throw new ConflictException('That file has already been sent.');
        }
      }
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
      if (attachments.length > 0) {
        await tx.media.createMany({
          data: attachments.map((a, position) => ({
            communityMessageId: made.id,
            kind: a.kind,
            // Never an address: [privatePath] is, and it is never sent.
            url: '',
            privatePath: a.ref,
            width: a.width,
            height: a.height,
            durationMs: a.durationMs,
            waveform: a.waveform,
            position,
          })),
        });
      }
      if (options) {
        await tx.communityChatPoll.create({
          data: {
            messageId: made.id,
            multiple: input.poll?.multiple === true,
            options: {
              create: options.map((text, position) => ({ text, position })),
            },
          },
        });
      }
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
    try {
      await this.notify(chat, item, repliedTo, now);
    } catch (error) {
      // The message is said; a push that could not go is not its failure.
      this.logger.warn(`chat ${chat.id}: push failed: ${String(error)}`);
    }
    return item;
  }

  /**
   * Changes the words of a message the reader sent, within
   * [editWindowMs] of sending it. What it said before is kept
   * (CommunityChatMessageEdit), for review; the chat shows it was edited.
   * A poll cannot be: its answers were given to the question as asked.
   */
  async edit(
    viewerId: string,
    chatId: string,
    messageId: string,
    input: { body: string },
    now: Date = new Date(),
  ): Promise<CommunityChatMessageItem> {
    const { chat, role } = await this.access(viewerId, chatId);
    const message = await this.prisma.communityChatMessage.findFirst({
      where: { id: messageId, chatId: chat.id, deletedAt: null },
      select: {
        id: true,
        senderId: true,
        body: true,
        createdAt: true,
        poll: { select: { id: true } },
        _count: { select: { media: true, edits: true } },
      },
    });
    if (!message) {
      throw new NotFoundException('That message is no longer here.');
    }
    if (message.senderId !== viewerId) {
      throw new ForbiddenException('You can only edit your own messages.');
    }
    // Still somebody who may write here: out of the chat, or in one that is
    // now for moderators only, they do not get to rewrite what is in it.
    await this.requireWriter(viewerId, chat, role);
    if (message.poll) {
      throw new BadRequestException('A poll cannot be edited.');
    }
    if (
      now.getTime() - message.createdAt.getTime() >
      CommunityChatsService.editWindowMs
    ) {
      throw new ForbiddenException(
        'A message can be edited for 15 minutes after it is sent.',
      );
    }
    if (message._count.edits >= CommunityChatsService.maxEdits) {
      throw new ForbiddenException(
        'This message has been edited as many times as it can be.',
      );
    }
    const body =
      message._count.media > 0
        ? CommunityChatsService.caption(input.body)
        : CommunityChatsService.body(input.body);

    if (body !== message.body) {
      await this.prisma.$transaction([
        this.prisma.communityChatMessageEdit.create({
          data: { messageId: message.id, body: message.body, editedAt: now },
        }),
        this.prisma.communityChatMessage.update({
          where: { id: message.id },
          data: { body, editedAt: now },
        }),
      ]);
      await this.tellChat(chat.id, {
        type: 'community.chat.message.edited',
        chatId: chat.id,
        messageId: message.id,
      });
    }
    const [item] = await this.items(
      viewerId,
      { id: message.id },
      new Set<string>(),
      1,
    );
    return item;
  }

  /**
   * Messages in a chat whose words hold [query], newest first. The same
   * people are left out as anywhere else in the chat.
   */
  async search(
    viewerId: string,
    chatId: string,
    query: string,
  ): Promise<{ items: CommunityChatMessageItem[] }> {
    const { chat } = await this.access(viewerId, chatId);
    const words = (query ?? '').trim();
    if (words.length < 2) return { items: [] };
    if (words.length > CommunityChatsService.maxQuery) {
      throw new BadRequestException('That search is too long.');
    }
    const blocked = await this.blockedWith(viewerId);
    const items = await this.items(
      viewerId,
      {
        chatId: chat.id,
        deletedAt: null,
        // Escaped: Prisma hands `contains` to LIKE as it is, so a search for
        // "e_" matched every e followed by anything, and "%" matched all.
        body: {
          contains: words.replace(/[\\%_]/g, (c) => `\\${c}`),
          mode: 'insensitive',
        },
        ...(blocked.size > 0 ? { senderId: { notIn: [...blocked] } } : {}),
      },
      blocked,
      30,
    );
    return { items };
  }

  /** Mutes a chat for the reader, or unmutes it. Only one they have joined:
   * nothing is pushed from any other. */
  async setMuted(
    viewerId: string,
    chatId: string,
    muted: boolean,
  ): Promise<{ id: string; muted: boolean }> {
    const { chat } = await this.access(viewerId, chatId);
    const { count } = await this.prisma.communityChatMember.updateMany({
      where: { chatId: chat.id, userId: viewerId },
      data: { mutedAt: muted ? new Date() : null },
    });
    if (count === 0) {
      throw new ForbiddenException('Join this chat to mute it.');
    }
    return { id: chat.id, muted };
  }

  /**
   * Keeps a joined chat at the top of the reader's Messages list, or stops.
   * Not the chat's pinned message ([pin]), which is the moderators' and
   * everybody's; this is the reader's alone, like muting.
   */
  async setPinned(
    viewerId: string,
    chatId: string,
    pinned: boolean,
  ): Promise<{ id: string; pinnedAt: Date | null }> {
    const { chat } = await this.access(viewerId, chatId);
    const member = await this.prisma.communityChatMember.findUnique({
      where: { chatId_userId: { chatId: chat.id, userId: viewerId } },
      select: { pinnedAt: true },
    });
    if (!member) {
      throw new ForbiddenException('Join this chat to pin it.');
    }
    if (!pinned) {
      await this.prisma.communityChatMember.update({
        where: { chatId_userId: { chatId: chat.id, userId: viewerId } },
        data: { pinnedAt: null },
      });
      return { id: chat.id, pinnedAt: null };
    }
    // Already pinned keeps its place rather than moving up.
    if (member.pinnedAt) return { id: chat.id, pinnedAt: member.pinnedAt };
    await assertRoomForPin(this.prisma, viewerId);
    const { pinnedAt } = await this.prisma.communityChatMember.update({
      where: { chatId_userId: { chatId: chat.id, userId: viewerId } },
      data: { pinnedAt: new Date() },
      select: { pinnedAt: true },
    });
    return { id: chat.id, pinnedAt };
  }

  /**
   * How many of the reader's chats have something new in them, for the
   * Messages badge: joined, not muted, in a community they are still in, and
   * a message since they last read it from somebody they can see.
   */
  async unreadChats(viewerId: string): Promise<{ chats: number }> {
    const rows = await this.prisma.$queryRaw<{ n: number }[]>`
      SELECT count(*)::int AS n
      FROM "CommunityChatMember" cm
      JOIN "CommunityChat" c ON c.id = cm."chatId" AND c."deletedAt" IS NULL
      JOIN "Community" co ON co.id = c."communityId" AND co."deletedAt" IS NULL
      JOIN "CommunityMember" mem
        ON mem."communityId" = c."communityId" AND mem."userId" = cm."userId"
      WHERE cm."userId" = ${viewerId}::uuid
        AND cm."mutedAt" IS NULL
        AND EXISTS (
          SELECT 1 FROM "CommunityChatMessage" m
          WHERE m."chatId" = cm."chatId"
            AND m."deletedAt" IS NULL
            AND m."senderId" <> cm."userId"
            AND m."createdAt" > COALESCE(cm."lastReadAt", cm."joinedAt")
            AND NOT EXISTS (
              SELECT 1 FROM "Block" b
              WHERE (b."blockerId" = cm."userId" AND b."blockedId" = m."senderId")
                 OR (b."blockerId" = m."senderId" AND b."blockedId" = cm."userId")
            )
        )`;
    return { chats: rows[0]?.n ?? 0 };
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

    // Their own: unsaid, wholly -- its words, what they were before an edit,
    // its pictures and its poll. Somebody else's: out of the chat, all of it
    // kept for review.
    const files = own
      ? await this.prisma.media.findMany({
          where: { communityMessageId: message.id },
          select: { privatePath: true },
        })
      : [];
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
      ...(own
        ? [
            this.prisma.communityChatMessageEdit.deleteMany({
              where: { messageId: message.id },
            }),
            this.prisma.media.deleteMany({
              where: { communityMessageId: message.id },
            }),
            this.prisma.communityChatPoll.deleteMany({
              where: { messageId: message.id },
            }),
          ]
        : []),
    ]);
    const paths = files
      .map((f) => f.privatePath)
      .filter((p): p is string => !!p);
    if (paths.length > 0) {
      try {
        await this.supabase.removePrivate(paths);
      } catch (error) {
        // The rows are gone, so nobody is handed a link to these again;
        // the files wait for the account's own sweep.
        this.logger.warn(
          `message ${message.id}: files not removed: ${String(error)}`,
        );
      }
    }
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

  // ---- Polls -----------------------------------------------------------------

  /**
   * Answers a poll, in place of any earlier answer. Anybody who can read the
   * chat may, as with reacting: a spectator, or a member in a chat that is
   * for announcements.
   */
  async vote(
    viewerId: string,
    chatId: string,
    messageId: string,
    optionIds: string[],
  ): Promise<CommunityChatMessageItem> {
    const { chat } = await this.access(viewerId, chatId);
    const poll = await this.livePoll(viewerId, chat.id, messageId);
    if (poll.closedAt) throw new ForbiddenException('This poll is closed.');
    const chosen = [...new Set(optionIds ?? [])];
    if (chosen.length === 0) {
      throw new BadRequestException('Choose an answer.');
    }
    if (!poll.multiple && chosen.length > 1) {
      throw new BadRequestException('This poll takes one answer.');
    }
    const offered = new Set(poll.options.map((o) => o.id));
    if (chosen.some((id) => !offered.has(id))) {
      throw new BadRequestException('That is not one of its answers.');
    }
    await this.prisma.$transaction(async (tx) => {
      // Two taps on two answers, side by side: without turns, each clears
      // nothing the other has written yet, and a one-answer poll ends up
      // with two from one person.
      await CommunityChatsService.takeTurns(tx, `vote:${poll.id}:${viewerId}`);
      await tx.communityChatPollVote.deleteMany({
        where: { pollId: poll.id, userId: viewerId },
      });
      await tx.communityChatPollVote.createMany({
        data: chosen.map((optionId) => ({
          pollId: poll.id,
          optionId,
          userId: viewerId,
        })),
      });
    });
    await this.tellChat(chat.id, {
      type: 'community.chat.poll',
      chatId: chat.id,
      messageId,
    });
    const [item] = await this.items(
      viewerId,
      { id: messageId },
      new Set<string>(),
      1,
    );
    return item;
  }

  /** Takes the reader's answer back, while the poll is open. */
  async unvote(
    viewerId: string,
    chatId: string,
    messageId: string,
  ): Promise<{ ok: true }> {
    const { chat } = await this.access(viewerId, chatId);
    const poll = await this.livePoll(viewerId, chat.id, messageId);
    if (poll.closedAt) throw new ForbiddenException('This poll is closed.');
    const { count } = await this.prisma.communityChatPollVote.deleteMany({
      where: { pollId: poll.id, userId: viewerId },
    });
    if (count > 0) {
      await this.tellChat(chat.id, {
        type: 'community.chat.poll',
        chatId: chat.id,
        messageId,
      });
    }
    return { ok: true };
  }

  /** Closes a poll: by whoever asked it, or the community's owner or a
   * moderator. Its answers stay to be read. */
  async closePoll(
    viewerId: string,
    chatId: string,
    messageId: string,
  ): Promise<{ ok: true }> {
    const { chat, role } = await this.access(viewerId, chatId);
    const poll = await this.livePoll(viewerId, chat.id, messageId);
    if (poll.senderId !== viewerId && !CommunityChatsService.moderates(role)) {
      throw new ForbiddenException(
        'Only whoever asked it, or a moderator, can close a poll.',
      );
    }
    if (!poll.closedAt) {
      await this.prisma.communityChatPoll.update({
        where: { id: poll.id },
        data: { closedAt: new Date() },
      });
      await this.tellChat(chat.id, {
        type: 'community.chat.poll',
        chatId: chat.id,
        messageId,
      });
    }
    return { ok: true };
  }

  /** The poll a message is, if the message is still up and the reader can
   * see who asked it. */
  private async livePoll(viewerId: string, chatId: string, messageId: string) {
    const blocked = await this.blockedWith(viewerId);
    const message = await this.prisma.communityChatMessage.findFirst({
      where: {
        id: messageId,
        chatId,
        deletedAt: null,
        ...(blocked.size > 0 ? { senderId: { notIn: [...blocked] } } : {}),
      },
      select: {
        senderId: true,
        poll: {
          select: {
            id: true,
            multiple: true,
            closedAt: true,
            options: { select: { id: true } },
          },
        },
      },
    });
    if (!message) {
      throw new NotFoundException('That message is no longer here.');
    }
    if (!message.poll) {
      throw new BadRequestException('That message is not a poll.');
    }
    return { ...message.poll, senderId: message.senderId };
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

  /** Words under a picture: trimmed, and allowed to be none. */
  static caption(raw: string): string {
    const body = (raw ?? '').trim();
    if (body.length > CommunityChatsService.maxBody) {
      throw new BadRequestException(
        `A message can be at most ${CommunityChatsService.maxBody} characters.`,
      );
    }
    return body;
  }

  /**
   * What a message carries, checked: the reader's own uploads from POST
   * /media/chat, no more than [maxMedia], a voice note on its own, and what
   * each is read from the file's own name -- set by the server when it
   * looked at the bytes -- rather than from what the client says it is.
   */
  static attachments(
    viewerId: string,
    raw: readonly CommunityChatMediaInput[],
  ): {
    ref: string;
    kind: MediaKind;
    width: number | null;
    height: number | null;
    durationMs: number | null;
    waveform: number[];
  }[] {
    if (!raw || raw.length === 0) return [];
    if (raw.length > CommunityChatsService.maxMedia) {
      throw new BadRequestException(
        `A message can carry at most ${CommunityChatsService.maxMedia} photos or clips.`,
      );
    }
    const refs = new Set<string>();
    const out = raw.map((a) => {
      const ref = typeof a?.ref === 'string' ? a.ref : '';
      if (
        !MediaService.isOwnPrivateRef(MediaService.chatFolder, ref, viewerId)
      ) {
        throw new BadRequestException('That file was not uploaded here.');
      }
      if (refs.has(ref)) {
        throw new BadRequestException('The same file is in there twice.');
      }
      refs.add(ref);
      const kind = CommunityChatsService.kindOfRef(ref);
      const count = (n: unknown, max: number): number | null =>
        typeof n === 'number' && Number.isInteger(n) && n > 0 && n <= max
          ? n
          : null;
      const waveform =
        kind === MediaKind.VOICE && a.waveform
          ? a.waveform
              .slice(0, CommunityChatsService.maxWaveform)
              .map((v: unknown) =>
                typeof v === 'number' && Number.isFinite(v)
                  ? Math.min(100, Math.max(0, Math.round(v)))
                  : 0,
              )
          : [];
      return {
        ref,
        kind,
        width: count(a.width, 20_000),
        height: count(a.height, 20_000),
        durationMs:
          kind === MediaKind.VOICE || kind === MediaKind.VIDEO
            ? count(a.durationMs, 60 * 60_000)
            : null,
        waveform,
      };
    });
    if (out.length > 1 && out.some((a) => a.kind === MediaKind.VOICE)) {
      throw new BadRequestException('A voice note goes on its own.');
    }
    return out;
  }

  /** What an upload is, from the extension the server gave it. */
  static kindOfRef(ref: string): MediaKind {
    const extension = ref.slice(ref.lastIndexOf('.') + 1).toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'png':
      case 'webp':
      case 'heic':
        return MediaKind.IMAGE;
      case 'gif':
        return MediaKind.GIF;
      case 'mp4':
      case 'mov':
      case 'webm':
        return MediaKind.VIDEO;
      case 'm4a':
        return MediaKind.VOICE;
      default:
        throw new BadRequestException('That file is not one a chat can carry.');
    }
  }

  /** A poll's answers: two to ten, each a few words, none twice. */
  static pollOptions(raw: readonly string[]): string[] {
    if (!Array.isArray(raw)) {
      throw new BadRequestException('A poll needs answers to choose from.');
    }
    const options = raw.map((o) =>
      (typeof o === 'string' ? o : '').trim().replace(/\s+/g, ' '),
    );
    if (options.some((o) => !o)) {
      throw new BadRequestException('An answer cannot be empty.');
    }
    if (
      options.length < CommunityChatsService.minPollOptions ||
      options.length > CommunityChatsService.maxPollOptions
    ) {
      throw new BadRequestException(
        `A poll has between ${CommunityChatsService.minPollOptions} and ${CommunityChatsService.maxPollOptions} answers.`,
      );
    }
    if (options.some((o) => o.length > CommunityChatsService.maxPollOption)) {
      throw new BadRequestException(
        `An answer can be at most ${CommunityChatsService.maxPollOption} characters.`,
      );
    }
    if (new Set(options.map((o) => o.toLowerCase())).size !== options.length) {
      throw new BadRequestException('Each answer can be in a poll once.');
    }
    return options;
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
      name: string;
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
        name: true,
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

  /**
   * Pushes a new message to the people who should hear about it, once.
   *
   * Joined, not muted, still in the community, and not on either side of a
   * block with the sender. And once per run of unread messages: somebody
   * already pushed about this chat is not pushed again until they have read
   * past it -- a lively room is one buzz, not one per line. A reply to them
   * is the exception; muted stays muted even then.
   *
   * Chosen and marked in one statement, so two messages a moment apart
   * cannot both push the same person: the second finds them marked.
   */
  private async notify(
    chat: { id: string; name: string; community: { name: string } },
    item: CommunityChatMessageItem,
    repliedTo: string | null,
    now: Date,
  ): Promise<void> {
    const rows = await this.prisma.$queryRaw<{ userId: string }[]>`
      UPDATE "CommunityChatMember" cm
      SET "notifiedAt" = ${now}
      FROM "CommunityChat" c
      WHERE cm."chatId" = ${chat.id}::uuid
        AND c.id = cm."chatId"
        AND cm."userId" <> ${item.sender.id}::uuid
        AND cm."mutedAt" IS NULL
        AND EXISTS (
          SELECT 1 FROM "CommunityMember" mem
          WHERE mem."communityId" = c."communityId" AND mem."userId" = cm."userId"
        )
        AND NOT EXISTS (
          SELECT 1 FROM "Block" b
          WHERE (b."blockerId" = cm."userId" AND b."blockedId" = ${item.sender.id}::uuid)
             OR (b."blockerId" = ${item.sender.id}::uuid AND b."blockedId" = cm."userId")
        )
        AND (
          cm."notifiedAt" IS NULL
          OR cm."notifiedAt" <= COALESCE(cm."lastReadAt", cm."joinedAt")
          OR cm."userId" = ${repliedTo}::uuid
        )
      RETURNING cm."userId" AS "userId"`;
    if (rows.length === 0) return;
    const who = item.sender.name ?? item.sender.username ?? say('someone');
    this.delivery.pushMany(
      rows.map((r) => r.userId),
      {
        title: `${chat.name} · ${chat.community.name}`,
        body: say('named_line', {
          name: who,
          text: CommunityChatsService.preview(item),
        }),
        data: { type: 'community.chat', chatId: chat.id },
      },
    );
  }

  /** What a push says a message was: its words, or what it carried. */
  static preview(item: {
    body: string;
    media: { kind: MediaKind }[];
    poll: unknown;
  }): PushText {
    const words = item.body.trim().replace(/\s+/g, ' ');
    if (item.poll) {
      return say('chat_poll', { text: CommunityChatsService.clip(words) });
    }
    if (words) return CommunityChatsService.clip(words);
    switch (item.media[0]?.kind) {
      case MediaKind.IMAGE:
        return say('chat_photo');
      case MediaKind.GIF:
        return say('chat_gif');
      case MediaKind.VIDEO:
        return say('chat_clip');
      case MediaKind.VOICE:
        return say('chat_voice');
      default:
        return say('new_message');
    }
  }

  private static clip(words: string): string {
    return words.length > 100 ? `${words.slice(0, 99)}…` : words;
  }

  /**
   * Whether the reader may write in [chat] now -- joined, and allowed by who
   * it is for -- answering whether they are one of its moderators.
   */
  private async requireWriter(
    viewerId: string,
    chat: { id: string; writers: CommunityChatWriters },
    role: CommunityRole,
  ): Promise<boolean> {
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
    return moderator;
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
   * that something in it changed. Ids only, and no push: what is pushed, to
   * whom, is [notify]'s to decide.
   */
  private async tellChat(
    chatId: string,
    event:
      | { type: 'community.chat.updated'; chatId: string }
      | {
          type:
            | 'community.chat.message'
            | 'community.chat.message.deleted'
            | 'community.chat.message.edited'
            | 'community.chat.reaction'
            | 'community.chat.poll';
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
        select: {
          joinedAt: true,
          lastReadAt: true,
          mutedAt: true,
          pinnedAt: true,
        },
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
      members: {
        joinedAt: Date;
        lastReadAt: Date | null;
        mutedAt: Date | null;
        pinnedAt: Date | null;
      }[];
    },
    community: {
      id: string;
      slug: string;
      name: string;
      avatarUrl: string | null;
    },
    role: CommunityRole,
    blocked: ReadonlySet<string>,
  ): Promise<CommunityChatSummary> {
    const membership = chat.members[0];
    const moderator = CommunityChatsService.moderates(role);
    // Not counting anybody the reader cannot see: a count of messages that
    // are never shown said "3 new" over a chat with nothing new in it.
    const unread = membership
      ? await this.prisma.communityChatMessage.count({
          where: {
            chatId: chat.id,
            deletedAt: null,
            senderId: { notIn: [viewerId, ...blocked] },
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
      muted: membership?.mutedAt != null,
      pinnedAt: membership?.pinnedAt ?? null,
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
        editedAt: true,
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
    const [counts, mine, roles, media, polls] = await Promise.all([
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
      this.prisma.media.findMany({
        where: { communityMessageId: { in: ids } },
        orderBy: { position: 'asc' },
        select: {
          id: true,
          communityMessageId: true,
          kind: true,
          privatePath: true,
          width: true,
          height: true,
          durationMs: true,
          waveform: true,
        },
      }),
      this.prisma.communityChatPoll.findMany({
        where: { messageId: { in: ids } },
        select: {
          id: true,
          messageId: true,
          multiple: true,
          closedAt: true,
          options: {
            orderBy: { position: 'asc' },
            select: { id: true, text: true },
          },
        },
      }),
    ]);
    const roleOf = new Map(roles.map((r) => [r.userId, r.role]));
    const mediaOf = await this.mediaItems(media);
    const pollOf = await this.pollItems(viewerId, polls);
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
        editedAt: row.editedAt,
        editableUntil:
          row.senderId === viewerId && !pollOf.has(row.id)
            ? new Date(
                row.createdAt.getTime() + CommunityChatsService.editWindowMs,
              )
            : null,
        media: mediaOf.get(row.id) ?? [],
        poll: pollOf.get(row.id) ?? null,
        createdAt: row.createdAt,
      };
    });
  }

  /**
   * What messages carry, by message, each with a link that lasts
   * [mediaLinkSeconds]. Signed together, in one round trip. If the store
   * cannot be reached the messages still come back, their pictures without
   * links, rather than the chat failing to open.
   */
  private async mediaItems(
    rows: {
      id: string;
      communityMessageId: string | null;
      kind: MediaKind;
      privatePath: string | null;
      width: number | null;
      height: number | null;
      durationMs: number | null;
      waveform: number[];
    }[],
  ): Promise<Map<string, CommunityChatMediaItem[]>> {
    const byMessage = new Map<string, CommunityChatMediaItem[]>();
    if (rows.length === 0) return byMessage;
    let links = new Map<string, string>();
    try {
      links = await this.supabase.signPrivateMany(
        rows.map((r) => r.privatePath).filter((p): p is string => !!p),
        CommunityChatsService.mediaLinkSeconds,
      );
    } catch (error) {
      this.logger.warn(`could not sign chat media: ${String(error)}`);
    }
    for (const row of rows) {
      if (!row.communityMessageId) continue;
      const list = byMessage.get(row.communityMessageId) ?? [];
      list.push({
        id: row.id,
        kind: row.kind,
        url: (row.privatePath && links.get(row.privatePath)) ?? '',
        width: row.width,
        height: row.height,
        durationMs: row.durationMs,
        waveform: row.waveform,
      });
      byMessage.set(row.communityMessageId, list);
    }
    return byMessage;
  }

  /** Polls, by message: each answer's count, how many answered, and what
   * the reader chose. */
  private async pollItems(
    viewerId: string,
    polls: {
      id: string;
      messageId: string;
      multiple: boolean;
      closedAt: Date | null;
      options: { id: string; text: string }[];
    }[],
  ): Promise<Map<string, CommunityChatPollItem>> {
    const byMessage = new Map<string, CommunityChatPollItem>();
    if (polls.length === 0) return byMessage;
    const pollIds = polls.map((p) => p.id);
    const [counts, voters, mine] = await Promise.all([
      this.prisma.communityChatPollVote.groupBy({
        by: ['optionId'],
        where: { pollId: { in: pollIds } },
        _count: { _all: true },
      }),
      this.prisma.$queryRaw<{ pollId: string; n: number }[]>`
        SELECT "pollId", count(DISTINCT "userId")::int AS n
        FROM "CommunityChatPollVote"
        WHERE "pollId" IN (${Prisma.join(pollIds.map((id) => Prisma.sql`${id}::uuid`))})
        GROUP BY "pollId"`,
      this.prisma.communityChatPollVote.findMany({
        where: { pollId: { in: pollIds }, userId: viewerId },
        select: { pollId: true, optionId: true },
      }),
    ]);
    const votesOf = new Map(counts.map((c) => [c.optionId, c._count._all]));
    const votersOf = new Map(voters.map((v) => [v.pollId, v.n]));
    for (const poll of polls) {
      byMessage.set(poll.messageId, {
        id: poll.id,
        multiple: poll.multiple,
        closed: poll.closedAt !== null,
        options: poll.options.map((o) => ({
          id: o.id,
          text: o.text,
          votes: votesOf.get(o.id) ?? 0,
        })),
        voters: votersOf.get(poll.id) ?? 0,
        mine: mine.filter((m) => m.pollId === poll.id).map((m) => m.optionId),
      });
    }
    return byMessage;
  }
}
