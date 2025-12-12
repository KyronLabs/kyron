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
  BadRequestException,
} from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { ProfileService } from './profile.service';
import { Request } from 'express';

interface AuthRequest extends Request {
  user: {
    id: string;
    email: string;
    role: string;
  };
}

@Controller('profile')
export class ProfileController {
  private readonly logger = new Logger(ProfileController.name);

  constructor(private readonly svc: ProfileService) {}

  // ------------------------------------
  // GET MY PROFILE
  // ------------------------------------
  @UseGuards(AuthGuard)
  @Get('me')
  async me(@Req() req: AuthRequest) {
    return this.svc.getProfile(req.user.id);
  }

  // ------------------------------------
  // UPDATE PROFILE
  // ------------------------------------
  @UseGuards(AuthGuard)
  @Patch()
  async update(@Req() req: AuthRequest, @Body() body: any) {
    return this.svc.updateProfile(req.user.id, body);
  }

  // ------------------------------------
  // UPLOAD AVATAR
  // ------------------------------------
  @UseGuards(AuthGuard)
  @Post('avatar')
  async uploadAvatar(@Req() req: any) {
    const userId = (req as any).user.id;

    const file = await req.file();
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

  // ------------------------------------
  // UPLOAD COVER
  // ------------------------------------
  @UseGuards(AuthGuard)
  @Post('cover')
  async uploadCover(@Req() req: any) {
    const userId = (req as any).user.id;

    const file = await req.file();
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
    return { url: await this.svc.getRandomDefaultCover() };
  }

  // ------------------------------------
  // LIST INTERESTS
  // ------------------------------------
  @Get('interests')
  async interests() {
    return { data: await this.svc.listInterests() };
  }

  // ------------------------------------
  // SAVE INTERESTS
  // ------------------------------------
  @UseGuards(AuthGuard)
  @Post('interests')
  async saveInterests(@Req() req: AuthRequest, @Body() body: any) {
    const interests = body.interests;

    if (!Array.isArray(interests)) {
      throw new BadRequestException('Invalid interests array');
    }

    return this.svc.saveInterests(req.user.id, interests);
  }

  // ------------------------------------
  // FOLLOW MANY
  // ------------------------------------
  @UseGuards(AuthGuard)
  @Post('follow-many')
  async followMany(@Req() req: AuthRequest, @Body() body: any) {
    const ids = body.ids;

    if (!Array.isArray(ids)) {
      throw new BadRequestException('ids must be an array of user IDs');
    }

    return this.svc.followMany(req.user.id, ids);
  }

  // ------------------------------------
  // GET SUGGESTED USERS
  // ------------------------------------
  @UseGuards(AuthGuard)
  @Get('suggested')
  async getSuggested(@Req() req: AuthRequest) {
    return this.svc.getSuggestedUsers(req.user.id);
  }
}
