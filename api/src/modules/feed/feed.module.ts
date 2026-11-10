import { Module } from '@nestjs/common';
import { FeedService } from './feed.service';
import { RankingService } from './ranking.service';
import { FeedController } from './feed.controller';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';
import { DeletedMediaService } from './deleted-media.service';

@Module({
  // AuthGuard needs SupabaseTokenService in scope to be constructible.
  imports: [SupabaseTokenModule, SupabaseModule],
  controllers: [FeedController],
  providers: [FeedService, RankingService, DeletedMediaService],
  exports: [FeedService],
})
export class FeedModule {}
