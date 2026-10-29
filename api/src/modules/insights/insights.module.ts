import { Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { InsightsController } from './insights.controller';
import { InsightsService } from './insights.service';

@Module({
  imports: [SupabaseTokenModule],
  controllers: [InsightsController],
  providers: [InsightsService],
})
export class InsightsModule {}
