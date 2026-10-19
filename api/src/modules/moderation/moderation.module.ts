import { Global, Module } from '@nestjs/common';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { EnforcementController } from './enforcement.controller';
import { EnforcementService } from './enforcement.service';
import { ModerationController } from './moderation.controller';
import { ModerationService } from './moderation.service';

// Global, because FeedService needs filtersFor on every listing and importing
// the module into each consumer is the same thing said three times.
@Global()
@Module({
  // SupabaseTokenService is what AuthGuard uses to verify access tokens;
  // without it in scope Nest cannot construct the guard on this controller.
  imports: [SupabaseTokenModule],
  controllers: [ModerationController, EnforcementController],
  providers: [ModerationService, EnforcementService],
  exports: [ModerationService, EnforcementService],
})
export class ModerationModule {}
