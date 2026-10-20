import { ConversationKind, MemberRole } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { GroupsService } from './groups.service';
import type { MessagesService } from './messages.service';

/**
 * Who may do what in a group, without a database. messages.groups.db.spec.ts
 * runs the same against a real one.
 */

const OWNER = 'owner';
const ADMIN = 'admin';
const MEMBER = 'member';
const SPECTATOR = 'spectator';

function service() {
  const members = [
    { userId: OWNER, role: MemberRole.OWNER },
    { userId: ADMIN, role: MemberRole.ADMIN },
    { userId: MEMBER, role: MemberRole.MEMBER },
    { userId: SPECTATOR, role: MemberRole.SPECTATOR },
  ].map((m) => ({ ...m, joinedAt: new Date(0), handRaisedAt: null }));
  const messages = {
    requireMembership: jest.fn(() =>
      Promise.resolve({
        id: 'g1',
        kind: ConversationKind.GROUP,
        title: 'Birders',
        joinRole: MemberRole.MEMBER,
        members,
      }),
    ),
    requireNoBlock: jest.fn(() => Promise.resolve()),
  };
  const writes: string[] = [];
  const op = (name: string) =>
    jest.fn(() => {
      writes.push(name);
      return Promise.resolve({});
    });
  const prisma = {
    conversationMember: {
      update: op('member.update'),
      updateMany: op('member.updateMany'),
      delete: op('member.delete'),
      createMany: op('member.createMany'),
    },
    conversation: { update: op('conversation.update') },
    message: { create: op('message.create') },
    user: {
      findMany: jest.fn(({ where }: { where: { id: { in: string[] } } }) =>
        Promise.resolve(
          where.id.in.map((id) => ({ id, name: id, username: null })),
        ),
      ),
    },
    $transaction: jest.fn((ops: Promise<unknown>[]) => Promise.all(ops)),
  };
  const delivery = new RecordingDelivery();
  const svc = new GroupsService(
    prisma as unknown as PrismaService,
    delivery,
    messages as unknown as MessagesService,
  );
  return { svc, writes, delivery };
}

describe('a group’s name and who joins as what', () => {
  it('is trimmed, and neither empty nor too long', () => {
    expect(GroupsService.title('  Birders   of  the bay ')).toBe(
      'Birders of the bay',
    );
    expect(() => GroupsService.title('   ')).toThrow();
    expect(() => GroupsService.title('x'.repeat(81))).toThrow();
  });

  it('starts people as members or spectators, never admins', () => {
    expect(() => GroupsService.joinable(MemberRole.SPECTATOR)).not.toThrow();
    expect(() => GroupsService.joinable(MemberRole.ADMIN)).toThrow();
    expect(() => GroupsService.joinable(MemberRole.OWNER)).toThrow();
  });
});

describe('who may do what', () => {
  it('lets only admins add, rename or remove', async () => {
    const { svc, writes } = service();
    await expect(svc.add(MEMBER, 'g1', ['new'])).rejects.toMatchObject({
      status: 403,
    });
    await expect(
      svc.update(SPECTATOR, 'g1', { title: 'Mine' }),
    ).rejects.toMatchObject({ status: 403 });
    await expect(svc.remove(MEMBER, 'g1', SPECTATOR)).rejects.toMatchObject({
      status: 403,
    });
    expect(writes).toEqual([]);
  });

  it('lets an admin move people between member and spectator', async () => {
    const { svc, writes } = service();
    await svc.setRole(ADMIN, 'g1', SPECTATOR, MemberRole.MEMBER);
    expect(writes).toContain('member.update');
  });

  it('keeps making and unmaking admins to the owner', async () => {
    const { svc } = service();
    await expect(
      svc.setRole(ADMIN, 'g1', MEMBER, MemberRole.ADMIN),
    ).rejects.toMatchObject({ status: 403 });
    await expect(
      svc.setRole(ADMIN, 'g1', OWNER, MemberRole.MEMBER),
    ).rejects.toMatchObject({ status: 403 });
    await expect(svc.remove(ADMIN, 'g1', OWNER)).rejects.toMatchObject({
      status: 403,
    });
  });

  it('hands ownership on rather than leaving two owners', async () => {
    const { svc, writes } = service();
    await svc.setRole(OWNER, 'g1', ADMIN, MemberRole.OWNER);
    // Theirs, and the old owner's.
    expect(writes.filter((w) => w === 'member.update')).toHaveLength(2);
  });

  it('lets only a spectator raise a hand, and tells the admins', async () => {
    const { svc, delivery } = service();
    await expect(svc.raiseHand(MEMBER, 'g1')).rejects.toMatchObject({
      status: 400,
    });
    await svc.raiseHand(SPECTATOR, 'g1');
    const told = delivery.told.find((t) => t.push);
    expect(told?.userIds.sort()).toEqual([ADMIN, OWNER].sort());
    expect(told?.push?.body).toBe('spectator raised a hand to ask to write.');
  });

  it('lets an admin, and nobody else, put somebody else’s hand down', async () => {
    const { svc } = service();
    await expect(svc.lowerHand(MEMBER, 'g1', SPECTATOR)).rejects.toMatchObject({
      status: 403,
    });
    await expect(svc.lowerHand(ADMIN, 'g1', SPECTATOR)).resolves.toEqual({
      ok: true,
    });
  });
});
