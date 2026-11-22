import { Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { RewardsController } from './rewards.controller';
import { RewardsService } from './rewards.service';

@Module({
  imports: [SupabaseTokenModule],
  controllers: [RewardsController],
  providers: [RewardsService],
  exports: [RewardsService],
})
export class RewardsModule {}
