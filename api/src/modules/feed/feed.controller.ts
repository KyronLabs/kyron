import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { FeedService } from './feed.service';
import { CreatePostDto } from './dto/create-post.dto';

@Controller('feed')
export class FeedController {
  constructor(private readonly svc: FeedService) {}

  @Post('posts')
  async create(@Body() dto: CreatePostDto) {
    return this.svc.createPost(dto);
  }

  @Get('recent')
  async recent(@Query('limit') limit = '20') {
    return this.svc.listRecent(Number(limit));
  }
}
