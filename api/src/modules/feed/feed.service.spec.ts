import { BadRequestException, NotFoundException } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import { FeedService } from './feed.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { ModerationService } from '../moderation/moderation.service';

/** One row in the shape the service selects. */
const row = (id: string, createdAt = new Date()) => ({
  id,
  content: `post ${id}`,
  createdAt,
  author: {
    id: 'author-1',
    name: 'Author',
    username: 'author',
    profile: { avatarUrl: 'https://example.test/a.png' },
  },
  replyPolicy: 'EVERYONE' as const,
  _count: { likes: 0, comments: 0, reposts: 0 },
  // Empty means the reader has not liked or saved it: the relation is filtered
  // to their own row, so at most one ever comes back.
  likes: [] as { id: string }[],
  saves: [] as { id: string }[],
  reposts: [] as { id: string }[],
  media: [] as never[],
  quotedPost: null,
});

const VIEWER = 'viewer-1';

type Row = ReturnType<typeof row>;

describe('FeedService', () => {
  // Typed so the awaited results are not `any`, which would let a wrong shape
  // through these assertions silently.
  const post = {
    create: jest.fn<Promise<Row>, [unknown]>(),
    findMany: jest.fn<Promise<Row[]>, [unknown]>(),
    findFirst: jest.fn<Promise<Record<string, unknown> | null>, [unknown]>(),
    findUnique: jest.fn<Promise<{ id: string } | null>, [unknown]>(),
    updateMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
  };

  /** A comment row in the shape commentShape selects. */
  const commentRow = (id: string, parentId: string | null = null) => ({
    id,
    content: `comment ${id}`,
    createdAt: new Date(),
    parentId,
    authorId: 'author-1',
    author: {
      id: 'author-1',
      name: 'Author',
      username: 'author',
      profile: { avatarUrl: null },
    },
    _count: { replies: 0 },
  });

  type CommentRow = ReturnType<typeof commentRow>;

  const comment = {
    create: jest.fn<Promise<CommentRow>, [unknown]>(),
    findMany: jest.fn<Promise<CommentRow[]>, [unknown]>(),
    findFirst: jest.fn<
      Promise<{ id: string; parentId?: string | null } | null>,
      [unknown]
    >(),
    findUnique: jest.fn<Promise<{ id: string } | null>, [unknown]>(),
    updateMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
    count: jest.fn<Promise<number>, [unknown]>(),
  };

  const postView = {
    upsert: jest.fn<Promise<unknown>, [unknown]>(),
    count: jest.fn<Promise<number>, [unknown]>(),
    findMany: jest.fn<Promise<{ createdAt: Date }[]>, [unknown]>(),
  };

  const hashtag = {
    upsert: jest.fn<Promise<{ id: string }>, [unknown]>(),
  };

  const block = {
    findFirst: jest.fn<Promise<{ id: string } | null>, [unknown]>(),
  };

  const follow = {
    findFirst: jest.fn<Promise<{ id: string } | null>, [unknown]>(),
  };

  const user = {
    findUnique: jest.fn<
      Promise<{ username: string | null } | null>,
      [unknown]
    >(),
  };

  /** Nothing blocked, muted or hidden unless a test says otherwise. */
  const moderation = {
    filtersFor: jest.fn(() =>
      Promise.resolve({
        blockedUserIds: [] as string[],
        mutedUserIds: [] as string[],
        mutedPostIds: [] as string[],
        hiddenPostIds: [] as string[],
        mutedPhrases: [] as string[],
      }),
    ),
  };

  const relation = () => ({
    findMany: jest.fn<Promise<{ id: string; post: Row }[]>, [unknown]>(),
    findUnique: jest.fn<Promise<{ id: string } | null>, [unknown]>(),
    upsert: jest.fn<Promise<unknown>, [unknown]>(),
    deleteMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
    count: jest.fn<Promise<number>, [unknown]>(),
  });

  let postLike = relation();
  let postSave = relation();

  const service = async (extra: Record<string, unknown> = {}) => {
    const moduleRef = await Test.createTestingModule({
      providers: [
        FeedService,
        {
          provide: PrismaService,
          useValue: {
            post,
            postLike,
            postSave,
            comment,
            postView,
            hashtag,
            block,
            follow,
            user,
            repost: relation(),
            ...extra,
          },
        },
        { provide: ModerationService, useValue: moderation },
      ],
    }).compile();
    return moduleRef.get(FeedService);
  };

  beforeEach(() => {
    jest.resetAllMocks();
    postLike = relation();
    postSave = relation();
    moderation.filtersFor.mockResolvedValue({
      blockedUserIds: [],
      mutedUserIds: [],
      mutedPostIds: [],
      hiddenPostIds: [],
      mutedPhrases: [],
    });
  });

  describe('createPost', () => {
    it('takes the author from its argument, never from the caller', async () => {
      // The route used to accept authorId in the body while unguarded, so any
      // caller could post as anyone. The author is now the token's subject and
      // there is no path for a request to influence it.
      post.create.mockResolvedValue(row('p1'));
      await (await service()).createPost('user-42', { content: 'hello' });

      expect(post.create).toHaveBeenCalledWith(
        expect.objectContaining({
          data: expect.objectContaining({ authorId: 'user-42' }) as unknown,
        }),
      );
    });

    it('trims the content', async () => {
      post.create.mockResolvedValue(row('p1'));
      await (await service()).createPost('u', { content: '  padded  ' });

      expect(post.create).toHaveBeenCalledWith(
        expect.objectContaining({
          data: expect.objectContaining({ content: 'padded' }) as unknown,
        }),
      );
    });

    it('flattens the author profile into the post', async () => {
      post.create.mockResolvedValue(row('p1'));
      const created = await (
        await service()
      ).createPost('u', { content: 'hi' });

      expect(created.author.avatarUrl).toBe('https://example.test/a.png');
    });
  });

  describe('listRecent', () => {
    it('excludes soft-deleted posts and orders newest first', async () => {
      post.findMany.mockResolvedValue([]);
      await (await service()).listRecent(VIEWER);

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { deletedAt: null },
          orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        }),
      );
    });

    it('asks for one row more than the page, to detect a next page', async () => {
      post.findMany.mockResolvedValue([]);
      await (await service()).listRecent(VIEWER, 20);

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({ take: 21 }),
      );
    });

    it('returns a cursor and trims the probe row when more remain', async () => {
      post.findMany.mockResolvedValue([row('a'), row('b'), row('c')]);
      const page = await (await service()).listRecent(VIEWER, 2);

      expect(page.items.map((i) => i.id)).toEqual(['a', 'b']);
      // The cursor is the last returned row, not the probe -- pointing at the
      // probe would skip it on the next page.
      expect(page.nextCursor).toBe('b');
    });

    it('reports no cursor on the last page', async () => {
      post.findMany.mockResolvedValue([row('a'), row('b')]);
      const page = await (await service()).listRecent(VIEWER, 2);

      expect(page.items).toHaveLength(2);
      expect(page.nextCursor).toBeNull();
    });

    it('skips the cursor row itself', async () => {
      post.findUnique.mockResolvedValue({ id: 'anchor' });
      post.findMany.mockResolvedValue([]);
      await (await service()).listRecent(VIEWER, 20, 'anchor');

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({ cursor: { id: 'anchor' }, skip: 1 }),
      );
    });

    it('answers 404, not 500, for a cursor that no longer exists', async () => {
      // A client holding a cursor to a deleted post would otherwise make
      // Prisma throw and surface as a server error.
      post.findUnique.mockResolvedValue(null);

      await expect(
        (await service()).listRecent(VIEWER, 20, 'gone'),
      ).rejects.toThrow(NotFoundException);
      expect(post.findMany).not.toHaveBeenCalled();
    });
  });

  describe('viewer state on a post', () => {
    it("reports a post the reader has liked, and the post's total", async () => {
      post.findMany.mockResolvedValue([
        {
          ...row('a'),
          _count: { likes: 7, comments: 2, reposts: 1 },
          likes: [{ id: 'like-1' }],
        },
      ]);
      const page = await (await service()).listRecent(VIEWER, 20);

      expect(page.items[0].likes).toBe(7);
      expect(page.items[0].comments).toBe(2);
      expect(page.items[0].reposts).toBe(1);
      expect(page.items[0].likedByViewer).toBe(true);
      expect(page.items[0].savedByViewer).toBe(false);
    });

    it('scopes the like and save relations to the reader', async () => {
      // Without the filter every post would come back carrying everyone's
      // likes, and the reader's own flag would be "did anybody like this".
      post.findMany.mockResolvedValue([]);
      await (await service()).listRecent(VIEWER, 20);

      const args = post.findMany.mock.calls[0][0] as {
        select: {
          likes: { where: { userId: string } };
          saves: { where: { userId: string } };
        };
      };
      expect(args.select.likes.where).toEqual({ userId: VIEWER });
      expect(args.select.saves.where).toEqual({ userId: VIEWER });
    });
  });

  describe('listByAuthor', () => {
    it('filters to that author and still excludes deleted posts', async () => {
      post.findMany.mockResolvedValue([]);
      await (await service()).listByAuthor('author-9', VIEWER, 20);

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { authorId: 'author-9', deletedAt: null },
        }),
      );
    });
  });

  describe('setLiked', () => {
    it('upserts, so a double tap cannot like twice', async () => {
      post.findFirst.mockResolvedValue({ id: 'p1' });
      postLike.count.mockResolvedValue(1);
      await (await service()).setLiked(VIEWER, 'p1', true);

      expect(postLike.upsert).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { userId_postId: { userId: VIEWER, postId: 'p1' } },
          update: {},
        }),
      );
    });

    it('returns the recounted total, not an incremented guess', async () => {
      post.findFirst.mockResolvedValue({ id: 'p1' });
      postLike.count.mockResolvedValue(4);

      await expect(
        (await service()).setLiked(VIEWER, 'p1', true),
      ).resolves.toEqual({ liked: true, likes: 4 });
    });

    it('refuses to like a post that is deleted or missing', async () => {
      post.findFirst.mockResolvedValue(null);

      await expect(
        (await service()).setLiked(VIEWER, 'gone', true),
      ).rejects.toThrow(NotFoundException);
      expect(postLike.upsert).not.toHaveBeenCalled();
    });
  });

  describe('listSaved', () => {
    it("reads only the reader's own saves, newest first", async () => {
      postSave.findMany.mockResolvedValue([]);
      await (await service()).listSaved(VIEWER, 20);

      expect(postSave.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { userId: VIEWER, post: { deletedAt: null } },
          orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        }),
      );
    });

    it('cursors on the save, not on the post', async () => {
      // The list is ordered by when you saved, so a post-id cursor would point
      // into a different ordering and skip or repeat rows.
      postSave.findMany.mockResolvedValue([
        { id: 'save-a', post: row('p1') },
        { id: 'save-b', post: row('p2') },
        { id: 'save-c', post: row('p3') },
      ]);
      const page = await (await service()).listSaved(VIEWER, 2);

      expect(page.items.map((i) => i.id)).toEqual(['p1', 'p2']);
      expect(page.nextCursor).toBe('save-b');
    });

    it('answers 404 for a cursor that no longer exists', async () => {
      postSave.findUnique.mockResolvedValue(null);

      await expect(
        (await service()).listSaved(VIEWER, 20, 'gone'),
      ).rejects.toThrow(NotFoundException);
      expect(postSave.findMany).not.toHaveBeenCalled();
    });
  });

  describe('addComment', () => {
    it('takes the author from its argument and trims the content', async () => {
      post.findFirst.mockResolvedValue({
        authorId: 'user-9',
        replyPolicy: 'EVERYONE',
        content: '',
      });
      comment.create.mockResolvedValue(commentRow('c1'));
      await (await service()).addComment('p1', 'user-9', '  hi  ');

      expect(comment.create).toHaveBeenCalledWith(
        expect.objectContaining({
          data: expect.objectContaining({
            postId: 'p1',
            authorId: 'user-9',
            content: 'hi',
            parentId: null,
          }) as unknown,
        }),
      );
    });

    it('attaches a reply to a reply to the same thread, not a third level', async () => {
      post.findFirst.mockResolvedValue({
        authorId: 'u',
        replyPolicy: 'EVERYONE',
        content: '',
      });
      // The comment being replied to is itself a reply, under 'top'.
      comment.findFirst.mockResolvedValue({ id: 'c2', parentId: 'top' });
      comment.create.mockResolvedValue(commentRow('c3', 'top'));

      await (await service()).addComment('p1', 'u', 'nested', 'c2');

      expect(comment.create).toHaveBeenCalledWith(
        expect.objectContaining({
          data: expect.objectContaining({ parentId: 'top' }) as unknown,
        }),
      );
    });

    it('refuses a parent comment that belongs to another post', async () => {
      // Scoped by postId, so an id lifted from a different thread matches
      // nothing rather than being grafted on.
      post.findFirst.mockResolvedValue({
        authorId: 'u',
        replyPolicy: 'EVERYONE',
        content: '',
      });
      comment.findFirst.mockResolvedValue(null);

      await expect(
        (await service()).addComment('p1', 'u', 'hi', 'elsewhere'),
      ).rejects.toThrow(NotFoundException);
      expect(comment.create).not.toHaveBeenCalled();
    });

    it('refuses to comment on a post that is deleted or missing', async () => {
      post.findFirst.mockResolvedValue(null);

      await expect(
        (await service()).addComment('gone', 'u', 'hi'),
      ).rejects.toThrow(NotFoundException);
    });
  });

  describe('listComments', () => {
    it('reads a thread oldest first, top level only', async () => {
      post.findFirst.mockResolvedValue({ id: 'p1' });
      comment.findMany.mockResolvedValue([]);
      await (await service()).listComments('p1', VIEWER, 20);

      expect(comment.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { postId: 'p1', parentId: null, deletedAt: null },
          // A conversation reads in the order it happened, unlike every other
          // list here.
          orderBy: [{ createdAt: 'asc' }, { id: 'asc' }],
        }),
      );
    });

    it('marks the reader own comments so they can delete them', async () => {
      post.findFirst.mockResolvedValue({ id: 'p1' });
      comment.findMany.mockResolvedValue([
        commentRow('c1'),
        { ...commentRow('c2'), authorId: VIEWER },
      ]);

      const page = await (await service()).listComments('p1', VIEWER, 20);

      expect(page.items.map((c) => c.mine)).toEqual([false, true]);
    });
  });

  describe('deleteComment', () => {
    it('soft deletes, scoped to the author', async () => {
      comment.updateMany.mockResolvedValue({ count: 1 });
      await (await service()).deleteComment('user-1', 'c1');

      expect(comment.updateMany).toHaveBeenCalledWith({
        where: { id: 'c1', authorId: 'user-1', deletedAt: null },
        data: { deletedAt: expect.any(Date) as unknown },
      });
    });

    it("reports not found for someone else's comment", async () => {
      comment.updateMany.mockResolvedValue({ count: 0 });

      await expect(
        (await service()).deleteComment('someone-else', 'c1'),
      ).rejects.toThrow(NotFoundException);
    });
  });

  describe('recordView', () => {
    it('counts a reader once, however many times they open it', async () => {
      post.findFirst.mockResolvedValue({ authorId: 'someone-else' });
      await (await service()).recordView('p1', VIEWER);

      expect(postView.upsert).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { postId_viewerId: { postId: 'p1', viewerId: VIEWER } },
          update: {},
        }),
      );
    });

    it("does not count the author's own opens as reach", async () => {
      post.findFirst.mockResolvedValue({ authorId: VIEWER });
      await (await service()).recordView('p1', VIEWER);

      expect(postView.upsert).not.toHaveBeenCalled();
    });
  });

  describe('analytics', () => {
    it('answers 404 to anyone but the author', async () => {
      // Forbidden would confirm the post exists to someone with no business
      // knowing its reach.
      post.findFirst.mockResolvedValue({
        id: 'p1',
        authorId: 'someone-else',
        createdAt: new Date(),
      });

      await expect((await service()).analytics('p1', VIEWER)).rejects.toThrow(
        NotFoundException,
      );
    });

    it('groups views by day, oldest first', async () => {
      post.findFirst.mockResolvedValue({
        id: 'p1',
        authorId: VIEWER,
        createdAt: new Date('2026-08-30T00:00:00Z'),
      });
      postView.count.mockResolvedValue(3);
      postLike.count.mockResolvedValue(1);
      postSave.count.mockResolvedValue(0);
      comment.count.mockResolvedValue(2);
      postView.findMany.mockResolvedValue([
        { createdAt: new Date('2026-08-30T09:00:00Z') },
        { createdAt: new Date('2026-08-30T18:00:00Z') },
        { createdAt: new Date('2026-08-31T07:00:00Z') },
      ]);

      const report = await (await service()).analytics('p1', VIEWER);

      expect(report.views).toBe(3);
      expect(report.comments).toBe(2);
      expect(report.timeline).toEqual([
        { date: '2026-08-30', views: 2 },
        { date: '2026-08-31', views: 1 },
      ]);
    });
  });

  describe('hashtagsIn', () => {
    it('finds tags and lower-cases them', () => {
      expect(FeedService.hashtagsIn('Hello #Kyron and #running')).toEqual([
        'kyron',
        'running',
      ]);
    });

    it('counts a tag once however often it appears', () => {
      expect(FeedService.hashtagsIn('#a #A #a')).toEqual(['a']);
    });

    it('ignores a hash that is not at a word boundary', () => {
      // A colour and an id fragment are not topics.
      expect(FeedService.hashtagsIn('colour #fff in the#middle')).toEqual([
        'fff',
      ]);
      expect(FeedService.hashtagsIn('email a#b')).toEqual([]);
    });

    it('ignores a purely numeric tag', () => {
      // "ranked #1" is not a topic.
      expect(FeedService.hashtagsIn('ranked #1 of #2026things')).toEqual([
        '2026things',
      ]);
    });

    it('reads tags in other scripts', () => {
      expect(FeedService.hashtagsIn('#naija #日本')).toEqual(['naija', '日本']);
    });
  });

  describe('createPost', () => {
    it('refuses a post with neither text nor an attachment', async () => {
      await expect(
        (await service()).createPost('u', { content: '   ' }),
      ).rejects.toThrow(BadRequestException);
      expect(post.create).not.toHaveBeenCalled();
    });

    it('accepts a post that is only an attachment', async () => {
      hashtag.upsert.mockResolvedValue({ id: 'h1' });
      post.create.mockResolvedValue(row('p1'));

      await (
        await service()
      ).createPost('u', {
        content: '',
        media: [{ url: 'https://example.test/a.jpg' }],
      });

      expect(post.create).toHaveBeenCalled();
    });

    it('refuses more attachments than the limit', async () => {
      await expect(
        (await service()).createPost('u', {
          content: 'hi',
          media: Array.from({ length: 5 }, () => ({
            url: 'https://example.test/a.jpg',
          })),
        }),
      ).rejects.toThrow(BadRequestException);
    });

    it('indexes the tags the text actually contains', async () => {
      // Extracted server-side. Taking them from the client would let a post be
      // filed under anything its author names in a field nobody sees.
      hashtag.upsert.mockResolvedValue({ id: 'h1' });
      post.create.mockResolvedValue(row('p1'));

      await (await service()).createPost('u', { content: 'about #kyron' });

      expect(hashtag.upsert).toHaveBeenCalledWith(
        expect.objectContaining({ where: { tag: 'kyron' } }),
      );
    });
  });

  describe("the feed applies the reader's filters", () => {
    it('excludes blocked and muted accounts in the query', async () => {
      // Filtered server-side: hiding a blocked account's posts after they have
      // been sent is not blocking.
      moderation.filtersFor.mockResolvedValue({
        blockedUserIds: ['blocked-1'],
        mutedUserIds: ['muted-1'],
        mutedPostIds: [],
        hiddenPostIds: [],
        mutedPhrases: [],
      });
      post.findMany.mockResolvedValue([]);

      await (await service()).listRecent(VIEWER, 20);

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: expect.objectContaining({
            authorId: { notIn: ['blocked-1', 'muted-1'] },
          }) as unknown,
        }),
      );
    });

    it('excludes hidden posts and anything quoting them', async () => {
      moderation.filtersFor.mockResolvedValue({
        blockedUserIds: [],
        mutedUserIds: [],
        mutedPostIds: ['thread-1'],
        hiddenPostIds: ['hidden-1'],
        mutedPhrases: [],
      });
      post.findMany.mockResolvedValue([]);

      await (await service()).listRecent(VIEWER, 20);

      const args = post.findMany.mock.calls[0][0] as {
        where: { AND: { id?: { notIn: string[] } }[] };
      };
      expect(args.where.AND[0].id).toEqual({
        notIn: ['hidden-1', 'thread-1'],
      });
    });

    it('matches a muted word case-insensitively, as a substring', async () => {
      // Someone muting a word should not have to guess its plural.
      moderation.filtersFor.mockResolvedValue({
        blockedUserIds: [],
        mutedUserIds: [],
        mutedPostIds: [],
        hiddenPostIds: [],
        mutedPhrases: ['spoiler'],
      });
      post.findMany.mockResolvedValue([]);

      await (await service()).listRecent(VIEWER, 20);

      const args = post.findMany.mock.calls[0][0] as {
        where: { AND: { content?: unknown }[] };
      };
      expect(args.where.AND[0].content).toEqual({
        not: { contains: 'spoiler', mode: 'insensitive' },
      });
    });

    it('does not filter a profile, which was asked for by name', async () => {
      moderation.filtersFor.mockResolvedValue({
        blockedUserIds: ['blocked-1'],
        mutedUserIds: [],
        mutedPostIds: [],
        hiddenPostIds: [],
        mutedPhrases: [],
      });
      post.findMany.mockResolvedValue([]);

      await (await service()).listByAuthor('author-9', VIEWER, 20);

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { authorId: 'author-9', deletedAt: null },
        }),
      );
    });
  });

  describe('reply policy', () => {
    const policy = (replyPolicy: string, content = '') => ({
      authorId: 'author-1',
      replyPolicy,
      content,
    });

    it('lets anyone reply when the policy is EVERYONE', async () => {
      post.findFirst.mockResolvedValue(policy('EVERYONE'));
      block.findFirst.mockResolvedValue(null);
      comment.create.mockResolvedValue(commentRow('c1'));

      await expect(
        (await service()).addComment('p1', 'stranger', 'hi'),
      ).resolves.toBeDefined();
    });

    it('refuses everyone but the author when the policy is NOBODY', async () => {
      post.findFirst.mockResolvedValue(policy('NOBODY'));
      block.findFirst.mockResolvedValue(null);

      await expect(
        (await service()).addComment('p1', 'stranger', 'hi'),
      ).rejects.toThrow(BadRequestException);
    });

    it('still lets the author reply under their own NOBODY policy', async () => {
      post.findFirst.mockResolvedValue(policy('NOBODY'));
      comment.create.mockResolvedValue(commentRow('c1'));

      await expect(
        (await service()).addComment('p1', 'author-1', 'hi'),
      ).resolves.toBeDefined();
      expect(block.findFirst).not.toHaveBeenCalled();
    });

    it('requires a follow when the policy is FOLLOWERS', async () => {
      post.findFirst.mockResolvedValue(policy('FOLLOWERS'));
      block.findFirst.mockResolvedValue(null);
      follow.findFirst.mockResolvedValue(null);

      await expect(
        (await service()).addComment('p1', 'stranger', 'hi'),
      ).rejects.toThrow(BadRequestException);
    });

    it('requires a mention when the policy is MENTIONED', async () => {
      post.findFirst.mockResolvedValue(policy('MENTIONED', 'hello @ada'));
      block.findFirst.mockResolvedValue(null);
      user.findUnique.mockResolvedValue({ username: 'bob' });

      await expect(
        (await service()).addComment('p1', 'bob-id', 'hi'),
      ).rejects.toThrow(BadRequestException);

      user.findUnique.mockResolvedValue({ username: 'ada' });
      comment.create.mockResolvedValue(commentRow('c1'));
      await expect(
        (await service()).addComment('p1', 'ada-id', 'hi'),
      ).resolves.toBeDefined();
    });

    it('answers not found, not forbidden, when the two have blocked', async () => {
      // Forbidden would confirm the post exists to someone shut out of it.
      post.findFirst.mockResolvedValue(policy('EVERYONE'));
      block.findFirst.mockResolvedValue({ id: 'b1' });

      await expect(
        (await service()).addComment('p1', 'blocked', 'hi'),
      ).rejects.toThrow(NotFoundException);
    });
  });

  describe('setReposted', () => {
    it('upserts, so a double tap cannot repost twice', async () => {
      post.findFirst.mockResolvedValue({ id: 'p1' });
      const repost = relation();
      await (await service({ repost })).setReposted(VIEWER, 'p1', true);

      expect(repost.upsert).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { userId_postId: { userId: VIEWER, postId: 'p1' } },
          update: {},
        }),
      );
    });
  });

  describe('deletePost', () => {
    it('soft deletes, scoped to the author', async () => {
      post.updateMany.mockResolvedValue({ count: 1 });
      await (await service()).deletePost('user-1', 'post-1');

      expect(post.updateMany).toHaveBeenCalledWith({
        where: { id: 'post-1', authorId: 'user-1', deletedAt: null },
        data: { deletedAt: expect.any(Date) as unknown },
      });
    });

    it("reports not found for someone else's post, not forbidden", async () => {
      // Distinguishing the two would confirm the post exists to a caller who
      // is not allowed to know that.
      post.updateMany.mockResolvedValue({ count: 0 });

      await expect(
        (await service()).deletePost('someone-else', 'post-1'),
      ).rejects.toThrow(NotFoundException);
    });
  });
});
