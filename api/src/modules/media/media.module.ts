import { Module } from '@nestjs/common';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { MediaController } from './media.controller';
import { MediaService } from './media.service';

@Module({
  imports: [
    // MediaService uploads through SupabaseService. SupabaseModule is not
    // global, so without this import Nest cannot construct MediaService and
    // the whole application fails to start.
    SupabaseModule,
    // SupabaseTokenService is what AuthGuard uses to verify access tokens;
    // without it in scope Nest cannot construct the guard on this controller.
    SupabaseTokenModule,
  ],
  controllers: [MediaController],
  providers: [MediaService],
  exports: [MediaService],
})
export class MediaModule {}
