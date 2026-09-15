import { Module } from '@nestjs/common';
import { FeedbackController } from './feedback.controller';
import { FeedbackService } from './feedback.service';
import { SupabaseTokenModule } from '../auth/supabase-token.module';

/**
 * SupabaseTokenModule because the controller is behind AuthGuard, which
 * injects the token service. A guarded controller in a module that does not
 * import it type-checks, builds, passes every unit test, and then fails at
 * boot.
 */
@Module({
  imports: [SupabaseTokenModule],
  controllers: [FeedbackController],
  providers: [FeedbackService],
  exports: [FeedbackService],
})
export class FeedbackModule {}
