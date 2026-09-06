import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { CommunitiesService } from './communities.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

const ME = 'me';

const containing = (shape: Record<string, unknown>): unknown =>
  expect.objectContaining(shape);

interface Stub {
  found?: Record<string, unknown> | null;
  owned?: number;
  taken?: boolean;
}

function serviceWith(stub: Stub = {}) {
  const created: unknown[] = [];
  const memberWrites: unknown[] = [];

  const prisma = {
    community: {
      findFirst: jest
        .fn()
        .mockResolvedValue('found' in stub ? stub.found : null),
      findUnique: jest
        .fn()
        .mockResolvedValue(stub.taken ? { id: 'taken' } : null),
      findMany: jest.fn().mockResolvedValue([]),
      count: jest.fn().mockResolvedValue(stub.owned ?? 0),
      create: jest.fn((args: unknown) => {
        created.push(args);
        return Promise.resolve({
          id: 'c1',
          slug: 'design',
          name: 'Design',
          description: null,
          avatarUrl: null,
          createdAt: new Date(),
          _count: { members: 1, posts: 0 },
        });
      }),
    },
    communityMember: {
      findMany: jest.fn().mockResolvedValue([]),
      upsert: jest.fn((args: unknown) => {
        memberWrites.push(['upsert', args]);
        return Promise.resolve({});
      }),
      deleteMany: jest.fn((args: unknown) => {
        memberWrites.push(['delete', args]);
        return Promise.resolve({ count: 1 });
      }),
    },
    // Joining checks this first: a removal that could be undone by tapping
    // Join is not a removal.
    communityBan: {
      findUnique: jest.fn().mockResolvedValue(null),
      deleteMany: jest.fn().mockResolvedValue({ count: 0 }),
      upsert: jest.fn().mockResolvedValue({}),
      findMany: jest.fn().mockResolvedValue([]),
    },
  } as unknown as PrismaService;

  return {
    service: new CommunitiesService(prisma),
    prisma,
    created,
    memberWrites,
  };
}

describe('CommunitiesService.slugify', () => {
  it('is what the community is addressed by', () => {
    expect(CommunitiesService.slugify('Lagos Design')).toBe('lagos-design');
    expect(CommunitiesService.slugify('  Photo & Film  ')).toBe('photo-film');
    expect(CommunitiesService.slugify('C++')).toBe('c');
  });

  it('is the same place whatever case it was typed in', () => {
    expect(CommunitiesService.slugify('Design')).toBe(
      CommunitiesService.slugify('DESIGN'),
    );
  });

  it('is empty for a name with nothing to address it by', () => {
    expect(CommunitiesService.slugify('!!!')).toBe('');
  });
});

describe('starting a community', () => {
  it('makes whoever started it its owner and first member', async () => {
    const { service, created } = serviceWith();
    const community = await service.create(ME, { name: 'Design' });

    expect(created[0]).toEqual(
      containing({
        data: containing({
          slug: 'design',
          createdById: ME,
          members: { create: { userId: ME, role: 'OWNER' } },
        }),
      }),
    );
    expect(community.joined).toBe(true);
    expect(community.role).toBe('OWNER');
  });

  it('refuses a name with nothing to address it by', async () => {
    // A community with no slug cannot be opened.
    const { service } = serviceWith();
    await expect(service.create(ME, { name: '!!!' })).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('refuses an empty name', async () => {
    const { service } = serviceWith();
    await expect(service.create(ME, { name: '   ' })).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('refuses one whose address is already taken', async () => {
    const { service } = serviceWith({ taken: true });
    await expect(service.create(ME, { name: 'Design' })).rejects.toBeInstanceOf(
      ConflictException,
    );
  });

  it('stops one account starting an unbounded number', async () => {
    const { service } = serviceWith({ owned: CommunitiesService.maxOwned });
    await expect(service.create(ME, { name: 'Design' })).rejects.toBeInstanceOf(
      ForbiddenException,
    );
  });
});

describe('membership', () => {
  it('joins', async () => {
    const { service, memberWrites } = serviceWith({
      found: { id: 'c1', createdById: 'someone-else' },
    });
    // setMembership re-reads the community afterwards to answer with it as it
    // now stands; the stub has no members array, so that read throws. What is
    // under test is the write.
    await service.setMembership(ME, 'design', true).catch(() => undefined);
    expect(memberWrites[0]).toEqual(['upsert', expect.anything()]);
  });

  it('will not let the owner leave', async () => {
    // Leaving would leave it with nobody who can moderate it. Handing it over
    // is a different thing, and not one this offers yet.
    const { service } = serviceWith({ found: { id: 'c1', createdById: ME } });
    await expect(
      service.setMembership(ME, 'design', false),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('says so when there is no such community', async () => {
    const { service } = serviceWith({ found: null });
    await expect(
      service.setMembership(ME, 'nowhere', true),
    ).rejects.toBeInstanceOf(NotFoundException);
  });
});

describe('posting into one', () => {
  it('is for members', async () => {
    // A community anybody can post into is a feed with a name on it.
    const { service } = serviceWith({ found: { id: 'c1', members: [] } });
    await expect(service.requirePostable(ME, 'design')).rejects.toBeInstanceOf(
      ForbiddenException,
    );
  });

  it('answers with the id when they are one', async () => {
    const { service } = serviceWith({
      found: { id: 'c1', members: [{ userId: ME }] },
    });
    await expect(service.requirePostable(ME, 'design')).resolves.toBe('c1');
  });

  it('says so when there is no such community', async () => {
    const { service } = serviceWith({ found: null });
    await expect(service.requirePostable(ME, 'nowhere')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});
