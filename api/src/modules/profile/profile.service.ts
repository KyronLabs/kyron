/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
// src/modules/profile/profile.service.ts
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
    const ext = originalName.includes('.')
      ? originalName.split('.').pop()
      : 'bin';
    return `${userId}_${prefix}_${Date.now()}.${ext}`;
  }

  async uploadAvatar(
    userId: string,
    fileBuffer: Buffer,
    originalName: string,
    mimeType: string,
  ) {
    if (!fileBuffer || fileBuffer.length === 0)
      throw new BadRequestException('Empty file');

    const filename = this.buildFileName(userId, 'avatar', originalName);
    const { publicUrl } = await this.supabase.uploadFile(
      this.supabase.getAvatarFolder(),
      filename,
      fileBuffer,
      mimeType,
    );

    // upsert user profile if missing
    await this.prisma.userProfile.upsert({
      where: { userId },
      update: { avatarUrl: publicUrl },
      create: { userId, avatarUrl: publicUrl },
    });

    this.logger.log(`Avatar uploaded for ${userId}: ${publicUrl}`);
    return publicUrl;
  }

  async uploadCover(
    userId: string,
    fileBuffer: Buffer,
    originalName: string,
    mimeType: string,
  ) {
    if (!fileBuffer || fileBuffer.length === 0)
      throw new BadRequestException('Empty file');

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

    // upsert profile
    await this.prisma.userProfile.upsert({
      where: { userId },
      create: { userId, bio, location, website },
      update: { bio, location, website },
    });

    // update user display name
    if (typeof name !== 'undefined') {
      await this.prisma.user.update({
        where: { id: userId },
        data: { name },
      });
    }

    // replace interests
    if (Array.isArray(interests)) {
      // remove any existing then create new relations
      await this.prisma.userInterest.deleteMany({ where: { userId } });

      const connect = interests.map((interestId) => ({
        id: uuidv4(),
        userId,
        interestId,
      }));

      if (connect.length > 0) {
        await this.prisma.userInterest.createMany({
          data: connect,
          skipDuplicates: true,
        });
      }
    }

    return { ok: true };
  }

  async getProfile(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      include: { profile: true, interests: { include: { interest: true } } },
    });

    return user;
  }
}
