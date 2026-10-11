import { Module } from '@nestjs/common';
import { HealthController } from './health.controller';
import { StatusHistoryService } from './status-history.service';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';

@Module({
  imports: [SupabaseTokenModule, SupabaseModule],
  controllers: [HealthController],
  // PrismaService comes from the @Global() PrismaModule.
  providers: [StatusHistoryService],
  exports: [],
})
export class CommonModule {}
