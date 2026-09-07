import { Global, Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { DeliveryService } from './delivery.service';
import { PushController } from './push.controller';
import { PushService } from './push.service';

/**
 * Global, for the same reason RealtimeModule is: the modules that need to say
 * something happened should not each have to import a transport.
 */
@Global()
@Module({
  imports: [SupabaseTokenModule],
  controllers: [PushController],
  providers: [PushService, DeliveryService],
  exports: [PushService, DeliveryService],
})
export class PushModule {}
