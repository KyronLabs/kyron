import { CommunityChatWriters, CommunityRole } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
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
    $transaction: jest.fn((ops: Promise<unknown>[]) => Promise.all(ops)),
  };
  const svc = new CommunityChatsService(
    prisma as unknown as PrismaService,
    new RecordingDelivery(),
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
