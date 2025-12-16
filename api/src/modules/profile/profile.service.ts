/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */

import { Injectable, Logger, BadRequestException, NotFoundException } from '@nestjs/common';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

@Injectable()
export class ProfileService {
  private readonly logger = new Logger(ProfileService.name);

  constructor(
    private readonly supabase: SupabaseService,
    private readonly prisma: PrismaService,
  ) {}

  // ==========================================
  // PHASE 1: GET /profile/me (SINGLE SOURCE OF TRUTH)
  // Reads from Prisma (authoritative) + Supabase (supplemental)
  // ==========================================
  async getMe(userId: string) {
    const [user, prismaProfile, followers, following] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: {
          id: true,
          username: true,
          did: true,
          kyronPoints: true,
        },
      }),

      this.prisma.userProfile.findUnique({
        where: { userId },
        select: {
          avatarUrl: true,
          coverUrl: true,
        },
      }),

      this.prisma.follow.count({
        where: { followingId: userId },
      }),

      this.prisma.follow.count({
        where: { followerId: userId },
      }),
    ]);

    if (!user) throw new NotFoundException('User not found');

    // If Prisma profile is missing, try to sync from Supabase
    if (!prismaProfile) {
      this.logger.warn(`User ${userId} missing Prisma profile, attempting Supabase sync`);
      await this.syncProfileFromSupabase(userId);
      
      // Retry after sync
      const syncedProfile = await this.prisma.userProfile.findUnique({
        where: { userId },
      });

      return {
        user,
        profile: syncedProfile || { avatarUrl: null, coverUrl: null },
        stats: { followers, following },
      };
    }

    return {
      user,
      profile: prismaProfile,
      stats: { followers, following },
    };
  }

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
      this.logger.error(`Failed to sync from Supabase for user ${userId}:`, error);
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
  async getPublicProfile(username: string, viewerId?: string) {
    const user = await this.prisma.user.findUnique({
      where: { username },
      select: {
        id: true,
        username: true,
        did: true,
        kyronPoints: true,
        profile: {
          select: {
            avatarUrl: true,
            coverUrl: true,
            bio: true,
          },
        },
      },
    });

    if (!user) throw new NotFoundException('User not found');

    const [followers, following, isFollowing] = await Promise.all([
      this.prisma.follow.count({
        where: { followingId: user.id },
      }),

      this.prisma.follow.count({
        where: { followerId: user.id },
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
        username: user.username,
        did: user.did,
        kyronPoints: user.kyronPoints,
      },
      profile: user.profile,
      stats: {
        followers,
        following,
        isFollowing,
      },
    };
  }

  // ==========================================
  // DUAL-WRITE OPERATIONS
  // These write to BOTH Prisma AND Supabase
  // ==========================================
  
  private buildFileName(userId: string, prefix: string, originalName: string) {
    const ext = originalName.includes('.') ? originalName.split('.').pop() : 'bin';
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
      interests?: string[];
    },
  ) {
    const { name, bio, location, website, interests } = payload;

    // DUAL-WRITE: Update both databases
    await Promise.all([
      // Update Prisma User (if name changed)
      name !== undefined
        ? this.prisma.user.update({
            where: { id: userId },
            data: { name: name ?? null },
          })
        : Promise.resolve(),

      // Update Prisma Profile
      (bio !== undefined || location !== undefined || website !== undefined)
        ? this.prisma.userProfile.upsert({
            where: { userId },
            update: {
              bio: bio ?? undefined,
              location: location ?? undefined,
              website: website ?? undefined,
            },
            create: {
              userId,
              bio: bio ?? null,
              location: location ?? null,
              website: website ?? null,
            },
          })
        : Promise.resolve(),

      // Update Supabase (public-facing)
      this.supabase.upsertProfileRow({
        user_id: userId,
        display_name: name ?? undefined,
        bio: bio ?? undefined,
        location: location ?? undefined,
        website: website ?? undefined,
        updated_at: new Date().toISOString(),
      }),
    ]);

    // Handle interests (Supabase only for now)
    if (Array.isArray(interests)) {
      await this.supabase.replaceUserInterests(userId, interests);
    }

    this.logger.log(`✅ Profile updated for ${userId} (dual-write)`);
    return { ok: true };
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
      ...new Set(matches.map((m: any) => m.user_id).filter((id) => id !== userId)),
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