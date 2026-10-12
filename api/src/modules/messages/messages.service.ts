import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { MediaKind, Prisma } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { DeliveryService } from '../push/delivery.service';
import type { ConversationFilter } from './dto/list-messages.dto';

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
    /** Its attachments, so a voice note or a photo says what it is rather
     * than nothing. */
    media: MessageMedia[];
    /** The reader's own last message, read by the other side. Always false
     * when either of them has read receipts off. */
    seen: boolean;
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

/** One person's reaction to a message. */
export interface MessageReactionItem {
  userId: string;
  emoji: string;
}

export interface MessageItem {
  id: string;
  body: string;
  senderId: string;
  createdAt: Date;
  /**
   * Who reacted, and with what. Readable, unlike the body: a decided trade,
   * written down in docs/E2EE.md.
   */
  reactions: MessageReactionItem[];
  /** True once the other side has read past it. Drawn as a tick. */
  seen: boolean;
  /**
   * The message this one answers, if it answers one.
   *
   * An id, never the quoted words. This server holds ciphertext it cannot
   * read; the client has the thread decrypted and resolves the quote itself.
   */
  replyToId: string | null;
  /**
   * The card for a link in it, sealed by the sender like the body. Opaque
   * here: see the column's note in the schema.
   */
  linkCard: string | null;
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
/**
 * Exactly one emoji: a flag, a keycap, or a pictograph carrying any variation
 * selector, skin tone or tag characters, joined to more of the same by
 * zero-width joiners.
 */
const PICTOGRAPH =
  '\\p{Extended_Pictographic}[\\uFE0F\\p{Emoji_Modifier}\\u{E0020}-\\u{E007F}]*';
const SINGLE_EMOJI = new RegExp(
  `^(?:\\p{Regional_Indicator}{2}|[#*0-9]\\uFE0F?\\u20E3|${PICTOGRAPH}(?:\\u200D${PICTOGRAPH})*)$`,
  'u',
);

@Injectable()
export class MessagesService {
  private readonly logger = new Logger(MessagesService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly delivery: DeliveryService,
  ) {}

  /** The longest one message may be. */
  static readonly maxBody = 4000;

  /**
   * The longest a sealed body may be.
   *
   * [maxBody] is a limit on what somebody writes, and the server cannot see
   * that once it is sealed: the stored body is ciphertext, base64, plus the
   * message key wrapped once per device. A 4,000-character message in a
   * script that takes three bytes a character seals to about 16,000. Held to
   * [maxBody], every long message in Japanese, Hindi or Arabic failed to send;
   * the app now enforces 4,000 on what is typed, and this is the ceiling on
   * what that can seal to.
   */
  static readonly maxSealedBody = 24000;

  /** Whether a stored body is a sealed message, in any version. */
  static isSealed(body: string): boolean {
    return /^k[12]\./.test(body);
  }

  /**
   * The longest a link card may be: a title, a line of description and a
   * picture shrunk to a few tens of kilobytes, sealed. Larger than a body
   * because of the picture, and bounded so a card is not a way to store a
   * file in a row.
   */
  static readonly maxLinkCard = 96000;

  /** How many attachments one message may carry. Same as a post's. */
  static readonly maxMedia = 10;

  /**
   * Whether [value] can be a reaction: exactly one emoji, and nothing else.
   *
   * One emoji as a reader sees it, which can be many code points: a skin
   * tone (👍🏾), a joined sequence (👩🏽‍💻, 🏳️‍🌈), a flag (🇳🇬, and the tag
   * sequences of 🏴󠁧󠁢󠁳󠁣󠁴󠁿), a keycap (1️⃣). Two emoji, a letter, or a word
   * with an emoji in it is not one. The length cap is generous for the longest
   * of those and stops a reaction being a place to store an essay on somebody
   * else's message.
   */
  static isReactionEmoji(value: string): boolean {
    if (value.length === 0 || value.length > 32) return false;
    return SINGLE_EMOJI.test(value);
  }

  private readonly personShape = {
    id: true,
    name: true,
    username: true,
    profile: { select: { avatarUrl: true } },
  } as const;

  /** The reader's conversations, whichever moved last at the top. */
  async list(
    viewerId: string,
    { limit = DEFAULT_LIMIT, cursor, unreadOnly = false, filter } = {} as {
      limit?: number;
      cursor?: string;
      unreadOnly?: boolean;
      filter?: ConversationFilter;
    },
  ) {
    const which: ConversationFilter = filter ?? (unreadOnly ? 'unread' : 'all');
    const hidden = which === 'hidden';

    // Narrowed before paging, not after. Filtering a page down afterwards
    // gives short pages and an "Unread" tab that looks empty while there is
    // more behind the cursor.
    const only =
      which === 'unread'
        ? await this.unreadConversationIds(viewerId)
        : which === 'unanswered'
          ? await this.unansweredConversationIds(viewerId)
          : null;
    if (only !== null && only.length === 0) {
      return { items: [] as ConversationSummary[], nextCursor: null };
    }

    const rows = await this.prisma.conversation.findMany({
      where: {
        ...(only ? { id: { in: only } } : {}),
        members: {
          some: {
            userId: viewerId,
            hiddenAt: hidden ? { not: null } : null,
          },
        },
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
            user: { select: { ...this.personShape, readReceipts: true } },
          },
        },
        messages: {
          where: { deletedAt: null },
          orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
          take: 1,
          select: {
            id: true,
            body: true,
            senderId: true,
            createdAt: true,
            media: { select: this.mediaShape, orderBy: { position: 'asc' } },
          },
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

    const items: ConversationSummary[] = page.map((row) => {
      const last = row.messages[0];
      const readUpTo = this.readUpTo(viewerId, row.members);
      return {
        id: row.id,
        people: row.members
          .filter((m) => m.userId !== viewerId)
          .map((m) => this.toPerson(m.user)),
        lastMessage: last
          ? {
              ...last,
              seen:
                last.senderId === viewerId &&
                readUpTo !== null &&
                last.createdAt <= readUpTo,
            }
          : null,
        unread: unreadOf.get(row.id) ?? 0,
        lastMessageAt: row.lastMessageAt,
      };
    });

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

  /**
   * Which of the reader's conversations end on the other person's word: the
   * ones waiting on a reply.
   *
   * The last message of each, in one query, rather than each conversation's
   * messages fetched to find it.
   */
  private async unansweredConversationIds(viewerId: string): Promise<string[]> {
    const rows = await this.prisma.$queryRaw<
      Array<{ conversationId: string; senderId: string }>
    >`
      SELECT DISTINCT ON (m."conversationId") m."conversationId", m."senderId"
      FROM "Message" m
      JOIN "ConversationMember" cm
        ON cm."conversationId" = m."conversationId"
       AND cm."userId" = ${viewerId}::uuid
       AND cm."hiddenAt" IS NULL
      WHERE m."deletedAt" IS NULL
      ORDER BY m."conversationId", m."createdAt" DESC, m."id" DESC
    `;
    return rows
      .filter((row) => row.senderId !== viewerId)
      .map((row) => row.conversationId);
  }

  /**
   * How far everybody else in a conversation has read, as far as the reader
   * may know it: the earliest of their read marks, or null when any of them
   * has never opened it -- or when read receipts are off on either side,
   * which is the trade the setting makes.
   */
  private readUpTo(
    viewerId: string,
    members: ReadonlyArray<{
      userId: string;
      lastReadAt: Date | null;
      user: { readReceipts?: boolean };
    }>,
  ): Date | null {
    // Only an explicit false is off: the column defaults to on.
    const me = members.find((m) => m.userId === viewerId);
    if (me?.user.readReceipts === false) return null;
    const others = members.filter((m) => m.userId !== viewerId);
    if (others.length === 0) return null;
    let earliest: Date | null = null;
    for (const other of others) {
      if (other.user.readReceipts === false || other.lastReadAt === null) {
        return null;
      }
      if (earliest === null || other.lastReadAt < earliest) {
        earliest = other.lastReadAt;
      }
    }
    return earliest;
  }

  /** The reader's messaging settings. */
  async settings(viewerId: string): Promise<{ readReceipts: boolean }> {
    const user = await this.prisma.user.findUnique({
      where: { id: viewerId },
      select: { readReceipts: true },
    });
    return { readReceipts: user?.readReceipts ?? true };
  }

  /** Changes them. */
  async updateSettings(
    viewerId: string,
    settings: { readReceipts: boolean },
  ): Promise<{ readReceipts: boolean }> {
    const user = await this.prisma.user.update({
      where: { id: viewerId },
      data: { readReceipts: settings.readReceipts },
      select: { readReceipts: true },
    });
    return { readReceipts: user.readReceipts };
  }

  /** Puts a conversation the reader removed back in their list. */
  async unhide(viewerId: string, conversationId: string) {
    await this.requireMembership(viewerId, conversationId);
    await this.prisma.conversationMember.updateMany({
      where: { conversationId, userId: viewerId },
      data: { hiddenAt: null },
    });
    return { ok: true };
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
    // makes the whole thing unseen, and so does read receipts being off on
    // either side.
    const otherRead = this.readUpTo(viewerId, conversation.members);

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
        // The id of what each one answers. The quoted text is not sent: this
        // server holds ciphertext, and the client has the thread decrypted.
        replyToId: true,
        linkCard: true,
        media: { select: this.mediaShape, orderBy: { position: 'asc' } },
        reactions: {
          select: this.reactionShape,
          orderBy: { createdAt: 'asc' },
        },
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
      // How far the reader had read before opening this. Reading a thread
      // does not mark it read -- PUT :id/read does, after -- so this is still
      // the old mark, which is exactly what drawing "New messages" above the
      // first unread one needs. Null when they have never opened it.
      lastReadAt:
        conversation.members.find((m) => m.userId === viewerId)?.lastReadAt ??
        null,
    };
  }

  /** Says something. */
  async send(
    viewerId: string,
    conversationId: string,
    body: string,
    media: MessageMediaInput[] = [],
    replyToId?: string,
    linkCard?: string,
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
    const limit = MessagesService.isSealed(text)
      ? MessagesService.maxSealedBody
      : MessagesService.maxBody;
    if (text.length > limit) {
      throw new BadRequestException(
        `A message cannot exceed ${MessagesService.maxBody} characters.`,
      );
    }

    const card = linkCard?.trim() || null;
    if (card) {
      // A card is for a link in the words; with no words there is no link.
      if (!text) {
        throw new BadRequestException('A link card needs a message with it.');
      }
      if (card.length > MessagesService.maxLinkCard) {
        throw new BadRequestException('That link card is too large.');
      }
      // Sealed words with an open card would put the address -- the one
      // thing in the message the card is about -- in this database in the
      // clear. Refused rather than stored: the client sealed one and not the
      // other, and that is a bug to hear about, not to keep.
      if (MessagesService.isSealed(text) && !MessagesService.isSealed(card)) {
        throw new BadRequestException(
          'A sealed message needs its link card sealed too.',
        );
      }
    }

    const conversation = await this.requireMembership(viewerId, conversationId);
    for (const member of conversation.members) {
      if (member.userId !== viewerId) {
        await this.requireNoBlock(viewerId, member.userId);
      }
    }

    // A reply has to answer something in *this* conversation. Without the
    // check, a caller could quote a message out of a thread they are not in --
    // and although the body is ciphertext they cannot read, the reply would
    // still tell them that message exists and when it was written.
    if (replyToId) {
      const answering = await this.prisma.message.findFirst({
        where: { id: replyToId, conversationId, deletedAt: null },
        select: { id: true },
      });
      if (!answering) {
        throw new BadRequestException(
          'That message is not in this conversation.',
        );
      }
    }

    const [message] = await this.prisma.$transaction([
      this.prisma.message.create({
        data: {
          conversationId,
          senderId: viewerId,
          body: text,
          replyToId: replyToId ?? null,
          linkCard: card,
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
          replyToId: true,
          linkCard: true,
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

    // Told to everyone else in the thread, so a chat that is open updates
    // without waiting for its next poll. The event carries ids only: the
    // client fetches the message through the same endpoint it always has, so
    // there is no second shape of a message to keep in step, and nothing
    // readable leaks to a socket whose token has since been revoked.
    const sender = conversation.members.find((m) => m.userId === viewerId);
    this.delivery.tellMany(
      conversation.members.map((m) => m.userId).filter((id) => id !== viewerId),
      { type: 'message.new', conversationId, messageId: message.id },
      {
        // Defensively: this is a notification title, and a shape that does
        // not carry the sender should cost a generic push, never the message.
        title:
          sender?.user?.name?.trim() ||
          sender?.user?.username?.trim() ||
          'New message',
        // Never the message. This used to be the stored body, and the body of
        // a sealed message is ciphertext: the push is shown by the phone's
        // own notification system, with no chance for the app to open it
        // first, so every encrypted message arrived on the lock screen as
        // `k1.Zx9f…`. A body that was not sealed was worse -- the words went
        // through Google's servers in the clear, from a feature the README
        // calls end-to-end encrypted. The server cannot read a sealed message
        // and must not repeat an unsealed one, so the push says only that
        // something arrived. Showing the words again means opening them on
        // the device, in a push the app handles itself -- docs/E2EE.md.
        body: media.length > 0 ? 'Sent an attachment' : 'Sent you a message',
        data: { type: 'message', conversationId },
      },
    );

    // The same shape as a message read from the thread, so the client parses
    // one kind of thing. Nobody has reacted to a message a moment old.
    return { ...message, seen: false, reactions: [] };
  }

  /** What a message's attachments look like on the wire. */
  private get reactionShape() {
    return { userId: true, emoji: true } as const;
  }

  /**
   * Reacts to a message, replacing any reaction the reader already had on it.
   *
   * Anyone in the conversation can react to anything in it, their own
   * messages included -- but not across a block, the same rule sending
   * follows, and not to a message that is gone.
   */
  async react(
    viewerId: string,
    conversationId: string,
    messageId: string,
    emoji: string,
  ) {
    const value = emoji.trim();
    if (!MessagesService.isReactionEmoji(value)) {
      throw new BadRequestException('A reaction is one emoji.');
    }
    const conversation = await this.requireMembership(viewerId, conversationId);
    for (const member of conversation.members) {
      if (member.userId !== viewerId) {
        await this.requireNoBlock(viewerId, member.userId);
      }
    }
    await this.requireMessage(conversationId, messageId);

    await this.prisma.messageReaction.upsert({
      where: { messageId_userId: { messageId, userId: viewerId } },
      create: { messageId, userId: viewerId, emoji: value },
      update: { emoji: value, createdAt: new Date() },
    });

    this.tellReaction(viewerId, conversation, messageId);
    return { messageId, userId: viewerId, emoji: value };
  }

  /** Takes the reader's reaction off a message. Nothing there is not an
   * error: the end state is the one asked for. */
  async unreact(viewerId: string, conversationId: string, messageId: string) {
    const conversation = await this.requireMembership(viewerId, conversationId);
    const { count } = await this.prisma.messageReaction.deleteMany({
      where: { messageId, userId: viewerId, message: { conversationId } },
    });
    if (count > 0) this.tellReaction(viewerId, conversation, messageId);
    return { ok: true };
  }

  /**
   * One message's reactions, for a client told over the socket that they
   * changed. The event carries only ids; this is where the emoji are read,
   * behind the same membership check as the thread itself.
   */
  async reactionsFor(
    viewerId: string,
    conversationId: string,
    messageId: string,
  ) {
    await this.requireMembership(viewerId, conversationId);
    await this.requireMessage(conversationId, messageId);
    const reactions = await this.prisma.messageReaction.findMany({
      where: { messageId },
      orderBy: { createdAt: 'asc' },
      select: this.reactionShape,
    });
    return { messageId, reactions };
  }

  /**
   * Tells everyone else in the conversation that the reader is writing.
   *
   * Over the socket only, never a push: "Ada is typing" is worth something
   * while the thread is open and nothing at all as a buzz in a pocket. The
   * client sends this at most every few seconds while the box is changing,
   * and the other side lets it lapse on its own, so there is no "stopped
   * typing" to forget to send.
   */
  async typing(viewerId: string, conversationId: string) {
    const conversation = await this.requireMembership(viewerId, conversationId);
    for (const member of conversation.members) {
      if (member.userId !== viewerId) {
        await this.requireNoBlock(viewerId, member.userId);
      }
    }
    this.delivery.tellMany(
      conversation.members.map((m) => m.userId).filter((id) => id !== viewerId),
      { type: 'message.typing', conversationId, userId: viewerId },
    );
    return { ok: true };
  }

  private tellReaction(
    viewerId: string,
    conversation: { id: string; members: { userId: string }[] },
    messageId: string,
  ) {
    // No push. A reaction is a small thing, and a phone that buzzes for every
    // heart is a phone that gets its notifications turned off.
    this.delivery.tellMany(
      conversation.members.map((m) => m.userId).filter((id) => id !== viewerId),
      { type: 'message.reaction', conversationId: conversation.id, messageId },
    );
  }

  /** The message, if it is in this conversation and not withdrawn. */
  private async requireMessage(conversationId: string, messageId: string) {
    const message = await this.prisma.message.findFirst({
      where: { id: messageId, conversationId, deletedAt: null },
      select: { id: true },
    });
    if (!message) throw new NotFoundException('That message is gone.');
    return message;
  }

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

  /**
   * The attachments in a conversation, newest first, each with the message it
   * came in and when -- for the conversation's info page.
   *
   * Paged by message rather than by attachment, so the cursor is a message id
   * like every other page of this thread, and an album is never split
   * across two pages.
   */
  async sharedMedia(
    viewerId: string,
    conversationId: string,
    { limit = DEFAULT_LIMIT, cursor }: { limit?: number; cursor?: string } = {},
  ) {
    await this.requireMembership(viewerId, conversationId);
    const take = Math.min(Math.max(limit, 1), 60);

    if (cursor) {
      // A cursor from another conversation would page through this one from
      // an arbitrary point. Refused rather than quietly misread.
      const anchor = await this.prisma.message.findFirst({
        where: { id: cursor, conversationId },
        select: { id: true },
      });
      if (!anchor) throw new NotFoundException('That page no longer exists.');
    }

    const rows = await this.prisma.message.findMany({
      where: { conversationId, deletedAt: null, media: { some: {} } },
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      take: take + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
      select: {
        id: true,
        senderId: true,
        createdAt: true,
        media: { select: this.mediaShape, orderBy: { position: 'asc' } },
      },
    });

    const page = rows.slice(0, take);
    return {
      items: page.flatMap((message) =>
        message.media.map((media) => ({
          ...media,
          messageId: message.id,
          senderId: message.senderId,
          createdAt: message.createdAt,
        })),
      ),
      nextCursor: rows.length > take ? page[page.length - 1].id : null,
    };
  }

  /** Marks everything in a conversation as read. */
  async markRead(viewerId: string, conversationId: string) {
    const conversation = await this.requireMembership(viewerId, conversationId);
    await this.prisma.conversationMember.updateMany({
      where: { conversationId, userId: viewerId },
      data: { lastReadAt: new Date() },
    });

    // The other side's own bubbles are now seen, and their ticks should fill
    // in without waiting for them to pull the thread. No push with it: a
    // phone that buzzes because somebody read a message is a phone nobody
    // wants. Not at all with read receipts off: the event itself says the
    // message was read.
    const me = conversation.members.find((m) => m.userId === viewerId);
    if (me?.user.readReceipts === false) return { ok: true };
    this.delivery.tellMany(
      conversation.members.map((m) => m.userId).filter((id) => id !== viewerId),
      { type: 'message.read', conversationId, readerId: viewerId },
    );

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

    // Withdrawn on the other side too. A message that stays on somebody's
    // screen until they happen to reopen the thread was not really deleted.
    const members = await this.prisma.conversationMember.findMany({
      where: { conversationId: message.conversationId },
      select: { userId: true },
    });
    this.delivery.tellMany(
      members.map((m) => m.userId).filter((id) => id !== viewerId),
      {
        type: 'message.deleted',
        conversationId: message.conversationId,
        messageId,
      },
    );

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
            user: { select: { ...this.personShape, readReceipts: true } },
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
