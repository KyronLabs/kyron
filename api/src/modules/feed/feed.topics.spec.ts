import { BadRequestException } from '@nestjs/common';
import { FeedService } from './feed.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { ModerationService } from '../moderation/moderation.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { RankingService } from './ranking.service';

const noFilters = {
  filtersFor: jest.fn().mockResolvedValue({
    blockedUserIds: [],
    mutedUserIds: [],
    hiddenPostIds: [],
    mutedPostIds: [],
    mutedPhrases: [],
  }),
} as unknown as ModerationService;

const catalogue = [
  { id: 'i-music', slug: 'music' },
  { id: 'i-code', slug: 'code' },
  { id: 'i-art', slug: 'art' },
  { id: 'i-food', slug: 'food' },
];

function serviceWith() {
  const created: { data?: Record<string, unknown> }[] = [];
  const prisma = {
    interest: {
      findMany: jest.fn((args: { where: { slug: { in: string[] } } }) =>
        Promise.resolve(
          catalogue.filter((row) => args.where.slug.in.includes(row.slug)),
        ),
      ),
      findUnique: jest.fn(() => Promise.resolve({ id: 'i-music' })),
    },
    hashtag: { upsert: jest.fn() },
    $transaction: jest.fn(() => Promise.resolve([])),
    post: {
      create: jest.fn((args: { data?: Record<string, unknown> }) => {
        created.push(args);
        return Promise.resolve({
          id: 'p1',
          content: 'hi',
          createdAt: new Date(),
          author: { id: 'a', name: null, username: null, profile: null },
          media: [],
          _count: { likes: 0, comments: 0, reposts: 0 },
          likes: [],
          saves: [],
          reposts: [],
          quotedPost: null,
          poll: null,
          replyPolicy: 'EVERYONE',
        });
      }),
    },
  } as unknown as PrismaService;
  return {
    service: new FeedService(
      prisma,
      noFilters,
      new RankingService(),
      new RecordingDelivery(),
    ),
    created,
    prisma,
  };
}

/** What the create call asked to be written into PostTopic. */
function topicsWritten(args: { data?: Record<string, unknown> }): string[] {
  const topics = args.data?.topics as
    | { create: { interestId: string }[] }
    | undefined;
  return (topics?.create ?? []).map((row) => row.interestId);
}

describe('filing a post under topics', () => {
  it('writes a row per topic the author chose', async () => {
    const { service, created } = serviceWith();
    await service.createPost('me', {
      content: 'hi',
      topics: ['music', 'code'],
    });
    expect(topicsWritten(created[0])).toEqual(['i-music', 'i-code']);
  });

  it('writes none when the author chose none', async () => {
    const { service, created } = serviceWith();
    await service.createPost('me', { content: 'hi' });
    expect(topicsWritten(created[0])).toEqual([]);
  });

  it('is case and whitespace insensitive, and de-duplicates', async () => {
    const { service, created } = serviceWith();
    await service.createPost('me', {
      content: 'hi',
      topics: [' Music ', 'MUSIC', 'code'],
    });
    expect(topicsWritten(created[0])).toEqual(['i-music', 'i-code']);
  });

  it('refuses a topic the catalogue does not have', async () => {
    // Quietly dropping it would hide a composer that has drifted out of step
    // with the server, and post without the topic the author picked.
    const { service } = serviceWith();
    await expect(
      service.createPost('me', { content: 'hi', topics: ['nonsense'] }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('refuses more than it will file', async () => {
    const { service } = serviceWith();
    await expect(
      service.createPost('me', {
        content: 'hi',
        topics: ['music', 'code', 'art', 'food'],
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
