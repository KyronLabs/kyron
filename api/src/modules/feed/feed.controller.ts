import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Put,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { FeedService } from './feed.service';
import { CreatePostDto } from './dto/create-post.dto';
import { CreateCommentDto } from './dto/create-comment.dto';
import { ListFeedDto } from './dto/list-feed.dto';
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
    return this.svc.createPost(req.user.id, dto.content);
  }

  @Get('recent')
  recent(@Req() req: AuthRequest, @Query() query: ListFeedDto) {
    return this.svc.listRecent(req.user.id, query.limit, query.cursor);
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
    return this.svc.addComment(id, req.user.id, dto.content, dto.parentId);
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

  @Put('posts/:id/save')
  save(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setSaved(req.user.id, id, true);
  }

  @Delete('posts/:id/save')
  unsave(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setSaved(req.user.id, id, false);
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
