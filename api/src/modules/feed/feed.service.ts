import {
  BadRequestException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { MediaKind, Prisma, ReplyPolicy } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { RealtimeService } from '../realtime/realtime.service';
import { ModerationService } from '../moderation/moderation.service';
import { RankingService } from './ranking.service';

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
  /** The poll attached to it, with the reader's own vote. Null for most. */
  poll: FeedPoll | null;
}

/**
 * A poll as a post carries it.
 *
 * Counts are always present. Hiding them until someone votes is a common
 * pattern and the wrong one here: it makes a poll a thing you have to answer
 * to read, and there is nothing to stop a client showing them anyway.
 */
export interface FeedPoll {
  id: string;
  closesAt: Date;
  /** True once closesAt has passed. Computed on the server so every reader
   * agrees, rather than each device deciding from its own clock. */
  closed: boolean;
  totalVotes: number;
  /** The option this reader picked, or null. */
  votedOptionId: string | null;
  options: { id: string; text: string; votes: number }[];
}

export interface FeedMedia {
  id: string;
  kind: MediaKind;
  url: string;
  width: number | null;
  height: number | null;
  alt: string | null;
  /**
   * A still from a video, so a list can draw the clip without opening a
   * decoder for it. Null for anything that is not a video, and for clips
   * posted before the composer started sending one.
   */
  thumbnailUrl: string | null;
  /** How long a voice recording runs, in ms. Null for anything else. */
  durationMs: number | null;
  /**
   * Loudness over time, 0-100, one value per waveform bar. Empty for anything
   * that is not a voice recording.
   */
  waveform: number[];
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
  /** How many replies hang off it. */
  replies: number;
  /**
   * The first few people who answered it, for the marker that opens a folded
   * run. Empty when nobody has, and never padded out: a face on that row is a
   * claim that a particular person is in the conversation.
   */
  replyFaces: {
    id: string;
    name: string | null;
    username: string | null;
    avatarUrl: string | null;
  }[];
  media: FeedMedia[];
  /** Whether the reader wrote it, and so may delete it. */
  mine: boolean;
  /** How many people liked it. */
  likes: number;
  /** Whether the reader is one of them. */
  liked: boolean;
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

/** One hashtag on the Explore wall. */
export interface TrendingTag {
  /** Without its leading #, which is how every tag is stored. */
  tag: string;
  /** Posts carrying it that the reader can see, all time. */
  posts: number;
  /** How many of those are inside the trending window. What ranks it. */
  recent: number;
}

const DEFAULT_LIMIT = 20;

@Injectable()
export class FeedService {
  private readonly logger = new Logger(FeedService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly moderation: ModerationService,
    private readonly ranking: RankingService,
    private readonly realtime: RealtimeService,
  ) {}

  /** How many attachments one post or comment may carry. */
  static readonly maxMedia = 4;

  /**
   * How far back trending looks.
   *
   * A week rather than a day: on a network this size a day is often nothing at
   * all, and an Explore page that is empty most mornings is worse than one
   * that moves slowly.
   */
  static readonly trendingWindowMs = 7 * 24 * 60 * 60 * 1000;

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
        thumbnailUrl?: string;
        durationMs?: number;
        waveform?: number[];
      }[];
      quotedPostId?: string;
      replyPolicy?: ReplyPolicy;
      poll?: { options: string[]; durationMinutes: number };
      /** Topic slugs the author filed it under. */
      topics?: string[];
      /**
       * The community to write into, already checked. Resolved by the caller
       * rather than here: whether the author may post into it is the
       * communities module's rule, and this module should not learn it twice.
       */
      communityId?: string;
    },
  ): Promise<FeedPost> {
    const content = input.content.trim();
    const media = input.media ?? [];
    const poll = normalisePoll(input.poll);

    if (media.length > FeedService.maxMedia) {
      throw new BadRequestException(
        `A post can carry at most ${FeedService.maxMedia} attachments.`,
      );
    }
    // A post has to say something. Media alone is a post; empty and unattached
    // is not, and the client should not be able to create one.
    if (!content && media.length === 0 && !poll) {
      throw new BadRequestException('A post needs text or an attachment.');
    }
    // A poll with no question is a set of buttons with nothing above them.
    if (poll && !content) {
      throw new BadRequestException('A poll needs a question.');
    }

    if (input.quotedPostId) {
      // Checked here so quoting a deleted post fails with a message rather
      // than a foreign key error.
      await this.requireVisiblePost(input.quotedPostId);
    }

    const topicIds = await this.topicLinks(input.topics ?? []);

    const post = await this.prisma.post.create({
      data: {
        authorId,
        content,
        communityId: input.communityId,
        replyPolicy: input.replyPolicy ?? ReplyPolicy.EVERYONE,
        quotedPostId: input.quotedPostId,
        media: {
          create: media.map((item, index) => ({
            url: item.url,
            kind: item.kind ?? MediaKind.IMAGE,
            thumbnailUrl: item.thumbnailUrl,
            durationMs: item.durationMs,
            waveform: item.waveform ?? [],
            width: item.width,
            height: item.height,
            alt: item.alt,
            position: index,
          })),
        },
        hashtags: { create: await this.hashtagLinks(content) },
        topics: { create: topicIds.map((interestId) => ({ interestId })) },
        poll: poll
          ? {
              create: {
                closesAt: new Date(
                  Date.now() + poll.durationMinutes * 60 * 1000,
                ),
                options: {
                  create: poll.options.map((text, position) => ({
                    text,
                    position,
                  })),
                },
              },
            }
          : undefined,
      },
      select: this.shapeFor(authorId),
    });

    this.logger.log(`post ${post.id} created by ${authorId}`);
    return this.toFeedPost(post);
  }

  /** How many topics one post may be filed under. */
  static readonly maxTopics = 3;

  // How many recent posts the ranker gets to choose between. Wide enough that
  // scoring has something to do, bounded so one request cannot read the table.
  static readonly candidatePool = 400;

  // How far back likes count towards author affinity, and how many are read.
  static readonly affinityDays = 30;
  static readonly affinitySample = 200;

  // How deep a comment page walks before it stops following replies.
  static readonly maxThreadDepth = 8;

  // And how many it reads at each level. A comment with ten thousand answers
  // is a denial of service, not a conversation.
  static readonly maxThreadNodes = 200;

  /**
   * Resolves topic slugs to rows to attach to a post.
   *
   * Unknown slugs are an error rather than something to drop quietly: a
   * composer that offers a topic the server does not have is a composer out of
   * step with it, and silently posting without the topic hides that.
   */
  private async topicLinks(slugs: string[]): Promise<string[]> {
    const wanted = [
      ...new Set(
        slugs.map((slug) => slug.trim().toLowerCase()).filter(Boolean),
      ),
    ];
    if (wanted.length === 0) return [];
    if (wanted.length > FeedService.maxTopics) {
      throw new BadRequestException(
        `A post can be filed under at most ${FeedService.maxTopics} topics.`,
      );
    }

    const rows = await this.prisma.interest.findMany({
      where: { slug: { in: wanted } },
      select: { id: true, slug: true },
    });
    if (rows.length !== wanted.length) {
      const known = new Set(rows.map((row) => row.slug));
      const missing = wanted.filter((slug) => !known.has(slug));
      throw new BadRequestException(`No such topic: ${missing.join(', ')}.`);
    }
    return rows.map((row) => row.id);
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
    // Community posts are left out. They were written into a named place with
    // its own members, and pushing them at everybody is what makes people stop
    // posting in them.
    const where = await this.withFilters(
      { deletedAt: null, communityId: null },
      viewerId,
    );
    return this.rankedPage(where, viewerId, limit, cursor);
  }

  /**
   * A scored page, rather than the newest N.
   *
   * `ORDER BY createdAt DESC` gives every reader the same posts in the same
   * order every session until somebody writes something new, which is what
   * made the feed feel like a list rather than a feed. This reads a bounded
   * pool of recent candidates, scores them for this reader, and pages the
   * result.
   *
   * The cursor carries the session seed and an offset instead of a post id: a
   * ranking is recomputed per request, so an id names a position that may not
   * exist on the next page. Carrying the seed is what makes page two continue
   * page one rather than reshuffle under the reader.
   */
  private async rankedPage(
    where: Prisma.PostWhereInput,
    viewerId: string,
    limit: number,
    cursor?: string,
  ): Promise<FeedPage> {
    const { seed, offset } = this.readRankCursor(cursor);
    const since = new Date(Date.now() - RankingService.windowHours * 3_600_000);

    const [rows, viewer] = await Promise.all([
      this.prisma.post.findMany({
        where: { ...where, createdAt: { gte: since } },
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        // The pool, not the page. Wide enough that ranking has something to
        // choose between, bounded so one request cannot read the table.
        take: FeedService.candidatePool,
        select: this.shapeFor(viewerId),
      }),
      this.rankingViewer(viewerId),
    ]);

    const candidates = rows.map((row) => ({
      row,
      id: row.id,
      authorId: row.authorId,
      createdAt: row.createdAt,
      likes: row._count?.likes ?? 0,
      comments: row._count?.comments ?? 0,
      reposts: row._count?.reposts ?? 0,
      seen: (row.views?.length ?? 0) > 0,
      followed: viewer.followedIds.has(row.authorId),
      topicIds: (row.topics ?? []).map((t) => t.interestId),
    }));

    const ranked = this.ranking.rank(candidates, viewer, {
      seed,
      offset,
      limit,
    });

    return {
      items: ranked.items.map((entry) => this.toFeedPost(entry.row)),
      nextCursor:
        ranked.nextOffset === null
          ? null
          : this.writeRankCursor(seed, ranked.nextOffset),
    };
  }

  /**
   * The seed and offset a ranked cursor carries.
   *
   * A fresh seed on every first page is what makes two sessions read
   * differently; an unreadable cursor is treated as a fresh start rather than
   * an error, because a stale client should get a feed, not a 400.
   */
  private readRankCursor(cursor?: string): { seed: number; offset: number } {
    if (cursor) {
      const match = /^r(\d+)-(\d+)$/.exec(cursor);
      if (match) {
        return { seed: Number(match[1]), offset: Number(match[2]) };
      }
    }
    return { seed: (Math.random() * 0xffffffff) >>> 0, offset: 0 };
  }

  private writeRankCursor(seed: number, offset: number): string {
    return `r${seed}-${offset}`;
  }

  /** What the reader brings to the ranking: who they follow and engage with. */
  private async rankingViewer(viewerId: string) {
    const [follows, likes, topics] = await Promise.all([
      this.prisma.follow.findMany({
        where: { followerId: viewerId },
        select: { followingId: true },
      }),
      // Recent likes stand in for affinity: whose posts does this reader
      // actually touch, as opposed to whom did they follow once and forget.
      this.prisma.postLike.findMany({
        where: {
          userId: viewerId,
          createdAt: {
            gte: new Date(Date.now() - FeedService.affinityDays * 86_400_000),
          },
        },
        orderBy: { createdAt: 'desc' },
        take: FeedService.affinitySample,
        select: { post: { select: { authorId: true } } },
      }),
      this.prisma.userInterest.findMany({
        where: { userId: viewerId },
        select: { interestId: true },
      }),
    ]);

    const affinity = new Map<string, number>();
    for (const like of likes) {
      const author = like.post?.authorId;
      if (author) affinity.set(author, (affinity.get(author) ?? 0) + 1);
    }

    return {
      affinity,
      followedIds: new Set(follows.map((f) => f.followingId)),
      topicIds: new Set(topics.map((t) => t.interestId)),
    };
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
              // NOT at the clause level, not `content: { not: {...} }`.
              // Prisma's NestedStringFilter carries no `mode`, so the nested
              // form is rejected at query time -- every feed request answered
              // 500 the moment one word was muted.
              //
              // Case-insensitive substring, which is what someone muting a
              // word means -- not a whole-word match they would have to guess
              // the plural of.
              ...filters.mutedPhrases.map(
                (phrase) =>
                  ({
                    NOT: {
                      content: { contains: phrase, mode: 'insensitive' },
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
    const post = await this.requireVisiblePost(postId);
    if (reposted) {
      await this.prisma.repost.upsert({
        where: { userId_postId: { userId: viewerId, postId } },
        create: { userId: viewerId, postId },
        update: {},
      });
      this.tellAuthor(post.authorId, viewerId, 'repost');
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

  /**
   * The hashtags being used right now, most used first.
   *
   * Trending is a window, not a total: a tag with four hundred posts from last
   * year is not trending, and one with nine from this morning is. So the
   * ranking is the count inside [trendingWindowMs], and the number shown is
   * the total -- because the total is what you find when you tap through.
   *
   * Filtered the way the feed is. A tag kept alive by an account the reader
   * has blocked is not trending as far as they are concerned.
   */
  async trendingTags(
    viewerId: string,
    limit = DEFAULT_LIMIT,
  ): Promise<{ items: TrendingTag[] }> {
    const visible = await this.withFilters({ deletedAt: null }, viewerId);
    const since = new Date(Date.now() - FeedService.trendingWindowMs);

    const ranked = await this.prisma.postHashtag.groupBy({
      by: ['hashtagId'],
      where: { post: { ...visible, createdAt: { gte: since } } },
      _count: { postId: true },
      orderBy: { _count: { postId: 'desc' } },
      take: limit,
    });
    if (ranked.length === 0) return { items: [] };

    const hashtagIds = ranked.map((row) => row.hashtagId);
    const [tags, totals] = await Promise.all([
      this.prisma.hashtag.findMany({
        where: { id: { in: hashtagIds } },
        select: { id: true, tag: true },
      }),
      this.prisma.postHashtag.groupBy({
        by: ['hashtagId'],
        where: { hashtagId: { in: hashtagIds }, post: visible },
        _count: { postId: true },
      }),
    ]);

    const nameOf = new Map(tags.map((row) => [row.id, row.tag]));
    const totalOf = new Map(
      totals.map((row) => [row.hashtagId, row._count.postId]),
    );

    return {
      items: ranked.flatMap((row) => {
        const tag = nameOf.get(row.hashtagId);
        // Deleted between the two queries: dropped, rather than rendered as a
        // blank row that goes nowhere.
        if (!tag) return [];
        return [
          {
            tag,
            posts: totalOf.get(row.hashtagId) ?? row._count.postId,
            recent: row._count.postId,
          },
        ];
      }),
    };
  }

  /**
   * Posts by the people who follow a topic.
   *
   * Two things, in one list: posts the author filed under this topic, and
   * posts by people who say it is what they are into. The first is the exact
   * answer and the second is why the screen is not empty -- most posts carry
   * no topic, and a topic showing only the handful that do looks dead.
   */
  async listByTopic(
    slug: string,
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    const normalised = slug.trim().toLowerCase();
    const interest = await this.prisma.interest.findUnique({
      where: { slug: normalised },
      select: { id: true },
    });
    if (!interest) throw new NotFoundException('That topic does not exist.');

    const where = await this.withFilters(
      {
        deletedAt: null,
        OR: [
          // Filed under it by whoever wrote it.
          { topics: { some: { interestId: interest.id } } },
          // Or written by somebody who says this is what they are into. Kept
          // alongside the explicit link rather than replaced by it: most posts
          // carry no topic at all, and a topic that only shows the handful
          // that do is a topic that looks dead.
          { author: { interests: { some: { interestId: interest.id } } } },
        ],
      },
      viewerId,
    );
    return this.page(where, viewerId, limit, cursor);
  }

  /**
   * What has been posted into one community, newest first.
   *
   * Takes a slug rather than an id so the client can open a community from a
   * link without looking it up first.
   */
  async listByCommunity(
    slug: string,
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    const community = await this.prisma.community.findFirst({
      where: { slug: slug.trim().toLowerCase(), deletedAt: null },
      select: { id: true },
    });
    if (!community) {
      throw new NotFoundException('That community does not exist.');
    }

    const where = await this.withFilters(
      { deletedAt: null, communityId: community.id },
      viewerId,
    );
    return this.page(where, viewerId, limit, cursor);
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
    has?: string,
  ): Promise<FeedPage> {
    // The profile's Media tab wants anything visual, so image, gif and video
    // together -- not one kind at a time, which would put a clip in Videos and
    // nowhere else.
    const kinds =
      has === 'media'
        ? [MediaKind.IMAGE, MediaKind.GIF, MediaKind.VIDEO]
        : mediaKindFilter(has)
          ? [mediaKindFilter(has)!]
          : null;

    return this.page(
      {
        authorId,
        deletedAt: null,
        ...(kinds ? { media: { some: { kind: { in: kinds } } } } : {}),
      },
      viewerId,
      limit,
      cursor,
    );
  }

  /**
   * Posts from the accounts the reader follows.
   *
   * The Following tab in the top bar was a pill that recoloured itself and
   * changed nothing -- every tab read the same everyone-newest-first feed.
   *
   * Own posts are included. A timeline of people you follow that omits you is
   * a timeline you cannot check your own post landed in.
   */
  async listFollowing(
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    const follows = await this.prisma.follow.findMany({
      where: { followerId: viewerId },
      select: { followingId: true },
    });
    const authorIds = [...follows.map((f) => f.followingId), viewerId];

    const where = await this.withFilters(
      { deletedAt: null, authorId: { in: authorIds } },
      viewerId,
    );
    return this.page(where, viewerId, limit, cursor);
  }

  /**
   * Posts carrying at least one video.
   *
   * `some` rather than loading each post and filtering in memory: a page of
   * twenty videos may sit behind any number of pages of text, and paginating
   * over a filter applied after the fact returns short pages that look like
   * the end of the feed.
   */
  async listVideos(
    viewerId: string,
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    const where = await this.withFilters(
      { deletedAt: null, media: { some: { kind: MediaKind.VIDEO } } },
      viewerId,
    );
    return this.page(where, viewerId, limit, cursor);
  }

  /**
   * Records one vote and answers with the poll as it now stands.
   *
   * The unique index on (pollId, userId) is what actually enforces one vote
   * per person: two taps racing each other both pass a "have you voted?"
   * read, and only the constraint stops the second writing a second row.
   * A repeat vote is reported rather than silently changing the answer --
   * a poll whose answers can be edited after the fact is not a poll.
   */
  async voteOnPoll(
    viewerId: string,
    postId: string,
    optionId: string,
  ): Promise<FeedPost> {
    const poll = await this.prisma.poll.findUnique({
      where: { postId },
      select: {
        id: true,
        closesAt: true,
        options: { select: { id: true } },
        post: { select: { deletedAt: true } },
      },
    });

    if (!poll || poll.post.deletedAt !== null) {
      throw new NotFoundException('That poll no longer exists.');
    }
    if (poll.closesAt.getTime() <= Date.now()) {
      throw new BadRequestException('This poll has closed.');
    }
    // Checked against this poll's own options, so an option id from another
    // poll cannot be voted into this one.
    if (!poll.options.some((option) => option.id === optionId)) {
      throw new BadRequestException('That is not one of the answers.');
    }

    try {
      await this.prisma.pollVote.create({
        data: { pollId: poll.id, optionId, userId: viewerId },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new BadRequestException('You have already voted in this poll.');
      }
      throw error;
    }

    return this.getPost(postId, viewerId);
  }

  /**
   * Takes a vote back, and answers with the poll as it now stands.
   *
   * A poll with no way out is a poll that punishes a mistap: the row was
   * written the instant the option was touched, and there was nothing to undo
   * it with. Retracting is not editing -- the vote is removed rather than
   * moved -- so the counts stay honest and voting again is a fresh vote.
   *
   * Still refused once voting has closed. A closed poll is a result, and a
   * result that can be changed afterwards is not one.
   */
  async retractVote(viewerId: string, postId: string): Promise<FeedPost> {
    const poll = await this.prisma.poll.findUnique({
      where: { postId },
      select: {
        id: true,
        closesAt: true,
        post: { select: { deletedAt: true } },
      },
    });

    if (!poll || poll.post.deletedAt !== null) {
      throw new NotFoundException('That poll no longer exists.');
    }
    if (poll.closesAt.getTime() <= Date.now()) {
      throw new BadRequestException('This poll has closed.');
    }

    // deleteMany rather than delete: removing a vote that is not there is the
    // state the caller asked for, not an error to report.
    await this.prisma.pollVote.deleteMany({
      where: { pollId: poll.id, userId: viewerId },
    });

    return this.getPost(postId, viewerId);
  }

  /**
   * Post search, with the filters the search screen offers.
   *
   * `from` is a handle rather than an id because that is what someone types.
   * An unknown handle returns an empty page rather than a 404: the filter is
   * part of a query, and a query that matches nothing is a normal answer.
   */
  async searchPosts(
    viewerId: string,
    options: {
      q?: string;
      from?: string;
      after?: string;
      before?: string;
      has?: string;
    },
    limit = DEFAULT_LIMIT,
    cursor?: string,
  ): Promise<FeedPage> {
    const text = options.q?.trim();
    const handle = options.from?.trim();

    if (!text && !handle) {
      throw new BadRequestException(
        'Search for some words, or pick an account to search within.',
      );
    }

    let authorId: string | undefined;
    if (handle) {
      const author = await this.prisma.user.findFirst({
        where: { username: { equals: handle, mode: 'insensitive' } },
        select: { id: true },
      });
      if (!author) return { items: [], nextCursor: null };
      authorId = author.id;
    }

    const createdAt = dateRange(options.after, options.before);
    const kind = mediaKindFilter(options.has);

    // Both the words and a "has: link" filter match on content, so they go in
    // an AND rather than as two `content` keys in one object -- the second
    // would have replaced the first and quietly dropped the search terms.
    const content: Prisma.PostWhereInput[] = [];
    if (text) {
      content.push({ content: { contains: text, mode: 'insensitive' } });
    }
    if (options.has === 'link') {
      content.push({ content: { contains: 'http', mode: 'insensitive' } });
    }

    const where = await this.withFilters(
      {
        deletedAt: null,
        ...(authorId ? { authorId } : {}),
        ...(createdAt ? { createdAt } : {}),
        ...(kind ? { media: { some: { kind } } } : {}),
        ...(content.length ? { AND: content } : {}),
      },
      viewerId,
    );

    return this.page(where, viewerId, limit, cursor);
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
    const post = await this.requireVisiblePost(postId);
    if (liked) {
      await this.prisma.postLike.upsert({
        where: { userId_postId: { userId: viewerId, postId } },
        create: { userId: viewerId, postId },
        update: {},
      });
      this.tellAuthor(post.authorId, viewerId, 'like');
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
  private async requireReplyAllowed(
    postId: string,
    authorId: string,
  ): Promise<{ authorId: string }> {
    const post = await this.prisma.post.findFirst({
      where: { id: postId, deletedAt: null },
      select: { authorId: true, replyPolicy: true, content: true },
    });
    if (!post) throw new NotFoundException('Post not found.');

    // Your own post is always open to you, whatever you set.
    if (post.authorId === authorId) return post;

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
        return post;
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
        return post;
      }

      case ReplyPolicy.EVERYONE:
        return post;
    }
  }

  private async requireVisiblePost(postId: string): Promise<{
    id: string;
    authorId: string;
  }> {
    const post = await this.prisma.post.findFirst({
      where: { id: postId, deletedAt: null },
      select: { id: true, authorId: true },
    });
    if (!post) throw new NotFoundException('Post not found.');
    return post;
  }

  /**
   * Tells a post's author that somebody did something to it.
   *
   * Never to themselves: liking your own post is not news. Only on the way in
   * -- unliking is not an event anyone wants to hear about.
   */
  private tellAuthor(authorId: string, actorId: string, kind: string): void {
    if (authorId === actorId) return;
    this.realtime.emitTo(authorId, {
      type: 'notification.new',
      kind,
      actorId,
    });
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
   * The reply keeps the parent it was written under. It used to be re-hung on
   * that parent's own parent -- two levels and no more -- which meant tapping
   * reply under someone's answer filed the reply beside them, under the top
   * comment, addressed to the wrong person. The reader is told which comment
   * they are answering, so that is the comment it has to land under.
   *
   * Depth is bounded by [maxThreadDepth], the same limit the thread reader
   * walks to: past it there is nothing left to draw the reply under, so it
   * attaches to the deepest ancestor still inside the limit.
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
      thumbnailUrl?: string;
      durationMs?: number;
      waveform?: number[];
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

    const post = await this.requireReplyAllowed(postId, authorId);

    let threadParentId: string | null = null;
    if (parentId) {
      const parent = await this.prisma.comment.findFirst({
        where: { id: parentId, postId, deletedAt: null },
        select: { id: true, parentId: true },
      });
      // Scoped to this post, so a comment id from another thread cannot be
      // grafted onto it.
      if (!parent) throw new NotFoundException('Comment not found.');
      threadParentId = await this.deepestAllowedParent(parent.id, postId);
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
            thumbnailUrl: item.thumbnailUrl,
            durationMs: item.durationMs,
            waveform: item.waveform ?? [],
            width: item.width,
            height: item.height,
            alt: item.alt,
            position: index,
          })),
        },
      },
      select: this.commentShapeFor(authorId),
    });
    // The post's author hears about a comment; so does the person being
    // answered, when the reply is under somebody else's comment.
    this.tellAuthor(post.authorId, authorId, 'comment');
    if (threadParentId) {
      const parent = await this.prisma.comment.findUnique({
        where: { id: threadParentId },
        select: { authorId: true },
      });
      if (parent && parent.authorId !== post.authorId) {
        this.tellAuthor(parent.authorId, authorId, 'comment');
      }
    }

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
      select: this.commentShapeFor(viewerId),
    });

    const hasMore = rows.length > limit;
    const page = hasMore ? rows.slice(0, limit) : rows;
    const faces = await this.replyFacesFor(page.map((row) => row.id));

    return {
      items: page.map((row) =>
        this.toFeedComment(row, viewerId, faces.get(row.id)),
      ),
      nextCursor: hasMore ? page[page.length - 1].id : null,
    };
  }

  /** How many faces the "show replies" marker carries. */
  static readonly maxReplyFaces = 3;

  /**
   * The first few repliers under each of [parentIds].
   *
   * One query per parent, but issued as a single batch: `take` in a combined
   * query is a budget over the whole result, so one comment with a hundred
   * replies would swallow it and leave the rest of the page bare. Small,
   * index-backed reads, at most a page's worth.
   */
  private async replyFacesFor(
    parentIds: string[],
  ): Promise<Map<string, FeedComment['replyFaces']>> {
    const out = new Map<string, FeedComment['replyFaces']>();
    if (parentIds.length === 0) return out;

    const runs = await this.prisma.$transaction(
      parentIds.map((parentId) =>
        this.prisma.comment.findMany({
          where: { parentId, deletedAt: null },
          orderBy: [{ createdAt: 'asc' }, { id: 'asc' }],
          take: FeedService.maxReplyFaces,
          select: { author: { select: this.authorShape } },
        }),
      ),
    );

    parentIds.forEach((parentId, index) => {
      out.set(
        parentId,
        (runs[index] ?? []).map((row) => ({
          id: row.author.id,
          name: row.author.name,
          username: row.author.username,
          avatarUrl: row.author.profile?.avatarUrl ?? null,
        })),
      );
    });
    return out;
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
      _count: { select: { replies: true, likes: true } },
      media: { select: this.mediaShape, orderBy: { position: 'asc' } },
    } as const;
  }

  /**
   * The comment select, plus whether this reader has liked each row.
   *
   * A nested `where` on the reader rather than a second query: one row comes
   * back per comment the reader liked, none otherwise, so `likes.length` is
   * the boolean. Counting them all and checking membership in code would pull
   * every like on a popular comment across the wire to answer a yes or no.
   */
  private commentShapeFor(viewerId: string) {
    return {
      ...this.commentShape,
      likes: { where: { userId: viewerId }, select: { id: true }, take: 1 },
    } as const;
  }

  private toFeedComment(
    row: CommentRow,
    viewerId: string,
    replyFaces: FeedComment['replyFaces'] = [],
  ): FeedComment {
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
      replyFaces,
      media: row.media,
      mine: row.authorId === viewerId,
      likes: row._count.likes ?? 0,
      liked: (row.likes?.length ?? 0) > 0,
    };
  }

  /**
   * One comment and everything hanging off it, for the page that opens when a
   * reply is tapped.
   *
   * Read as a whole rather than a level at a time: the screen draws connector
   * lines from a parent to its children, and it cannot know where a line ends
   * until it holds the branch. [maxThreadDepth] is what stops a pathological
   * chain from turning one tap into an unbounded walk.
   */
  async commentThread(viewerId: string, commentId: string) {
    const root = await this.prisma.comment.findFirst({
      where: { id: commentId, deletedAt: null },
      select: { ...this.commentShapeFor(viewerId), postId: true },
    });
    if (!root) throw new NotFoundException('That comment does not exist.');

    const all: FeedComment[] = [];
    let frontier = [root.id];
    for (let depth = 0; depth < FeedService.maxThreadDepth; depth++) {
      if (frontier.length === 0) break;
      const rows = await this.prisma.comment.findMany({
        where: { parentId: { in: frontier }, deletedAt: null },
        orderBy: [{ createdAt: 'asc' }, { id: 'asc' }],
        take: FeedService.maxThreadNodes,
        select: this.commentShapeFor(viewerId),
      });
      all.push(...rows.map((row) => this.toFeedComment(row, viewerId)));
      frontier = rows.map((row) => row.id);
    }

    return {
      postId: root.postId,
      root: this.toFeedComment(root, viewerId),
      replies: all,
    };
  }

  /**
   * Where a reply to [parentId] may hang without pushing the thread past
   * [maxThreadDepth].
   *
   * Normally that is [parentId] itself. Only a chain already at the limit
   * walks back up, and then to the deepest ancestor a new child still fits
   * under -- which keeps the reply as close to its intended parent as the
   * limit allows rather than throwing it back to the top of the thread.
   */
  private async deepestAllowedParent(
    parentId: string,
    postId: string,
  ): Promise<string> {
    // Walk to the root, collecting the chain. Bounded by maxThreadDepth + 1
    // steps: anything longer cannot exist, since this method is what puts
    // comments there.
    const chain: string[] = [parentId];
    let cursor: string = parentId;
    const seen = new Set<string>([parentId]);

    for (let step = 0; step < FeedService.maxThreadDepth + 1; step++) {
      const row: { parentId: string | null } | null =
        await this.prisma.comment.findFirst({
          where: { id: cursor, postId, deletedAt: null },
          select: { parentId: true },
        });
      const next: string | null = row?.parentId ?? null;
      // A cycle in stored data would otherwise loop until the step budget
      // runs out and then return the wrong answer quietly.
      if (next === null || seen.has(next)) break;
      chain.push(next);
      seen.add(next);
      cursor = next;
    }

    // chain is [parent, grandparent, ... root]; its length is the parent's
    // depth + 1, which is the depth the new reply would sit at.
    if (chain.length < FeedService.maxThreadDepth) return parentId;
    return chain[chain.length - FeedService.maxThreadDepth];
  }

  /** Likes a comment, or unlikes one already liked. Idempotent either way. */
  async setCommentLike(viewerId: string, commentId: string, liked: boolean) {
    const comment = await this.prisma.comment.findFirst({
      where: { id: commentId, deletedAt: null },
      select: { id: true },
    });
    if (!comment) throw new NotFoundException('That comment does not exist.');

    if (liked) {
      // Nothing on a repeat: the unique index is what makes a double tap one
      // like, and catching its violation here would be the same result with
      // an exception in the middle.
      await this.prisma.commentLike.createMany({
        data: [{ userId: viewerId, commentId }],
        skipDuplicates: true,
      });
    } else {
      await this.prisma.commentLike.deleteMany({
        where: { userId: viewerId, commentId },
      });
    }

    const likes = await this.prisma.commentLike.count({ where: { commentId } });
    return { id: commentId, likes, liked };
  }

  /**
   * Changes who may reply, after the post has gone out.
   *
   * updateMany scoped to the author, for the same reason deletePost is: a post
   * belonging to someone else matches nothing rather than being reported as
   * forbidden, which would confirm it exists.
   */
  async setReplyPolicy(
    authorId: string,
    postId: string,
    replyPolicy: ReplyPolicy,
  ) {
    const { count } = await this.prisma.post.updateMany({
      where: { id: postId, authorId, deletedAt: null },
      data: { replyPolicy },
    });
    if (count === 0) throw new NotFoundException('Post not found.');
    return { replyPolicy };
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
      // Ranking needs these three and the shape is read everywhere, so they
      // are here rather than in a second query per page.
      authorId: true,
      views: { where: { viewerId }, select: { id: true }, take: 1 },
      topics: { select: { interestId: true } },
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
      poll: {
        select: {
          id: true,
          closesAt: true,
          _count: { select: { votes: true } },
          options: {
            orderBy: { position: 'asc' },
            select: {
              id: true,
              text: true,
              _count: { select: { votes: true } },
            },
          },
          // Just this reader's vote, so the answer they picked can be marked
          // without loading every vote on the poll.
          votes: {
            where: { userId: viewerId },
            select: { optionId: true },
            take: 1,
          },
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
    thumbnailUrl: true,
    durationMs: true,
    waveform: true,
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
      poll: toFeedPoll(row.poll),
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
  _count: { replies: number; likes?: number };
  media: FeedMedia[];
  /** Present only when the row was read through commentShapeFor. */
  likes?: { id: string }[];
}

interface AuthorRow {
  id: string;
  name: string | null;
  username: string | null;
  profile: { avatarUrl: string | null } | null;
}

/** A row shaped by {@link FeedService.shapeFor}. */
interface PollRow {
  id: string;
  closesAt: Date;
  _count: { votes: number };
  options: { id: string; text: string; _count: { votes: number } }[];
  votes: { optionId: string }[];
}

interface PostRow {
  id: string;
  content: string;
  createdAt: Date;
  replyPolicy: ReplyPolicy;
  poll: PollRow | null;
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

/**
 * Turns the two date filters into one Prisma range, or undefined.
 *
 * `before` is exclusive and `after` inclusive, which is what the words mean:
 * "after 1 March" should include something posted at midnight on the 1st.
 * A date that will not parse is dropped rather than throwing -- the DTO has
 * already rejected anything that is not ISO 8601, so what reaches here is
 * well-formed but may still be nonsense like month 13.
 */
function dateRange(
  after?: string,
  before?: string,
): Prisma.DateTimeFilter | undefined {
  const from = parseDate(after);
  const to = parseDate(before);
  if (!from && !to) return undefined;

  return {
    ...(from ? { gte: from } : {}),
    ...(to ? { lt: to } : {}),
  };
}

function parseDate(value?: string): Date | undefined {
  if (!value) return undefined;
  const date = new Date(value);
  return Number.isNaN(date.getTime()) ? undefined : date;
}

/** Maps the `has` filter onto a media kind, ignoring anything unrecognised. */
function mediaKindFilter(has?: string): MediaKind | undefined {
  switch (has) {
    case 'image':
      return MediaKind.IMAGE;
    case 'video':
      return MediaKind.VIDEO;
    case 'gif':
      return MediaKind.GIF;
    default:
      return undefined;
  }
}

/**
 * Shapes a poll row for the client.
 *
 * `closed` is decided here, against the server's clock. Leaving it to the
 * device means two readers disagree about whether a poll is still open, and
 * one of them gets a vote rejected by a server that has already closed it.
 */
function toFeedPoll(row: PollRow | null): FeedPoll | null {
  if (!row) return null;
  return {
    id: row.id,
    closesAt: row.closesAt,
    closed: row.closesAt.getTime() <= Date.now(),
    totalVotes: row._count.votes,
    votedOptionId: row.votes[0]?.optionId ?? null,
    options: row.options.map((option) => ({
      id: option.id,
      text: option.text,
      votes: option._count.votes,
    })),
  };
}

/**
 * Validates a poll from the composer, or returns undefined when there is none.
 *
 * Bounds are here rather than only in the DTO because this is also the last
 * point before the rows are written: a poll with one answer, or with two
 * identical ones, is not a poll, and neither shape is worth storing.
 */
function normalisePoll(
  input: { options: string[]; durationMinutes: number } | undefined,
): { options: string[]; durationMinutes: number } | undefined {
  if (!input) return undefined;

  const options = input.options
    .map((option) => option.trim())
    .filter((option) => option.length > 0);

  if (options.length < 2) {
    throw new BadRequestException('A poll needs at least two answers.');
  }
  if (options.length > 4) {
    throw new BadRequestException('A poll can have at most four answers.');
  }
  if (options.some((option) => option.length > 80)) {
    throw new BadRequestException('An answer can be at most 80 characters.');
  }

  const seen = new Set(options.map((option) => option.toLowerCase()));
  if (seen.size !== options.length) {
    throw new BadRequestException('Every answer has to be different.');
  }

  // Five minutes to a week, matching what the composer offers.
  const minutes = Math.round(input.durationMinutes);
  if (!Number.isFinite(minutes) || minutes < 5 || minutes > 7 * 24 * 60) {
    throw new BadRequestException(
      'A poll runs for between five minutes and seven days.',
    );
  }

  return { options, durationMinutes: minutes };
}
