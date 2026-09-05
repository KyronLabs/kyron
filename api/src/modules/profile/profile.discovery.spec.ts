import { NotFoundException } from '@nestjs/common';
import { ProfileService } from './profile.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';

const supabase = {} as unknown as SupabaseService;

interface Person {
  id: string;
  name: string | null;
  username: string | null;
  did: string | null;
  kyronPoints: number;
  profile: { avatarUrl: string | null; bio: string | null } | null;
  _count: { followers: number };
  createdAt: Date;
}

function person(id: string, followers: number, joined: string): Person {
  return {
    id,
    name: id,
    username: id,
    did: null,
    kyronPoints: 0,
    profile: { avatarUrl: null, bio: null },
    _count: { followers },
    createdAt: new Date(joined),
  };
}

describe('ProfileService.listSuggested', () => {
  function serviceWith(options: {
    myTopics?: string[];
    following?: string[];
    blocks?: { blockerId: string; blockedId: string }[];
    /** userId per shared-topic row; repeat an id to give it two topics. */
    matches?: string[];
    people?: Person[];
  }) {
    const people = options.people ?? [];
    const userFindMany = jest.fn(
      (args: { where?: { id?: { in?: string[] } } }) => {
        const only = args.where?.id?.in;
        return Promise.resolve(
          only ? people.filter((p) => only.includes(p.id)) : people,
        );
      },
    );

    const prisma = {
      userInterest: {
        // The reader's own picks are asked for by user; the people who share
        // them are asked for by topic.
        findMany: jest.fn((args: { where?: { interestId?: unknown } }) =>
          Promise.resolve(
            args.where?.interestId
              ? (options.matches ?? []).map((userId) => ({ userId }))
              : (options.myTopics ?? []).map((interestId) => ({ interestId })),
          ),
        ),
      },
      follow: {
        findMany: jest
          .fn()
          .mockResolvedValue(
            (options.following ?? []).map((followingId) => ({ followingId })),
          ),
      },
      block: { findMany: jest.fn().mockResolvedValue(options.blocks ?? []) },
      user: { findMany: userFindMany },
    } as unknown as PrismaService;

    return { service: new ProfileService(supabase, prisma), userFindMany };
  }

  it('puts whoever shares the most topics first', async () => {
    const { service } = serviceWith({
      myTopics: ['music', 'code'],
      matches: ['b', 'b', 'c'],
      people: [
        person('a', 900, '2026-09-01'),
        person('b', 2, '2020-01-01'),
        person('c', 50, '2020-01-01'),
      ],
    });

    const { items } = await service.listSuggested('me');
    expect(items.map((p) => p.id)).toEqual(['b', 'c', 'a']);
    expect(items[0].sharedTopics).toBe(2);
  });

  it('falls back to followers, then to who joined most recently', async () => {
    const { service } = serviceWith({
      people: [
        person('quiet', 1, '2026-09-04'),
        person('popular', 300, '2020-01-01'),
        person('newest', 1, '2026-09-05'),
      ],
    });

    const { items } = await service.listSuggested('me');
    expect(items.map((p) => p.id)).toEqual(['popular', 'newest', 'quiet']);
  });

  it('never suggests you, or anyone you already follow', async () => {
    const { service, userFindMany } = serviceWith({
      following: ['friend'],
      people: [person('stranger', 0, '2026-01-01')],
    });

    await service.listSuggested('me');
    const excluded = (
      userFindMany.mock.calls[0][0] as { where: { id: { notIn: string[] } } }
    ).where.id.notIn;
    expect(excluded).toEqual(expect.arrayContaining(['me', 'friend']));
  });

  it('never suggests someone either side of a block', async () => {
    const { service, userFindMany } = serviceWith({
      blocks: [
        { blockerId: 'me', blockedId: 'blocked-by-me' },
        { blockerId: 'blocked-me', blockedId: 'me' },
      ],
      people: [],
    });

    await service.listSuggested('me');
    const excluded = (
      userFindMany.mock.calls[0][0] as { where: { id: { notIn: string[] } } }
    ).where.id.notIn;
    expect(excluded).toEqual(
      expect.arrayContaining(['blocked-by-me', 'blocked-me']),
    );
  });

  it('marks nobody as followed, since that is what a suggestion is', async () => {
    const { service } = serviceWith({
      people: [person('a', 0, '2026-01-01')],
    });
    const { items } = await service.listSuggested('me');
    expect(items[0].isFollowing).toBe(false);
    expect(items[0].isSelf).toBe(false);
  });

  it('pages, and stops offering one when the list runs out', async () => {
    const { service } = serviceWith({
      people: [
        person('a', 3, '2026-01-01'),
        person('b', 2, '2026-01-01'),
        person('c', 1, '2026-01-01'),
      ],
    });

    const first = await service.listSuggested('me', 2);
    expect(first.items.map((p) => p.id)).toEqual(['a', 'b']);
    expect(first.nextCursor).toBe(2);

    const second = await service.listSuggested('me', 2, first.nextCursor!);
    expect(second.items.map((p) => p.id)).toEqual(['c']);
    expect(second.nextCursor).toBeNull();
  });
});

describe('ProfileService topics', () => {
  it('says how many people are into each, and which are yours', async () => {
    const prisma = {
      interest: {
        findMany: jest.fn().mockResolvedValue([
          { id: 'i1', slug: 'code', name: 'Code', _count: { users: 12 } },
          { id: 'i2', slug: 'music', name: 'Music', _count: { users: 3 } },
        ]),
      },
      userInterest: {
        findMany: jest.fn().mockResolvedValue([{ interestId: 'i2' }]),
      },
    } as unknown as PrismaService;

    const { items } = await new ProfileService(supabase, prisma).listTopics(
      'me',
    );
    expect(items).toEqual([
      { slug: 'code', name: 'Code', people: 12, following: false },
      { slug: 'music', name: 'Music', people: 3, following: true },
    ]);
  });

  it('adds one without touching the rest', async () => {
    // saveInterests replaces the whole set, which is what onboarding wants and
    // exactly what one toggle on the Explore wall must not do.
    const upsert = jest.fn().mockResolvedValue({});
    const deleteMany = jest.fn().mockResolvedValue({ count: 0 });
    const prisma = {
      interest: { findUnique: jest.fn().mockResolvedValue({ id: 'i1' }) },
      userInterest: {
        upsert,
        deleteMany,
        count: jest.fn().mockResolvedValue(5),
      },
    } as unknown as PrismaService;

    const result = await new ProfileService(supabase, prisma).setTopic(
      'me',
      'Code',
      true,
    );

    expect(upsert).toHaveBeenCalled();
    expect(deleteMany).not.toHaveBeenCalled();
    expect(result).toEqual({ slug: 'code', following: true, people: 5 });
  });

  it('removes one', async () => {
    const deleteMany = jest.fn().mockResolvedValue({ count: 1 });
    const prisma = {
      interest: { findUnique: jest.fn().mockResolvedValue({ id: 'i1' }) },
      userInterest: {
        upsert: jest.fn(),
        deleteMany,
        count: jest.fn().mockResolvedValue(4),
      },
    } as unknown as PrismaService;

    const result = await new ProfileService(supabase, prisma).setTopic(
      'me',
      'code',
      false,
    );
    expect(deleteMany).toHaveBeenCalled();
    expect(result.following).toBe(false);
  });

  it('says so when the topic does not exist', async () => {
    const prisma = {
      interest: { findUnique: jest.fn().mockResolvedValue(null) },
    } as unknown as PrismaService;

    await expect(
      new ProfileService(supabase, prisma).setTopic('me', 'nonsense', true),
    ).rejects.toBeInstanceOf(NotFoundException);
  });
});
