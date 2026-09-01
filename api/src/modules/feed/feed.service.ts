import {
  BadRequestException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { MediaKind, Prisma, ReplyPolicy } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { ModerationService } from '../moderation/moderation.service';

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
  /** Plain reposts. Quotes are posts of their own and counted as such. */
  reposts: number;
  /** Whether the reader has. Saves are private, so there is no count. */
  likedByViewer: boolean;
  savedByViewer: boolean;
  repostedByViewer: boolean;
  /** Who may reply to it. */
  replyPolicy: ReplyPolicy;
  media: FeedMedia[];
  /** The post this one quotes, one level deep. Null for most posts. */
  quotedPost: QuotedPost | null;
}

export interface FeedMedia {
  id: string;
  kind: MediaKind;
  url: string;
  width: number | null;
  height: number | null;
  alt: string | null;
}

/** A quoted post, without its own quote -- one level, so a chain cannot
 * recurse into an unbounded response. */
export interface QuotedPost {
  id: string;
  content: string;
  createdAt: Date;
  author: FeedPost['author'];
  media: FeedMedia[];
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
  media: FeedMedia[];
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

  constructor(
    private readonly prisma: PrismaService,
    private readonly moderation: ModerationService,
  ) {}

  /** How many attachments one post or comment may carry. */
  static readonly maxMedia = 4;

  async createPost(
    authorId: string,
    input: {
      content: string;
      media?: {
        url: string;
        kind?: MediaKind;
        width?: number;
        height?: number;
        alt?: string;
      }[];
      quotedPostId?: string;
      replyPolicy?: ReplyPolicy;
    },
  ): Promise<FeedPost> {
    const content = input.content.trim();
    const media = input.media ?? [];

    if (media.length > FeedService.maxMedia) {
      throw new BadRequestException(
        `A post can carry at most ${FeedService.maxMedia} attachments.`,
      );
    }
    // A post has to say something. Media alone is a post; empty and unattached
    // is not, and the client should not be able to create one.
    if (!content && media.length === 0) {
      throw new BadRequestException('A post needs text or an attachment.');
    }

    if (input.quotedPostId) {
      // Checked here so quoting a deleted post fails with a message rather
      // than a foreign key error.
      await this.requireVisiblePost(input.quotedPostId);
    }

    const post = await this.prisma.post.create({
      data: {
        authorId,
        content,
        replyPolicy: input.replyPolicy ?? ReplyPolicy.EVERYONE,
        quotedPostId: input.quotedPostId,
        media: {
          create: media.map((item, index) => ({
            url: item.url,
            kind: item.kind ?? MediaKind.IMAGE,
            width: item.width,
            height: item.height,
            alt: item.alt,
            position: index,
          })),
        },
        hashtags: { create: await this.hashtagLinks(content) },
      },
      select: this.shapeFor(authorId),
    });

    this.logger.log(`post ${post.id} created by ${authorId}`);
    return this.toFeedPost(post);
  }

  /**
   * Every #tag in the text, as rows to attach to a post.
   *
   * Extracted server-side rather than trusted from the client: the tags a post
   * is indexed under have to be the tags it actually contains, or a post can
   * be filed under anything its author names in a field nobody sees.
   */
  private async hashtagLinks(content: string) {
    const tags = FeedService.hashtagsIn(content);
    if (tags.length === 0) return [];

    // Upserted one at a time rather than createMany + findMany: the set is
    // small, and this returns the ids without a second round trip.
    const rows = await Promise.all(
      tags.map((tag) =>
        this.prisma.hashtag.upsert({
          where: { tag },
          create: { tag },
          update: {},
          select: { id: true },
        }),
      ),
    );
    return rows.map((row) => ({ hashtagId: row.id }));
  }

  /**
   * The hashtags in a piece of text, lower-cased and de-duplicated.
   *
   * Deliberately narrow: letters, digits and underscore, and never a tag that
   * is only digits -- "#1" in "ranked #1" is not a topic.
   */
  static hashtagsIn(content: string): string[] {
    const found = new Set<string>();
    // A tag must start at a boundary, so "a#b" and a colour like "#ffffff"
    // written mid-word are not swept up.
    const pattern = /(?<![\w#])#([\p{L}\p{N}_]{1,50})/gu;
    for (const match of content.matchAll(pattern)) {
      const tag = match[1].toLowerCase();
      if (/^\d+$/.test(tag)) continue;
      found.add(tag);
    }
    return [...found];
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
    // Filtered in the query, not in the client. Hiding a blocked account's
    // posts after they have been sent is not blocking: the content still
    // arrived, and anything reading the response can see it.
    const where = await this.withFilters({ deletedAt: null }, viewerId);
    return this.page(where, viewerId, limit, cursor);
  }

  /** One account's posts, filtered by whom the reader has blocked. */
  private async withFilters(
    where: Prisma.PostWhereInput,
    viewerId: string,
  ): Promise<Prisma.PostWhereInput> {
    const filters = await this.moderation.filtersFor(viewerId);
    const excluded = [...filters.blockedUserIds, ...filters.mutedUserIds];
    const hiddenIds = [...filters.hiddenPostIds, ...filters.mutedPostIds];

    return {
      ...where,
      ...(excluded.length ? { authorId: { notIn: excluded } } : {}),
      ...(hiddenIds.length || filters.mutedPhrases.length
        ? {
            AND: [
              // A muted thread hides the post and everything quoting it.
              ...(hiddenIds.length
                ? [
                    {
                      id: { notIn: hiddenIds },
                      quotedPostId: { notIn: hiddenIds },
                    } as Prisma.PostWhereInput,
                  ]
                : []),
              // Case-insensitive substring, which is what someone muting a
              // word means -- not a whole-word match they would have to guess
              // the plural of.
              ...filters.mutedPhrases.map(
                (phrase) =>
                  ({
                    content: {
                      not: { contains: phrase, mode: 'insensitive' },
                    },
                  }) as Prisma.PostWhereInput,
              ),
            ],
          }
        : {}),
    };
  }

  /** Plain reposts. A quote is a post and appears in the feed as one. */
  async setReposted(viewerId: string, postId: string, reposted: boolean) {
    await this.requireVisiblePost(postId);
    if (reposted) {
      await this.prisma.repost.upsert({
        where: { userId_postId: { userId: viewerId, postId } },
        create: { userId: viewerId, postId },
        update: {},
      });
    } else {
      await this.prisma.repost.deleteMany({
        where: { userId: viewerId, postId },
      });
    }
    return {
      reposted,
      reposts: await this.prisma.repost.count({ where: { postId } }),
    };
  }

  /** Posts carrying a given hashtag, newest first. */
  async listByHashtag(
    tag: string,
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    const normalised = tag.replace(/^#/, '').toLowerCase();
    const where = await this.withFilters(
      {
        deletedAt: null,
        hashtags: { some: { hashtag: { tag: normalised } } },
      },
      viewerId,
    );
    return this.page(where, viewerId, limit, cursor);
  }

  /** The paging every post list shares: same ordering, cursor and page size. */
  private async page(
    where: Prisma.PostWhereInput,
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

  /**
   * Whether this account may reply to that post.
   *
   * The composer offers a reply setting; a setting the server does not enforce
   * is decoration. NotFound rather than Forbidden for a blocked reader, so a
   * block does not confirm the post exists to someone shut out of it.
   */
  private async requireReplyAllowed(postId: string, authorId: string) {
    const post = await this.prisma.post.findFirst({
      where: { id: postId, deletedAt: null },
      select: { authorId: true, replyPolicy: true, content: true },
    });
    if (!post) throw new NotFoundException('Post not found.');

    // Your own post is always open to you, whatever you set.
    if (post.authorId === authorId) return;

    const blocked = await this.prisma.block.findFirst({
      where: {
        OR: [
          { blockerId: post.authorId, blockedId: authorId },
          { blockerId: authorId, blockedId: post.authorId },
        ],
      },
      select: { id: true },
    });
    if (blocked) throw new NotFoundException('Post not found.');

    switch (post.replyPolicy) {
      case ReplyPolicy.NOBODY:
        throw new BadRequestException('Replies are turned off for this post.');

      case ReplyPolicy.FOLLOWERS: {
        const follows = await this.prisma.follow.findFirst({
          where: { followerId: authorId, followingId: post.authorId },
          select: { id: true },
        });
        if (!follows) {
          throw new BadRequestException(
            'Only people who follow the author can reply to this post.',
          );
        }
        return;
      }

      case ReplyPolicy.MENTIONED: {
        const me = await this.prisma.user.findUnique({
          where: { id: authorId },
          select: { username: true },
        });
        const handle = me?.username?.toLowerCase();
        const mentioned =
          handle != null &&
          new RegExp(`(?<![\\w@])@${handle}\\b`, 'i').test(post.content);
        if (!mentioned) {
          throw new BadRequestException(
            'Only people mentioned in this post can reply to it.',
          );
        }
        return;
      }

      case ReplyPolicy.EVERYONE:
        return;
    }
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
    media: {
      url: string;
      kind?: MediaKind;
      width?: number;
      height?: number;
      alt?: string;
    }[] = [],
  ): Promise<FeedComment> {
    if (media.length > FeedService.maxMedia) {
      throw new BadRequestException(
        `A comment can carry at most ${FeedService.maxMedia} attachments.`,
      );
    }
    if (!content.trim() && media.length === 0) {
      throw new BadRequestException('A comment needs text or an attachment.');
    }

    await this.requireReplyAllowed(postId, authorId);

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
        media: {
          create: media.map((item, index) => ({
            url: item.url,
            kind: item.kind ?? MediaKind.IMAGE,
            width: item.width,
            height: item.height,
            alt: item.alt,
            position: index,
          })),
        },
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

  // A getter, not a field: class fields initialise in declaration order and
  // this one is declared above mediaShape, so reading it eagerly would see
  // undefined.
  private get commentShape() {
    return {
      id: true,
      content: true,
      createdAt: true,
      parentId: true,
      authorId: true,
      author: { select: this.authorShape },
      _count: { select: { replies: true } },
      media: { select: this.mediaShape, orderBy: { position: 'asc' } },
    } as const;
  }

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
      media: row.media,
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
      replyPolicy: true,
      author: { select: this.authorShape },
      _count: { select: { likes: true, comments: true, reposts: true } },
      likes: { where: { userId: viewerId }, select: { id: true }, take: 1 },
      saves: { where: { userId: viewerId }, select: { id: true }, take: 1 },
      reposts: { where: { userId: viewerId }, select: { id: true }, take: 1 },
      media: { select: this.mediaShape, orderBy: { position: 'asc' } },
      // One level. A quote of a quote of a quote would otherwise walk the
      // chain into an unbounded response.
      quotedPost: {
        select: {
          id: true,
          content: true,
          createdAt: true,
          deletedAt: true,
          author: { select: this.authorShape },
          media: { select: this.mediaShape, orderBy: { position: 'asc' } },
        },
      },
    } as const;
  }

  private readonly authorShape = {
    id: true,
    name: true,
    username: true,
    profile: { select: { avatarUrl: true } },
  } as const;

  private readonly mediaShape = {
    id: true,
    kind: true,
    url: true,
    width: true,
    height: true,
    alt: true,
  } as const;

  private toFeedPost(row: PostRow): FeedPost {
    const quoted = row.quotedPost;
    return {
      id: row.id,
      content: row.content,
      createdAt: row.createdAt,
      author: this.toAuthor(row.author),
      likes: row._count.likes,
      comments: row._count.comments,
      reposts: row._count.reposts,
      likedByViewer: row.likes.length > 0,
      savedByViewer: row.saves.length > 0,
      repostedByViewer: row.reposts.length > 0,
      replyPolicy: row.replyPolicy,
      media: row.media,
      // A deleted quote target is dropped rather than rendered: the row is
      // kept by SetNull so the quoting post survives, but its content is gone.
      quotedPost:
        quoted && quoted.deletedAt === null
          ? {
              id: quoted.id,
              content: quoted.content,
              createdAt: quoted.createdAt,
              author: this.toAuthor(quoted.author),
              media: quoted.media,
            }
          : null,
    };
  }

  private toAuthor(author: AuthorRow): FeedPost['author'] {
    return {
      id: author.id,
      name: author.name,
      username: author.username,
      avatarUrl: author.profile?.avatarUrl ?? null,
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
  media: FeedMedia[];
}

interface AuthorRow {
  id: string;
  name: string | null;
  username: string | null;
  profile: { avatarUrl: string | null } | null;
}

/** A row shaped by {@link FeedService.shapeFor}. */
interface PostRow {
  id: string;
  content: string;
  createdAt: Date;
  replyPolicy: ReplyPolicy;
  author: AuthorRow;
  _count: { likes: number; comments: number; reposts: number };
  likes: { id: string }[];
  saves: { id: string }[];
  reposts: { id: string }[];
  media: FeedMedia[];
  quotedPost:
    | (Omit<QuotedPost, 'author'> & {
        author: AuthorRow;
        deletedAt: Date | null;
      })
    | null;
}
