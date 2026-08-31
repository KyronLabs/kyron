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
      select: this.postShape,
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
  async listRecent(limit = DEFAULT_LIMIT, cursor?: string): Promise<FeedPage> {
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
      where: { deletedAt: null },
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      take: limit + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
      select: this.postShape,
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

  private readonly postShape = {
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
  } as const;

  private toFeedPost(row: {
    id: string;
    content: string;
    createdAt: Date;
    author: {
      id: string;
      name: string | null;
      username: string | null;
      profile: { avatarUrl: string | null } | null;
    };
  }): FeedPost {
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
    };
  }
}
