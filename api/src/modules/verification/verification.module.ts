import { Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { VerificationController } from './verification.controller';
import { VerificationService } from './verification.service';

@Module({
  // SupabaseTokenService is what AuthGuard verifies access tokens with.
  imports: [SupabaseTokenModule],
  controllers: [VerificationController],
  providers: [VerificationService],
})
export class VerificationModule {}
