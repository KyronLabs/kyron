import { NotFoundException } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import { FeedService } from './feed.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

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
  _count: { likes: 0 },
  // Empty means the reader has not liked or saved it: the relation is filtered
  // to their own row, so at most one ever comes back.
  likes: [] as { id: string }[],
  saves: [] as { id: string }[],
});

const VIEWER = 'viewer-1';

type Row = ReturnType<typeof row>;

describe('FeedService', () => {
  // Typed so the awaited results are not `any`, which would let a wrong shape
  // through these assertions silently.
  const post = {
    create: jest.fn<Promise<Row>, [unknown]>(),
    findMany: jest.fn<Promise<Row[]>, [unknown]>(),
    findFirst: jest.fn<Promise<{ id: string } | null>, [unknown]>(),
    findUnique: jest.fn<Promise<{ id: string } | null>, [unknown]>(),
    updateMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
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

  const service = async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [
        FeedService,
        { provide: PrismaService, useValue: { post, postLike, postSave } },
      ],
    }).compile();
    return moduleRef.get(FeedService);
  };

  beforeEach(() => {
    jest.resetAllMocks();
    postLike = relation();
    postSave = relation();
  });

  describe('createPost', () => {
    it('takes the author from its argument, never from the caller', async () => {
      // The route used to accept authorId in the body while unguarded, so any
      // caller could post as anyone. The author is now the token's subject and
      // there is no path for a request to influence it.
      post.create.mockResolvedValue(row('p1'));
      await (await service()).createPost('user-42', 'hello');

      expect(post.create).toHaveBeenCalledWith(
        expect.objectContaining({
          data: expect.objectContaining({ authorId: 'user-42' }) as unknown,
        }),
      );
    });

    it('trims the content', async () => {
      post.create.mockResolvedValue(row('p1'));
      await (await service()).createPost('u', '  padded  ');

      expect(post.create).toHaveBeenCalledWith(
        expect.objectContaining({
          data: expect.objectContaining({ content: 'padded' }) as unknown,
        }),
      );
    });

    it('flattens the author profile into the post', async () => {
      post.create.mockResolvedValue(row('p1'));
      const created = await (await service()).createPost('u', 'hi');

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
        { ...row('a'), _count: { likes: 7 }, likes: [{ id: 'like-1' }] },
      ]);
      const page = await (await service()).listRecent(VIEWER, 20);

      expect(page.items[0].likes).toBe(7);
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
