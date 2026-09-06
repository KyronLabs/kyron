import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { CommunityRole } from '@prisma/client';
import { CommunitiesService } from './communities.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

const OWNER = 'owner';
const MOD = 'mod';
const MEMBER = 'member';
const OUTSIDER = 'outsider';

const roles: Record<string, CommunityRole | null> = {
  [OWNER]: CommunityRole.OWNER,
  [MOD]: CommunityRole.MODERATOR,
  [MEMBER]: CommunityRole.MEMBER,
  [OUTSIDER]: null,
};

function serviceWith({
  target = CommunityRole.MEMBER as CommunityRole | null,
} = {}) {
  const writes: { table: string; args: unknown }[] = [];
  const record = (table: string) => (args: unknown) => {
    writes.push({ table, args });
    return Promise.resolve({ count: 1 });
  };

  const prisma = {
    community: {
      findFirst: jest.fn().mockResolvedValue({ id: 'c1' }),
      update: jest.fn(record('community.update')),
    },
    communityMember: {
      findUnique: jest.fn(
        ({ where }: { where: { communityId_userId: { userId: string } } }) => {
          const userId = where.communityId_userId.userId;
          // The actor's own role comes from the table; the person being acted
          // on gets whatever the test set up.
          const role = userId in roles ? roles[userId] : target;
          return Promise.resolve(role === null ? null : { role });
        },
      ),
      updateMany: jest.fn(record('member.updateMany')),
      deleteMany: jest.fn(record('member.deleteMany')),
      findMany: jest.fn().mockResolvedValue([]),
    },
    communityBan: {
      upsert: jest.fn(record('ban.upsert')),
      deleteMany: jest.fn(record('ban.deleteMany')),
      findUnique: jest.fn().mockResolvedValue(null),
      findMany: jest.fn().mockResolvedValue([]),
    },
    $transaction: jest.fn((ops: Promise<unknown>[]) => Promise.all(ops)),
  } as unknown as PrismaService;

  return { svc: new CommunitiesService(prisma), writes, prisma };
}

describe('community management', () => {
  describe('who may change the community', () => {
    it('lets the owner', async () => {
      const { svc, writes } = serviceWith();
      // bySlug is called to return the updated summary and is not what is
      // under test; the write is.
      await svc.update(OWNER, 'design', { name: 'New' }).catch(() => undefined);

      expect(writes.some((w) => w.table === 'community.update')).toBe(true);
    });

    it('refuses a moderator', async () => {
      const { svc } = serviceWith();

      await expect(svc.update(MOD, 'design', { name: 'New' })).rejects.toThrow(
        ForbiddenException,
      );
    });

    it('refuses somebody who is not in it at all', async () => {
      const { svc } = serviceWith();

      await expect(
        svc.update(OUTSIDER, 'design', { name: 'New' }),
      ).rejects.toThrow(ForbiddenException);
    });
  });

  describe('roles', () => {
    it('refuses to let the owner demote themselves', async () => {
      // Nobody would be left who could undo it.
      const { svc } = serviceWith();

      await expect(
        svc.setRole(OWNER, 'design', OWNER, CommunityRole.MEMBER),
      ).rejects.toThrow(ForbiddenException);
    });

    it('refuses to mint a second owner', async () => {
      const { svc } = serviceWith();

      await expect(
        svc.setRole(OWNER, 'design', MEMBER, CommunityRole.OWNER),
      ).rejects.toThrow();
    });

    it('refuses a moderator promoting anybody', async () => {
      const { svc } = serviceWith();

      await expect(
        svc.setRole(MOD, 'design', MEMBER, CommunityRole.MODERATOR),
      ).rejects.toThrow(ForbiddenException);
    });
  });

  describe('removing somebody', () => {
    it('deletes the membership and records the ban together', async () => {
      // Both or neither: a deleted membership without the ban is a removal
      // undone by tapping Join.
      const { svc, writes } = serviceWith();

      await svc.removeMember(OWNER, 'design', 'them', 'spam');

      expect(writes.map((w) => w.table)).toEqual([
        'member.deleteMany',
        'ban.upsert',
      ]);
    });

    it('lets a moderator remove a plain member', async () => {
      const { svc } = serviceWith({ target: CommunityRole.MEMBER });

      await expect(svc.removeMember(MOD, 'design', 'them')).resolves.toEqual({
        ok: true,
      });
    });

    it('stops a moderator removing another moderator', async () => {
      const { svc } = serviceWith({ target: CommunityRole.MODERATOR });

      await expect(svc.removeMember(MOD, 'design', 'them')).rejects.toThrow(
        ForbiddenException,
      );
    });

    it('lets the owner remove a moderator', async () => {
      const { svc } = serviceWith({ target: CommunityRole.MODERATOR });

      await expect(svc.removeMember(OWNER, 'design', 'them')).resolves.toEqual({
        ok: true,
      });
    });

    it('points somebody at Leave rather than removing themselves', async () => {
      const { svc } = serviceWith();

      await expect(svc.removeMember(MOD, 'design', MOD)).rejects.toThrow(
        ForbiddenException,
      );
    });
  });

  describe('the roll', () => {
    it('is not readable from outside the community', async () => {
      const { svc } = serviceWith();

      await expect(svc.members(OUTSIDER, 'design')).rejects.toThrow(
        ForbiddenException,
      );
    });

    it('is readable by a plain member', async () => {
      const { svc } = serviceWith();

      await expect(svc.members(MEMBER, 'design')).resolves.toEqual({
        items: [],
        nextCursor: null,
      });
    });

    it('answers 404 for a community that does not exist', async () => {
      const { svc, prisma } = serviceWith();
      (prisma.community.findFirst as jest.Mock).mockResolvedValue(null);

      await expect(svc.members(MEMBER, 'gone')).rejects.toThrow(
        NotFoundException,
      );
    });
  });

  describe('closing one', () => {
    it('is soft, so its posts still resolve', async () => {
      const { svc, writes } = serviceWith();

      await svc.remove(OWNER, 'design');

      const update = writes.find((w) => w.table === 'community.update');
      expect(update?.args).toMatchObject({
        data: { deletedAt: expect.any(Date) as unknown },
      });
    });

    it('is the owner only', async () => {
      const { svc } = serviceWith();

      await expect(svc.remove(MOD, 'design')).rejects.toThrow(
        ForbiddenException,
      );
    });
  });
});
