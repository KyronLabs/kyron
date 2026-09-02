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
import { FeedService } from './feed.service';
import { CreatePostDto } from './dto/create-post.dto';
import { CreateCommentDto } from './dto/create-comment.dto';
import { ReplyPolicyDto } from './dto/reply-policy.dto';
import { ListFeedDto } from './dto/list-feed.dto';
import { SearchPostsDto } from './dto/search-posts.dto';
import { VotePollDto } from './dto/vote-poll.dto';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';

@Controller('feed')
// Every route is guarded. Creating a post was previously open, and took the
// author from the request body, so any caller could post as any user simply by
// naming them. Reading was open too, which made the whole feed scrapeable
// without an account.
@UseGuards(AuthGuard)
export class FeedController {
  constructor(private readonly svc: FeedService) {}

  @Post('posts')
  create(@Req() req: AuthRequest, @Body() dto: CreatePostDto) {
    // The author is the verified token's subject, never a field of the body.
    //
    // Named field by field rather than spread, so nothing the body carries can
    // reach the service unless it is meant to. The cost of that is a field
    // going missing in silence, which is what happened to the poll: it was
    // validated, dropped here, and the post was written without it.
    return this.svc.createPost(req.user.id, {
      content: dto.content,
      media: dto.media,
      quotedPostId: dto.quotedPostId,
      replyPolicy: dto.replyPolicy,
      poll: dto.poll,
    });
  }

  @Get('recent')
  recent(@Req() req: AuthRequest, @Query() query: ListFeedDto) {
    return this.svc.listRecent(req.user.id, query.limit, query.cursor);
  }

  /** Vote in a post's poll. One vote per person, enforced by the database. */
  @Post('posts/:id/poll/vote')
  vote(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() body: VotePollDto,
  ) {
    return this.svc.voteOnPoll(req.user.id, id, body.optionId);
  }

  /** Post search: words, an account, a date range, an attachment kind. */
  @Get('search')
  searchPosts(@Req() req: AuthRequest, @Query() query: SearchPostsDto) {
    return this.svc.searchPosts(
      req.user.id,
      {
        q: query.q,
        from: query.from,
        after: query.after,
        before: query.before,
        has: query.has,
      },
      query.limit,
      query.cursor,
    );
  }

  /** Posts from the accounts you follow. The top bar's Following tab. */
  @Get('following')
  following(@Req() req: AuthRequest, @Query() query: ListFeedDto) {
    return this.svc.listFollowing(req.user.id, query.limit, query.cursor);
  }

  /** Posts carrying a video. The top bar's Videos tab. */
  @Get('videos')
  videos(@Req() req: AuthRequest, @Query() query: ListFeedDto) {
    return this.svc.listVideos(req.user.id, query.limit, query.cursor);
  }

  /** One account's posts -- what a profile screen's Posts tab reads. */
  @Get('users/:userId/posts')
  byAuthor(
    @Req() req: AuthRequest,
    @Param('userId', ParseUUIDPipe) userId: string,
    @Query() query: ListFeedDto,
  ) {
    return this.svc.listByAuthor(
      userId,
      req.user.id,
      query.limit,
      query.cursor,
      query.has,
    );
  }

  /** Your liked posts. Always your own -- there is no id in the path. */
  @Get('liked')
  liked(@Req() req: AuthRequest, @Query() query: ListFeedDto) {
    return this.svc.listLiked(req.user.id, query.limit, query.cursor);
  }

  /** Your saved posts. Saves are private, so likewise only ever your own. */
  @Get('saved')
  saved(@Req() req: AuthRequest, @Query() query: ListFeedDto) {
    return this.svc.listSaved(req.user.id, query.limit, query.cursor);
  }

  /** One post on its own, for the screen that shows it with its thread. */
  @Get('posts/:id')
  post(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.getPost(id, req.user.id);
  }

  @Get('posts/:id/comments')
  comments(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Query() query: ListFeedDto,
  ) {
    return this.svc.listComments(id, req.user.id, query.limit, query.cursor);
  }

  @Post('posts/:id/comments')
  addComment(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: CreateCommentDto,
  ) {
    // The author is the token's subject, exactly as it is for a post.
    return this.svc.addComment(
      id,
      req.user.id,
      dto.content,
      dto.parentId,
      dto.media,
    );
  }

  @Get('comments/:id/replies')
  replies(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Query() query: ListFeedDto,
  ) {
    return this.svc.listReplies(id, req.user.id, query.limit, query.cursor);
  }

  @Delete('comments/:id')
  async removeComment(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
  ) {
    await this.svc.deleteComment(req.user.id, id);
    return { ok: true };
  }

  /** Records that this reader opened the post. Idempotent per reader. */
  @Put('posts/:id/view')
  async view(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    await this.svc.recordView(id, req.user.id);
    return { ok: true };
  }

  /** How a post is doing. Answers 404 to anyone but its author. */
  @Get('posts/:id/analytics')
  analytics(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.analytics(id, req.user.id);
  }

  @Put('posts/:id/like')
  like(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setLiked(req.user.id, id, true);
  }

  @Delete('posts/:id/like')
  unlike(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setLiked(req.user.id, id, false);
  }

  @Put('posts/:id/repost')
  repost(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setReposted(req.user.id, id, true);
  }

  @Delete('posts/:id/repost')
  unrepost(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setReposted(req.user.id, id, false);
  }

  /** Posts carrying a hashtag. The tag may be given with or without its #. */
  @Get('tags/:tag')
  byHashtag(
    @Req() req: AuthRequest,
    @Param('tag') tag: string,
    @Query() query: ListFeedDto,
  ) {
    return this.svc.listByHashtag(tag, req.user.id, query.limit, query.cursor);
  }

  @Put('posts/:id/save')
  save(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setSaved(req.user.id, id, true);
  }

  @Delete('posts/:id/save')
  unsave(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setSaved(req.user.id, id, false);
  }

  @Patch('posts/:id/reply-policy')
  replyPolicy(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: ReplyPolicyDto,
  ) {
    return this.svc.setReplyPolicy(req.user.id, id, dto.replyPolicy);
  }

  @Delete('posts/:id')
  async remove(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
  ) {
    await this.svc.deletePost(req.user.id, id);
    return { ok: true };
  }
}
