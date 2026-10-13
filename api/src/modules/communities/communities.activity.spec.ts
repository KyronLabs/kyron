import { ConflictException } from '@nestjs/common';
import { CommunityRole, MediaKind, Prisma } from '@prisma/client';

import { CommunitiesService } from './communities.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/**
 * The Communities list as a list of places with something happening in them:
 * the newest post in each, how many have come since the reader last looked,
 * and the busiest at the top -- the way the Messages list treats
 * conversations.
 */
const ME = 'me';

const community = (id: string, name = id) => ({
  id,
  slug: id,
  name,
  description: null,
  avatarUrl: null,
  bannerUrl: null,
  createdAt: new Date('2026-01-01'),
  _count: { members: 3, posts: 2 },
});

interface Membership {
  communityId: string;
  role?: CommunityRole;
  joinedAt: Date;
  lastReadAt?: Date | null;
}

function serviceWith({
  memberships,
  latest = {},
  unread = {},
  posts = {},
}: {
  memberships: Membership[];
  /** The newest post time per community, as the groupBy answers it. */
  latest?: Record<string, Date>;
  /** New posts per community. */
  unread?: Record<string, number>;
  /** The newest post per community, as findFirst answers it. */
  posts?: Record<string, unknown>;
}) {
  const groupBy = jest.fn((args: { _max?: unknown; _count?: unknown }) =>
    Promise.resolve(
      args._max
        ? Object.entries(latest).map(([communityId, createdAt]) => ({
            communityId,
            _max: { createdAt },
          }))
        : Object.entries(unread).map(([communityId, n]) => ({
            communityId,
            _count: { _all: n },
          })),
    ),
  );
  const findFirst = jest.fn(
    (args: { where: { AND: Array<{ communityId?: string }> } }) =>
      Promise.resolve(posts[args.where.AND[1].communityId ?? ''] ?? null),
  );
  const memberFind = jest.fn(() =>
    Promise.resolve(
      memberships.map((m) => ({
        communityId: m.communityId,
        role: m.role ?? CommunityRole.MEMBER,
        joinedAt: m.joinedAt,
        lastReadAt: m.lastReadAt ?? null,
        community: community(m.communityId),
      })),
    ),
  );
  const updateMany = jest.fn(() => Promise.resolve({ count: 1 }));
  const userFind = jest.fn(() =>
    Promise.resolve({ communityPostsInHome: false }),
  );
  const userUpdate = jest.fn(
    (args: { data: { communityPostsInHome: boolean } }) =>
      Promise.resolve({ communityPostsInHome: args.data.communityPostsInHome }),
  );

  const prisma = {
    communityMember: { findMany: memberFind, updateMany },
    post: { groupBy, findFirst },
    user: { findUnique: userFind, update: userUpdate },
    community: {
      count: jest.fn(() => Promise.resolve(0)),
      findUnique: jest.fn(() => Promise.resolve(null)),
    },
  } as unknown as PrismaService;

  return {
    service: new CommunitiesService(prisma),
    groupBy,
    findFirst,
    memberFind,
    updateMany,
    userUpdate,
  };
}

const post = (overrides: Record<string, unknown> = {}) => ({
  id: 'p1',
  authorId: 'ada',
  content: 'the light this morning',
  createdAt: new Date('2026-10-12T09:00:00Z'),
  author: { name: 'Ada', username: 'ada' },
  media: [],
  ...overrides,
});

describe('the reader’s communities, as a list of what is happening', () => {
  it('puts the one with the newest post first, and an empty one by when it was joined', async () => {
    const { service } = serviceWith({
      memberships: [
        { communityId: 'quiet', joinedAt: new Date('2026-10-01') },
        { communityId: 'busy', joinedAt: new Date('2026-01-01') },
        { communityId: 'new', joinedAt: new Date('2026-10-11') },
      ],
      latest: {
        busy: new Date('2026-10-12'),
        quiet: new Date('2026-09-01'),
      },
    });

    const page = await service.mine(ME);

    expect(page.items.map((c) => c.id)).toEqual(['busy', 'new', 'quiet']);
    // Quiet's newest post is older than when the reader joined it, but it is
    // still the activity the row shows.
    expect(page.items[2].lastActivityAt).toEqual(new Date('2026-09-01'));
  });

  it('counts what other people posted since the reader last looked', async () => {
    const read = new Date('2026-10-10');
    const joined = new Date('2026-10-01');
    const { service, groupBy } = serviceWith({
      memberships: [
        { communityId: 'a', joinedAt: joined, lastReadAt: read },
        { communityId: 'b', joinedAt: joined },
      ],
      latest: { a: new Date('2026-10-12'), b: new Date('2026-10-11') },
      unread: { a: 3 },
    });

    const page = await service.mine(ME);

    expect(page.items.map((c) => [c.id, c.unread])).toEqual([
      ['a', 3],
      ['b', 0],
    ]);
    const countArgs = groupBy.mock.calls
      .map(
        ([args]) => args as { _count?: unknown; where: Prisma.PostWhereInput },
      )
      .find((args) => args._count)!;
    expect(countArgs.where.AND).toEqual(
      expect.arrayContaining([
        // Not the reader's own posts: you have read what you wrote.
        { authorId: { not: ME } },
        {
          OR: [
            { communityId: 'a', createdAt: { gt: read } },
            // Never opened since this was added: from when they joined, not
            // every post the community has ever had.
            { communityId: 'b', createdAt: { gt: joined } },
          ],
        },
      ]),
    );
  });

  it('carries the newest post, as much of it as a row shows', async () => {
    const { service } = serviceWith({
      memberships: [{ communityId: 'a', joinedAt: new Date('2026-01-01') }],
      latest: { a: new Date('2026-10-12') },
      posts: {
        a: post({
          content: 'x'.repeat(500),
          author: { name: '  ', username: 'ada' },
          media: [{ kind: MediaKind.IMAGE }, { kind: MediaKind.VIDEO }],
        }),
      },
    });

    const [row] = (await service.mine(ME)).items;

    expect(row.lastPost).toMatchObject({
      authorId: 'ada',
      // A blank display name falls back to the handle.
      authorName: 'ada',
      media: [MediaKind.IMAGE, MediaKind.VIDEO],
    });
    expect(row.lastPost!.body).toHaveLength(160);
  });

  it('has no newest post for a community nobody has posted in, and does not look', async () => {
    const { service, findFirst } = serviceWith({
      memberships: [{ communityId: 'a', joinedAt: new Date('2026-01-01') }],
    });

    const [row] = (await service.mine(ME)).items;

    expect(row.lastPost).toBeNull();
    expect(findFirst).not.toHaveBeenCalled();
  });

  it('previews only what the reader may see', async () => {
    // A blocked author's post must not be the row's preview when the
    // community page would hide it.
    const hidden: Prisma.PostWhereInput = { authorId: { notIn: ['blocked'] } };
    const { service, groupBy, findFirst } = serviceWith({
      memberships: [{ communityId: 'a', joinedAt: new Date('2026-01-01') }],
      latest: { a: new Date('2026-10-12') },
      posts: { a: post() },
    });

    await service.mine(ME, {
      visible: (where) => Promise.resolve({ ...where, ...hidden }),
    });

    const [latestArgs] = groupBy.mock.calls[0] as [
      { where: Prisma.PostWhereInput },
    ];
    expect(latestArgs.where).toMatchObject(hidden);
    const [firstArgs] = findFirst.mock.calls[0] as [
      { where: { AND: Prisma.PostWhereInput[] } },
    ];
    expect(firstArgs.where.AND[0]).toMatchObject(hidden);
  });

  it('Unread leaves out the ones with nothing new', async () => {
    const { service } = serviceWith({
      memberships: [
        { communityId: 'a', joinedAt: new Date('2026-01-01') },
        { communityId: 'b', joinedAt: new Date('2026-01-01') },
      ],
      latest: { a: new Date('2026-10-12'), b: new Date('2026-10-11') },
      unread: { b: 1 },
    });

    const page = await service.mine(ME, { filter: 'unread' });

    expect(page.items.map((c) => c.id)).toEqual(['b']);
  });

  it('Yours to run asks only for the ones the reader owns or moderates', async () => {
    const { service, memberFind } = serviceWith({ memberships: [] });

    await service.mine(ME, { filter: 'running' });

    const [args] = memberFind.mock.calls[0] as unknown as [
      { where: Record<string, unknown> },
    ];
    expect(args.where.role).toEqual({
      in: [CommunityRole.OWNER, CommunityRole.MODERATOR],
    });
  });

  it('pages by the last community shown, and says when there are no more', async () => {
    const { service } = serviceWith({
      memberships: ['a', 'b', 'c'].map((id) => ({
        communityId: id,
        joinedAt: new Date('2026-01-01'),
      })),
      latest: {
        a: new Date('2026-10-12'),
        b: new Date('2026-10-11'),
        c: new Date('2026-10-10'),
      },
    });

    const first = await service.mine(ME, { limit: 2 });
    expect(first.items.map((c) => c.id)).toEqual(['a', 'b']);
    expect(first.nextCursor).toBe('b');

    const second = await service.mine(ME, {
      limit: 2,
      cursor: first.nextCursor!,
    });
    expect(second.items.map((c) => c.id)).toEqual(['c']);
    expect(second.nextCursor).toBeNull();
  });

  it('is empty without asking about posts when the reader is in none', async () => {
    const { service, groupBy } = serviceWith({ memberships: [] });

    await expect(service.mine(ME)).resolves.toEqual({
      items: [],
      nextCursor: null,
    });
    expect(groupBy).not.toHaveBeenCalled();
  });
});

describe('opening a community', () => {
  it('starts its new-post count again, for the reader alone', async () => {
    const { service, updateMany } = serviceWith({ memberships: [] });

    await service.markRead(ME, ' Gardeners ');

    const [args] = updateMany.mock.calls[0] as unknown as [
      { where: unknown; data: { lastReadAt: Date } },
    ];
    expect(args.where).toEqual({
      userId: ME,
      community: { slug: 'gardeners', deletedAt: null },
    });
    expect(args.data.lastReadAt).toBeInstanceOf(Date);
  });
});

describe('settings for communities', () => {
  it('reads and changes whether their posts appear in Home', async () => {
    const { service, userUpdate } = serviceWith({ memberships: [] });

    await expect(service.settings(ME)).resolves.toEqual({
      postsInHome: false,
    });
    await expect(
      service.updateSettings(ME, { postsInHome: true }),
    ).resolves.toEqual({ postsInHome: true });
    expect(userUpdate).toHaveBeenCalledWith(
      expect.objectContaining({ data: { communityPostsInHome: true } }),
    );
  });
});

describe('a name that is an address the app already uses', () => {
  it.each(['Settings', 'Mine', 'discover'])('"%s" is refused', async (name) => {
    // GET /communities/settings is the settings, so a community at that
    // address could never be opened.
    const { service } = serviceWith({ memberships: [] });

    await expect(service.create(ME, { name })).rejects.toBeInstanceOf(
      ConflictException,
    );
  });
});
