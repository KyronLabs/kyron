/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */

/* eslint-disable @typescript-eslint/no-unsafe-member-access */

import {
  Injectable,
  Logger,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

@Injectable()
export class ProfileService {
  private readonly logger = new Logger(ProfileService.name);

  /**
   * Whether a path segment is an account id rather than a handle.
   *
   * Handles are validated on the way in and cannot take this shape, so there
   * is nothing for the two to collide over.
   */
  static isUuid(value: string): boolean {
    return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(
      value,
    );
  }

  constructor(
    private readonly supabase: SupabaseService,
    private readonly prisma: PrismaService,
  ) {}

  // ==========================================
  // PHASE 1: GET /profile/me (SINGLE SOURCE OF TRUTH)
  // Reads from Prisma (authoritative) + Supabase (supplemental)
  // ==========================================
  async getMe(userId: string) {
    const [user, prismaProfile, followers, following, posts] =
      await Promise.all([
        this.prisma.user.findUnique({
          where: { id: userId },
          select: {
            id: true,
            // The profile screen leads with a display name. Without it the
            // client had nothing to show but the handle, so every profile
            // read "@name" twice over.
            name: true,
            username: true,
            did: true,
            kyronPoints: true,
          },
        }),

        this.prisma.userProfile.findUnique({
          where: { userId },
          select: this.profileShape,
        }),

        this.prisma.follow.count({
          where: { followingId: userId },
        }),

        this.prisma.follow.count({
          where: { followerId: userId },
        }),

        this.prisma.post.count({
          where: { authorId: userId, deletedAt: null },
        }),
      ]);

    if (!user) throw new NotFoundException('User not found');

    // If Prisma profile is missing, try to sync from Supabase
    if (!prismaProfile) {
      this.logger.warn(
        `User ${userId} missing Prisma profile, attempting Supabase sync`,
      );
      await this.syncProfileFromSupabase(userId);

      // Retry after sync
      const syncedProfile = await this.prisma.userProfile.findUnique({
        where: { userId },
        select: this.profileShape,
      });

      return {
        user,
        profile: syncedProfile ?? this.emptyProfile,
        stats: { followers, following, posts },
      };
    }

    return {
      user,
      profile: prismaProfile,
      stats: { followers, following, posts },
    };
  }

  /**
   * The profile columns both profile endpoints return.
   *
   * Named once so /profile/me and /profile/:username cannot drift apart: they
   * previously selected different sets, and the client had to guess which
   * fields a given response would carry.
   */
  private readonly profileShape = {
    avatarUrl: true,
    coverUrl: true,
    bio: true,
    location: true,
    website: true,
  } as const;

  private readonly emptyProfile = {
    avatarUrl: null,
    coverUrl: null,
    bio: null,
    location: null,
    website: null,
  };

  // ==========================================
  // DUAL-WRITE: Sync profile from Supabase to Prisma (Recovery)
  // ==========================================
  private async syncProfileFromSupabase(userId: string) {
    try {
      const supabaseProfile = await this.supabase.getProfileRow(userId);

      if (supabaseProfile) {
        await this.prisma.userProfile.upsert({
          where: { userId },
          update: {
            avatarUrl: supabaseProfile.avatar_url,
            coverUrl: supabaseProfile.cover_url,
            bio: supabaseProfile.bio,
            location: supabaseProfile.location,
            website: supabaseProfile.website,
          },
          create: {
            userId,
            avatarUrl: supabaseProfile.avatar_url,
            coverUrl: supabaseProfile.cover_url,
            bio: supabaseProfile.bio,
            location: supabaseProfile.location,
            website: supabaseProfile.website,
          },
        });

        this.logger.log(`✅ Synced profile from Supabase for user ${userId}`);
      }
    } catch (error) {
      this.logger.error(
        `Failed to sync from Supabase for user ${userId}:`,
        error,
      );
    }
  }

  // ==========================================
  // PHASE 2: FOLLOW SYSTEM (Prisma only)
  // ==========================================
  async follow(userId: string, targetId: string) {
    if (userId === targetId) {
      throw new BadRequestException('Cannot follow yourself');
    }

    await this.prisma.follow.upsert({
      where: {
        followerId_followingId: {
          followerId: userId,
          followingId: targetId,
        },
      },
      update: {},
      create: {
        followerId: userId,
        followingId: targetId,
      },
    });

    this.logger.log(`User ${userId} followed ${targetId}`);
    return { success: true };
  }

  async unfollow(userId: string, targetId: string) {
    await this.prisma.follow.deleteMany({
      where: {
        followerId: userId,
        followingId: targetId,
      },
    });

    this.logger.log(`User ${userId} unfollowed ${targetId}`);
    return { success: true };
  }

  // ==========================================
  // PHASE 3: KYRON POINTS ENGINE (Prisma only)
  // ==========================================
  async awardKP(userId: string, amount: number, reason: string) {
    const [event, updatedUser] = await this.prisma.$transaction([
      this.prisma.kyronPointEvent.create({
        data: { userId, amount, reason },
      }),
      this.prisma.user.update({
        where: { id: userId },
        data: {
          kyronPoints: { increment: amount },
        },
      }),
    ]);

    this.logger.log(`Awarded ${amount} KP to ${userId} for: ${reason}`);
    return { event, newTotal: updatedUser.kyronPoints };
  }

  async getKPHistory(userId: string, limit = 50) {
    return this.prisma.kyronPointEvent.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
      take: limit,
    });
  }

  async getKPLeaderboard(limit = 100) {
    return this.prisma.user.findMany({
      where: { status: 'ACTIVE' },
      select: {
        id: true,
        username: true,
        kyronPoints: true,
        profile: {
          select: {
            avatarUrl: true,
          },
        },
      },
      orderBy: { kyronPoints: 'desc' },
      take: limit,
    });
  }

  // ==========================================
  // PHASE 4: PUBLIC PROFILE (Read from Prisma)
  // ==========================================
  async getPublicProfile(handleOrId: string, viewerId?: string) {
    // Either a handle or an id. Not every account has a handle -- one is only
    // set during onboarding -- and without this an account that skipped it was
    // unreachable: every list that offered to open it had nothing to open it
    // by, so the tap did nothing at all.
    const where = ProfileService.isUuid(handleOrId)
      ? { id: handleOrId }
      : { username: handleOrId };

    const user = await this.prisma.user.findUnique({
      where,
      select: {
        id: true,
        name: true,
        username: true,
        did: true,
        kyronPoints: true,
        profile: { select: this.profileShape },
      },
    });

    if (!user) throw new NotFoundException('User not found');

    const [followers, following, posts, isFollowing] = await Promise.all([
      this.prisma.follow.count({
        where: { followingId: user.id },
      }),

      this.prisma.follow.count({
        where: { followerId: user.id },
      }),

      this.prisma.post.count({
        where: { authorId: user.id, deletedAt: null },
      }),

      viewerId
        ? this.prisma.follow
            .findFirst({
              where: {
                followerId: viewerId,
                followingId: user.id,
              },
            })
            .then((f) => !!f)
        : Promise.resolve(false),
    ]);

    return {
      user: {
        // The id is what the client needs to follow, unfollow or ask for this
        // account's posts. Withholding it meant the follow button on a public
        // profile had no target.
        id: user.id,
        name: user.name,
        username: user.username,
        did: user.did,
        kyronPoints: user.kyronPoints,
      },
      profile: user.profile ?? this.emptyProfile,
      stats: {
        followers,
        following,
        posts,
        isFollowing,
      },
    };
  }

  /**
   * People matching a handle or display name.
   *
   * Case-insensitive contains rather than a prefix: someone searching for
   * "kyron" should find "teamkyron", which a prefix match would miss. The
   * caller is excluded -- your own account is not a search result.
   */
  async searchProfiles(query: string, viewerId: string, limit = 20) {
    const q = query.trim();
    if (q.length < 2) return { items: [] };

    const users = await this.prisma.user.findMany({
      where: {
        id: { not: viewerId },
        deletedAt: null,
        OR: [
          { username: { contains: q, mode: 'insensitive' } },
          { name: { contains: q, mode: 'insensitive' } },
        ],
      },
      // An exact handle sorts first; beyond that, the most-followed people are
      // the ones a short query most likely meant.
      orderBy: [{ kyronPoints: 'desc' }, { username: 'asc' }],
      take: limit,
      select: {
        id: true,
        name: true,
        username: true,
        did: true,
        kyronPoints: true,
        profile: { select: { avatarUrl: true, bio: true } },
        _count: { select: { followers: true } },
      },
    });

    return {
      items: users.map((user) => ({
        id: user.id,
        name: user.name,
        username: user.username,
        did: user.did,
        kyronPoints: user.kyronPoints,
        avatarUrl: user.profile?.avatarUrl ?? null,
        bio: user.profile?.bio ?? null,
        followers: user._count.followers,
      })),
    };
  }

  /**
   * The accounts following a user, or the accounts they follow.
   *
   * Paged by the Follow row's own id rather than an offset: a list that is
   * being followed and unfollowed while it is read shifts under an offset, and
   * the reader sees the same person twice or misses one entirely.
   *
   * `isFollowing` is filled from the reader's own follows in one query, so the
   * list can show a working Follow button without a request per row.
   */
  async listFollows(
    userId: string,
    direction: 'followers' | 'following',
    viewerId: string,
    limit = 30,
    cursor?: string,
  ) {
    const user = await this.prisma.user.findFirst({
      where: { id: userId, deletedAt: null },
      select: { id: true },
    });
    if (!user) throw new NotFoundException('That account does not exist.');

    const rows = await this.prisma.follow.findMany({
      where:
        direction === 'followers'
          ? { followingId: userId }
          : { followerId: userId },
      orderBy: { createdAt: 'desc' },
      // One extra, to learn whether there is another page without counting.
      take: limit + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
      select: {
        id: true,
        follower: { select: this.summaryShape },
        following: { select: this.summaryShape },
      },
    });

    const page = rows.slice(0, limit);
    const people = page.map((row) =>
      direction === 'followers' ? row.follower : row.following,
    );

    // Which of these the reader already follows, in one query rather than one
    // per row.
    const followed = await this.prisma.follow.findMany({
      where: {
        followerId: viewerId,
        followingId: { in: people.map((person) => person.id) },
      },
      select: { followingId: true },
    });
    const followedIds = new Set(followed.map((row) => row.followingId));

    return {
      items: people.map((person) => ({
        id: person.id,
        name: person.name,
        username: person.username,
        did: person.did,
        kyronPoints: person.kyronPoints,
        avatarUrl: person.profile?.avatarUrl ?? null,
        bio: person.profile?.bio ?? null,
        followers: person._count.followers,
        isFollowing: followedIds.has(person.id),
        // Your own row never carries a Follow button.
        isSelf: person.id === viewerId,
      })),
      nextCursor: rows.length > limit ? page[page.length - 1].id : null,
    };
  }

  private readonly summaryShape = {
    id: true,
    name: true,
    username: true,
    did: true,
    kyronPoints: true,
    profile: { select: { avatarUrl: true, bio: true } },
    _count: { select: { followers: true } },
  } as const;

  // ==========================================
  // DUAL-WRITE OPERATIONS
  // These write to BOTH Prisma AND Supabase
  // ==========================================

  private buildFileName(userId: string, prefix: string, originalName: string) {
    const ext = originalName.includes('.')
      ? originalName.split('.').pop()
      : 'bin';
    return `${userId}_${prefix}_${Date.now()}.${ext}`;
  }

  async uploadAvatar(
    userId: string,
    fileBuffer: Buffer,
    originalName: string,
    mimeType?: string,
  ) {
    if (!fileBuffer || fileBuffer.length === 0)
      throw new BadRequestException('Empty file');

    const filename = this.buildFileName(userId, 'avatar', originalName);
    const folder = this.supabase.getAvatarFolder();

    // 1. Upload to Supabase Storage (CDN)
    const { publicUrl } = await this.supabase.uploadFile(
      folder,
      filename,
      fileBuffer,
      mimeType,
    );

    // 2. DUAL-WRITE: Update both databases
    await Promise.all([
      // Write to Prisma (source of truth)
      this.prisma.userProfile.upsert({
        where: { userId },
        update: { avatarUrl: publicUrl },
        create: { userId, avatarUrl: publicUrl },
      }),

      // Write to Supabase (fast public reads)
      this.supabase.upsertProfileRow({
        user_id: userId,
        avatar_url: publicUrl,
        updated_at: new Date().toISOString(),
      }),
    ]);

    this.logger.log(`✅ Avatar updated for ${userId} (dual-write)`);
    return publicUrl;
  }

  async uploadCover(
    userId: string,
    fileBuffer: Buffer,
    originalName: string,
    mimeType?: string,
  ) {
    if (!fileBuffer || fileBuffer.length === 0)
      throw new BadRequestException('Empty file');

    const filename = this.buildFileName(userId, 'cover', originalName);
    const folder = this.supabase.getCoverFolder();

    // 1. Upload to Supabase Storage (CDN)
    const { publicUrl } = await this.supabase.uploadFile(
      folder,
      filename,
      fileBuffer,
      mimeType,
    );

    // 2. DUAL-WRITE: Update both databases
    await Promise.all([
      // Write to Prisma (source of truth)
      this.prisma.userProfile.upsert({
        where: { userId },
        update: { coverUrl: publicUrl },
        create: { userId, coverUrl: publicUrl },
      }),

      // Write to Supabase (fast public reads)
      this.supabase.upsertProfileRow({
        user_id: userId,
        cover_url: publicUrl,
        updated_at: new Date().toISOString(),
      }),
    ]);

    this.logger.log(`✅ Cover updated for ${userId} (dual-write)`);
    return publicUrl;
  }

  async updateProfile(
    userId: string,
    payload: {
      name?: string;
      bio?: string;
      location?: string;
      website?: string;
      coverUrl?: string;
      interests?: string[];
    },
  ) {
    const { name, bio, location, website, coverUrl, interests } = payload;

    // Prisma is the source of truth and must succeed.
    await Promise.all([
      // Update Prisma User (if name changed)
      name !== undefined
        ? this.prisma.user.update({
            where: { id: userId },
            data: { name: name ?? null },
          })
        : Promise.resolve(),

      // Update Prisma Profile
      bio !== undefined ||
      location !== undefined ||
      website !== undefined ||
      coverUrl !== undefined
        ? this.prisma.userProfile.upsert({
            where: { userId },
            update: {
              bio: bio ?? undefined,
              location: location ?? undefined,
              website: website ?? undefined,
              coverUrl: coverUrl ?? undefined,
            },
            create: {
              userId,
              bio: bio ?? null,
              location: location ?? null,
              website: website ?? null,
              coverUrl: coverUrl ?? null,
            },
          })
        : Promise.resolve(),
    ]);

    // The Supabase row mirrors that for public reads. It used to sit in the
    // same Promise.all, so a mirror that could not be written failed the whole
    // request -- and when public.user_profiles did not exist in the project at
    // all, every save answered 500 and "Create your profile" could not be
    // completed by anyone. A mirror is not worth blocking the write it mirrors.
    let mirrored = true;
    try {
      await this.supabase.upsertProfileRow({
        user_id: userId,
        display_name: name ?? undefined,
        bio: bio ?? undefined,
        location: location ?? undefined,
        website: website ?? undefined,
        cover_url: coverUrl ?? undefined,
        updated_at: new Date().toISOString(),
      });
    } catch (error) {
      // Loud, because the consequence is real even though it is not fatal:
      // this row is what other people see, and what a fresh install reads to
      // decide whether onboarding is already done.
      mirrored = false;
      this.logger.error(
        `Saved the profile for ${userId} but could not mirror it to Supabase. ` +
          'Public reads will not see it until this is fixed; if the table is ' +
          'missing, apply the user_profiles migration to the project this API ' +
          'is configured for.',
        error instanceof Error ? error.stack : String(error),
      );
    }

    // Interests live only in Supabase, so a failure here is data loss rather
    // than a stale mirror. It stays fatal, and stays after the writes above so
    // it cannot roll them back.
    if (Array.isArray(interests)) {
      await this.supabase.replaceUserInterests(userId, interests);
    }

    this.logger.log(
      `✅ Profile updated for ${userId}` +
        (mirrored ? ' (dual-write)' : ' (Prisma only -- mirror failed)'),
    );
    return { ok: true, mirrored };
  }

  // ==========================================
  // READ OPERATIONS (Legacy/Helper Methods)
  // ==========================================

  async getProfile(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        email: true,
        username: true,
        name: true,
        role: true,
        createdAt: true,
        profile: {
          select: {
            avatarUrl: true,
            coverUrl: true,
            bio: true,
            location: true,
            website: true,
          },
        },
      },
    });

    // Get interests from Supabase
    const interests = await this.supabase
      .getClient()
      .from('user_interests')
      .select('interest_id, interest(id, name, slug)')
      .eq('user_id', userId);

    return {
      user,
      profile: user?.profile,
      interests: Array.isArray((interests as any).data)
        ? (interests as any).data
        : [],
    };
  }

  async listInterests() {
    return this.supabase.listInterests();
  }

  async getRandomDefaultCover() {
    return this.supabase.getRandomDefaultCover();
  }

  async saveInterests(userId: string, labels: string[]) {
    this.logger.log(`Saving interests for ${userId}`);

    const normalized = labels.map((l) => l.toLowerCase().trim());

    const { data: interestRows, error: fetchErr } = await this.supabase
      .getClient()
      .from('interests')
      .select('id, slug, name')
      .in('slug', normalized);

    if (fetchErr) throw new Error(fetchErr.message);

    if (!interestRows || interestRows.length === 0)
      throw new BadRequestException('No valid interests found');

    const { error: delErr } = await this.supabase
      .getClient()
      .from('user_interests')
      .delete()
      .eq('user_id', userId);

    if (delErr) throw new Error(delErr.message);

    const payload = interestRows.map((row) => ({
      user_id: userId,
      interest_id: row.id,
    }));

    const { error: insertErr } = await this.supabase
      .getClient()
      .from('user_interests')
      .insert(payload);

    if (insertErr) throw new Error(insertErr.message);

    return { ok: true, count: payload.length };
  }

  async followMany(userId: string, targetIds: string[]) {
    if (targetIds.length === 0) return { ok: true, count: 0 };

    const cleanIds = targetIds
      .filter((id) => id !== userId)
      .filter((v, i, a) => a.indexOf(v) === i);

    await this.prisma.follow.createMany({
      data: cleanIds.map((id) => ({
        followerId: userId,
        followingId: id,
      })),
      skipDuplicates: true,
    });

    return { ok: true, count: cleanIds.length };
  }

  async getSuggestedUsers(userId: string) {
    this.logger.log(`Generating suggestions for ${userId}`);

    const client = this.supabase.getClient();

    const { data: myInterests, error: myErr } = await client
      .from('user_interests')
      .select('interest_id')
      .eq('user_id', userId);

    if (myErr) throw new Error(myErr.message);

    const interestIds = (myInterests ?? []).map((i) => i.interest_id);

    if (interestIds.length === 0) {
      return this.getRandomSuggestedUsers(userId);
    }

    const { data: matches, error: matchErr } = await client
      .from('user_interests')
      .select('user_id')
      .in('interest_id', interestIds);

    if (matchErr) throw new Error(matchErr.message);

    const relatedUserIds = [
      ...new Set(
        matches.map((m: any) => m.user_id).filter((id) => id !== userId),
      ),
    ];

    if (relatedUserIds.length === 0) {
      return this.getRandomSuggestedUsers(userId);
    }

    const { data: profiles, error: profileErr } = await client
      .from('user_profiles')
      .select('*')
      .in('user_id', relatedUserIds)
      .limit(50);

    if (profileErr) throw new Error(profileErr.message);

    const followingRows = await this.prisma.follow.findMany({
      where: {
        followerId: userId,
        followingId: { in: relatedUserIds },
      },
    });

    const followingSet = new Set(followingRows.map((f) => f.followingId));

    return profiles.map((p: any) => ({
      id: p.user_id,
      avatar: p.avatar_url,
      handle: p.display_name ?? '@user',
      bio: p.bio,
      isFollowing: followingSet.has(p.user_id),
    }));
  }

  async getRandomSuggestedUsers(userId: string) {
    const client = this.supabase.getClient();

    const { data, error } = await client
      .from('user_profiles')
      .select('*')
      .neq('user_id', userId)
      .order('updated_at', { ascending: false })
      .limit(20);

    if (error) throw new Error(error.message);

    const followingRows = await this.prisma.follow.findMany({
      where: {
        followerId: userId,
        followingId: { in: data.map((x: any) => x.user_id) },
      },
    });

    const followingSet = new Set(followingRows.map((f) => f.followingId));

    return data.map((p: any) => ({
      id: p.user_id,
      avatar: p.avatar_url,
      handle: p.display_name ?? '@user',
      bio: p.bio,
      isFollowing: followingSet.has(p.user_id),
    }));
  }
}
