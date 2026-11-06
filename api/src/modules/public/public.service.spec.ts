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
    ...over,
  };
}

function setup(rows: {
  post?: unknown;
  user?: unknown;
  community?: unknown;
  counts?: number[];
}) {
  const counts = [...(rows.counts ?? [5, 7, 9])];
  const prisma = {
    post: {
      findFirst: jest.fn().mockResolvedValue(rows.post ?? null),
      count: jest.fn(() => Promise.resolve(counts.pop() ?? 0)),
    },
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
    expect(select.media.take).toBe(PublicService.maxMedia);
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
