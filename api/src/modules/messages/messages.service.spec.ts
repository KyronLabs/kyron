import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { MessagesService } from './messages.service';
import { RecordingRealtime } from '../realtime/realtime.test-double';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

const ME = 'me';
const THEM = 'them';

function person(id: string) {
  return { id, name: id, username: id, profile: { avatarUrl: null } };
}

interface Stub {
  conversation?: Record<string, unknown> | null;
  block?: unknown;
  user?: unknown;
}

function serviceWith(stub: Stub = {}) {
  const calls: Record<string, unknown[]> = {
    memberUpdates: [],
    messageCreates: [],
    messageUpdates: [],
    conversationCreates: [],
  };

  const prisma = {
    conversation: {
      findFirst: jest.fn().mockResolvedValue(stub.conversation ?? null),
      findMany: jest.fn().mockResolvedValue([]),
      create: jest.fn((args: unknown) => {
        calls.conversationCreates.push(args);
        return Promise.resolve({ id: 'c-new' });
      }),
      update: jest.fn().mockResolvedValue({}),
    },
    conversationMember: {
      findMany: jest.fn().mockResolvedValue([]),
      updateMany: jest.fn((args: unknown) => {
        calls.memberUpdates.push(args);
        return Promise.resolve({ count: 1 });
      }),
    },
    message: {
      findMany: jest.fn().mockResolvedValue([]),
      groupBy: jest.fn().mockResolvedValue([]),
      findFirst: jest.fn().mockResolvedValue(null),
      create: jest.fn((args: unknown) => {
        calls.messageCreates.push(args);
        return Promise.resolve({
          id: 'm1',
          body: 'hi',
          senderId: ME,
          createdAt: new Date(),
        });
      }),
      update: jest.fn((args: unknown) => {
        calls.messageUpdates.push(args);
        return Promise.resolve({});
      }),
    },
    block: { findFirst: jest.fn().mockResolvedValue(stub.block ?? null) },
    // `in` rather than `??`: the point of some of these cases is an explicit
    // null, which `??` would replace with the default.
    user: {
      findFirst: jest
        .fn()
        .mockResolvedValue('user' in stub ? stub.user : { id: THEM }),
    },
    $transaction: jest.fn((ops: Promise<unknown>[]) => Promise.all(ops)),
  } as unknown as PrismaService;

  const realtime = new RecordingRealtime();
  return {
    service: new MessagesService(prisma, realtime),
    prisma,
    calls,
    realtime,
  };
}

/** `expect.objectContaining`, typed, so the matchers are not `any`. */
const containing = (shape: Record<string, unknown>): unknown =>
  expect.objectContaining(shape);

/** The stubbed read, typed so the spec is not full of `any`. */
function stubReads(prisma: PrismaService, rows: unknown[]) {
  (prisma.message.findMany as jest.Mock).mockResolvedValue(rows);
}

/** A conversation the reader is in, with the other side's read mark. */
function membership(otherReadAt: Date | null) {
  return {
    id: 'c1',
    members: [
      { userId: ME, lastReadAt: new Date('2026-01-01'), user: person(ME) },
      { userId: THEM, lastReadAt: otherReadAt, user: person(THEM) },
    ],
  };
}

describe('opening a conversation', () => {
  it('reuses the one that already exists', async () => {
    // "Message this person" is a thing you can do twice, and both times it
    // should land in the same thread rather than splitting the history.
    const { service, calls } = serviceWith({ conversation: { id: 'c1' } });
    await expect(service.openWith(ME, THEM)).resolves.toEqual({ id: 'c1' });
    expect(calls.conversationCreates).toEqual([]);
  });

  it('un-hides one the reader had removed from their list', async () => {
    const { service, calls } = serviceWith({ conversation: { id: 'c1' } });
    await service.openWith(ME, THEM);
    expect(calls.memberUpdates).toContainEqual(
      containing({ data: { hiddenAt: null } }),
    );
  });

  it('refuses to open one with yourself', async () => {
    const { service } = serviceWith();
    await expect(service.openWith(ME, ME)).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('refuses when either side has blocked the other', async () => {
    for (const block of [{ blockerId: ME }, { blockerId: THEM }]) {
      const { service } = serviceWith({ block });
      await expect(service.openWith(ME, THEM)).rejects.toBeInstanceOf(
        ForbiddenException,
      );
    }
  });

  it('says so when the account is gone', async () => {
    const { service } = serviceWith({ user: null });
    await expect(service.openWith(ME, THEM)).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});

describe('reading a conversation', () => {
  it('is not found for somebody who is not in it', async () => {
    // Not forbidden: whether an id names a real conversation is not something
    // a stranger should learn from the difference.
    const { service } = serviceWith({ conversation: null });
    await expect(service.messages(ME, 'c1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });

  it('marks a message seen once the other side has read past it', async () => {
    const { service, prisma } = serviceWith({
      conversation: membership(new Date('2026-02-02')),
    });
    stubReads(prisma, [
      {
        id: 'm2',
        body: 'after',
        senderId: ME,
        createdAt: new Date('2026-03-03'),
      },
      {
        id: 'm1',
        body: 'before',
        senderId: ME,
        createdAt: new Date('2026-01-01'),
      },
    ]);

    const { items } = await service.messages(ME, 'c1');
    expect(items.map((m) => [m.id, m.seen])).toEqual([
      ['m2', false],
      ['m1', true],
    ]);
  });

  it('marks nothing seen while the other side has never opened it', async () => {
    const { service, prisma } = serviceWith({
      conversation: membership(null),
    });
    (prisma.message.findMany as jest.Mock).mockResolvedValue([
      {
        id: 'm1',
        body: 'hi',
        senderId: ME,
        createdAt: new Date('2020-01-01'),
      },
    ]);

    const { items } = await service.messages(ME, 'c1');
    expect(items[0].seen).toBe(false);
  });
});

describe('sending', () => {
  it('refuses an empty message', async () => {
    const { service } = serviceWith({ conversation: membership(null) });
    await expect(service.send(ME, 'c1', '   ')).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('refuses one past the limit', async () => {
    const { service } = serviceWith({ conversation: membership(null) });
    await expect(
      service.send(ME, 'c1', 'x'.repeat(MessagesService.maxBody + 1)),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('trims what it stores', async () => {
    const { service, calls } = serviceWith({
      conversation: membership(null),
    });
    await service.send(ME, 'c1', '  hello  ');
    expect(calls.messageCreates[0]).toEqual(
      containing({ data: containing({ body: 'hello' }) }),
    );
  });

  it('counts as reading, and brings the thread back for both sides', async () => {
    // A reply landing in a thread the other side had removed would otherwise
    // go somewhere they cannot see.
    const { service, calls } = serviceWith({
      conversation: membership(null),
    });
    await service.send(ME, 'c1', 'hello');

    expect(calls.memberUpdates).toContainEqual(
      containing({
        data: containing({ hiddenAt: null }),
        where: containing({ userId: ME }),
      }),
    );
    expect(calls.memberUpdates).toContainEqual(
      containing({
        data: { hiddenAt: null },
        where: containing({ userId: { not: ME } }),
      }),
    );
  });

  it('refuses once a block is in place either way', async () => {
    const { service } = serviceWith({
      conversation: membership(null),
      block: { blockerId: THEM },
    });
    await expect(service.send(ME, 'c1', 'hello')).rejects.toBeInstanceOf(
      ForbiddenException,
    );
  });
});

describe('removing', () => {
  it("will not remove somebody else's message", async () => {
    const { service, prisma } = serviceWith();
    (prisma.message.findFirst as jest.Mock).mockResolvedValue({
      id: 'm1',
      senderId: THEM,
      conversationId: 'c1',
    } as unknown);
    await expect(service.remove(ME, 'm1')).rejects.toBeInstanceOf(
      ForbiddenException,
    );
  });

  it('soft deletes your own', async () => {
    const { service, prisma, calls } = serviceWith();
    (prisma.message.findFirst as jest.Mock).mockResolvedValue({
      id: 'm1',
      senderId: ME,
      conversationId: 'c1',
    } as unknown);
    await service.remove(ME, 'm1');
    expect(calls.messageUpdates[0]).toEqual(
      containing({ data: { deletedAt: expect.any(Date) as Date } }),
    );
  });
});

describe('hiding a conversation', () => {
  it("touches only the reader's own membership", async () => {
    // The messages are the other side's history too; deleting them would be
    // deciding that for both people.
    const { service, calls } = serviceWith({
      conversation: membership(null),
    });
    await service.hide(ME, 'c1');
    expect(calls.memberUpdates).toEqual([
      containing({ where: { conversationId: 'c1', userId: ME } }),
    ]);
  });
});
