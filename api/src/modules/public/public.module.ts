import { Module } from '@nestjs/common';

import { PublicController } from './public.controller';
import { PublicService } from './public.service';

/** No SupabaseTokenModule: nothing here is behind a guard. */
@Module({
  controllers: [PublicController],
  providers: [PublicService],
})
export class PublicModule {}
