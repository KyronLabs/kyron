import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { FeedService } from './feed.service';
import { CreatePostDto } from './dto/create-post.dto';
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
  recent(@Query() query: ListFeedDto) {
    return this.svc.listRecent(query.limit, query.cursor);
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
