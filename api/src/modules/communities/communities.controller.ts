import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { CommunitiesService } from './communities.service';
import {
  CreateCommunityDto,
  DiscoverCommunitiesDto,
  ListCommunitiesDto,
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

  @Put(':slug/membership')
  join(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.setMembership(req.user.id, slug, true);
  }

  @Delete(':slug/membership')
  leave(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.svc.setMembership(req.user.id, slug, false);
  }
}
