import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/** A post as the feed returns it, with just enough of its author to render. */
export interface FeedPost {
  id: string;
  content: string;
  createdAt: Date;
  author: {
    id: string;
    name: string | null;
    username: string | null;
    avatarUrl: string | null;
  };
  /** How many people have liked it. */
  likes: number;
  /** How many comments and replies it has. */
  comments: number;
  /** Whether the reader has. Saves are private, so there is no count. */
  likedByViewer: boolean;
  savedByViewer: boolean;
}

/** One comment, or one reply to a comment. */
export interface FeedComment {
  id: string;
  content: string;
  createdAt: Date;
  author: {
    id: string;
    name: string | null;
    username: string | null;
    avatarUrl: string | null;
  };
  /** Null on a top-level comment. */
  parentId: string | null;
  /** How many replies hang off it. Always 0 on a reply. */
  replies: number;
  /** Whether the reader wrote it, and so may delete it. */
  mine: boolean;
}

export interface CommentPage {
  items: FeedComment[];
  nextCursor: string | null;
}

/** What an author can see about their own post. */
export interface PostAnalytics {
  postId: string;
  createdAt: Date;
  /** Distinct people who opened it. Counted once each, not per open. */
  views: number;
  likes: number;
  saves: number;
  comments: number;
  /** Views per day since it was posted, oldest first. */
  timeline: { date: string; views: number }[];
}

export interface FeedPage {
  items: FeedPost[];
  /** Pass as `cursor` for the next page, or null at the end. */
  nextCursor: string | null;
}

const DEFAULT_LIMIT = 20;

@Injectable()
export class FeedService {
  private readonly logger = new Logger(FeedService.name);

  constructor(private readonly prisma: PrismaService) {}

  async createPost(authorId: string, content: string): Promise<FeedPost> {
    const post = await this.prisma.post.create({
      data: { authorId, content: content.trim() },
      select: this.shapeFor(authorId),
    });
    this.logger.log(`post ${post.id} created by ${authorId}`);
    return this.toFeedPost(post);
  }

  /**
   * Newest first, one page at a time.
   *
   * Keyset pagination rather than an offset: the feed is written to while it
   * is being read, so an offset shifts under the reader and duplicates or
   * skips whatever crossed the page boundary. A cursor is anchored to a row.
   */
  async listRecent(
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    return this.page({ deletedAt: null }, viewerId, limit, cursor);
  }

  /** The paging every post list shares: same ordering, cursor and page size. */
  private async page(
    where: { authorId?: string; deletedAt: null },
    viewerId: string,
    limit: number,
    cursor?: string,
  ): Promise<FeedPage> {
    if (cursor) {
      const anchor = await this.prisma.post.findUnique({
        where: { id: cursor },
        select: { id: true },
      });
      // A cursor naming a post that no longer exists would otherwise make
      // Prisma throw, turning a stale client into a 500.
      if (!anchor) throw new NotFoundException('That page no longer exists.');
    }

    // One extra row tells us whether another page exists without a count(*)
    // over the whole table.
    const rows = await this.prisma.post.findMany({
      where,
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      take: limit + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
      select: this.shapeFor(viewerId),
    });

    const hasMore = rows.length > limit;
    const items = (hasMore ? rows.slice(0, limit) : rows).map((row) =>
      this.toFeedPost(row),
    );

    return {
      items,
      nextCursor: hasMore ? items[items.length - 1].id : null,
    };
  }

  /**
   * The liked and saved lists.
   *
   * Ordered by when the reader liked or saved, not by when the post was
   * written: that is the order they remember putting them in. The cursor is
   * therefore a PostLike/PostSave id, not a post id.
   */
  private async pageByRelation(
    kind: 'like' | 'save',
    viewerId: string,
    limit: number,
    cursor?: string,
  ): Promise<FeedPage> {
    // Both delegates are queried inline rather than through a shared variable.
    // Their argument types are distinct, so a union of the two is not callable,
    // and Prisma infers a query's result from the literal passed to it -- a
    // hoisted `args` object loses that inference.
    if (cursor) {
      const anchor =
        kind === 'like'
          ? await this.prisma.postLike.findUnique({
              where: { id: cursor },
              select: { id: true },
            })
          : await this.prisma.postSave.findUnique({
              where: { id: cursor },
              select: { id: true },
            });
      if (!anchor) throw new NotFoundException('That page no longer exists.');
    }

    const where = { userId: viewerId, post: { deletedAt: null } };
    const orderBy = [{ createdAt: 'desc' as const }, { id: 'desc' as const }];
    const take = limit + 1;
    // Spread as `...(cursor ? {...} : {})` and the key becomes optional, which
    // the two delegates' argument types disagree about. Passing it explicitly
    // undefined keeps one shape; Prisma treats that as no cursor.
    const from = cursor ? { id: cursor } : undefined;
    const skip = cursor ? 1 : 0;
    const select = { id: true, post: { select: this.shapeFor(viewerId) } };

    const rows: { id: string; post: PostRow }[] =
      kind === 'like'
        ? await this.prisma.postLike.findMany({
            where,
            orderBy,
            take,
            cursor: from,
            skip,
            select,
          })
        : await this.prisma.postSave.findMany({
            where,
            orderBy,
            take,
            cursor: from,
            skip,
            select,
          });

    const hasMore = rows.length > limit;
    const page = hasMore ? rows.slice(0, limit) : rows;

    return {
      items: page.map((row) => this.toFeedPost(row.post)),
      nextCursor: hasMore ? page[page.length - 1].id : null,
    };
  }

  /**
   * One author's posts, newest first.
   *
   * Shares listRecent's cursor rules -- a profile is read while its owner is
   * posting just as the main feed is, so it needs the same anchored page
   * boundary rather than an offset.
   */
  async listByAuthor(
    authorId: string,
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    return this.page({ authorId, deletedAt: null }, viewerId, limit, cursor);
  }

  /** The posts the reader has liked, most recently liked first. */
  async listLiked(
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    return this.pageByRelation('like', viewerId, limit, cursor);
  }

  /** The posts the reader has saved. Private: only ever their own. */
  async listSaved(
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    return this.pageByRelation('save', viewerId, limit, cursor);
  }

  /** Idempotent: liking an already-liked post is a no-op, not a duplicate. */
  async setLiked(viewerId: string, postId: string, liked: boolean) {
    await this.requireVisiblePost(postId);
    if (liked) {
      await this.prisma.postLike.upsert({
        where: { userId_postId: { userId: viewerId, postId } },
        create: { userId: viewerId, postId },
        update: {},
      });
    } else {
      await this.prisma.postLike.deleteMany({
        where: { userId: viewerId, postId },
      });
    }
    return {
      liked,
      likes: await this.prisma.postLike.count({ where: { postId } }),
    };
  }

  async setSaved(viewerId: string, postId: string, saved: boolean) {
    await this.requireVisiblePost(postId);
    if (saved) {
      await this.prisma.postSave.upsert({
        where: { userId_postId: { userId: viewerId, postId } },
        create: { userId: viewerId, postId },
        update: {},
      });
    } else {
      await this.prisma.postSave.deleteMany({
        where: { userId: viewerId, postId },
      });
    }
    return { saved };
  }

  private async requireVisiblePost(postId: string) {
    const post = await this.prisma.post.findFirst({
      where: { id: postId, deletedAt: null },
      select: { id: true },
    });
    if (!post) throw new NotFoundException('Post not found.');
  }

  /** One post on its own, for the screen that shows it with its thread. */
  async getPost(postId: string, viewerId: string): Promise<FeedPost> {
    const post = await this.prisma.post.findFirst({
      where: { id: postId, deletedAt: null },
      select: this.shapeFor(viewerId),
    });
    if (!post) throw new NotFoundException('Post not found.');
    return this.toFeedPost(post);
  }

  /**
   * Records that someone opened a post.
   *
   * One row per person per post: an impression count that rises every time the
   * same reader refreshes tells the author nothing. The author's own opens are
   * not counted -- checking your own post is not reach.
   */
  async recordView(postId: string, viewerId: string): Promise<void> {
    const post = await this.prisma.post.findFirst({
      where: { id: postId, deletedAt: null },
      select: { authorId: true },
    });
    if (!post) throw new NotFoundException('Post not found.');
    if (post.authorId === viewerId) return;

    await this.prisma.postView.upsert({
      where: { postId_viewerId: { postId, viewerId } },
      create: { postId, viewerId },
      update: {},
    });
  }

  /**
   * A post's top-level comments, oldest first.
   *
   * Oldest first, unlike every other list here: a thread is a conversation and
   * reads in the order it happened. The cursor is therefore ascending too.
   */
  async listComments(
    postId: string,
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<CommentPage> {
    await this.requireVisiblePost(postId);
    return this.commentPage(
      { postId, parentId: null, deletedAt: null },
      viewerId,
      limit,
      cursor,
    );
  }

  /** The replies under one comment, oldest first. */
  async listReplies(
    commentId: string,
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<CommentPage> {
    const parent = await this.prisma.comment.findFirst({
      where: { id: commentId, deletedAt: null },
      select: { id: true },
    });
    if (!parent) throw new NotFoundException('Comment not found.');

    return this.commentPage(
      { parentId: commentId, deletedAt: null },
      viewerId,
      limit,
      cursor,
    );
  }

  /**
   * Adds a comment, or a reply to one.
   *
   * A reply to a reply is attached to the thread it is already in rather than
   * nesting a third level: the screen renders two, and a deeper tree would be
   * flattened on the way out anyway.
   */
  async addComment(
    postId: string,
    authorId: string,
    content: string,
    parentId?: string,
  ): Promise<FeedComment> {
    await this.requireVisiblePost(postId);

    let threadParentId: string | null = null;
    if (parentId) {
      const parent = await this.prisma.comment.findFirst({
        where: { id: parentId, postId, deletedAt: null },
        select: { id: true, parentId: true },
      });
      // Scoped to this post, so a comment id from another thread cannot be
      // grafted onto it.
      if (!parent) throw new NotFoundException('Comment not found.');
      threadParentId = parent.parentId ?? parent.id;
    }

    const comment = await this.prisma.comment.create({
      data: {
        postId,
        authorId,
        parentId: threadParentId,
        content: content.trim(),
      },
      select: this.commentShape,
    });
    return this.toFeedComment(comment, authorId);
  }

  /** Soft delete, and only by the author of the comment. */
  async deleteComment(authorId: string, commentId: string): Promise<void> {
    const { count } = await this.prisma.comment.updateMany({
      where: { id: commentId, authorId, deletedAt: null },
      data: { deletedAt: new Date() },
    });
    if (count === 0) throw new NotFoundException('Comment not found.');
  }

  /**
   * How a post is doing. Only its author may ask.
   *
   * Reporting this to anyone would hand every account a reach figure for every
   * post on the service, which is the author's to know.
   */
  async analytics(postId: string, viewerId: string): Promise<PostAnalytics> {
    const post = await this.prisma.post.findFirst({
      where: { id: postId, deletedAt: null },
      select: { id: true, authorId: true, createdAt: true },
    });
    // Not found rather than forbidden: telling a stranger the post exists but
    // is not theirs is more than they need to know.
    if (!post || post.authorId !== viewerId) {
      throw new NotFoundException('Post not found.');
    }

    const [views, likes, saves, comments, rows] = await Promise.all([
      this.prisma.postView.count({ where: { postId } }),
      this.prisma.postLike.count({ where: { postId } }),
      this.prisma.postSave.count({ where: { postId } }),
      this.prisma.comment.count({ where: { postId, deletedAt: null } }),
      this.prisma.postView.findMany({
        where: { postId },
        select: { createdAt: true },
        orderBy: { createdAt: 'asc' },
      }),
    ]);

    // Grouped here rather than in SQL: a post's view rows are bounded by the
    // number of people who have seen it, and a groupBy on a date expression is
    // not something Prisma expresses without raw SQL.
    const byDay = new Map<string, number>();
    for (const row of rows) {
      const day = row.createdAt.toISOString().slice(0, 10);
      byDay.set(day, (byDay.get(day) ?? 0) + 1);
    }

    return {
      postId: post.id,
      createdAt: post.createdAt,
      views,
      likes,
      saves,
      comments,
      timeline: [...byDay.entries()].map(([date, count]) => ({
        date,
        views: count,
      })),
    };
  }

  private async commentPage(
    where: {
      postId?: string;
      parentId: string | null;
      deletedAt: null;
    },
    viewerId: string,
    limit: number,
    cursor?: string,
  ): Promise<CommentPage> {
    if (cursor) {
      const anchor = await this.prisma.comment.findUnique({
        where: { id: cursor },
        select: { id: true },
      });
      if (!anchor) throw new NotFoundException('That page no longer exists.');
    }

    const rows = await this.prisma.comment.findMany({
      where,
      orderBy: [{ createdAt: 'asc' }, { id: 'asc' }],
      take: limit + 1,
      cursor: cursor ? { id: cursor } : undefined,
      skip: cursor ? 1 : 0,
      select: this.commentShape,
    });

    const hasMore = rows.length > limit;
    const page = hasMore ? rows.slice(0, limit) : rows;

    return {
      items: page.map((row) => this.toFeedComment(row, viewerId)),
      nextCursor: hasMore ? page[page.length - 1].id : null,
    };
  }

  private readonly commentShape = {
    id: true,
    content: true,
    createdAt: true,
    parentId: true,
    authorId: true,
    author: {
      select: {
        id: true,
        name: true,
        username: true,
        profile: { select: { avatarUrl: true } },
      },
    },
    _count: { select: { replies: true } },
  } as const;

  private toFeedComment(row: CommentRow, viewerId: string): FeedComment {
    return {
      id: row.id,
      content: row.content,
      createdAt: row.createdAt,
      parentId: row.parentId,
      author: {
        id: row.author.id,
        name: row.author.name,
        username: row.author.username,
        avatarUrl: row.author.profile?.avatarUrl ?? null,
      },
      replies: row._count.replies,
      mine: row.authorId === viewerId,
    };
  }

  /** Soft delete, and only by the author. */
  async deletePost(authorId: string, postId: string): Promise<void> {
    const { count } = await this.prisma.post.updateMany({
      where: { id: postId, authorId, deletedAt: null },
      data: { deletedAt: new Date() },
    });
    // updateMany rather than a read-then-write: one statement, and a post
    // belonging to someone else matches nothing rather than being reported as
    // forbidden, which would confirm it exists.
    if (count === 0) throw new NotFoundException('Post not found.');
  }

  /**
   * The columns every post list selects, for one particular reader.
   *
   * The liked/saved flags come back as a filtered relation holding at most one
   * row rather than as a second query per post: the alternative is an N+1, and
   * a page of twenty posts would issue forty extra statements.
   */
  private shapeFor(viewerId: string) {
    return {
      id: true,
      content: true,
      createdAt: true,
      author: {
        select: {
          id: true,
          name: true,
          username: true,
          profile: { select: { avatarUrl: true } },
        },
      },
      _count: { select: { likes: true, comments: true } },
      likes: { where: { userId: viewerId }, select: { id: true }, take: 1 },
      saves: { where: { userId: viewerId }, select: { id: true }, take: 1 },
    } as const;
  }

  private toFeedPost(row: PostRow): FeedPost {
    return {
      id: row.id,
      content: row.content,
      createdAt: row.createdAt,
      author: {
        id: row.author.id,
        name: row.author.name,
        username: row.author.username,
        avatarUrl: row.author.profile?.avatarUrl ?? null,
      },
      likes: row._count.likes,
      comments: row._count.comments,
      likedByViewer: row.likes.length > 0,
      savedByViewer: row.saves.length > 0,
    };
  }
}

/** A row shaped by {@link FeedService.commentShape}. */
interface CommentRow {
  id: string;
  content: string;
  createdAt: Date;
  parentId: string | null;
  authorId: string;
  author: {
    id: string;
    name: string | null;
    username: string | null;
    profile: { avatarUrl: string | null } | null;
  };
  _count: { replies: number };
}

/** A row shaped by {@link FeedService.shapeFor}. */
interface PostRow {
  id: string;
  content: string;
  createdAt: Date;
  author: {
    id: string;
    name: string | null;
    username: string | null;
    profile: { avatarUrl: string | null } | null;
  };
  _count: { likes: number; comments: number };
  likes: { id: string }[];
  saves: { id: string }[];
}
