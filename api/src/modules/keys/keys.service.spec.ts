import { BadRequestException } from '@nestjs/common';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { RealtimeService } from '../realtime/realtime.service';
import { KeysService } from './keys.service';

/** A well-formed X25519 key: 32 bytes, base64url, 43 characters. */
const KEY = 'a'.repeat(43);

const build = (overrides: Record<string, unknown> = {}) => {
  const messageKey = {
    findUnique: jest.fn().mockResolvedValue(null),
    upsert: jest.fn(),
    findMany: jest.fn().mockResolvedValue([]),
    deleteMany: jest.fn().mockResolvedValue({ count: 1 }),
  };
  const conversationMember = {
    findMany: jest
      .fn()
      .mockResolvedValue([{ userId: 'me' }, { userId: 'them' }]),
  };
  const prisma = {
    messageKey,
    conversationMember,
    ...overrides,
  } as unknown as PrismaService;
  const realtime = { emitToMany: jest.fn() };
  return {
    service: new KeysService(prisma, realtime as unknown as RealtimeService),
    messageKey,
    conversationMember,
    realtime,
  };
};

describe('KeysService', () => {
  describe('publish', () => {
    it('stores a well-formed key against the install', async () => {
      const { service, messageKey } = build();
      messageKey.upsert.mockResolvedValue({
        userId: 'me',
        deviceId: 'device-1234',
        publicKey: KEY,
      });

      await service.publish('me', 'device-1234', KEY);

      expect(messageKey.upsert).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { userId_deviceId: { userId: 'me', deviceId: 'device-1234' } },
        }),
      );
    });

    it('tells everybody who writes to the account about a new device', async () => {
      // Their apps hold each conversation's device list for minutes, and
      // sealed for the old one meanwhile: the new phone could open nothing
      // sent to it in its first minutes.
      const { service, messageKey, conversationMember, realtime } = build();
      messageKey.upsert.mockResolvedValue({
        userId: 'me',
        deviceId: 'new-phone',
        publicKey: KEY,
      });

      await service.publish('me', 'new-phone', KEY);

      expect(conversationMember.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { conversation: { members: { some: { userId: 'me' } } } },
        }),
      );
      expect(realtime.emitToMany).toHaveBeenCalledWith(['me', 'them'], {
        type: 'keys.changed',
        userId: 'me',
      });
    });

    it('says nothing when the same key is published again', async () => {
      // Every sign-in publishes; announcing each would drop every
      // correspondent's device lists on every launch.
      const { service, messageKey, realtime } = build();
      messageKey.findUnique.mockResolvedValue({ publicKey: KEY });
      messageKey.upsert.mockResolvedValue({
        userId: 'me',
        deviceId: 'phone',
        publicKey: KEY,
      });

      await service.publish('me', 'phone', KEY);

      expect(realtime.emitToMany).not.toHaveBeenCalled();
    });

    it('refuses anything that is not a key', async () => {
      // A short or malformed value would be stored and then fail to seal on
      // every device that fetched it, which is a hard failure to trace.
      const { service, messageKey } = build();

      await expect(service.publish('me', 'd', 'short')).rejects.toThrow(
        BadRequestException,
      );
      await expect(service.publish('me', 'd', '!'.repeat(43))).rejects.toThrow(
        BadRequestException,
      );
      expect(messageKey.upsert).not.toHaveBeenCalled();
    });
  });

  describe('forConversation', () => {
    it('answers with the keys of everybody in it', async () => {
      const { service, messageKey } = build();
      await service.forConversation('me', 'c1');

      expect(messageKey.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { userId: { in: ['me', 'them'] } },
        }),
      );
    });

    it('lists the freshest devices first, so a cap drops the stale ones', async () => {
      const { service, messageKey } = build();
      await service.forConversation('me', 'c1');

      expect(messageKey.findMany).toHaveBeenCalledWith(
        expect.objectContaining({ orderBy: { updatedAt: 'desc' } }),
      );
    });

    it('does not confirm a conversation the reader is not in', async () => {
      const { service, messageKey } = build();

      await expect(service.forConversation('stranger', 'c1')).rejects.toThrow(
        BadRequestException,
      );
      expect(messageKey.findMany).not.toHaveBeenCalled();
    });
  });

  it('withdraws only the install that asked', async () => {
    const { service, messageKey } = build();

    await service.withdraw('me', 'device-1234');

    // Scoped to one device: signing out of a phone must not stop a tablet
    // being written to.
    expect(messageKey.deleteMany).toHaveBeenCalledWith({
      where: { userId: 'me', deviceId: 'device-1234' },
    });
  });
});
