import { Module } from '@nestjs/common';
import { HealthController } from './health.controller';
import { SupabaseTokenModule } from '../auth/supabase-token.module';

@Module({
  imports: [SupabaseTokenModule],
  controllers: [HealthController],
  providers: [],
  exports: [],
})
export class CommonModule {}
