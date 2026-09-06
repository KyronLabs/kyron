import { Module } from '@nestjs/common';
import { FeedService } from './feed.service';
import { RankingService } from './ranking.service';
import { FeedController } from './feed.controller';
import { SupabaseTokenModule } from '../auth/supabase-token.module';

@Module({
  // AuthGuard needs SupabaseTokenService in scope to be constructible.
  imports: [SupabaseTokenModule],
  controllers: [FeedController],
  providers: [FeedService, RankingService],
  exports: [FeedService],
})
export class FeedModule {}
