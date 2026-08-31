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
});

type Row = ReturnType<typeof row>;

describe('FeedService', () => {
  // Typed so the awaited results are not `any`, which would let a wrong shape
  // through these assertions silently.
  const post = {
    create: jest.fn<Promise<Row>, [unknown]>(),
    findMany: jest.fn<Promise<Row[]>, [unknown]>(),
    findUnique: jest.fn<Promise<{ id: string } | null>, [unknown]>(),
    updateMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
  };

  const service = async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [FeedService, { provide: PrismaService, useValue: { post } }],
    }).compile();
    return moduleRef.get(FeedService);
  };

  beforeEach(() => jest.resetAllMocks());

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
      await (await service()).listRecent();

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { deletedAt: null },
          orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        }),
      );
    });

    it('asks for one row more than the page, to detect a next page', async () => {
      post.findMany.mockResolvedValue([]);
      await (await service()).listRecent(20);

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({ take: 21 }),
      );
    });

    it('returns a cursor and trims the probe row when more remain', async () => {
      post.findMany.mockResolvedValue([row('a'), row('b'), row('c')]);
      const page = await (await service()).listRecent(2);

      expect(page.items.map((i) => i.id)).toEqual(['a', 'b']);
      // The cursor is the last returned row, not the probe -- pointing at the
      // probe would skip it on the next page.
      expect(page.nextCursor).toBe('b');
    });

    it('reports no cursor on the last page', async () => {
      post.findMany.mockResolvedValue([row('a'), row('b')]);
      const page = await (await service()).listRecent(2);

      expect(page.items).toHaveLength(2);
      expect(page.nextCursor).toBeNull();
    });

    it('skips the cursor row itself', async () => {
      post.findUnique.mockResolvedValue({ id: 'anchor' });
      post.findMany.mockResolvedValue([]);
      await (await service()).listRecent(20, 'anchor');

      expect(post.findMany).toHaveBeenCalledWith(
        expect.objectContaining({ cursor: { id: 'anchor' }, skip: 1 }),
      );
    });

    it('answers 404, not 500, for a cursor that no longer exists', async () => {
      // A client holding a cursor to a deleted post would otherwise make
      // Prisma throw and surface as a server error.
      post.findUnique.mockResolvedValue(null);

      await expect((await service()).listRecent(20, 'gone')).rejects.toThrow(
        NotFoundException,
      );
      expect(post.findMany).not.toHaveBeenCalled();
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
