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

  // -----------------------------------------------------
  // AVATAR UPLOAD
  // -----------------------------------------------------
  async uploadAvatar(
    userId: string,
    fileBuffer: Buffer,
    originalName: string,
    mimeType: string,
  ) {
    if (!fileBuffer?.length) {
      throw new BadRequestException('Empty file');
    }

    const filename = this.buildFileName(userId, 'avatar', originalName);

    const { publicUrl } = await this.supabase.uploadFile(
      this.supabase.getAvatarFolder(),
      filename,
      fileBuffer,
      mimeType,
    );

    await this.prisma.userProfile.upsert({
      where: { userId },
      update: { avatarUrl: publicUrl },
      create: { userId, avatarUrl: publicUrl },
    });

    this.logger.log(`Avatar uploaded for ${userId}: ${publicUrl}`);
    return publicUrl;
  }

  // -----------------------------------------------------
  // COVER UPLOAD
  // -----------------------------------------------------
  async uploadCover(
    userId: string,
    fileBuffer: Buffer,
    originalName: string,
    mimeType: string,
  ) {
    if (!fileBuffer?.length) {
      throw new BadRequestException('Empty file');
    }

    const filename = this.buildFileName(userId, 'cover', originalName);

    const { publicUrl } = await this.supabase.uploadFile(
      this.supabase.getCoverFolder(),
      filename,
      fileBuffer,
      mimeType,
    );

    await this.prisma.userProfile.upsert({
      where: { userId },
      update: { coverUrl: publicUrl },
      create: { userId, coverUrl: publicUrl },
    });

    this.logger.log(`Cover uploaded for ${userId}: ${publicUrl}`);
    return publicUrl;
  }

  // -----------------------------------------------------
  // PROFILE UPDATE
  // -----------------------------------------------------
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

    // update or create profile
    await this.prisma.userProfile.upsert({
      where: { userId },
      create: { userId, bio, location, website },
      update: { bio, location, website },
    });

    // update name in user table
    if (typeof name !== 'undefined') {
      await this.prisma.user.update({
        where: { id: userId },
        data: { name },
      });
    }

    // update interests
    if (Array.isArray(interests)) {
      await this.prisma.userInterest.deleteMany({ where: { userId } });

      const rows = interests.map((interestId) => ({
        id: uuidv4(),
        userId,
        interestId,
      }));

      if (rows.length > 0) {
        await this.prisma.userInterest.createMany({
          data: rows,
          skipDuplicates: true,
        });
      }
    }

    return { ok: true };
  }

  // -----------------------------------------------------
  // GET PROFILE
  // -----------------------------------------------------
  async getProfile(userId: string) {
    return await this.prisma.user.findUnique({
      where: { id: userId },
      include: {
        profile: true,
        interests: { include: { interest: true } },
      },
    });
  }
}
