import { Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { GiftsController } from './gifts.controller';
import { GiftsService } from './gifts.service';

@Module({
  // AuthGuard needs SupabaseTokenService in scope to be constructible.
  imports: [SupabaseTokenModule],
  controllers: [GiftsController],
  providers: [GiftsService],
})
export class GiftsModule {}
