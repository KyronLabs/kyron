import { CommunityChatWriters, CommunityRole, MediaKind } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { RecordingPrivateStorage } from '../../infrastructure/supabase/private-storage.test-double';
import { RecordingDelivery } from '../push/delivery.test-double';
import { CommunityChatsService } from './community-chats.service';

/**
 * Who may do what in a community chat, without a database, so CI holds the
 * rules. community-chats.db.spec.ts runs the same against a real one.
 */

const CHAT = 'chat-1';
const NOW = new Date('2026-10-21T12:00:00Z');

interface Scene {
  /** Each person's role in the community; absent means not in it. */
  roles: Record<string, CommunityRole>;
  /** Who has joined the chat. */
  joined: string[];
  writers?: CommunityChatWriters;
  slowModeSeconds?: number;
  /** Messages already sent: who, how long ago. */
  sent?: { senderId: string; secondsAgo: number }[];
  /** The message being acted on, and who wrote it. */
  message?: { id: string; senderId: string };
}

type Transaction = Promise<unknown>[] | ((tx: unknown) => Promise<unknown>);

function service(scene: Scene) {
  const created: unknown[] = [];
  const sent = (scene.sent ?? []).map((m) => ({
    ...m,
    createdAt: new Date(NOW.getTime() - m.secondsAgo * 1000),
  }));
  const prisma = {
    community: {
      findFirst: jest.fn(() =>
        Promise.resolve({
          id: 'c1',
          slug: 'birders',
          name: 'Birders',
          avatarUrl: null,
        }),
      ),
    },
    communityChat: {
      findFirst: jest.fn(() =>
        Promise.resolve({
          id: CHAT,
          writers: scene.writers ?? CommunityChatWriters.MEMBERS,
          slowModeSeconds: scene.slowModeSeconds ?? 0,
          community: {
            id: 'c1',
            slug: 'birders',
            name: 'Birders',
            avatarUrl: null,
          },
        }),
      ),
      findMany: jest.fn(() => Promise.resolve([])),
      update: jest.fn(() => Promise.resolve({})),
      updateMany: jest.fn(() => Promise.resolve({ count: 0 })),
    },
    communityMember: {
      findUnique: jest.fn(
        ({ where }: { where: { communityId_userId: { userId: string } } }) => {
          const role = scene.roles[where.communityId_userId.userId];
          return Promise.resolve(role ? { role } : null);
        },
      ),
      findMany: jest.fn(() => Promise.resolve([])),
    },
    communityChatMember: {
      findUnique: jest.fn(
        ({ where }: { where: { chatId_userId: { userId: string } } }) =>
          Promise.resolve(
            scene.joined.includes(where.chatId_userId.userId)
              ? { userId: where.chatId_userId.userId }
              : null,
          ),
      ),
      findMany: jest.fn(() => Promise.resolve([])),
      updateMany: jest.fn(() => Promise.resolve({ count: 1 })),
    },
    communityChatMessage: {
      findMany: jest.fn(
        ({
          where,
        }: {
          where: { id?: string; senderId?: string; createdAt?: { gt: Date } };
        }) => {
          // Reading back the message just sent.
          if (where.id) {
            return Promise.resolve([
              {
                id: where.id,
                chatId: CHAT,
                body: 'hello',
                createdAt: NOW,
                senderId: 'someone',
                sender: {
                  id: 'someone',
                  name: null,
                  username: null,
                  verifiedAt: null,
                  profile: null,
                },
                chat: { communityId: 'c1' },
                replyTo: null,
              },
            ]);
          }
          return Promise.resolve(
            sent.filter(
              (m) =>
                m.senderId === where.senderId &&
                (!where.createdAt || m.createdAt > where.createdAt.gt),
            ),
          );
        },
      ),
      findFirst: jest.fn(
        ({ where }: { where: { id?: string; senderId?: string } }) => {
          if (where.id) {
            return Promise.resolve(
              scene.message && scene.message.id === where.id
                ? scene.message
                : null,
            );
          }
          const mine = sent
            .filter((m) => m.senderId === where.senderId)
            .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime());
          return Promise.resolve(mine[0] ?? null);
        },
      ),
      create: jest.fn((args: unknown) => {
        created.push(args);
        return Promise.resolve({ id: 'new' });
      }),
      update: jest.fn(() => Promise.resolve({})),
    },
    communityChatReaction: {
      upsert: jest.fn(() => Promise.resolve({})),
      groupBy: jest.fn(() => Promise.resolve([])),
      findMany: jest.fn(() => Promise.resolve([])),
    },
    block: { findMany: jest.fn(() => Promise.resolve([])) },
    media: {
      count: jest.fn(() => Promise.resolve(0)),
      findMany: jest.fn(() => Promise.resolve([])),
      createMany: jest.fn(() => Promise.resolve({ count: 0 })),
      deleteMany: jest.fn(() => Promise.resolve({ count: 0 })),
    },
    communityChatPoll: {
      findMany: jest.fn(() => Promise.resolve([])),
      create: jest.fn(() => Promise.resolve({})),
      deleteMany: jest.fn(() => Promise.resolve({ count: 0 })),
    },
    communityChatMessageEdit: {
      deleteMany: jest.fn(() => Promise.resolve({ count: 0 })),
    },
    // Nobody to push to.
    $queryRaw: jest.fn(() => Promise.resolve([])),
    $executeRaw: jest.fn(() => Promise.resolve(1)),
    $transaction: jest.fn(
      (ops: Transaction): Promise<unknown> => Promise.resolve(ops),
    ),
  };
  // Both forms: a list of writes, or a callback handed the client.
  prisma.$transaction.mockImplementation((ops: Transaction) =>
    typeof ops === 'function' ? ops(prisma) : Promise.all(ops),
  );
  const svc = new CommunityChatsService(
    prisma as unknown as PrismaService,
    new RecordingDelivery(),
    new RecordingPrivateStorage().asService,
  );
  return { svc, created, prisma };
}

const send = (svc: CommunityChatsService, who: string, body = 'hello') =>
  svc.send(who, CHAT, { body }, NOW);

describe('a chat’s name and words', () => {
  it('trims a name to single spaces, and refuses an empty or long one', () => {
    expect(CommunityChatsService.chatName('  General   chat ')).toBe(
      'General chat',
    );
    expect(() => CommunityChatsService.chatName('   ')).toThrow();
    expect(() => CommunityChatsService.chatName('x'.repeat(41))).toThrow();
  });

  it('refuses an empty or overlong message', () => {
    expect(CommunityChatsService.body('  hi  ')).toBe('hi');
    expect(() => CommunityChatsService.body(' \n ')).toThrow();
    expect(() => CommunityChatsService.body('x'.repeat(2001))).toThrow();
  });

  it('counts the owner and moderators as running it, and nobody else', () => {
    expect(CommunityChatsService.moderates(CommunityRole.OWNER)).toBe(true);
    expect(CommunityChatsService.moderates(CommunityRole.MODERATOR)).toBe(true);
    expect(CommunityChatsService.moderates(CommunityRole.MEMBER)).toBe(false);
    expect(CommunityChatsService.moderates(null)).toBe(false);
  });
});

describe('who may read and write', () => {
  it('shuts out anybody not in the community', async () => {
    const { svc } = service({ roles: {}, joined: ['ben'] });
    // Joined the chat once, and since removed from the community: out.
    await expect(send(svc, 'ben')).rejects.toMatchObject({ status: 403 });
    await expect(svc.messages('ben', CHAT)).rejects.toMatchObject({
      status: 403,
    });
  });

  it('lets a member read without joining, but not write', async () => {
    const { svc, created } = service({
      roles: { ada: CommunityRole.MEMBER },
      joined: [],
    });
    await expect(send(svc, 'ada')).rejects.toMatchObject({ status: 403 });
    expect(created).toEqual([]);
  });

  it('keeps an announcements chat to the owner and moderators', async () => {
    const scene = {
      roles: { ada: CommunityRole.MEMBER, mod: CommunityRole.MODERATOR },
      joined: ['ada', 'mod'],
      writers: CommunityChatWriters.MODERATORS,
    };
    await expect(send(service(scene).svc, 'ada')).rejects.toMatchObject({
      status: 403,
    });
    await expect(send(service(scene).svc, 'mod')).resolves.toBeDefined();
  });

  it('refuses a burst of messages', async () => {
    const { svc } = service({
      roles: { ada: CommunityRole.MEMBER },
      joined: ['ada'],
      sent: [1, 2, 3, 4, 5].map((s) => ({ senderId: 'ada', secondsAgo: s })),
    });
    await expect(send(svc, 'ada')).rejects.toMatchObject({ status: 429 });
  });

  it('counts a sender’s messages only after taking their turn', async () => {
    // Without this, requests sent side by side all count none before them.
    const { svc, prisma } = service({
      roles: { ada: CommunityRole.MEMBER },
      joined: ['ada'],
    });
    await send(svc, 'ada');
    const [lock] = prisma.$executeRaw.mock.calls as unknown as [
      [TemplateStringsArray, string],
    ];
    expect(lock[0].join('?')).toContain('pg_advisory_xact_lock');
    expect(lock[1]).toBe(`community-chat:send:${CHAT}:ada`);
    const locked = prisma.$executeRaw.mock.invocationCallOrder[0];
    const counted =
      prisma.communityChatMessage.findMany.mock.invocationCallOrder[0];
    expect(locked).toBeLessThan(counted);
  });

  it('holds members to slow mode, and not moderators', async () => {
    const scene = (who: string, role: CommunityRole) => ({
      roles: { [who]: role },
      joined: [who],
      slowModeSeconds: 30,
      sent: [{ senderId: who, secondsAgo: 12 }],
    });
    await expect(
      send(service(scene('ada', CommunityRole.MEMBER)).svc, 'ada'),
    ).rejects.toMatchObject({ status: 429 });
    await expect(
      send(service(scene('mod', CommunityRole.MODERATOR)).svc, 'mod'),
    ).resolves.toBeDefined();
  });
});

describe('who may take a message down', () => {
  it('lets nobody but its author, or the people running the community', async () => {
    const { svc } = service({
      roles: { ada: CommunityRole.MEMBER, ben: CommunityRole.MEMBER },
      joined: [],
      message: { id: 'm1', senderId: 'ben' },
    });
    await expect(svc.deleteMessage('ada', CHAT, 'm1')).rejects.toMatchObject({
      status: 403,
    });
  });

  it('keeps the owner’s and other moderators’ messages from a moderator', async () => {
    const { svc } = service({
      roles: { mod: CommunityRole.MODERATOR, owner: CommunityRole.OWNER },
      joined: [],
      message: { id: 'm1', senderId: 'owner' },
    });
    await expect(svc.deleteMessage('mod', CHAT, 'm1')).rejects.toMatchObject({
      status: 403,
    });
  });

  it('erases the words when the author takes it down', async () => {
    const { svc, prisma } = service({
      roles: { ben: CommunityRole.MEMBER },
      joined: [],
      message: { id: 'm1', senderId: 'ben' },
    });
    await svc.deleteMessage('ben', CHAT, 'm1');
    expect(prisma.communityChatMessage.update).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({
          body: '',
          deletedById: 'ben',
        }) as unknown,
      }),
    );
  });
});

describe('reactions', () => {
  it('are a single emoji', async () => {
    const { svc } = service({
      roles: { ada: CommunityRole.MEMBER },
      joined: [],
      message: { id: 'm1', senderId: 'ben' },
    });
    await expect(svc.react('ada', CHAT, 'm1', 'lol')).rejects.toMatchObject({
      status: 400,
    });
  });
});

describe('what a message may carry', () => {
  const ADA = '0b6b6c2a-0000-4000-8000-000000000001';
  const own = (ext: string, n = 1) => `chat/${ADA}_${n}_abc.${ext}`;

  it('is the sender’s own uploads, from the chat folder, each once', () => {
    expect(() =>
      CommunityChatsService.attachments(ADA, [{ ref: 'chat/other_1_abc.jpg' }]),
    ).toThrow('That file was not uploaded here.');
    expect(() =>
      CommunityChatsService.attachments(ADA, [
        { ref: `once/${ADA}_1_abc.jpg` },
      ]),
    ).toThrow('That file was not uploaded here.');
    expect(() =>
      CommunityChatsService.attachments(ADA, [
        { ref: `chat/${ADA}_1_../../x.jpg` },
      ]),
    ).toThrow('That file was not uploaded here.');
    expect(() =>
      CommunityChatsService.attachments(ADA, [
        { ref: own('jpg') },
        { ref: own('jpg') },
      ]),
    ).toThrow('The same file is in there twice.');
  });

  it('is four at most, and a voice note alone', () => {
    expect(() =>
      CommunityChatsService.attachments(
        ADA,
        [1, 2, 3, 4, 5].map((n) => ({ ref: own('jpg', n) })),
      ),
    ).toThrow('at most 4');
    expect(() =>
      CommunityChatsService.attachments(ADA, [
        { ref: own('m4a', 1) },
        { ref: own('jpg', 2) },
      ]),
    ).toThrow('A voice note goes on its own.');
  });

  it('is what the server named the file, not what the phone says', () => {
    const [voice] = CommunityChatsService.attachments(ADA, [
      { ref: own('m4a'), durationMs: 4000, waveform: [3, 140, -2], width: 9 },
    ]);
    expect(voice).toMatchObject({
      kind: MediaKind.VOICE,
      durationMs: 4000,
      waveform: [3, 100, 0],
    });
    const [photo] = CommunityChatsService.attachments(ADA, [
      { ref: own('jpg'), durationMs: 4000, waveform: [3] },
    ]);
    // A still has no length and no waveform, whatever was sent.
    expect(photo).toMatchObject({
      kind: MediaKind.IMAGE,
      durationMs: null,
      waveform: [],
    });
    expect(() =>
      CommunityChatsService.attachments(ADA, [{ ref: own('exe') }]),
    ).toThrow('not one a chat can carry');
  });
});

describe('a poll’s answers', () => {
  it('are two to ten, trimmed, and each once whatever the case', () => {
    expect(CommunityChatsService.pollOptions([' Yes ', 'No  thanks'])).toEqual([
      'Yes',
      'No thanks',
    ]);
    expect(() => CommunityChatsService.pollOptions(['Only'])).toThrow();
    expect(() =>
      CommunityChatsService.pollOptions(
        Array.from({ length: 11 }, (_, i) => `${i}`),
      ),
    ).toThrow();
    expect(() => CommunityChatsService.pollOptions(['Yes', 'yes'])).toThrow(
      'once',
    );
    expect(() => CommunityChatsService.pollOptions(['Yes', ' '])).toThrow(
      'empty',
    );
    expect(() =>
      CommunityChatsService.pollOptions(['Yes', 'x'.repeat(101)]),
    ).toThrow('100');
  });
});

describe('what a push says', () => {
  it('is the words, cut short, or what was sent', () => {
    const say = (
      body: string,
      media: { kind: MediaKind }[] = [],
      poll: unknown = null,
    ) => CommunityChatsService.preview({ body, media, poll });
    expect(say('hello   there')).toBe('hello there');
    expect(say('x'.repeat(150))).toHaveLength(100);
    expect(say('', [{ kind: MediaKind.IMAGE }])).toBe('Photo');
    expect(say('', [{ kind: MediaKind.VOICE }])).toBe('Voice note');
    expect(say('look', [{ kind: MediaKind.IMAGE }])).toBe('look');
    expect(say('Saturday?', [], {})).toBe('Poll: Saturday?');
  });
});

describe('searching a chat', () => {
  it('looks for a % or an _ as itself, not as a wildcard', async () => {
    const { svc, prisma } = service({
      roles: { ada: CommunityRole.MEMBER },
      joined: [],
    });
    await svc.search('ada', CHAT, '50%_off');
    expect(prisma.communityChatMessage.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: expect.objectContaining({
          body: { contains: '50\\%\\_off', mode: 'insensitive' },
        }) as unknown,
      }),
    );
  });

  it('runs on nothing shorter than two letters', async () => {
    const { svc, prisma } = service({
      roles: { ada: CommunityRole.MEMBER },
      joined: [],
    });
    await expect(svc.search('ada', CHAT, ' k ')).resolves.toEqual({
      items: [],
    });
    expect(prisma.communityChatMessage.findMany).not.toHaveBeenCalled();
  });
});
