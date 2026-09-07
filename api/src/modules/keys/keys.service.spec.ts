import { BadRequestException } from '@nestjs/common';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { KeysService } from './keys.service';

/** A well-formed X25519 key: 32 bytes, base64url, 43 characters. */
const KEY = 'a'.repeat(43);

const build = (overrides: Record<string, unknown> = {}) => {
  const messageKey = {
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
  return { service: new KeysService(prisma), messageKey, conversationMember };
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
