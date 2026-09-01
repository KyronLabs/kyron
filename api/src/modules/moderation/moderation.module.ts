import { Global, Module } from '@nestjs/common';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { ModerationController } from './moderation.controller';
import { ModerationService } from './moderation.service';

// Global, because FeedService needs filtersFor on every listing and importing
// the module into each consumer is the same thing said three times.
@Global()
@Module({
  // SupabaseTokenService is what AuthGuard uses to verify access tokens;
  // without it in scope Nest cannot construct the guard on this controller.
  imports: [SupabaseTokenModule],
  controllers: [ModerationController],
  providers: [ModerationService],
  exports: [ModerationService],
})
export class ModerationModule {}
