/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */

import {
  Controller,
  Delete,
  Get,
  Post,
  Patch,
  Put,
  UseGuards,
  Body,
  Req,
  Param,
  ParseUUIDPipe,
  Query,
  Logger,
  BadRequestException,
} from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { ProfileService } from './profile.service';
import { SearchProfilesDto } from './dto/search-profiles.dto';
import { ListFollowsDto } from './dto/list-follows.dto';
import { ListSuggestedDto } from './dto/list-suggested.dto';
import { Request } from 'express';

/**
 * The slice of the Fastify multipart request these handlers touch. Typed
 * locally because @fastify/multipart augments FastifyRequest, which the Nest
 * @Req() decorator does not surface here.
 */
interface MultipartFile {
  filename: string;
  mimetype: string;
  toBuffer(): Promise<Buffer>;
}

interface MultipartRequest {
  user: { id: string };
  file(): Promise<MultipartFile | undefined>;
}

/** An unguarded route: `user` is present only when a token was supplied. */
interface OptionalAuthRequest extends Request {
  user?: { id: string };
}

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
  // PHASE 4: FINDING PEOPLE
  // ==========================================
  @UseGuards(AuthGuard)
  @Get('search')
  async search(@Req() req: AuthRequest, @Query() query: SearchProfilesDto) {
    return this.svc.searchProfiles(query.q, req.user.id, query.limit);
  }

  /**
   * Who follows this account, and who it follows.
   *
   * Declared above the legacy catch-all below: a route with a parameter
   * segment declared first swallows every static path after it, which is how
   * /profile/interests once answered "User not found".
   */
  @UseGuards(AuthGuard)
  @Get('users/:userId/followers')
  async followers(
    @Req() req: AuthRequest,
    @Param('userId', ParseUUIDPipe) userId: string,
    @Query() query: ListFollowsDto,
  ) {
    return this.svc.listFollows(
      userId,
      'followers',
      req.user.id,
      query.limit,
      query.cursor,
    );
  }

  @UseGuards(AuthGuard)
  @Get('users/:userId/following')
  async following(
    @Req() req: AuthRequest,
    @Param('userId', ParseUUIDPipe) userId: string,
    @Query() query: ListFollowsDto,
  ) {
    return this.svc.listFollows(
      userId,
      'following',
      req.user.id,
      query.limit,
      query.cursor,
    );
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
  async uploadAvatar(@Req() req: MultipartRequest) {
    const userId = req.user.id;

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
  async uploadCover(@Req() req: MultipartRequest) {
    const userId = req.user.id;

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

  /** The topic catalogue, with its counts and the reader's own picks. */
  @UseGuards(AuthGuard)
  @Get('interests')
  async interests(@Req() req: AuthRequest) {
    return this.svc.listTopics(req.user.id);
  }

  /** Follows one topic, leaving the rest of the reader's picks alone. */
  @UseGuards(AuthGuard)
  @Put('interests/:slug')
  async followTopic(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.setTopic(req.user.id, slug, true);
  }

  @UseGuards(AuthGuard)
  @Delete('interests/:slug')
  async unfollowTopic(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.setTopic(req.user.id, slug, false);
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

  /** Accounts worth following, best match first. */
  @UseGuards(AuthGuard)
  @Get('suggested')
  async getSuggested(
    @Req() req: AuthRequest,
    @Query() query: ListSuggestedDto,
  ) {
    return this.svc.listSuggested(req.user.id, query.limit, query.cursor);
  }

  // ==========================================
  // PUBLIC PROFILE -- DECLARED LAST, DELIBERATELY
  // ==========================================
  // ':username' matches any single segment, so Nest resolves it before any
  // route declared after it. Sitting above them, it swallowed
  // GET /profile/interests and GET /profile/suggested: both answered "User not
  // found" for an account named "interests" or "suggested". Any new
  // fixed-name route belongs above this one.
  @Get(':username')
  async getPublicProfile(
    @Param('username') username: string,
    @Req() req: OptionalAuthRequest,
  ) {
    // Signed-in callers additionally learn whether they follow this account.
    return this.svc.getPublicProfile(username, req.user?.id);
  }
}
