import { Module } from '@nestjs/common';
import { HealthController } from './health.controller';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';

@Module({
  imports: [SupabaseTokenModule, SupabaseModule],
  controllers: [HealthController],
  // PrismaService comes from the @Global() PrismaModule.
  providers: [],
  exports: [],
})
export class CommonModule {}
