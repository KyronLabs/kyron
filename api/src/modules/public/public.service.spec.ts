import { BadRequestException, NotFoundException } from '@nestjs/common';
import { AccountStatus, MediaKind } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { PublicController } from './public.controller';
import { PublicService } from './public.service';

/**
 * What a stranger with a link may read. Every test here is about what is
 * left out as much as what is put in: these answers go to anybody.
 */
const POST_ID = '7d5d3c2a-1b0e-4f7a-9c1d-2e3f4a5b6c7d';

/** The arguments a mocked Prisma call was first given. */
interface Query {
  where: Record<string, unknown>;
  select: Record<string, Record<string, unknown>>;
}
function argsOf(fn: jest.Mock): Query {
  return (fn.mock.calls[0] as [Query])[0];
}

function postRow(over: Record<string, unknown> = {}) {
  return {
    id: POST_ID,
    content: 'First light over the harbour.',
    createdAt: new Date('2026-11-05T08:00:00Z'),
    likeCount: 12,
    commentCount: 3,
    repostCount: 1,
    author: {
      name: 'Ada',
      username: 'ada',
      verifiedAt: new Date('2026-01-01'),
      profile: { avatarUrl: 'https://cdn/ada.jpg' },
    },
    community: null,
    media: [],
    poll: null,
    quotedPost: null,
    ...over,
  };
}

const visibleAuthor = {
  name: 'Ben',
  username: 'ben',
  verifiedAt: null,
  profile: { avatarUrl: null },
  status: AccountStatus.ACTIVE,
  deletedAt: null,
};

function quotedRow(over: Record<string, unknown> = {}) {
  return {
    id: 'q1',
    content: 'The original.',
    createdAt: new Date('2026-11-01T00:00:00Z'),
    deletedAt: null,
    author: visibleAuthor,
    media: [],
    ...over,
  };
}

function setup(rows: {
  post?: unknown;
  user?: unknown;
  community?: unknown;
  comment?: unknown;
  recent?: unknown[];
  counts?: number[];
}) {
  const counts = [...(rows.counts ?? [5, 7, 9])];
  const prisma = {
    post: {
      findFirst: jest.fn().mockResolvedValue(rows.post ?? null),
      count: jest.fn(() => Promise.resolve(counts.pop() ?? 0)),
      findMany: jest.fn().mockResolvedValue(rows.recent ?? []),
    },
    comment: { findFirst: jest.fn().mockResolvedValue(rows.comment ?? null) },
    user: { findFirst: jest.fn().mockResolvedValue(rows.user ?? null) },
    follow: { count: jest.fn(() => Promise.resolve(counts.shift() ?? 0)) },
    community: {
      findFirst: jest.fn().mockResolvedValue(rows.community ?? null),
    },
  };
  const service = new PublicService(prisma as unknown as PrismaService);
  return { prisma, service };
}

describe('a public post', () => {
  it('is only ever looked up among live posts by visible accounts', async () => {
    const { prisma, service } = setup({ post: postRow() });
    await service.post(POST_ID);

    const { where } = argsOf(prisma.post.findFirst);
    expect(where).toEqual({
      id: POST_ID,
      deletedAt: null,
      author: {
        status: {
          notIn: [AccountStatus.BANNED, AccountStatus.DELETED],
        },
        deletedAt: null,
      },
    });
  });

  it('never selects an attachment from the private bucket, or a comment’s', async () => {
    const { prisma, service } = setup({ post: postRow() });
    await service.post(POST_ID);

    const { select } = argsOf(prisma.post.findFirst);
    expect(select.media.where).toEqual({ privatePath: null, commentId: null });
    expect(select.media.take).toBe(PublicService.maxAttachments);
  });

  it('is said not to exist when the query finds nothing', async () => {
    const { service } = setup({});
    await expect(service.post(POST_ID)).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });

  it('carries exactly the public fields, and nothing about any viewer', async () => {
    const { service } = setup({
      post: postRow({
        media: [
          {
            kind: MediaKind.IMAGE,
            url: 'https://cdn/a.jpg',
            thumbnailUrl: null,
            width: 1200,
            height: 800,
            alt: 'A harbour',
          },
        ],
      }),
    });
    const post = await service.post(POST_ID);

    expect(Object.keys(post).sort()).toEqual(
      [
        'author',
        'community',
        'content',
        'createdAt',
        'hasVoice',
        'id',
        'media',
        'mediaCount',
        'poll',
        'quoted',
        'stats',
      ].sort(),
    );
    expect(post.author).toEqual({
      name: 'Ada',
      username: 'ada',
      verified: true,
      avatarUrl: 'https://cdn/ada.jpg',
    });
    expect(post.createdAt).toBe('2026-11-05T08:00:00.000Z');
    expect(post.stats).toEqual({ likes: 12, comments: 3, reposts: 1 });
    expect(post.media).toHaveLength(1);
  });

  it('shows four pictures and says how many there are in all', async () => {
    const picture = {
      kind: MediaKind.IMAGE,
      url: 'https://cdn/a.jpg',
      thumbnailUrl: null,
      width: null,
      height: null,
      alt: null,
    };
    const { service } = setup({
      post: postRow({
        media: Array.from({ length: 8 }, () => picture),
      }),
    });
    const post = await service.post(POST_ID);
    expect(post.media).toHaveLength(PublicService.maxMedia);
    expect(post.mediaCount).toBe(8);
  });

  it('shows a poll as counts per option, and nothing about who voted', async () => {
    const { prisma, service } = setup({
      post: postRow({
        poll: {
          closesAt: new Date('2026-12-01T00:00:00Z'),
          options: [
            { text: 'Yes', _count: { votes: 3 } },
            { text: 'No', _count: { votes: 1 } },
          ],
        },
      }),
    });
    const post = await service.post(POST_ID);
    expect(post.poll).toEqual({
      options: [
        { text: 'Yes', votes: 3 },
        { text: 'No', votes: 1 },
      ],
      totalVotes: 4,
      closesAt: '2026-12-01T00:00:00.000Z',
    });
    const { select } = argsOf(prisma.post.findFirst);
    expect(JSON.stringify(select.poll)).not.toContain('voterId');
    expect(JSON.stringify(select.poll)).not.toContain('userId');
  });

  it('shows the post it quotes, without that author’s account state', async () => {
    const { service } = setup({ post: postRow({ quotedPost: quotedRow() }) });
    const post = await service.post(POST_ID);
    expect(post.quoted).toEqual({
      id: 'q1',
      content: 'The original.',
      createdAt: '2026-11-01T00:00:00.000Z',
      author: {
        name: 'Ben',
        username: 'ben',
        verified: false,
        avatarUrl: null,
      },
      media: [],
    });
  });

  it('leaves out a quoted post that is deleted, or by an account that is gone', async () => {
    for (const quoted of [
      quotedRow({ deletedAt: new Date() }),
      quotedRow({ author: { ...visibleAuthor, status: AccountStatus.BANNED } }),
      quotedRow({
        author: { ...visibleAuthor, status: AccountStatus.DELETED },
      }),
      quotedRow({ author: { ...visibleAuthor, deletedAt: new Date() } }),
    ]) {
      const { service } = setup({ post: postRow({ quotedPost: quoted }) });
      expect((await service.post(POST_ID)).quoted).toBeNull();
    }
  });

  it('says a voice note is there without publishing its file', async () => {
    const { service } = setup({
      post: postRow({
        media: [
          {
            kind: MediaKind.VOICE,
            url: 'https://cdn/voice.m4a',
            thumbnailUrl: null,
            width: null,
            height: null,
            alt: null,
          },
        ],
      }),
    });
    const post = await service.post(POST_ID);
    expect(post.media).toEqual([]);
    expect(post.hasVoice).toBe(true);
  });

  it('does not name a deleted community', async () => {
    const gone = setup({
      post: postRow({
        community: { name: 'Old', slug: 'old', deletedAt: new Date() },
      }),
    });
    expect((await gone.service.post(POST_ID)).community).toBeNull();

    const live = setup({
      post: postRow({
        community: { name: 'Sailing', slug: 'sailing', deletedAt: null },
      }),
    });
    expect((await live.service.post(POST_ID)).community).toEqual({
      name: 'Sailing',
      slug: 'sailing',
    });
  });
});

describe('a public comment', () => {
  const comment = {
    id: 'c1',
    content: 'Lovely.',
    createdAt: new Date('2026-11-05T09:00:00Z'),
    author: visibleAuthor,
    media: [],
    _count: { likes: 2, replies: 1 },
    post: postRow(),
  };

  it('is only shown on a live post, by visible accounts on both', async () => {
    const { prisma, service } = setup({ comment });
    await service.comment(POST_ID);

    const live = {
      status: { notIn: [AccountStatus.BANNED, AccountStatus.DELETED] },
      deletedAt: null,
    };
    expect(argsOf(prisma.comment.findFirst).where).toEqual({
      id: POST_ID,
      deletedAt: null,
      author: live,
      post: { deletedAt: null, author: live },
    });
  });

  it('never selects a private attachment', async () => {
    const { prisma, service } = setup({ comment });
    await service.comment(POST_ID);
    expect(argsOf(prisma.comment.findFirst).select.media.where).toEqual({
      privatePath: null,
      kind: { not: MediaKind.VOICE },
    });
  });

  it('comes with the post it answers', async () => {
    const { service } = setup({ comment });
    const result = await service.comment(POST_ID);
    expect(result.post.id).toBe(POST_ID);
    expect(result.stats).toEqual({ likes: 2, replies: 1 });
    expect(result.author).not.toHaveProperty('status');
  });

  it('is said not to exist when it, its post or an author is gone', async () => {
    const { service } = setup({});
    await expect(service.comment(POST_ID)).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});

describe('a public profile', () => {
  const user = {
    id: POST_ID,
    name: 'Ada',
    username: 'ada',
    verifiedAt: null,
    profile: { avatarUrl: null, coverUrl: null, bio: 'Sails.' },
  };

  it('is found by handle, whatever its case, among visible accounts', async () => {
    const { prisma, service } = setup({ user });
    await service.profile('Ada');

    const { where } = argsOf(prisma.user.findFirst);
    expect(where.username).toEqual({ equals: 'Ada', mode: 'insensitive' });
    expect(where.status).toEqual({
      notIn: [AccountStatus.BANNED, AccountStatus.DELETED],
    });
    expect(where.deletedAt).toBeNull();
  });

  it('is found by id when given one: not every account has a handle', async () => {
    const { prisma, service } = setup({ user });
    await service.profile(POST_ID);
    expect(argsOf(prisma.user.findFirst).where.id).toBe(POST_ID);
  });

  it('never selects a date of birth, a location or an email', async () => {
    const { prisma, service } = setup({ user });
    await service.profile('ada');

    const { select } = argsOf(prisma.user.findFirst);
    expect(Object.keys(select.profile.select as object).sort()).toEqual([
      'avatarUrl',
      'bio',
      'coverUrl',
    ]);
    expect(select).not.toHaveProperty('email');
    expect(select).not.toHaveProperty('dateOfBirth');
  });

  it('counts followers, following and posts', async () => {
    const { service } = setup({ user, counts: [5, 7, 9] });
    const profile = await service.profile('ada');
    expect(profile.stats).toEqual({ followers: 5, following: 7, posts: 9 });
    expect(profile.verified).toBe(false);
    expect(profile.bio).toBe('Sails.');
  });

  it('lists its latest posts, live ones only', async () => {
    const { prisma, service } = setup({ user, recent: [postRow()] });
    const profile = await service.profile('ada');

    expect(profile.recent).toHaveLength(1);
    expect(profile.recent[0]).not.toHaveProperty('poll');
    const args = (
      prisma.post.findMany.mock.calls[0] as [Query & { take: number }]
    )[0];
    expect(args.where).toEqual({ authorId: POST_ID, deletedAt: null });
    expect(args.take).toBe(PublicService.recentPosts);
  });

  it('is said not to exist for a banned, deleted or unknown account', async () => {
    const { service } = setup({});
    await expect(service.profile('ghost')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});

describe('a public community', () => {
  it('is looked up among live communities, and counts its members', async () => {
    const { prisma, service } = setup({
      community: {
        id: POST_ID,
        slug: 'sailing',
        name: 'Sailing',
        description: null,
        avatarUrl: null,
        bannerUrl: null,
        _count: { members: 42 },
      },
    });
    const community = await service.community('Sailing');

    const { where } = argsOf(prisma.community.findFirst);
    expect(where).toEqual({
      slug: { equals: 'Sailing', mode: 'insensitive' },
      deletedAt: null,
    });
    expect(community.members).toBe(42);
    expect(community).not.toHaveProperty('_count');
    expect(community.recent).toEqual([]);

    // Its posts: live, and only by accounts still visible.
    const posts = argsOf(prisma.post.findMany);
    expect(posts.where).toEqual({
      communityId: POST_ID,
      deletedAt: null,
      author: {
        status: { notIn: [AccountStatus.BANNED, AccountStatus.DELETED] },
        deletedAt: null,
      },
    });
  });
});

describe('the public routes', () => {
  const { service } = setup({});
  const controller = new PublicController(service);

  it('refuse a name that could not be a handle or a slug', () => {
    for (const bad of ['', 'a b', '../etc', 'x'.repeat(65), "o'neil", 'a/b']) {
      expect(() => controller.profile(bad)).toThrow(BadRequestException);
      expect(() => controller.community(bad)).toThrow(BadRequestException);
    }
  });

  it('take a handle with or without its @', async () => {
    const spy = jest.spyOn(service, 'profile').mockResolvedValue({} as never);
    await controller.profile('@ada');
    await controller.profile('ada');
    expect(spy.mock.calls).toEqual([['ada'], ['ada']]);
  });
});
