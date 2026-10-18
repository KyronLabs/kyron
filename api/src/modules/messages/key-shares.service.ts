import {
  BadRequestException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { DeliveryService } from '../push/delivery.service';

/** One request a device may be able to answer. */
export interface KeyRequest {
  id: string;
  conversationId: string;
  messageId: string;
  /** The sealed message, which the answering device opens to reach its key. */
  body: string;
  /** Its sealed link card, if it has one: that key travels in the same
   * answer, after the message's. */
  linkCard: string | null;
  /** The asking device's public key: what the answer is sealed for. */
  publicKey: string;
}

/** One message's key, sealed for one of the reader's devices. */
export interface KeyShare {
  publicKey: string;
  sealed: string;
}

const KEY = '[A-Za-z0-9_-]{43}=?';
const PART = '[A-Za-z0-9_-]+={0,2}';
/** `<answering key>.<nonce>.<sealed key>.<mac>`, every part base64url. */
const SHARE = new RegExp(`^(${KEY})\\.${PART}\\.${PART}\\.${PART}$`);

/**
 * Messages a device was not sealed for, opened for it by a device that was.
 *
 * A message is sealed for the devices listed when it is sent. One that came
 * later -- a new phone, a reinstall, a key lost to the old sign-out -- could
 * never read it, and showed "This message cannot be read on this device"
 * for good. Now the device asks, and any device in the conversation that can
 * open the message seals its key again for the one asking: the sender's
 * phone, or another of the reader's own. The way WhatsApp's "Waiting for
 * this message" works, and with the same property: this server carries a
 * request and an answer and can read neither.
 *
 * What it does change is what an actively malicious server could do. One
 * that published a key of its own under somebody's name could already read
 * what was sent after; asking with it, it could now be handed recent history
 * too. [window] bounds how far back, and docs/E2EE.md says so.
 */
@Injectable()
export class KeySharesService {
  private readonly logger = new Logger(KeySharesService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly delivery: DeliveryService,
  ) {}

  /** How old a message may be and still be asked for, or answered. */
  static readonly windowDays = 30;

  /** The most requests handed out at once. */
  static readonly maxPending = 100;

  private static since(now = new Date()): Date {
    return new Date(now.getTime() - KeySharesService.windowDays * 86_400_000);
  }

  /**
   * Asks, for the device [deviceId], for the keys of [messageIds].
   *
   * Asking again for one already answered clears the answer: a device asks
   * only for what it could not open, so an answer it holds and still cannot
   * open is no answer.
   */
  async request(
    viewerId: string,
    conversationId: string,
    deviceId: string,
    messageIds: string[],
  ): Promise<{ requested: number }> {
    const members = await this.membersOf(viewerId, conversationId);
    const key = await this.prisma.messageKey.findUnique({
      where: { userId_deviceId: { userId: viewerId, deviceId } },
      select: { publicKey: true },
    });
    if (!key) {
      throw new BadRequestException(
        'This device has published no key to seal for.',
      );
    }

    const found = await this.prisma.message.findMany({
      where: {
        id: { in: [...new Set(messageIds)] },
        conversationId,
        deletedAt: null,
        body: { startsWith: 'k2.' },
        createdAt: { gte: KeySharesService.since() },
      },
      select: { id: true },
    });
    const ids = found.map((m) => m.id);
    if (ids.length === 0) return { requested: 0 };

    await this.prisma.messageKeyShare.updateMany({
      where: { messageId: { in: ids }, publicKey: key.publicKey },
      data: { sealed: null, answeredAt: null },
    });
    await this.prisma.messageKeyShare.createMany({
      data: ids.map((messageId) => ({
        messageId,
        userId: viewerId,
        publicKey: key.publicKey,
      })),
      skipDuplicates: true,
    });

    // Everybody in it, the asker included: another of their own devices may
    // be the one that can answer.
    this.delivery.tellMany(members, {
      type: 'message.keys.requested',
      conversationId,
    });
    return { requested: ids.length };
  }

  /**
   * What the reader's devices may be able to answer: requests in their
   * conversations, from a device whose key is still published, for a message
   * inside the window.
   */
  async pending(viewerId: string): Promise<KeyRequest[]> {
    const rows = await this.prisma.messageKeyShare.findMany({
      where: {
        sealed: null,
        message: {
          deletedAt: null,
          createdAt: { gte: KeySharesService.since() },
          conversation: { members: { some: { userId: viewerId } } },
        },
      },
      orderBy: { createdAt: 'desc' },
      take: KeySharesService.maxPending,
      select: {
        id: true,
        userId: true,
        publicKey: true,
        message: {
          select: {
            id: true,
            conversationId: true,
            body: true,
            linkCard: true,
          },
        },
      },
    });
    if (rows.length === 0) return [];

    // A key withdrawn since it asked has no secret half anywhere to open an
    // answer with.
    const live = await this.prisma.messageKey.findMany({
      where: { publicKey: { in: rows.map((r) => r.publicKey) } },
      select: { publicKey: true, userId: true },
    });
    const owner = new Map(live.map((k) => [k.publicKey, k.userId]));

    return rows
      .filter((r) => owner.get(r.publicKey) === r.userId)
      .map((r) => ({
        id: r.id,
        conversationId: r.message.conversationId,
        messageId: r.message.id,
        body: r.message.body,
        linkCard: r.message.linkCard,
        publicKey: r.publicKey,
      }));
  }

  /**
   * Answers requests: each message's key, sealed by one of the reader's own
   * devices for the device that asked.
   *
   * The answering key has to be one this account published, so an answer
   * says which device gave it, and the reader's app can tell it from noise.
   * First answer wins; a second for the same request changes nothing.
   */
  async answer(
    viewerId: string,
    shares: { id: string; sealed: string }[],
  ): Promise<{ answered: number }> {
    const mine = new Set(
      (
        await this.prisma.messageKey.findMany({
          where: { userId: viewerId },
          select: { publicKey: true },
        })
      ).map((k) => k.publicKey),
    );
    for (const share of shares) {
      const match = SHARE.exec(share.sealed);
      if (!match) {
        throw new BadRequestException('That is not a sealed message key.');
      }
      if (!mine.has(match[1])) {
        throw new BadRequestException(
          'Answer with a key this account has published.',
        );
      }
    }

    const rows = await this.prisma.messageKeyShare.findMany({
      where: {
        id: { in: shares.map((s) => s.id) },
        sealed: null,
        message: {
          deletedAt: null,
          conversation: { members: { some: { userId: viewerId } } },
        },
      },
      select: {
        id: true,
        userId: true,
        message: { select: { conversationId: true } },
      },
    });

    const sealedBy = new Map(shares.map((s) => [s.id, s.sealed]));
    const told = new Map<string, Set<string>>();
    let answered = 0;
    for (const row of rows) {
      const { count } = await this.prisma.messageKeyShare.updateMany({
        where: { id: row.id, sealed: null },
        data: { sealed: sealedBy.get(row.id), answeredAt: new Date() },
      });
      if (count === 0) continue;
      answered += count;
      const conversations = told.get(row.userId) ?? new Set<string>();
      conversations.add(row.message.conversationId);
      told.set(row.userId, conversations);
    }

    for (const [userId, conversations] of told) {
      for (const conversationId of conversations) {
        this.delivery.tell(userId, {
          type: 'message.keys.shared',
          conversationId,
        });
      }
    }
    if (answered > 0) {
      this.logger.log(`${answered} message keys shared by ${viewerId}`);
    }
    return { answered };
  }

  /** Who is in it, if the reader is; not found otherwise. */
  private async membersOf(
    viewerId: string,
    conversationId: string,
  ): Promise<string[]> {
    const members = await this.prisma.conversationMember.findMany({
      where: { conversationId },
      select: { userId: true },
    });
    if (!members.some((m) => m.userId === viewerId)) {
      throw new NotFoundException('That conversation does not exist.');
    }
    return members.map((m) => m.userId);
  }
}
