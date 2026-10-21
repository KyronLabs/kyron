import { Module } from '@nestjs/common';
import { CommunitiesController } from './communities.controller';
import { CommunitiesService } from './communities.service';
import {
  CommunityChatListController,
  CommunityChatsController,
} from './community-chats.controller';
import { CommunityChatsService } from './community-chats.service';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { FeedModule } from '../feed/feed.module';

@Module({
  // AuthGuard needs SupabaseTokenService in scope to be constructible; the
  // feed is where a community's posts are read from and written to.
  imports: [SupabaseTokenModule, FeedModule],
  controllers: [
    CommunitiesController,
    CommunityChatListController,
    CommunityChatsController,
  ],
  providers: [CommunitiesService, CommunityChatsService],
  exports: [CommunitiesService],
})
export class CommunitiesModule {}
