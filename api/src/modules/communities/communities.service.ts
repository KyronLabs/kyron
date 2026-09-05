import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CommunityRole, Prisma } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/** A community as a list row or a header needs it. */
export interface CommunitySummary {
  id: string;
  slug: string;
  name: string;
  description: string | null;
  avatarUrl: string | null;
  members: number;
  posts: number;
  /** Whether the reader is in it, and what they can do if so. */
  joined: boolean;
  role: CommunityRole | null;
  createdAt: Date;
}

const DEFAULT_LIMIT = 20;

/**
 * Communities: a named place with members, and posts written into it rather
 * than into the feed.
 */
@Injectable()
export class CommunitiesService {
  private readonly logger = new Logger(CommunitiesService.name);

  constructor(private readonly prisma: PrismaService) {}

  static readonly maxName = 60;
  static readonly maxDescription = 400;

  /** How many communities one account may start. */
  static readonly maxOwned = 20;

  private readonly shape = {
    id: true,
    slug: true,
    name: true,
    description: true,
    avatarUrl: true,
    createdAt: true,
    _count: { select: { members: true, posts: true } },
  } as const;

  /**
   * Turns a name into the slug it is addressed by.
   *
   * Exposed so the client can show what the address will be while the name is
   * being typed, rather than after the fact.
   */
  static slugify(name: string): string {
    return name
      .toLowerCase()
      .trim()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-+|-+$/g, '')
      .slice(0, 40);
  }

  /** The communities the reader is in, most recently joined first. */
  async mine(
    viewerId: string,
    { limit = DEFAULT_LIMIT, cursor } = {} as {
      limit?: number;
      cursor?: string;
    },
  ) {
    const rows = await this.prisma.communityMember.findMany({
      where: { userId: viewerId, community: { deletedAt: null } },
      orderBy: [{ joinedAt: 'desc' }, { communityId: 'desc' }],
      take: limit + 1,
      ...(cursor
        ? {
            cursor: {
              communityId_userId: { communityId: cursor, userId: viewerId },
            },
            skip: 1,
          }
        : {}),
      select: { role: true, community: { select: this.shape } },
    });

    const page = rows.slice(0, limit);
    return {
      items: page.map((row) =>
        this.toSummary(row.community, { joined: true, role: row.role }),
      ),
      nextCursor:
        rows.length > limit ? page[page.length - 1].community.id : null,
    };
  }

  /**
   * Communities the reader is not in, busiest first.
   *
   * Busiest, not newest: an empty community made a minute ago is not the thing
   * to put at the top of a page called Discover.
   */
  async discover(
    viewerId: string,
    { limit = DEFAULT_LIMIT, query }: { limit?: number; query?: string } = {},
  ) {
    const term = query?.trim();
    const rows = await this.prisma.community.findMany({
      where: {
        deletedAt: null,
        members: { none: { userId: viewerId } },
        ...(term
          ? {
              OR: [
                { name: { contains: term, mode: 'insensitive' } },
                { slug: { contains: term.toLowerCase() } },
                { description: { contains: term, mode: 'insensitive' } },
              ] as Prisma.CommunityWhereInput[],
            }
          : {}),
      },
      orderBy: [{ members: { _count: 'desc' } }, { createdAt: 'desc' }],
      take: limit,
      select: this.shape,
    });

    return {
      items: rows.map((row) =>
        this.toSummary(row, { joined: false, role: null }),
      ),
      // Ranked by a count, so there is no row a cursor could name. Discover is
      // a shelf, not an infinite list.
      nextCursor: null,
    };
  }

  /** One community, by slug. */
  async bySlug(viewerId: string, slug: string): Promise<CommunitySummary> {
    const community = await this.prisma.community.findFirst({
      where: { slug: slug.trim().toLowerCase(), deletedAt: null },
      select: { ...this.shape, members: { where: { userId: viewerId } } },
    });
    if (!community) {
      throw new NotFoundException('That community does not exist.');
    }
    const membership = community.members[0];
    return this.toSummary(community, {
      joined: Boolean(membership),
      role: membership?.role ?? null,
    });
  }

  /** Starts one. Whoever makes it owns it and is its first member. */
  async create(
    viewerId: string,
    input: { name: string; description?: string },
  ): Promise<CommunitySummary> {
    const name = input.name.trim();
    if (!name) throw new BadRequestException('A community needs a name.');
    if (name.length > CommunitiesService.maxName) {
      throw new BadRequestException(
        `A name cannot exceed ${CommunitiesService.maxName} characters.`,
      );
    }

    const slug = CommunitiesService.slugify(name);
    // A name of only punctuation slugs to nothing, and a community with no
    // address cannot be opened.
    if (!slug) {
      throw new BadRequestException(
        'A name needs at least one letter or number.',
      );
    }

    const owned = await this.prisma.community.count({
      where: { createdById: viewerId, deletedAt: null },
    });
    if (owned >= CommunitiesService.maxOwned) {
      throw new ForbiddenException(
        `You have already started ${CommunitiesService.maxOwned} communities.`,
      );
    }

    const taken = await this.prisma.community.findUnique({
      where: { slug },
      select: { id: true },
    });
    if (taken) {
      throw new ConflictException('There is already a community by that name.');
    }

    const created = await this.prisma.community.create({
      data: {
        slug,
        name,
        description: input.description?.trim() || null,
        createdById: viewerId,
        members: { create: { userId: viewerId, role: CommunityRole.OWNER } },
      },
      select: this.shape,
    });
    this.logger.log(`community ${created.slug} created by ${viewerId}`);
    return this.toSummary(created, {
      joined: true,
      role: CommunityRole.OWNER,
    });
  }

  /** Joins or leaves. Returns the community as it now stands. */
  async setMembership(
    viewerId: string,
    slug: string,
    joined: boolean,
  ): Promise<CommunitySummary> {
    const community = await this.prisma.community.findFirst({
      where: { slug: slug.trim().toLowerCase(), deletedAt: null },
      select: { id: true, createdById: true },
    });
    if (!community) {
      throw new NotFoundException('That community does not exist.');
    }

    if (joined) {
      await this.prisma.communityMember.upsert({
        where: {
          communityId_userId: { communityId: community.id, userId: viewerId },
        },
        create: { communityId: community.id, userId: viewerId },
        update: {},
      });
    } else {
      // The owner leaving would leave it with nobody who can moderate it.
      // Handing it over is a separate thing, and not one this offers yet.
      if (community.createdById === viewerId) {
        throw new ForbiddenException(
          'You started this community, so you cannot leave it.',
        );
      }
      await this.prisma.communityMember.deleteMany({
        where: { communityId: community.id, userId: viewerId },
      });
    }

    return this.bySlug(viewerId, slug);
  }

  /**
   * The id to write a post into, if the reader may.
   *
   * Members only: a community anybody can post into is a feed with a name on
   * it. Called by the feed service, which is where posts are created.
   */
  async requirePostable(viewerId: string, slug: string): Promise<string> {
    const community = await this.prisma.community.findFirst({
      where: { slug: slug.trim().toLowerCase(), deletedAt: null },
      select: { id: true, members: { where: { userId: viewerId } } },
    });
    if (!community) {
      throw new NotFoundException('That community does not exist.');
    }
    if (community.members.length === 0) {
      throw new ForbiddenException('Join this community before posting in it.');
    }
    return community.id;
  }

  private toSummary(
    row: {
      id: string;
      slug: string;
      name: string;
      description: string | null;
      avatarUrl: string | null;
      createdAt: Date;
      _count: { members: number; posts: number };
    },
    membership: { joined: boolean; role: CommunityRole | null },
  ): CommunitySummary {
    return {
      id: row.id,
      slug: row.slug,
      name: row.name,
      description: row.description,
      avatarUrl: row.avatarUrl,
      members: row._count.members,
      posts: row._count.posts,
      joined: membership.joined,
      role: membership.role,
      createdAt: row.createdAt,
    };
  }
}
