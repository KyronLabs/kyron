import { NotificationsService } from './notifications.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

const ME = 'me';

function actor(id: string) {
  return { id, name: id, username: id, profile: { avatarUrl: null } };
}

function at(minutesAgo: number): Date {
  return new Date(Date.now() - minutesAgo * 60_000);
}

interface Rows {
  likes?: unknown[];
  comments?: unknown[];
  reposts?: unknown[];
  follows?: unknown[];
  blocks?: { blockerId: string; blockedId: string }[];
  seenAt?: Date | null;
  counts?: Partial<Record<'like' | 'comment' | 'repost' | 'follow', number>>;
}

function serviceWith(rows: Rows = {}) {
  const where: Record<string, unknown> = {};

  const capture =
    (key: string, result: unknown[]) =>
    (args: { where?: unknown }): Promise<unknown[]> => {
      where[key] = args?.where;
      return Promise.resolve(result);
    };

  const prisma = {
    user: {
      findUnique: jest
        .fn()
        .mockResolvedValue({ notificationsSeenAt: rows.seenAt ?? null }),
      update: jest.fn().mockResolvedValue({}),
    },
    block: {
      findMany: jest.fn().mockResolvedValue(rows.blocks ?? []),
    },
    postLike: {
      findMany: jest.fn(capture('like', rows.likes ?? [])),
      count: jest.fn().mockResolvedValue(rows.counts?.like ?? 0),
    },
    comment: {
      findMany: jest.fn(capture('comment', rows.comments ?? [])),
      count: jest.fn().mockResolvedValue(rows.counts?.comment ?? 0),
    },
    repost: {
      findMany: jest.fn(capture('repost', rows.reposts ?? [])),
      count: jest.fn().mockResolvedValue(rows.counts?.repost ?? 0),
    },
    follow: {
      findMany: jest.fn(capture('follow', rows.follows ?? [])),
      count: jest.fn().mockResolvedValue(rows.counts?.follow ?? 0),
    },
  };

  return {
    svc: new NotificationsService(prisma as unknown as PrismaService),
    prisma,
    where,
  };
}

describe('NotificationsService', () => {
  it('puts every kind on one list, newest first', async () => {
    const { svc } = serviceWith({
      likes: [
        {
          id: 'l1',
          createdAt: at(30),
          postId: 'p1',
          user: actor('ana'),
          post: { content: 'a post' },
        },
      ],
      comments: [
        {
          id: 'c1',
          createdAt: at(5),
          postId: 'p1',
          content: 'nice one',
          author: actor('bo'),
          post: { content: 'a post' },
        },
      ],
      follows: [{ id: 'f1', createdAt: at(60), follower: actor('cy') }],
    });

    const { items } = await svc.list(ME);

    expect(items.map((row) => row.id)).toEqual([
      'comment:c1',
      'like:l1',
      'follow:f1',
    ]);
    expect(items[0].content).toBe('nice one');
    expect(items[0].actor.username).toBe('bo');
    // A follow is about the account, not about any one post.
    expect(items[2].postId).toBeNull();
  });

  it('keeps ids apart when two tables share a row id', async () => {
    const { svc } = serviceWith({
      likes: [
        {
          id: 'same',
          createdAt: at(1),
          postId: 'p1',
          user: actor('ana'),
          post: { content: 'x' },
        },
      ],
      reposts: [
        {
          id: 'same',
          createdAt: at(2),
          postId: 'p1',
          user: actor('bo'),
          post: { content: 'x' },
        },
      ],
    });

    const { items } = await svc.list(ME);

    expect(new Set(items.map((row) => row.id)).size).toBe(2);
  });

  it('never reports what the reader did to their own post', async () => {
    const { svc, where } = serviceWith();

    await svc.list(ME);

    expect(where.like).toMatchObject({ userId: { not: ME } });
    expect(where.comment).toMatchObject({ authorId: { not: ME } });
    expect(where.follow).toMatchObject({ followerId: { not: ME } });
  });

  it('leaves out anybody either side has blocked', async () => {
    const { svc, where } = serviceWith({
      blocks: [
        { blockerId: ME, blockedId: 'rude' },
        { blockerId: 'hostile', blockedId: ME },
      ],
    });

    await svc.list(ME);

    expect(where.like).toMatchObject({
      userId: {
        notIn: expect.arrayContaining(['rude', 'hostile']) as string[],
      },
    });
  });

  it('is unread until the screen has been opened past it', async () => {
    const { svc } = serviceWith({
      seenAt: at(10),
      likes: [
        {
          id: 'old',
          createdAt: at(20),
          postId: 'p1',
          user: actor('ana'),
          post: { content: 'x' },
        },
        {
          id: 'new',
          createdAt: at(2),
          postId: 'p1',
          user: actor('bo'),
          post: { content: 'x' },
        },
      ],
    });

    const { items } = await svc.list(ME);

    expect(items.find((row) => row.id === 'like:new')?.unread).toBe(true);
    expect(items.find((row) => row.id === 'like:old')?.unread).toBe(false);
  });

  it('asks only the kind a tab wants', async () => {
    const { svc, prisma } = serviceWith();

    await svc.list(ME, { kind: 'follow' });

    expect(prisma.follow.findMany).toHaveBeenCalled();
    expect(prisma.postLike.findMany).not.toHaveBeenCalled();
    expect(prisma.comment.findMany).not.toHaveBeenCalled();
  });

  it('offers a cursor only while a page comes back full', async () => {
    const full = Array.from({ length: 2 }, (_, index) => ({
      id: `l${index}`,
      createdAt: at(index + 1),
      postId: 'p1',
      user: actor('ana'),
      post: { content: 'x' },
    }));

    const { svc } = serviceWith({ likes: full });
    const page = await svc.list(ME, { limit: 2 });
    expect(page.nextCursor).toBe(full[1].createdAt.toISOString());

    const { svc: shortSvc } = serviceWith({ likes: full });
    const short = await shortSvc.list(ME, { limit: 5 });
    expect(short.nextCursor).toBeNull();
  });

  it('adds the badge up across all four kinds', async () => {
    const { svc } = serviceWith({
      counts: { like: 3, comment: 2, repost: 1, follow: 4 },
    });

    await expect(svc.unreadCount(ME)).resolves.toEqual({ count: 10 });
  });

  it('trims a long post down to a snippet', async () => {
    const { svc } = serviceWith({
      likes: [
        {
          id: 'l1',
          createdAt: at(1),
          postId: 'p1',
          user: actor('ana'),
          post: { content: 'w'.repeat(200) },
        },
      ],
    });

    const { items } = await svc.list(ME);

    expect(items[0].postSnippet).toHaveLength(91);
    expect(items[0].postSnippet?.endsWith('…')).toBe(true);
  });

  it('opening the screen moves the watermark forward', async () => {
    const { svc, prisma } = serviceWith();

    const { seenAt } = await svc.markSeen(ME);

    expect(prisma.user.update).toHaveBeenCalledWith({
      where: { id: ME },
      data: { notificationsSeenAt: seenAt },
    });
  });
});
