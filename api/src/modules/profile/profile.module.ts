import { Module } from '@nestjs/common';
import { ProfileService } from './profile.service';
import { ProfileController } from './profile.controller';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';
import { JwtModule } from '@nestjs/jwt';
import { SupabaseTokenModule } from '../auth/supabase-token.module';

@Module({
  imports: [
    SupabaseModule,
    // SupabaseTokenService is what AuthGuard uses to verify Supabase access
    // tokens; without it in scope Nest cannot construct the guard.
    SupabaseTokenModule,
    JwtModule.register({}), // Makes JwtService available to AuthGuard
  ],
  controllers: [ProfileController],
  // PrismaService comes from the @Global() PrismaModule.
  providers: [ProfileService],
  exports: [ProfileService],
})
export class ProfileModule {}
