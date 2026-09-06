import { FeedService } from './feed.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { NotFoundException } from '@nestjs/common';
import { RankingService } from './ranking.service';

const ME = 'me';

function serviceWith({
  comment = { id: 'c1', postId: 'p1' } as Record<string, unknown> | null,
  children = [] as Record<string, unknown>[][],
  likeCount = 0,
} = {}) {
  const created: unknown[] = [];
  const deleted: unknown[] = [];
  let level = 0;

  const prisma = {
    comment: {
      findFirst: jest.fn().mockResolvedValue(comment),
      findMany: jest.fn(() => Promise.resolve(children[level++] ?? [])),
    },
    commentLike: {
      createMany: jest.fn((args: unknown) => {
        created.push(args);
        return Promise.resolve({ count: 1 });
      }),
      deleteMany: jest.fn((args: unknown) => {
        deleted.push(args);
        return Promise.resolve({ count: 1 });
      }),
      count: jest.fn().mockResolvedValue(likeCount),
    },
  };

  return {
    svc: new FeedService(
      prisma as unknown as PrismaService,
      {} as never,
      new RankingService(),
    ),
    prisma,
    created,
    deleted,
  };
}

const row = (id: string, parentId: string | null) => ({
  id,
  content: id,
  createdAt: new Date(),
  parentId,
  authorId: 'them',
  author: { id: 'them', name: null, username: null, profile: null },
  _count: { replies: 0, likes: 0 },
  media: [],
  likes: [],
});

describe('comment likes', () => {
  it('is idempotent, so a double tap is one like', async () => {
    const { svc, created } = serviceWith({ likeCount: 1 });

    await svc.setCommentLike(ME, 'c1', true);

    // skipDuplicates rather than a caught unique violation: same result,
    // without an exception in the middle of the happy path.
    expect(created).toEqual([
      { data: [{ userId: ME, commentId: 'c1' }], skipDuplicates: true },
    ]);
  });

  it('takes the like back', async () => {
    const { svc, deleted } = serviceWith({ likeCount: 0 });

    await expect(svc.setCommentLike(ME, 'c1', false)).resolves.toEqual({
      id: 'c1',
      likes: 0,
      liked: false,
    });
    expect(deleted).toEqual([{ where: { userId: ME, commentId: 'c1' } }]);
  });

  it('refuses a comment that is gone', async () => {
    const { svc } = serviceWith({ comment: null });

    await expect(svc.setCommentLike(ME, 'c1', true)).rejects.toThrow(
      NotFoundException,
    );
  });
});

describe('commentThread', () => {
  it('walks the whole branch, not one level of it', async () => {
    const { svc } = serviceWith({
      comment: { ...row('c1', null), postId: 'p1' },
      children: [[row('c2', 'c1')], [row('c3', 'c2')], []],
    });

    const thread = await svc.commentThread(ME, 'c1');

    expect(thread.postId).toBe('p1');
    expect(thread.root.id).toBe('c1');
    expect(thread.replies.map((r) => r.id)).toEqual(['c2', 'c3']);
  });

  it('stops at the depth cap rather than following a chain forever', async () => {
    // Every level answers with one more child, so only the cap ends the walk.
    const { svc, prisma } = serviceWith({
      comment: { ...row('c1', null), postId: 'p1' },
      children: Array.from({ length: 50 }, (_, i) => [row(`c${i + 2}`, 'x')]),
    });

    await svc.commentThread(ME, 'c1');

    expect(prisma.comment.findMany).toHaveBeenCalledTimes(
      FeedService.maxThreadDepth,
    );
  });

  it('refuses a comment that is gone', async () => {
    const { svc } = serviceWith({ comment: null });

    await expect(svc.commentThread(ME, 'c1')).rejects.toThrow(
      NotFoundException,
    );
  });
});
