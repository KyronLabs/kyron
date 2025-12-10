/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
import {
  Controller,
  Get,
  Post,
  Patch,
  UseGuards,
  Body,
  Req,
  Logger,
} from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { ProfileService } from './profile.service';
import { Request } from 'express';
import { UserRole } from '@prisma/client';

@Controller('profile')
export class ProfileController {
  private readonly logger = new Logger(ProfileController.name);
  constructor(private readonly svc: ProfileService) {}

  // Get my profile
  @UseGuards(AuthGuard)
  @Get('me')
  async me(@Req() req: any) {
    const userId = req.user?.id;
    return await this.svc.getProfile(userId);
  }

  // Update profile text fields
  @UseGuards(AuthGuard)
  @Patch()
  async update(@Req() req: any, @Body() body: any) {
    const userId = req.user?.id;
    return await this.svc.updateProfile(userId, body);
  }

  // ✅ Upload avatar (Fastify style)
  @UseGuards(AuthGuard)
  @Post('avatar')
  async uploadAvatar(@Req() req: any) {
    const userId = req.user?.id;
    
    const file = await req.file(); // Fastify multipart
    if (!file) throw new Error('No file uploaded');
    
    const buffer = await file.toBuffer();
    const url = await this.svc.uploadAvatar(
      userId,
      buffer,
      file.filename,
      file.mimetype,
    );
    return { url };
  }

  // ✅ Upload cover (Fastify style)
  @UseGuards(AuthGuard)
  @Post('cover')
  async uploadCover(@Req() req: any) {
    const userId = req.user?.id;
    
    const file = await req.file(); // Fastify multipart
    if (!file) throw new Error('No file uploaded');
    
    const buffer = await file.toBuffer();
    const url = await this.svc.uploadCover(
      userId,
      buffer,
      file.filename,
      file.mimetype,
    );
    return { url };
  }

  @UseGuards(AuthGuard)
  @Get('default-cover/random')
  async randomDefaultCover() {
    const url = await this.svc.getRandomDefaultCover();
    return { url };
  }

  @Get('interests')
  async interests() {
    const rows = await this.svc.listInterests();
    return { data: rows };
  }
}