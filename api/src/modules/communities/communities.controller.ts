import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Put,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { CommunityRole } from '@prisma/client';
import { CommunitiesService } from './communities.service';
import {
  CreateCommunityDto,
  DiscoverCommunitiesDto,
  ListCommunitiesDto,
  RemoveMemberDto,
  SetRoleDto,
  UpdateCommunityDto,
} from './dto/community.dto';
import { ListFeedDto } from '../feed/dto/list-feed.dto';
import { CreatePostDto } from '../feed/dto/create-post.dto';
import { FeedService } from '../feed/feed.service';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';

@Controller('communities')
@UseGuards(AuthGuard)
export class CommunitiesController {
  constructor(
    private readonly svc: CommunitiesService,
    private readonly feed: FeedService,
  ) {}

  /**
   * The reader's own.
   *
   * Both fixed-name routes are declared above ':slug', or that parameter
   * swallows them and a community called "mine" is the only way to reach this.
   */
  @Get('mine')
  mine(@Req() req: AuthRequest, @Query() query: ListCommunitiesDto) {
    return this.svc.mine(req.user.id, {
      limit: query.limit,
      cursor: query.cursor,
    });
  }

  /** Communities the reader is not in, busiest first. */
  @Get('discover')
  discover(@Req() req: AuthRequest, @Query() query: DiscoverCommunitiesDto) {
    return this.svc.discover(req.user.id, {
      limit: query.limit,
      query: query.q,
    });
  }

  @Post()
  create(@Req() req: AuthRequest, @Body() dto: CreateCommunityDto) {
    return this.svc.create(req.user.id, {
      name: dto.name,
      description: dto.description,
    });
  }

  @Get(':slug')
  bySlug(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.bySlug(req.user.id, slug);
  }

  /** What has been posted into it. */
  @Get(':slug/posts')
  posts(
    @Req() req: AuthRequest,
    @Param('slug') slug: string,
    @Query() query: ListFeedDto,
  ) {
    return this.feed.listByCommunity(
      slug,
      req.user.id,
      query.limit,
      query.cursor,
    );
  }

  /**
   * Writes a post into it.
   *
   * Here rather than on the feed's create route, because whether this account
   * may post into this community is a rule that belongs to this module -- and
   * having the feed ask would make the two modules import each other.
   */
  @Post(':slug/posts')
  async post(
    @Req() req: AuthRequest,
    @Param('slug') slug: string,
    @Body() dto: CreatePostDto,
  ) {
    const communityId = await this.svc.requirePostable(req.user.id, slug);
    return this.feed.createPost(req.user.id, {
      content: dto.content,
      media: dto.media,
      quotedPostId: dto.quotedPostId,
      replyPolicy: dto.replyPolicy,
      poll: dto.poll,
      topics: dto.topics,
      communityId,
    });
  }

  /**
   * Everyone in a community.
   *
   * Above the ':slug' routes for the usual reason, and members-only: a roll
   * is who is in the room, and reading it from outside is not something a
   * member agreed to.
   */
  @Get(':slug/members')
  members(
    @Req() req: AuthRequest,
    @Param('slug') slug: string,
    @Query() query: ListCommunitiesDto,
  ) {
    return this.svc.members(req.user.id, slug, {
      limit: query.limit,
      cursor: query.cursor,
    });
  }

  /** Who is currently kept out. Moderators and the owner. */
  @Get(':slug/bans')
  bans(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.bans(req.user.id, slug);
  }

  /** Name, description, avatar, banner. The owner only. */
  @Patch(':slug')
  update(
    @Req() req: AuthRequest,
    @Param('slug') slug: string,
    @Body() dto: UpdateCommunityDto,
  ) {
    return this.svc.update(req.user.id, slug, dto);
  }

  @Put(':slug/members/:userId/role')
  setRole(
    @Req() req: AuthRequest,
    @Param('slug') slug: string,
    @Param('userId', ParseUUIDPipe) userId: string,
    @Body() dto: SetRoleDto,
  ) {
    return this.svc.setRole(
      req.user.id,
      slug,
      userId,
      dto.role as CommunityRole,
    );
  }

  /** Removes somebody and keeps them out. */
  @Delete(':slug/members/:userId')
  removeMember(
    @Req() req: AuthRequest,
    @Param('slug') slug: string,
    @Param('userId', ParseUUIDPipe) userId: string,
    @Body() dto: RemoveMemberDto,
  ) {
    return this.svc.removeMember(req.user.id, slug, userId, dto?.reason);
  }

  /** Lets somebody removed come back. */
  @Delete(':slug/bans/:userId')
  unban(
    @Req() req: AuthRequest,
    @Param('slug') slug: string,
    @Param('userId', ParseUUIDPipe) userId: string,
  ) {
    return this.svc.unban(req.user.id, slug, userId);
  }

  /** Closes a community. Soft, so its posts still resolve. */
  @Delete(':slug')
  remove(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.remove(req.user.id, slug);
  }

  @Put(':slug/membership')
  join(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.setMembership(req.user.id, slug, true);
  }

  @Delete(':slug/membership')
  leave(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.setMembership(req.user.id, slug, false);
  }
}
