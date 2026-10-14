import { Module } from '@nestjs/common';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { AccountController } from './account.controller';
import { AccountService } from './account.service';

@Module({
  imports: [
    SupabaseModule,
    // What AuthGuard verifies access tokens with.
    SupabaseTokenModule,
  ],
  controllers: [AccountController],
  // PrismaService comes from the @Global() PrismaModule.
  providers: [AccountService],
})
export class AccountModule {}
