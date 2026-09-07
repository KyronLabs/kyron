import { Global, Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { RealtimeGateway } from './realtime.gateway';
import { RealtimeService } from './realtime.service';

/**
 * Global, because the modules that need to say something happened -- messages,
 * the feed, follows -- should not each have to import a transport.
 */
@Global()
@Module({
  imports: [SupabaseTokenModule],
  providers: [RealtimeGateway, RealtimeService],
  exports: [RealtimeService],
})
export class RealtimeModule {}
