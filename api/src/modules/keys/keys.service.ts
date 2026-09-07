import { BadRequestException, Injectable } from '@nestjs/common';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/** One install's public half. */
export interface PublishedKey {
  userId: string;
  deviceId: string;
  publicKey: string;
}

/** X25519 raw bytes, base64url: 32 bytes is 43 characters unpadded. */
const KEY_PATTERN = /^[A-Za-z0-9_-]{43}=?$/;

/**
 * The public halves people need to write to each other in private.
 *
 * This server never sees a secret half and never sees a plaintext message.
 * What it does is publish keys and carry ciphertext, which is the smallest
 * job it can have and still be useful.
 *
 * That means it cannot verify that a key belongs to who it says it does --
 * only that whoever published it was signed in as them. A server that lied
 * about a key could read what came next, which is why every end-to-end system
 * eventually grows a way for two people to compare fingerprints out of band.
 * That is not built yet and is written down in docs/E2EE.md.
 */
@Injectable()
export class KeysService {
  constructor(private readonly prisma: PrismaService) {}

  /** Publishes, or replaces, this install's key. */
  async publish(
    userId: string,
    deviceId: string,
    publicKey: string,
  ): Promise<PublishedKey> {
    if (!KEY_PATTERN.test(publicKey)) {
      throw new BadRequestException('That is not an X25519 public key.');
    }

    const row = await this.prisma.messageKey.upsert({
      where: { userId_deviceId: { userId, deviceId } },
      update: { publicKey },
      create: { userId, deviceId, publicKey },
    });
    return {
      userId: row.userId,
      deviceId: row.deviceId,
      publicKey: row.publicKey,
    };
  }

  /**
   * Every key one person has published.
   *
   * A list, not one key: somebody with a phone and a tablet has two, and a
   * message has to be sealed for each of them or it arrives on one device and
   * not the other.
   */
  async forUser(userId: string): Promise<PublishedKey[]> {
    const rows = await this.prisma.messageKey.findMany({
      where: { userId },
      orderBy: { updatedAt: 'desc' },
      select: { userId: true, deviceId: true, publicKey: true },
    });
    return rows;
  }

  /** The keys for everybody in a conversation, the reader included. */
  async forConversation(
    viewerId: string,
    conversationId: string,
  ): Promise<PublishedKey[]> {
    const members = await this.prisma.conversationMember.findMany({
      where: { conversationId },
      select: { userId: true },
    });
    // Not found rather than forbidden, so asking about a conversation does not
    // confirm it exists to somebody outside it.
    if (!members.some((m) => m.userId === viewerId)) {
      throw new BadRequestException('That conversation does not exist.');
    }

    const rows = await this.prisma.messageKey.findMany({
      where: { userId: { in: members.map((m) => m.userId) } },
      select: { userId: true, deviceId: true, publicKey: true },
    });
    return rows;
  }

  /** Withdraws one install's key, on sign-out. */
  async withdraw(userId: string, deviceId: string): Promise<void> {
    await this.prisma.messageKey.deleteMany({ where: { userId, deviceId } });
  }
}
