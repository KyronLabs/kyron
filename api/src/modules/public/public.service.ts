import { Injectable, NotFoundException } from '@nestjs/common';
import { AccountStatus, MediaKind, Prisma } from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/**
 * What anybody on the internet may read about Kyron, without signing in.
 *
 * This is the read side of kyron-web: the pages a shared link opens for
 * somebody who does not have the app, and the cards WhatsApp, X and iMessage
 * draw from them. It is deliberately smaller than what the app reads. Every
 * field here is one a stranger with the link may see, and it is a list of
 * what to include, never of what to leave out, so a column added to a table
 * later is not published by accident.
 *
 * Nothing here knows who is asking. There is no viewer, so there are no
 * blocks, likes or follows to answer about, and nothing in the result
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

  private static readonly authorShape = {
    name: true,
    username: true,
    verifiedAt: true,
    profile: { select: { avatarUrl: true } },
  } as const;

  async post(id: string): Promise<PublicPost> {
    const post = await this.prisma.post.findFirst({
      where: { id, deletedAt: null, author: PublicService.visibleAuthor },
      select: {
        id: true,
        content: true,
        createdAt: true,
        likeCount: true,
        commentCount: true,
        repostCount: true,
        author: { select: PublicService.authorShape },
        community: { select: { name: true, slug: true, deletedAt: true } },
        media: {
          // Only what is already in the public bucket. A file with a private
          // path is served through a signed address to somebody entitled to
          // it; publishing it here would hand it to anyone with the link.
          where: { privatePath: null, commentId: null },
          orderBy: { position: 'asc' },
          take: PublicService.maxMedia,
          select: {
            kind: true,
            url: true,
            thumbnailUrl: true,
            width: true,
            height: true,
            alt: true,
          },
        },
      },
    });
    if (!post) throw new NotFoundException('Post not found.');

    return {
      id: post.id,
      content: post.content,
      createdAt: post.createdAt.toISOString(),
      author: PublicService.author(post.author),
      community:
        post.community && !post.community.deletedAt
          ? { name: post.community.name, slug: post.community.slug }
          : null,
      media: post.media
        // A voice note is a link to an audio file with nothing to show on a
        // card; the page says it is there instead.
        .filter((m) => m.kind !== MediaKind.VOICE)
        .map((m) => ({
          kind: m.kind,
          url: m.url,
          thumbnailUrl: m.thumbnailUrl,
          width: m.width,
          height: m.height,
          alt: m.alt,
        })),
      hasVoice: post.media.some((m) => m.kind === MediaKind.VOICE),
      stats: {
        likes: post.likeCount,
        comments: post.commentCount,
        reposts: post.repostCount,
      },
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

    const [followers, following, posts] = await Promise.all([
      this.prisma.follow.count({ where: { followingId: user.id } }),
      this.prisma.follow.count({ where: { followerId: user.id } }),
      this.prisma.post.count({ where: { authorId: user.id, deletedAt: null } }),
    ]);

    return {
      ...PublicService.author(user),
      id: user.id,
      bio: user.profile?.bio ?? null,
      coverUrl: user.profile?.coverUrl ?? null,
      stats: { followers, following, posts },
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

    return {
      id: community.id,
      slug: community.slug,
      name: community.name,
      description: community.description,
      avatarUrl: community.avatarUrl,
      bannerUrl: community.bannerUrl,
      members: community._count.members,
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

export interface PublicPost {
  id: string;
  content: string;
  createdAt: string;
  author: PublicAuthor;
  community: { name: string; slug: string } | null;
  media: PublicMedia[];
  hasVoice: boolean;
  stats: { likes: number; comments: number; reposts: number };
}

export interface PublicProfile extends PublicAuthor {
  id: string;
  bio: string | null;
  coverUrl: string | null;
  stats: { followers: number; following: number; posts: number };
}

export interface PublicCommunity {
  id: string;
  slug: string;
  name: string;
  description: string | null;
  avatarUrl: string | null;
  bannerUrl: string | null;
  members: number;
}
