import { Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { KeysController } from './keys.controller';
import { KeysService } from './keys.service';

@Module({
  imports: [SupabaseTokenModule],
  controllers: [KeysController],
  providers: [KeysService],
  exports: [KeysService],
})
export class KeysModule {}
