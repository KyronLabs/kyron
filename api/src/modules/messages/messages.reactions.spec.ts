import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { MessagesService } from './messages.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/**
 * Reactions, "is typing", and the read mark the "New messages" divider uses.
 *
 * What matters most here is what each one tells the other side, and how:
 * ids over the socket, never a push, never to the person who did it.
 */
const ME = 'me';
const THEM = 'them';

function person(id: string) {
  return { id, name: id, username: id, profile: { avatarUrl: null } };
}

function serviceWith(
  opts: {
    member?: boolean;
    message?: boolean;
    block?: boolean;
    myLastReadAt?: Date | null;
    removed?: number;
  } = {},
) {
  const conversation =
    opts.member === false
      ? null
      : {
          id: 'c1',
          members: [
            {
              userId: ME,
              lastReadAt: opts.myLastReadAt ?? null,
              mutedAt: null,
              user: person(ME),
            },
            {
              userId: THEM,
              lastReadAt: null,
              mutedAt: null,
              user: person(THEM),
            },
          ],
        };

  const upsert = jest.fn().mockResolvedValue({});
  const deleteMany = jest.fn().mockResolvedValue({ count: opts.removed ?? 1 });
  const reactionFindMany = jest
    .fn()
    .mockResolvedValue([{ userId: THEM, emoji: '❤️' }]);
  const messageFindMany = jest
    .fn<Promise<unknown[]>, [unknown]>()
    .mockResolvedValue([]);

  const prisma = {
    conversation: {
      findFirst: jest.fn().mockResolvedValue(conversation),
    },
    message: {
      findFirst: jest
        .fn()
        .mockResolvedValue(opts.message === false ? null : { id: 'm1' }),
      findMany: messageFindMany,
    },
    block: {
      findFirst: jest
        .fn()
        .mockResolvedValue(opts.block ? { blockerId: THEM } : null),
    },
    messageReaction: {
      upsert,
      deleteMany,
      findMany: reactionFindMany,
    },
  } as unknown as PrismaService;

  const delivery = new RecordingDelivery();
  return {
    service: new MessagesService(prisma, delivery),
    delivery,
    upsert,
    deleteMany,
    messageFindMany,
  };
}

describe('what a reaction can be', () => {
  it('is one emoji, however many code points it takes', () => {
    for (const emoji of ['❤️', '😂', '👍🏾', '👩🏽‍💻', '🏳️‍🌈', '🇳🇬', '1️⃣', '👨‍👩‍👧‍👦']) {
      expect(MessagesService.isReactionEmoji(emoji)).toBe(true);
    }
  });

  it('is never words, two emoji, or nothing', () => {
    for (const value of ['', 'a', 'nice', '😂😂', 'lol 😂', '1', '🇳']) {
      expect(MessagesService.isReactionEmoji(value)).toBe(false);
    }
  });

  it('is never long enough to hide a message in', () => {
    expect(MessagesService.isReactionEmoji('😂'.repeat(20))).toBe(false);
  });
});

describe('reacting', () => {
  it('stores the reaction, replacing any the reader already had', async () => {
    const { service, upsert } = serviceWith();
    await service.react(ME, 'c1', 'm1', '❤️');

    expect(upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { messageId_userId: { messageId: 'm1', userId: ME } },
        create: { messageId: 'm1', userId: ME, emoji: '❤️' },
      }),
    );
  });

  it('tells the other side by id, without a push and without the emoji', async () => {
    const { service, delivery } = serviceWith();
    await service.react(ME, 'c1', 'm1', '😂');

    expect(delivery.told).toHaveLength(1);
    const [told] = delivery.told;
    expect(told.userIds).toEqual([THEM]);
    expect(told.event).toEqual({
      type: 'message.reaction',
      conversationId: 'c1',
      messageId: 'm1',
    });
    expect(told.push).toBeUndefined();
    expect(JSON.stringify(told)).not.toContain('😂');
  });

  it('refuses anything that is not one emoji', async () => {
    const { service, upsert } = serviceWith();
    await expect(service.react(ME, 'c1', 'm1', 'nice')).rejects.toBeInstanceOf(
      BadRequestException,
    );
    expect(upsert).not.toHaveBeenCalled();
  });

  it('is not found for somebody who is not in the conversation', async () => {
    const { service } = serviceWith({ member: false });
    await expect(service.react(ME, 'c1', 'm1', '❤️')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });

  it('is not found for a message that is gone, or in another thread', async () => {
    const { service, upsert } = serviceWith({ message: false });
    await expect(service.react(ME, 'c1', 'm1', '❤️')).rejects.toBeInstanceOf(
      NotFoundException,
    );
    expect(upsert).not.toHaveBeenCalled();
  });

  it('is refused across a block, the same as sending', async () => {
    const { service, upsert } = serviceWith({ block: true });
    await expect(service.react(ME, 'c1', 'm1', '❤️')).rejects.toBeInstanceOf(
      ForbiddenException,
    );
    expect(upsert).not.toHaveBeenCalled();
  });
});

describe('taking a reaction back', () => {
  it('removes only the reader’s own, and only in this conversation', async () => {
    const { service, deleteMany } = serviceWith();
    await service.unreact(ME, 'c1', 'm1');

    expect(deleteMany).toHaveBeenCalledWith({
      where: { messageId: 'm1', userId: ME, message: { conversationId: 'c1' } },
    });
  });

  it('tells the other side when there was one to take back', async () => {
    const { service, delivery } = serviceWith();
    await service.unreact(ME, 'c1', 'm1');
    expect(delivery.ofType('message.reaction')).toHaveLength(1);
  });

  it('tells nobody when there was nothing to take back', async () => {
    const { service, delivery } = serviceWith({ removed: 0 });
    await service.unreact(ME, 'c1', 'm1');
    expect(delivery.told).toHaveLength(0);
  });
});

describe('reading one message’s reactions', () => {
  it('answers for a member', async () => {
    const { service } = serviceWith();
    expect(await service.reactionsFor(ME, 'c1', 'm1')).toEqual({
      messageId: 'm1',
      reactions: [{ userId: THEM, emoji: '❤️' }],
    });
  });

  it('is not found for anyone else', async () => {
    const { service } = serviceWith({ member: false });
    await expect(service.reactionsFor(ME, 'c1', 'm1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});

describe('typing', () => {
  it('tells everyone else who is typing, over the socket only', async () => {
    const { service, delivery } = serviceWith();
    await service.typing(ME, 'c1');

    expect(delivery.told).toEqual([
      {
        userIds: [THEM],
        event: { type: 'message.typing', conversationId: 'c1', userId: ME },
        push: undefined,
      },
    ]);
  });

  it('is not found for somebody who is not in the conversation', async () => {
    const { service, delivery } = serviceWith({ member: false });
    await expect(service.typing(ME, 'c1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
    expect(delivery.told).toHaveLength(0);
  });

  it('says nothing across a block', async () => {
    const { service, delivery } = serviceWith({ block: true });
    await expect(service.typing(ME, 'c1')).rejects.toBeInstanceOf(
      ForbiddenException,
    );
    expect(delivery.told).toHaveLength(0);
  });
});

describe('the thread', () => {
  it('carries each message’s reactions', async () => {
    const { service, messageFindMany } = serviceWith();
    await service.messages(ME, 'c1');

    const { select } = messageFindMany.mock.calls[0][0] as {
      select: { reactions?: unknown };
    };
    expect(select.reactions).toEqual(
      expect.objectContaining({ select: { userId: true, emoji: true } }),
    );
  });

  it('says how far the reader had read before opening it', async () => {
    const readAt = new Date('2026-10-01T09:00:00Z');
    const { service } = serviceWith({ myLastReadAt: readAt });
    const page = await service.messages(ME, 'c1');
    expect(page.lastReadAt).toEqual(readAt);
  });

  it('says null for a thread the reader has never opened', async () => {
    const { service } = serviceWith({ myLastReadAt: null });
    const page = await service.messages(ME, 'c1');
    expect(page.lastReadAt).toBeNull();
  });
});
