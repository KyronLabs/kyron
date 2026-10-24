import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { MessagesService } from './messages.service';
import { RecordingDelivery } from '../push/delivery.test-double';
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
  /** The reader's own membership row, for pinning. */
  member?: { pinnedAt: Date | null } | null;
  /** How many conversations and community chats the reader has pinned. */
  pins?: [number, number];
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
      findUnique: jest
        .fn()
        .mockResolvedValue('member' in stub ? stub.member : { pinnedAt: null }),
      count: jest.fn().mockResolvedValue(stub.pins?.[0] ?? 0),
      update: jest.fn((args: { data: Record<string, unknown> }) => {
        calls.memberUpdates.push(args);
        return Promise.resolve({ pinnedAt: args.data.pinnedAt ?? null });
      }),
      updateMany: jest.fn((args: unknown) => {
        calls.memberUpdates.push(args);
        return Promise.resolve({ count: 1 });
      }),
    },
    communityChatMember: {
      count: jest.fn().mockResolvedValue(stub.pins?.[1] ?? 0),
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

  const realtime = new RecordingDelivery();
  return {
    service: new MessagesService(prisma, realtime),
    prisma,
    calls,
    realtime,
  };
}

/** Answers the list's two reads: the pinned conversations, and the rest. */
function stubList(
  prisma: PrismaService,
  { pinned = [], rest = [] }: { pinned?: object[]; rest?: object[] },
) {
  (prisma.conversation.findMany as jest.Mock).mockImplementation(
    (args: { where: { members: { some: { pinnedAt?: unknown } } } }) =>
      Promise.resolve(
        args.where.members.some.pinnedAt === null ||
          args.where.members.some.pinnedAt === undefined
          ? rest
          : pinned,
      ),
  );
}

/** `expect.objectContaining`, typed, so the matchers are not `any`. */
const containing = (shape: Record<string, unknown>): unknown =>
  expect.objectContaining(shape);

/** The stubbed read, typed so the spec is not full of `any`. Every row has
 * the relations the query selects, empty unless the test says otherwise. */
function stubReads(prisma: PrismaService, rows: object[]) {
  (prisma.message.findMany as jest.Mock).mockResolvedValue(
    rows.map((row) => ({ keyShares: [], ...row })),
  );
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
    stubReads(prisma, [
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
  it('refuses a conversation whose other side deleted their account', async () => {
    // The deletion takes their membership with it, leaving the reader alone
    // in the thread. A message stored there would be read by nobody.
    const alone = membership(null);
    alone.members = alone.members.filter((m) => m.userId === ME);
    const { service, calls } = serviceWith({ conversation: alone });

    await expect(service.send(ME, 'c1', 'hello?')).rejects.toThrow(
      'This account has been deleted',
    );
    expect(calls.messageCreates).toHaveLength(0);
  });

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

  it('takes a sealed body longer than the limit on what is typed', async () => {
    // A long message in a three-byte script seals to several times its
    // length. Held to the typed limit, it could never be sent.
    const { service, calls } = serviceWith({ conversation: membership(null) });
    const sealed = `k2.${'x'.repeat(MessagesService.maxBody * 3)}`;

    await service.send(ME, 'c1', sealed);

    expect(calls.messageCreates).toHaveLength(1);
  });

  it('still refuses a sealed body past the sealed ceiling', async () => {
    const { service } = serviceWith({ conversation: membership(null) });
    const sealed = `k2.${'x'.repeat(MessagesService.maxSealedBody)}`;

    await expect(service.send(ME, 'c1', sealed)).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('holds a plain body to the limit on what is typed', async () => {
    const { service } = serviceWith({ conversation: membership(null) });
    // Not sealed: does not start with a version prefix.
    const plain = 'y'.repeat(MessagesService.maxBody + 1);

    await expect(service.send(ME, 'c1', plain)).rejects.toBeInstanceOf(
      BadRequestException,
    );
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

  it('stores the id of what a reply answers', async () => {
    const { service, prisma, calls } = serviceWith({
      conversation: membership(null),
    });
    // The message being answered is in this conversation.
    (prisma.message.findFirst as jest.Mock).mockResolvedValue({ id: 'm0' });

    await service.send(ME, 'c1', 'yes', [], 'm0');

    expect(calls.messageCreates[0]).toEqual(
      containing({ data: containing({ replyToId: 'm0' }) }),
    );
  });

  it('stores the id and never the quoted words', async () => {
    // The point of the whole design. A direct message is sealed before it
    // leaves the phone and this server holds ciphertext it cannot read -- so a
    // reply carrying the quoted *text* would write that text into the database
    // in the clear, undoing the encryption for every message anybody ever
    // replied to.
    const { service, prisma, calls } = serviceWith({
      conversation: membership(null),
    });
    (prisma.message.findFirst as jest.Mock).mockResolvedValue({ id: 'm0' });

    await service.send(ME, 'c1', 'yes', [], 'm0');

    const written = JSON.stringify(calls.messageCreates[0]);
    expect(written).toContain('m0');
    // Whatever shape it grows, nothing in it may be called a quote.
    expect(written).not.toMatch(/replyToBody|quoted|replyBody|replyText/i);
  });

  it('refuses a reply to a message in another conversation', async () => {
    // The body is ciphertext the caller cannot read, but accepting this would
    // still tell them the message exists and when it was written.
    const { service, prisma } = serviceWith({
      conversation: membership(null),
    });
    (prisma.message.findFirst as jest.Mock).mockResolvedValue(null);

    await expect(
      service.send(ME, 'c1', 'yes', [], 'somewhere-else'),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  describe('a link card', () => {
    it('is stored as the sender sealed it', async () => {
      const { service, calls } = serviceWith({
        conversation: membership(null),
      });
      await service.send(ME, 'c1', 'k2.body', [], undefined, 'k2.card');
      expect(calls.messageCreates[0]).toEqual(
        containing({ data: containing({ linkCard: 'k2.card' }) }),
      );
    });

    it('is never left open beside sealed words', async () => {
      // The card is about the address in the message. Stored open next to a
      // sealed body, it would put that address in this database in the
      // clear.
      const { service, calls } = serviceWith({
        conversation: membership(null),
      });
      await expect(
        service.send(ME, 'c1', 'k2.body', [], undefined, '{"url":"x"}'),
      ).rejects.toBeInstanceOf(BadRequestException);
      expect(calls.messageCreates).toHaveLength(0);
    });

    it('needs words to be about', async () => {
      const { service } = serviceWith({ conversation: membership(null) });
      await expect(
        service.send(
          ME,
          'c1',
          '',
          [{ url: 'https://cdn.invalid/a.jpg' }],
          undefined,
          'k2.card',
        ),
      ).rejects.toBeInstanceOf(BadRequestException);
    });

    it('is bounded, so it cannot carry a file', async () => {
      const { service } = serviceWith({ conversation: membership(null) });
      const huge = `k2.${'x'.repeat(MessagesService.maxLinkCard)}`;
      await expect(
        service.send(ME, 'c1', 'k2.body', [], undefined, huge),
      ).rejects.toBeInstanceOf(BadRequestException);
    });

    it('is null when there is none', async () => {
      const { service, calls } = serviceWith({
        conversation: membership(null),
      });
      await service.send(ME, 'c1', 'hello');
      expect(calls.messageCreates[0]).toEqual(
        containing({ data: containing({ linkCard: null }) }),
      );
    });
  });

  it('a message that answers nothing carries no reply', async () => {
    const { service, calls } = serviceWith({
      conversation: membership(null),
    });
    await service.send(ME, 'c1', 'hello');
    expect(calls.messageCreates[0]).toEqual(
      containing({ data: containing({ replyToId: null }) }),
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

describe('the push a message sends', () => {
  // The push is drawn by the phone's notification system while the app is in
  // the background, so whatever is in it is what the lock screen shows -- and
  // it travels through Google to get there.
  function pushFor(body: string, media: { url: string }[] = []) {
    const { service, realtime } = serviceWith({
      conversation: membership(null),
    });
    return service.send(ME, 'c1', body, media).then(() => {
      const told = realtime.told.find((t) => t.event.type === 'message.new');
      return told?.push;
    });
  }

  it('never carries a sealed message, which would read as ciphertext', async () => {
    const sealed = 'k1.bm9uY2U.Y2lwaGVydGV4dA.bWFj';
    const push = await pushFor(sealed);
    expect(JSON.stringify(push)).not.toContain('k1.');
    expect(push?.body).toBe('Sent you a message');
  });

  it('never carries an unsealed one through Google either', async () => {
    const push = await pushFor('meet me at the station at six');
    expect(JSON.stringify(push)).not.toContain('station');
    expect(push?.body).toBe('Sent you a message');
  });

  it('says an attachment arrived, without the words beside it', async () => {
    const push = await pushFor('look at this', [
      { url: 'https://example.test/a.jpg' },
    ]);
    expect(JSON.stringify(push)).not.toContain('look at this');
    expect(push?.body).toBe('Sent an attachment');
  });

  it('still names who it is from', async () => {
    const push = await pushFor('hello');
    expect(push?.title).toBe(ME);
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

describe('read receipts', () => {
  function withReceipts(mine: boolean, theirs: boolean) {
    return {
      id: 'c1',
      members: [
        {
          userId: ME,
          lastReadAt: new Date('2026-01-01'),
          user: { ...person(ME), readReceipts: mine },
        },
        {
          userId: THEM,
          lastReadAt: new Date('2026-02-02'),
          user: { ...person(THEM), readReceipts: theirs },
        },
      ],
    };
  }

  const read = {
    id: 'm1',
    body: 'before',
    senderId: ME,
    createdAt: new Date('2026-01-01'),
  };

  it('off on their side: nothing reads as seen', async () => {
    const { service, prisma } = serviceWith({
      conversation: withReceipts(true, false),
    });
    stubReads(prisma, [read]);
    const { items } = await service.messages(ME, 'c1');
    expect(items[0].seen).toBe(false);
  });

  it('off on mine: I am not told either, the way the setting promises', async () => {
    const { service, prisma } = serviceWith({
      conversation: withReceipts(false, true),
    });
    stubReads(prisma, [read]);
    const { items } = await service.messages(ME, 'c1');
    expect(items[0].seen).toBe(false);
  });

  it('off: reading a thread tells nobody', async () => {
    const { service, realtime } = serviceWith({
      conversation: withReceipts(false, true),
    });
    await service.markRead(ME, 'c1');
    expect(realtime.told).toEqual([]);
  });

  it('on: reading a thread tells the other side', async () => {
    const { service, realtime } = serviceWith({
      conversation: withReceipts(true, true),
    });
    await service.markRead(ME, 'c1');
    expect(realtime.told.map((t) => t.event.type)).toEqual(['message.read']);
  });
});

describe('the conversation list', () => {
  function row(
    lastSender: string,
    media: unknown[] = [],
    theirRead = new Date('2026-05-05'),
  ) {
    return {
      id: 'c1',
      lastMessageAt: new Date('2026-04-04'),
      members: [
        {
          userId: ME,
          lastReadAt: new Date('2026-04-04'),
          user: { ...person(ME), readReceipts: true },
        },
        {
          userId: THEM,
          lastReadAt: theirRead,
          user: { ...person(THEM), readReceipts: true },
        },
      ],
      messages: [
        {
          id: 'm9',
          body: '',
          senderId: lastSender,
          createdAt: new Date('2026-04-04'),
          media,
          keyShares: [],
        },
      ],
    };
  }

  it('carries the last message’s attachments, so a voice note is not blank', async () => {
    const { service, prisma } = serviceWith();
    stubList(prisma, {
      rest: [
        row(ME, [
          { id: 'v1', kind: 'VOICE', url: 'https://cdn.invalid/v.m4a' },
        ]),
      ],
    });
    const { items } = await service.list(ME);
    expect(items[0].lastMessage?.media).toHaveLength(1);
  });

  it('says whether the reader’s own last message has been seen', async () => {
    const { service, prisma } = serviceWith();
    stubList(prisma, {
      rest: [row(ME), { ...row(ME, [], new Date('2026-01-01')), id: 'c2' }],
    });
    const { items } = await service.list(ME);
    expect(items.map((i) => i.lastMessage?.seen)).toEqual([true, false]);
  });

  it('puts pinned ones first, the latest pinned on top, and pages the rest', async () => {
    const { service, prisma } = serviceWith();
    const pinnedAt = (at: string) => (r: ReturnType<typeof row>) => ({
      ...r,
      members: r.members.map((m) =>
        m.userId === ME ? { ...m, pinnedAt: new Date(at) } : m,
      ),
    });
    stubList(prisma, {
      // Quiet for months, and still first.
      pinned: [
        pinnedAt('2026-03-01')({ ...row(THEM), id: 'p-old' }),
        pinnedAt('2026-03-09')({ ...row(THEM), id: 'p-new' }),
      ],
      rest: [{ ...row(THEM), id: 'c1' }],
    });
    const { items } = await service.list(ME);
    expect(items.map((i) => i.id)).toEqual(['p-new', 'p-old', 'c1']);
    expect(items[0].pinnedAt).toEqual(new Date('2026-03-09'));
    expect(items[2].pinnedAt).toBeNull();

    // The paged read leaves the pins out, so none is listed twice.
    const [, restQuery] = (prisma.conversation.findMany as jest.Mock).mock
      .calls as [unknown, unknown][];
    expect(restQuery[0]).toEqual(
      containing({
        where: containing({
          members: { some: { userId: ME, hiddenAt: null, pinnedAt: null } },
        }),
      }),
    );
  });

  it('does not list the pins again on a later page', async () => {
    const { service, prisma } = serviceWith();
    stubList(prisma, { pinned: [{ ...row(THEM), id: 'p1' }], rest: [] });
    await service.list(ME, { cursor: 'c9' });
    const calls = (prisma.conversation.findMany as jest.Mock).mock.calls as [
      unknown,
    ][];
    expect(calls).toHaveLength(1);
    expect(calls[0][0]).toEqual(
      containing({
        where: containing({
          members: { some: { userId: ME, hiddenAt: null, pinnedAt: null } },
        }),
      }),
    );
  });

  it('Unanswered is the ones ending on the other person’s word', async () => {
    const { service, prisma } = serviceWith();
    (prisma as unknown as { $queryRaw: jest.Mock }).$queryRaw = jest
      .fn()
      .mockResolvedValue([
        { conversationId: 'c1', senderId: THEM },
        { conversationId: 'c2', senderId: ME },
      ]);
    await service.list(ME, { filter: 'unanswered' });
    const [query] = (prisma.conversation.findMany as jest.Mock).mock
      .calls[0] as unknown[];
    expect(query).toEqual(
      containing({ where: containing({ id: { in: ['c1'] } }) }),
    );
  });

  it('Hidden lists the ones the reader removed', async () => {
    const { service, prisma } = serviceWith();
    await service.list(ME, { filter: 'hidden' });
    const [query] = (prisma.conversation.findMany as jest.Mock).mock
      .calls[0] as unknown[];
    expect(query).toEqual(
      containing({
        where: containing({
          members: { some: { userId: ME, hiddenAt: { not: null } } },
        }),
      }),
    );
  });

  it('hiding one unpins it', async () => {
    const { service, calls } = serviceWith({ conversation: membership(null) });
    await service.hide(ME, 'c1');
    expect(calls.memberUpdates).toContainEqual(
      containing({
        data: { hiddenAt: expect.any(Date) as unknown, pinnedAt: null },
      }),
    );
  });

  it('restoring one puts it back', async () => {
    const { service, calls } = serviceWith({ conversation: membership(null) });
    await service.unhide(ME, 'c1');
    expect(calls.memberUpdates).toContainEqual(
      containing({ data: { hiddenAt: null } }),
    );
  });
});

describe('pinning a conversation', () => {
  it('keeps it at the top, and brings it back from Hidden', async () => {
    const { service, calls } = serviceWith();
    const { pinnedAt } = await service.setPinned(ME, 'c1', true);
    expect(pinnedAt).toBeInstanceOf(Date);
    expect(calls.memberUpdates).toContainEqual(
      containing({
        data: { pinnedAt: expect.any(Date) as unknown, hiddenAt: null },
      }),
    );
  });

  it('allows five, conversations and community chats together', async () => {
    const { service, calls } = serviceWith({ pins: [3, 2] });
    await expect(service.setPinned(ME, 'c1', true)).rejects.toBeInstanceOf(
      BadRequestException,
    );
    expect(calls.memberUpdates).toHaveLength(0);
  });

  it('pinning one already pinned keeps its place', async () => {
    const at = new Date('2026-03-01');
    const { service, calls } = serviceWith({
      member: { pinnedAt: at },
      pins: [5, 0],
    });
    await expect(service.setPinned(ME, 'c1', true)).resolves.toEqual({
      id: 'c1',
      pinnedAt: at,
    });
    expect(calls.memberUpdates).toHaveLength(0);
  });

  it('unpins, even with the list full', async () => {
    const { service, calls } = serviceWith({
      member: { pinnedAt: new Date('2026-03-01') },
      pins: [5, 0],
    });
    await service.setPinned(ME, 'c1', false);
    expect(calls.memberUpdates).toContainEqual(
      containing({ data: { pinnedAt: null } }),
    );
  });

  it('is only for a conversation the reader is in', async () => {
    const { service } = serviceWith({ member: null });
    await expect(service.setPinned(ME, 'c1', true)).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});
