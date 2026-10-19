import {
  InternalServerErrorException,
  ServiceUnavailableException,
} from '@nestjs/common';
import { AccountStatus, CommunityRole } from '@prisma/client';
import { AccountService } from './account.service';

const USER = '11111111-1111-1111-1111-111111111111';
const BUCKET = 'kyron-media';
const url = (path: string) =>
  `https://p.supabase.co/storage/v1/object/public/${BUCKET}/${path}`;

interface Setup {
  status?: AccountStatus | null;
  /** Communities the account owns, and who else is in each, best first. */
  owned?: Array<{ communityId: string; successor: string | null }>;
  bans?: Array<{ communityId: string; createdById: string }>;
  liked?: string[];
  reposted?: string[];
  commented?: string[];
  files?: Record<string, string[]>;
  pictures?: Array<{ avatarUrl: string | null; bannerUrl: string | null }>;
  signInFails?: boolean;
  dataFails?: boolean;
  listFails?: boolean;
}

/** A transaction client and a storage double that record what was asked. */
function setup(s: Setup = {}) {
  const calls: string[] = [];
  const record =
    <T>(name: string, value: T) =>
    (...args: unknown[]) => {
      calls.push(name);
      void args;
      return Promise.resolve(value);
    };

  const tx = {
    user: {
      findUnique: jest.fn(() =>
        Promise.resolve(
          s.status === null
            ? null
            : { status: s.status ?? AccountStatus.ACTIVE },
        ),
      ),
      delete: jest.fn(record('user.delete', {})),
      create: jest.fn(record('user.create', {})),
    },
    communityMember: {
      findMany: jest.fn(() =>
        Promise.resolve(
          (s.owned ?? []).map((o) => ({ communityId: o.communityId })),
        ),
      ),
      findFirst: jest.fn((args: { where: { communityId: string } }) => {
        const owned = (s.owned ?? []).find(
          (o) => o.communityId === args.where.communityId,
        );
        return Promise.resolve(
          owned?.successor ? { userId: owned.successor } : null,
        );
      }),
      update: jest.fn(record('communityMember.update', {})),
    },
    community: {
      update: jest.fn(record('community.update', {})),
      delete: jest.fn(record('community.delete', {})),
    },
    communityBan: {
      findMany: jest.fn(() =>
        Promise.resolve(
          (s.bans ?? []).map((b) => ({
            communityId: b.communityId,
            community: { createdById: b.createdById },
          })),
        ),
      ),
      updateMany: jest.fn(record('communityBan.updateMany', { count: 1 })),
    },
    postLike: {
      findMany: jest.fn(() =>
        Promise.resolve((s.liked ?? []).map((postId) => ({ postId }))),
      ),
    },
    repost: {
      findMany: jest.fn(() =>
        Promise.resolve((s.reposted ?? []).map((postId) => ({ postId }))),
      ),
    },
    comment: {
      findMany: jest.fn(() =>
        Promise.resolve((s.commented ?? []).map((postId) => ({ postId }))),
      ),
    },
    mediaJob: { deleteMany: jest.fn(record('mediaJob.deleteMany', {})) },
    post: { findMany: jest.fn(() => Promise.resolve([{ id: 'p1' }])) },
    moderationAction: {
      updateMany: jest.fn(() => Promise.resolve({ count: 0 })),
    },
    report: { updateMany: jest.fn(() => Promise.resolve({ count: 0 })) },
    $executeRaw: jest.fn((query: { values: unknown[] }) => {
      calls.push('recount');
      return Promise.resolve((query.values[0] as string[]).length);
    }),
  };

  const prisma = {
    $transaction: jest.fn((run: (client: typeof tx) => Promise<unknown>) => {
      calls.push('transaction');
      if (s.dataFails) return Promise.reject(new Error('deadlock'));
      return run(tx);
    }),
    community: {
      findMany: jest.fn(() => Promise.resolve(s.pictures ?? [])),
    },
  };

  const removed: string[] = [];
  const supabase = {
    deleteAuthUser: jest.fn(() => {
      calls.push('deleteAuthUser');
      return s.signInFails
        ? Promise.reject(new Error('503'))
        : Promise.resolve();
    }),
    listByPrefix: jest.fn((folder: string, prefix: string) => {
      if (s.listFails) return Promise.reject(new Error('storage down'));
      return Promise.resolve(
        (s.files?.[folder] ?? [])
          .filter((name) => name.startsWith(prefix))
          .map((name) => `${folder}/${name}`),
      );
    }),
    removeFiles: jest.fn((paths: string[]) => {
      removed.push(...paths);
      return Promise.resolve();
    }),
    getAvatarFolder: () => 'avatars',
    getCoverFolder: () => 'covers',
    getBucketName: () => BUCKET,
  };

  const service = new AccountService(prisma as never, supabase as never);
  return { service, tx, prisma, supabase, calls, removed };
}

describe('AccountService', () => {
  describe('deleteAccount', () => {
    it('deletes the sign-in before anything else, then the data', async () => {
      const { service, calls } = setup();

      await expect(service.deleteAccount(USER)).resolves.toEqual({
        deleted: true,
      });
      expect(calls.indexOf('deleteAuthUser')).toBe(0);
      expect(calls.indexOf('transaction')).toBeGreaterThan(0);
    });

    it('touches nothing when the sign-in cannot be deleted', async () => {
      // Done the other way round, a failure here would leave somebody able
      // to sign in to an account with nothing in it.
      const { service, prisma } = setup({ signInFails: true });

      await expect(service.deleteAccount(USER)).rejects.toBeInstanceOf(
        ServiceUnavailableException,
      );
      expect(prisma.$transaction).not.toHaveBeenCalled();
    });

    it('says it only partly finished when the data could not go', async () => {
      const { service } = setup({ dataFails: true });

      await expect(service.deleteAccount(USER)).rejects.toBeInstanceOf(
        InternalServerErrorException,
      );
    });

    it('still reports success when the files could not be removed', async () => {
      const { service } = setup({ listFails: true });

      await expect(service.deleteAccount(USER)).resolves.toEqual({
        deleted: true,
      });
    });
  });

  describe('deleteData', () => {
    it('does nothing to an account an earlier attempt already deleted', async () => {
      const { service, tx } = setup({ status: AccountStatus.DELETED });

      await service.deleteData(tx as never, USER);

      expect(tx.user.delete).not.toHaveBeenCalled();
      expect(tx.user.create).not.toHaveBeenCalled();
    });

    it('replaces the account with an empty row marked deleted', async () => {
      const { service, tx, calls } = setup();

      await service.deleteData(tx as never, USER);

      expect(calls.indexOf('user.delete')).toBeLessThan(
        calls.indexOf('user.create'),
      );
      const created = tx.user.create.mock.calls[0][0] as {
        data: Record<string, unknown>;
      };
      expect(created.data).toMatchObject({
        id: USER,
        email: `${USER}@deleted.invalid`,
        status: AccountStatus.DELETED,
        password: null,
      });
      // Nothing about the person survives in it.
      expect(created.data).not.toHaveProperty('name');
      expect(created.data).not.toHaveProperty('username');
      expect(created.data.deletedAt).toBeInstanceOf(Date);
    });

    it('hands a community to the next in line, and closes an empty one', async () => {
      const { service, tx } = setup({
        owned: [
          { communityId: 'c-busy', successor: 'mod-1' },
          { communityId: 'c-empty', successor: null },
        ],
      });

      const report = await service.deleteData(tx as never, USER);

      // Owner, then moderator, then member -- the order roles are declared
      // in -- and the longest-standing of them.
      expect(tx.communityMember.findFirst).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { communityId: 'c-busy', userId: { not: USER } },
          orderBy: [{ role: 'asc' }, { joinedAt: 'asc' }],
        }),
      );
      expect(tx.communityMember.update).toHaveBeenCalledWith({
        where: {
          communityId_userId: { communityId: 'c-busy', userId: 'mod-1' },
        },
        data: { role: CommunityRole.OWNER },
      });
      // What stops an owner leaving, so it moves with the role.
      expect(tx.community.update).toHaveBeenCalledWith({
        where: { id: 'c-busy' },
        data: { createdById: 'mod-1' },
      });
      expect(tx.community.delete).toHaveBeenCalledWith({
        where: { id: 'c-empty' },
      });
      expect(report).toMatchObject({
        communitiesHandedOver: 1,
        communitiesClosed: 1,
      });
    });

    it('keeps the bans it made, under the community owner', async () => {
      // A cascade would delete them, letting back in everybody a moderator
      // had removed.
      const { service, tx, calls } = setup({
        bans: [
          { communityId: 'c1', createdById: 'owner-1' },
          { communityId: 'c1', createdById: 'owner-1' },
          { communityId: 'c2', createdById: USER },
        ],
      });

      await service.deleteData(tx as never, USER);

      expect(tx.communityBan.updateMany).toHaveBeenCalledTimes(1);
      expect(tx.communityBan.updateMany).toHaveBeenCalledWith({
        where: { communityId: 'c1', bannedById: USER },
        data: { bannedById: 'owner-1' },
      });
      // Before the account goes, or the cascade takes them first.
      expect(calls.indexOf('communityBan.updateMany')).toBeLessThan(
        calls.indexOf('user.delete'),
      );
    });

    it('recounts every post it touched, once each, after it is gone', async () => {
      const { service, tx, calls } = setup({
        liked: ['p1', 'p2'],
        reposted: ['p2'],
        commented: ['p3'],
      });

      const report = await service.deleteData(tx as never, USER);

      expect(tx.$executeRaw).toHaveBeenCalledTimes(1);
      const query = (tx.$executeRaw.mock.calls[0] as unknown[])[0] as {
        values: unknown[];
        strings: string[];
      };
      expect(query.values[0]).toEqual(['p1', 'p2', 'p3']);
      const sql = query.strings.join('?');
      expect(sql).toContain('"likeCount"');
      expect(sql).toContain('"repostCount"');
      // Comments are counted as the write paths count them: not deleted.
      expect(sql).toContain('"deletedAt" IS NULL');
      expect(calls.indexOf('recount')).toBeGreaterThan(
        calls.indexOf('user.delete'),
      );
      expect(report.postsRecounted).toBe(3);
    });

    it('recounts nothing when it touched nothing', async () => {
      const { service, tx } = setup();

      await service.deleteData(tx as never, USER);

      expect(tx.$executeRaw).not.toHaveBeenCalled();
    });

    it('keeps decisions about it, without the words they quoted', async () => {
      // Leaving must not wipe a ban -- the case stays, and BannedIdentity
      // keeps the address -- but what the account wrote goes with it.
      const { service, tx } = setup();

      await service.deleteData(tx as never, USER);

      expect(tx.moderationAction.updateMany).toHaveBeenCalledWith({
        where: { subjectId: USER },
        data: { snapshot: null },
      });
      expect(tx.report.updateMany).toHaveBeenCalledWith(
        expect.objectContaining({ data: { snapshot: null } }),
      );
    });

    it('drops re-encodes waiting on its clips', async () => {
      const { service, tx } = setup();

      await service.deleteData(tx as never, USER);

      expect(tx.mediaJob.deleteMany).toHaveBeenCalledWith({
        where: { userId: USER },
      });
    });
  });

  describe('removeFiles', () => {
    it('removes its uploads in every folder, and nobody else’s', async () => {
      const { service, removed } = setup({
        files: {
          'post-media': [
            `${USER}_1_a.jpg`,
            `${USER}_1_a.mp4.poster.jpg`,
            'other_1_b.jpg',
          ],
          avatars: [`${USER}_avatar_1.png`],
          covers: [`${USER}_cover_1.jpg`],
        },
      });

      await expect(service.removeFiles(USER)).resolves.toBe(4);
      expect(removed.sort()).toEqual(
        [
          `avatars/${USER}_avatar_1.png`,
          `covers/${USER}_cover_1.jpg`,
          `post-media/${USER}_1_a.jpg`,
          `post-media/${USER}_1_a.mp4.poster.jpg`,
        ].sort(),
      );
    });

    it('keeps a picture a community still shows', async () => {
      const { service, removed } = setup({
        files: { 'post-media': [`${USER}_1_banner.jpg`, `${USER}_2_post.jpg`] },
        pictures: [
          {
            avatarUrl: null,
            bannerUrl: url(`post-media/${USER}_1_banner.jpg`),
          },
        ],
      });

      await service.removeFiles(USER);

      expect(removed).toEqual([`post-media/${USER}_2_post.jpg`]);
    });

    it('answers 0 rather than throwing when storage fails', async () => {
      const { service } = setup({ listFails: true });

      await expect(service.removeFiles(USER)).resolves.toBe(0);
    });
  });
});
