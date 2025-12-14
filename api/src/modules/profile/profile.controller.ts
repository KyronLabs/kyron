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
  Param,
  Query,
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

  // ==========================================
  // PHASE 1: GET /profile/me (CANONICAL)
  // ==========================================
  @UseGuards(AuthGuard)
  @Get('me')
  async getMe(@Req() req: AuthRequest) {
    return this.svc.getMe(req.user.id);
  }

  // ==========================================
  // PHASE 2: FOLLOW SYSTEM
  // ==========================================
  @UseGuards(AuthGuard)
  @Post('follow/:targetId')
  async follow(@Req() req: AuthRequest, @Param('targetId') targetId: string) {
    return this.svc.follow(req.user.id, targetId);
  }

  @UseGuards(AuthGuard)
  @Post('unfollow/:targetId')
  async unfollow(@Req() req: AuthRequest, @Param('targetId') targetId: string) {
    return this.svc.unfollow(req.user.id, targetId);
  }

  // ==========================================
  // PHASE 3: KYRON POINTS
  // ==========================================
  @UseGuards(AuthGuard)
  @Post('kp/award')
  async awardKP(
    @Req() req: AuthRequest,
    @Body() body: { userId: string; amount: number; reason: string },
  ) {
    // TODO: Add admin guard or internal-only guard
    return this.svc.awardKP(body.userId, body.amount, body.reason);
  }

  @UseGuards(AuthGuard)
  @Get('kp/history')
  async getKPHistory(@Req() req: AuthRequest, @Query('limit') limit?: string) {
    const limitNum = limit ? parseInt(limit, 10) : 50;
    return this.svc.getKPHistory(req.user.id, limitNum);
  }

  @Get('kp/leaderboard')
  async getKPLeaderboard(@Query('limit') limit?: string) {
    const limitNum = limit ? parseInt(limit, 10) : 100;
    return this.svc.getKPLeaderboard(limitNum);
  }

  // ==========================================
  // PHASE 4: PUBLIC PROFILE
  // ==========================================
  @Get(':username')
  async getPublicProfile(
    @Param('username') username: string,
    @Req() req: any,
  ) {
    // Optional: get viewerId from auth if logged in
    const viewerId = req.user?.id;
    return this.svc.getPublicProfile(username, viewerId);
  }

  // ==========================================
  // LEGACY ENDPOINTS (Backward Compatibility)
  // ==========================================
  @UseGuards(AuthGuard)
  @Get('legacy/profile')
  async getLegacyProfile(@Req() req: AuthRequest) {
    return this.svc.getProfile(req.user.id);
  }

  @UseGuards(AuthGuard)
  @Patch()
  async update(@Req() req: AuthRequest, @Body() body: any) {
    return this.svc.updateProfile(req.user.id, body);
  }

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

  @Get('interests')
  async interests() {
    return { data: await this.svc.listInterests() };
  }

  @UseGuards(AuthGuard)
  @Post('interests')
  async saveInterests(@Req() req: AuthRequest, @Body() body: any) {
    const interests = body.interests;

    if (!Array.isArray(interests)) {
      throw new BadRequestException('Invalid interests array');
    }

    return this.svc.saveInterests(req.user.id, interests);
  }

  @UseGuards(AuthGuard)
  @Post('follow-many')
  async followMany(@Req() req: AuthRequest, @Body() body: any) {
    const ids = body.ids;

    if (!Array.isArray(ids)) {
      throw new BadRequestException('ids must be an array of user IDs');
    }

    return this.svc.followMany(req.user.id, ids);
  }

  @UseGuards(AuthGuard)
  @Get('suggested')
  async getSuggested(@Req() req: AuthRequest) {
    return this.svc.getSuggestedUsers(req.user.id);
  }
}