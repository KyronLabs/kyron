import { Module } from '@nestjs/common';
import { IdentityService } from './identity.service';
import { IdentityController } from './identity.controller';
import { SupabaseTokenModule } from '../auth/supabase-token.module';

@Module({
  // AuthGuard needs the token verifier; PrismaService comes from the @Global()
  // PrismaModule.
  imports: [SupabaseTokenModule],
  controllers: [IdentityController],
  providers: [IdentityService],
  exports: [IdentityService],
})
export class IdentityModule {}
