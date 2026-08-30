import { Module } from '@nestjs/common';
import { ProfileService } from './profile.service';
import { ProfileController } from './profile.controller';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { JwtModule } from '@nestjs/jwt';
import { SupabaseTokenService } from '../auth/supabase-token.service';

@Module({
  imports: [
    SupabaseModule,
    JwtModule.register({}), // Makes JwtService available to AuthGuard
  ],
  controllers: [ProfileController],
  // SupabaseTokenService is what AuthGuard uses to verify Supabase access
  // tokens; without it here Nest cannot construct the guard.
  providers: [ProfileService, PrismaService, SupabaseTokenService],
  exports: [ProfileService],
})
export class ProfileModule {}
