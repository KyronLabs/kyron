/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */

import { Injectable, Logger, BadRequestException } from '@nestjs/common';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class ProfileService {
  private readonly logger = new Logger(ProfileService.name);

  constructor(
    private readonly supabase: SupabaseService,
    private readonly prisma: PrismaService,
  ) {}

  private buildFileName(userId: string, prefix: string, originalName: string) {
    const ext = originalName.includes('.') ? originalName.split('.').pop() : 'bin';
    return `${userId}_${prefix}_${Date.now()}.${ext}`;
  }

  /** Upload avatar buffer to storage, update profile row in Supabase */
  async uploadAvatar(userId: string, fileBuffer: Buffer, originalName: string, mimeType?: string) {
    if (!fileBuffer || fileBuffer.length === 0) throw new BadRequestException('Empty file');

    const filename = this.buildFileName(userId, 'avatar', originalName);
    const folder = this.supabase.getAvatarFolder(); // e.g. avatars
    const { publicUrl } = await this.supabase.uploadFile(folder, filename, fileBuffer, mimeType);

    // Upsert profile row in Supabase table
    await this.supabase.upsertProfileRow({
      user_id: userId,
      avatar_url: publicUrl,
      updated_at: new Date().toISOString(),
    });

    this.logger.log(`Avatar uploaded for ${userId}: ${publicUrl}`);
    return publicUrl;
  }

  /** Upload cover buffer to storage, update profile row in Supabase */
  async uploadCover(userId: string, fileBuffer: Buffer, originalName: string, mimeType?: string) {
    if (!fileBuffer || fileBuffer.length === 0) throw new BadRequestException('Empty file');

    const filename = this.buildFileName(userId, 'cover', originalName);
    const folder = `${this.supabase.getCoverFolder()}`; // e.g. covers
    const { publicUrl } = await this.supabase.uploadFile(folder, filename, fileBuffer, mimeType);

    await this.supabase.upsertProfileRow({
      user_id: userId,
      cover_url: publicUrl,
      updated_at: new Date().toISOString(),
    });

    this.logger.log(`Cover uploaded for ${userId}: ${publicUrl}`);
    return publicUrl;
  }

  /** Update profile fields and interests */
  async updateProfile(userId: string, payload: {
    name?: string;
    bio?: string;
    location?: string;
    website?: string;
    interests?: string[];
  }) {
    const { name, bio, location, website, interests } = payload;

    await this.supabase.upsertProfileRow({
      user_id: userId,
      display_name: name ?? undefined,
      bio: bio ?? undefined,
      location: location ?? undefined,
      website: website ?? undefined,
      updated_at: new Date().toISOString(),
    });

    // If display name present, also persist to users via Prisma (optional)
    if (typeof name !== 'undefined') {
      await this.prisma.user.update({
        where: { id: userId },
        data: { name: name ?? null },
      });
    }

    // Replace interests using Supabase table
    if (Array.isArray(interests)) {
      // validate interest ids exist optionally
      await this.supabase.replaceUserInterests(userId, interests);
    }

    return { ok: true };
  }

  /** Get combined user + profile + interests */
  async getProfile(userId: string) {
    // get user from Prisma (authoritative)
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        email: true,
        username: true,
        name: true,
        role: true,
        createdAt: true,
      },
    });

    // get profile from Supabase
    const profile = await this.supabase.getProfileRow(userId);

    // get interests joined
    const interests = await this.supabase.getClient()
      .from('user_interests')
      .select('interest_id, interests(name, slug)')
      .eq('user_id', userId);

    // Assemble clean object
    return {
      user,
      profile,
      interests: Array.isArray((interests as any).data) ? (interests as any).data : [],
    };
  }

  async listInterests() {
    return await this.supabase.listInterests();
  }

  async getRandomDefaultCover() {
    return await this.supabase.getRandomDefaultCover();
  }
}