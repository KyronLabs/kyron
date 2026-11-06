import { Injectable, NotFoundException } from '@nestjs/common';
import { AccountStatus, MediaKind, Prisma } from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/**
 * What anybody on the internet may read about Kyron, without signing in.
 *
 * This is the read side of kyron-links: the pages a shared link opens for
 * somebody who does not have the app, and the cards WhatsApp, X and iMessage
 * draw from them. It is deliberately smaller than what the app reads. Every
 * field here is one a stranger with the link may see, and it is a list of
 * what to include, never of what to leave out, so a column added to a table
 * later is not published by accident.
 *
 * Nothing here knows who is asking. There is no viewer, so there are no
 * blocks, likes, votes or follows to answer about, and nothing in the result
 * depends on an account.
 */
@Injectable()
export class PublicService {
  constructor(private readonly prisma: PrismaService) {}

  /** The accounts whose posts, profile and name a stranger may see. */
  static readonly visibleAuthor = {
    status: { notIn: [AccountStatus.BANNED, AccountStatus.DELETED] },
    deletedAt: null,
  } satisfies Prisma.UserWhereInput;

  /** At most this many attachments per post: a card shows one, a page four. */
  static readonly maxMedia = 4;

  /** The most attachments a post can carry: CreatePostDto's limit. */
  static readonly maxAttachments = 10;

  /** How many recent posts a profile or community page lists. */
  static readonly recentPosts = 10;

  /**
   * Only what is already in the public bucket. A file with a private path is
   * served through a signed address to somebody entitled to it; publishing
   * it here would hand it to anyone with the link.
   */
  static readonly publicMedia = {
    privatePath: null,
    commentId: null,
  } satisfies Prisma.MediaWhereInput;

  private static readonly authorShape = {
    name: true,
    username: true,
    verifiedAt: true,
    profile: { select: { avatarUrl: true } },
  } as const;

  private static readonly mediaShape = {
    kind: true,
    url: true,
    thumbnailUrl: true,
    width: true,
    height: true,
    alt: true,
  } as const;

  /** A post as a list shows it: enough for a card, not the whole thing. */
  private static readonly summaryShape = {
    id: true,
    content: true,
    createdAt: true,
    likeCount: true,
    commentCount: true,
    repostCount: true,
    author: { select: PublicService.authorShape },
    community: { select: { name: true, slug: true, deletedAt: true } },
    media: {
      where: PublicService.publicMedia,
      orderBy: { position: 'asc' },
      // All of them -- a post carries at most ten (CreatePostDto) -- so the
      // page can say "and four more" and notice a voice note after them.
      // Taking only what is shown missed one behind eight pictures.
      take: PublicService.maxAttachments,
      select: PublicService.mediaShape,
    },
  } satisfies Prisma.PostSelect;

  /** A post on its own page: its poll, and the post it quotes. */
  private static readonly postShape = {
    ...PublicService.summaryShape,
    poll: {
      select: {
        closesAt: true,
        options: {
          orderBy: { position: 'asc' },
          select: { text: true, _count: { select: { votes: true } } },
        },
      },
    },
    quotedPost: {
      select: {
        id: true,
        content: true,
        createdAt: true,
        deletedAt: true,
        // Read to decide whether to show it, never returned.
        author: {
          select: {
            ...PublicService.authorShape,
            status: true,
            deletedAt: true,
          },
        },
        media: {
          where: {
            ...PublicService.publicMedia,
            kind: { not: MediaKind.VOICE },
          },
          orderBy: { position: 'asc' },
          take: 1,
          select: PublicService.mediaShape,
        },
      },
    },
  } satisfies Prisma.PostSelect;

  /** Live posts by visible accounts. */
  private static readonly livePost = {
    deletedAt: null,
    author: PublicService.visibleAuthor,
  } satisfies Prisma.PostWhereInput;

  async post(id: string): Promise<PublicPost> {
    const post = await this.prisma.post.findFirst({
      where: { id, ...PublicService.livePost },
      select: PublicService.postShape,
    });
    if (!post) throw new NotFoundException('Post not found.');

    const quoted = post.quotedPost;
    const showQuoted =
      quoted &&
      !quoted.deletedAt &&
      !quoted.author.deletedAt &&
      quoted.author.status !== AccountStatus.BANNED &&
      quoted.author.status !== AccountStatus.DELETED;

    return {
      ...PublicService.summary(post),
      poll: post.poll ? PublicService.poll(post.poll) : null,
      quoted: showQuoted
        ? {
            id: quoted.id,
            content: quoted.content,
            createdAt: quoted.createdAt.toISOString(),
            author: PublicService.author(quoted.author),
            media: quoted.media.map((m) => PublicService.media(m)),
          }
        : null,
    };
  }

  /**
   * A comment, with the post it answers. Hidden whenever either would be:
   * a reply on a deleted post is not something to show on its own.
   */
  async comment(id: string): Promise<PublicComment> {
    const comment = await this.prisma.comment.findFirst({
      where: {
        id,
        deletedAt: null,
        author: PublicService.visibleAuthor,
        post: PublicService.livePost,
      },
      select: {
        id: true,
        content: true,
        createdAt: true,
        author: { select: PublicService.authorShape },
        media: {
          where: { privatePath: null, kind: { not: MediaKind.VOICE } },
          orderBy: { position: 'asc' },
          take: PublicService.maxMedia,
          select: PublicService.mediaShape,
        },
        _count: {
          select: { likes: true, replies: { where: { deletedAt: null } } },
        },
        post: { select: PublicService.summaryShape },
      },
    });
    if (!comment) throw new NotFoundException('Comment not found.');

    return {
      id: comment.id,
      content: comment.content,
      createdAt: comment.createdAt.toISOString(),
      author: PublicService.author(comment.author),
      media: comment.media.map((m) => PublicService.media(m)),
      stats: { likes: comment._count.likes, replies: comment._count.replies },
      post: PublicService.summary(comment.post),
    };
  }

  /** A profile, by handle or by id: not every account has a handle. */
  async profile(handleOrId: string): Promise<PublicProfile> {
    const where: Prisma.UserWhereInput = PublicService.isUuid(handleOrId)
      ? { id: handleOrId }
      : { username: { equals: handleOrId, mode: 'insensitive' } };
    const user = await this.prisma.user.findFirst({
      where: { ...where, ...PublicService.visibleAuthor },
      select: {
        id: true,
        name: true,
        username: true,
        verifiedAt: true,
        profile: {
          // Not dateOfBirth, not location: a page anybody can open is not
          // where either belongs.
          select: { avatarUrl: true, coverUrl: true, bio: true },
        },
      },
    });
    if (!user) throw new NotFoundException('Profile not found.');

    const [followers, following, posts, recent] = await Promise.all([
      this.prisma.follow.count({ where: { followingId: user.id } }),
      this.prisma.follow.count({ where: { followerId: user.id } }),
      this.prisma.post.count({ where: { authorId: user.id, deletedAt: null } }),
      this.prisma.post.findMany({
        where: { authorId: user.id, deletedAt: null },
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        take: PublicService.recentPosts,
        select: PublicService.summaryShape,
      }),
    ]);

    return {
      ...PublicService.author(user),
      id: user.id,
      bio: user.profile?.bio ?? null,
      coverUrl: user.profile?.coverUrl ?? null,
      stats: { followers, following, posts },
      recent: recent.map((p) => PublicService.summary(p)),
    };
  }

  async community(slug: string): Promise<PublicCommunity> {
    const community = await this.prisma.community.findFirst({
      where: { slug: { equals: slug, mode: 'insensitive' }, deletedAt: null },
      select: {
        id: true,
        slug: true,
        name: true,
        description: true,
        avatarUrl: true,
        bannerUrl: true,
        _count: { select: { members: true } },
      },
    });
    if (!community) throw new NotFoundException('Community not found.');

    const recent = await this.prisma.post.findMany({
      where: { communityId: community.id, ...PublicService.livePost },
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      take: PublicService.recentPosts,
      select: PublicService.summaryShape,
    });

    return {
      id: community.id,
      slug: community.slug,
      name: community.name,
      description: community.description,
      avatarUrl: community.avatarUrl,
      bannerUrl: community.bannerUrl,
      members: community._count.members,
      recent: recent.map((p) => PublicService.summary(p)),
    };
  }

  private static summary(
    post: Prisma.PostGetPayload<{ select: typeof PublicService.summaryShape }>,
  ): PublicPostSummary {
    const media = post.media.filter((m) => m.kind !== MediaKind.VOICE);
    return {
      id: post.id,
      content: post.content,
      createdAt: post.createdAt.toISOString(),
      author: PublicService.author(post.author),
      community:
        post.community && !post.community.deletedAt
          ? { name: post.community.name, slug: post.community.slug }
          : null,
      media: media
        .slice(0, PublicService.maxMedia)
        .map((m) => PublicService.media(m)),
      // All of them, so a page showing four can say there are eight.
      mediaCount: media.length,
      // A voice note is a link to an audio file with nothing to show on a
      // card; the page says it is there instead.
      hasVoice: post.media.some((m) => m.kind === MediaKind.VOICE),
      stats: {
        likes: post.likeCount,
        comments: post.commentCount,
        reposts: post.repostCount,
      },
    };
  }

  private static poll(poll: {
    closesAt: Date;
    options: { text: string; _count: { votes: number } }[];
  }): PublicPoll {
    const options = poll.options.map((o) => ({
      text: o.text,
      votes: o._count.votes,
    }));
    return {
      options,
      totalVotes: options.reduce((sum, o) => sum + o.votes, 0),
      closesAt: poll.closesAt.toISOString(),
    };
  }

  private static media(m: {
    kind: MediaKind;
    url: string;
    thumbnailUrl: string | null;
    width: number | null;
    height: number | null;
    alt: string | null;
  }): PublicMedia {
    return {
      kind: m.kind,
      url: m.url,
      thumbnailUrl: m.thumbnailUrl,
      width: m.width,
      height: m.height,
      alt: m.alt,
    };
  }

  private static author(user: {
    name: string | null;
    username: string | null;
    verifiedAt: Date | null;
    profile: { avatarUrl: string | null } | null;
  }): PublicAuthor {
    return {
      name: user.name,
      username: user.username,
      verified: !!user.verifiedAt,
      avatarUrl: user.profile?.avatarUrl ?? null,
    };
  }

  static isUuid(value: string): boolean {
    return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(
      value,
    );
  }
}

export interface PublicAuthor {
  name: string | null;
  username: string | null;
  verified: boolean;
  avatarUrl: string | null;
}

export interface PublicMedia {
  kind: MediaKind;
  url: string;
  thumbnailUrl: string | null;
  width: number | null;
  height: number | null;
  alt: string | null;
}

export interface PublicPostSummary {
  id: string;
  content: string;
  createdAt: string;
  author: PublicAuthor;
  community: { name: string; slug: string } | null;
  media: PublicMedia[];
  mediaCount: number;
  hasVoice: boolean;
  stats: { likes: number; comments: number; reposts: number };
}

/** Counts only: who voted for what is nobody's business on a public page. */
export interface PublicPoll {
  options: { text: string; votes: number }[];
  totalVotes: number;
  closesAt: string;
}

export interface PublicPost extends PublicPostSummary {
  poll: PublicPoll | null;
  quoted: {
    id: string;
    content: string;
    createdAt: string;
    author: PublicAuthor;
    media: PublicMedia[];
  } | null;
}

export interface PublicComment {
  id: string;
  content: string;
  createdAt: string;
  author: PublicAuthor;
  media: PublicMedia[];
  stats: { likes: number; replies: number };
  post: PublicPostSummary;
}

export interface PublicProfile extends PublicAuthor {
  id: string;
  bio: string | null;
  coverUrl: string | null;
  stats: { followers: number; following: number; posts: number };
  recent: PublicPostSummary[];
}

export interface PublicCommunity {
  id: string;
  slug: string;
  name: string;
  description: string | null;
  avatarUrl: string | null;
  bannerUrl: string | null;
  members: number;
  recent: PublicPostSummary[];
}
