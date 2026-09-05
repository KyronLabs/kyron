import { FeedService } from './feed.service';
import { ModerationService } from '../moderation/moderation.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/** No blocks, no mutes: the plain case, so the ranking is what is under test. */
const noFilters = {
  filtersFor: jest.fn().mockResolvedValue({
    blockedUserIds: [],
    mutedUserIds: [],
    hiddenPostIds: [],
    mutedPostIds: [],
    mutedPhrases: [],
  }),
} as unknown as ModerationService;

type GroupByArgs = { where?: Record<string, unknown> };

function serviceWith(options: {
  ranked: { hashtagId: string; _count: { postId: number } }[];
  totals: { hashtagId: string; _count: { postId: number } }[];
  tags: { id: string; tag: string }[];
  moderation?: ModerationService;
}) {
  const calls: GroupByArgs[] = [];
  const prisma = {
    postHashtag: {
      groupBy: jest.fn((args: GroupByArgs & { orderBy?: unknown }) => {
        calls.push(args);
        // The ranking query is the one that orders; the other is the totals.
        return Promise.resolve(args.orderBy ? options.ranked : options.totals);
      }),
    },
    hashtag: { findMany: jest.fn().mockResolvedValue(options.tags) },
  } as unknown as PrismaService;

  return {
    service: new FeedService(prisma, options.moderation ?? noFilters),
    calls,
  };
}

describe('FeedService.trendingTags', () => {
  it('ranks on the window and shows the total', async () => {
    // Two different numbers on purpose. What makes a tag trending is what has
    // happened this week; what you find when you tap through is everything.
    const { service } = serviceWith({
      ranked: [
        { hashtagId: 'h2', _count: { postId: 9 } },
        { hashtagId: 'h1', _count: { postId: 4 } },
      ],
      totals: [
        { hashtagId: 'h1', _count: { postId: 400 } },
        { hashtagId: 'h2', _count: { postId: 12 } },
      ],
      tags: [
        { id: 'h1', tag: 'lagos' },
        { id: 'h2', tag: 'kyron' },
      ],
    });

    const { items } = await service.trendingTags('viewer');

    expect(items).toEqual([
      { tag: 'kyron', posts: 12, recent: 9 },
      { tag: 'lagos', posts: 400, recent: 4 },
    ]);
  });

  it('asks only for posts inside the window when it ranks', async () => {
    const { service, calls } = serviceWith({
      ranked: [{ hashtagId: 'h1', _count: { postId: 1 } }],
      totals: [{ hashtagId: 'h1', _count: { postId: 1 } }],
      tags: [{ id: 'h1', tag: 'kyron' }],
    });

    await service.trendingTags('viewer');

    const ranking = calls[0].where?.post as { createdAt?: { gte: Date } };
    expect(ranking.createdAt?.gte).toBeInstanceOf(Date);
    const days =
      (Date.now() - ranking.createdAt!.gte.getTime()) / (24 * 60 * 60 * 1000);
    expect(days).toBeCloseTo(FeedService.trendingWindowMs / 86400000, 1);
  });

  it('leaves out whoever the reader has blocked', async () => {
    const moderation = {
      filtersFor: jest.fn().mockResolvedValue({
        blockedUserIds: ['loud-person'],
        mutedUserIds: [],
        hiddenPostIds: [],
        mutedPostIds: [],
        mutedPhrases: [],
      }),
    } as unknown as ModerationService;

    const { service, calls } = serviceWith({
      ranked: [{ hashtagId: 'h1', _count: { postId: 1 } }],
      totals: [{ hashtagId: 'h1', _count: { postId: 1 } }],
      tags: [{ id: 'h1', tag: 'kyron' }],
      moderation,
    });

    await service.trendingTags('viewer');

    // A tag kept alive by an account the reader has blocked is not trending as
    // far as they are concerned.
    const post = calls[0].where?.post as { authorId?: { notIn: string[] } };
    expect(post.authorId?.notIn).toEqual(['loud-person']);
  });

  it('says nothing is trending rather than inventing something', async () => {
    const { service } = serviceWith({ ranked: [], totals: [], tags: [] });
    await expect(service.trendingTags('viewer')).resolves.toEqual({
      items: [],
    });
  });

  it('drops a tag deleted between the ranking and the read', async () => {
    const { service } = serviceWith({
      ranked: [
        { hashtagId: 'gone', _count: { postId: 3 } },
        { hashtagId: 'h1', _count: { postId: 1 } },
      ],
      totals: [{ hashtagId: 'h1', _count: { postId: 1 } }],
      tags: [{ id: 'h1', tag: 'kyron' }],
    });

    const { items } = await service.trendingTags('viewer');
    expect(items).toEqual([{ tag: 'kyron', posts: 1, recent: 1 }]);
  });
});
