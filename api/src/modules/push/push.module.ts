import { Global, Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { ActivityPushService } from './activity-push.service';
import { DeliveryService } from './delivery.service';
import { NotificationsModule } from '../notifications/notifications.module';
import { PushController, ScheduledPushController } from './push.controller';
import { PushService } from './push.service';
import { ScheduledPushService } from './scheduled-push.service';

/**
 * Global, for the same reason RealtimeModule is: the modules that need to say
 * something happened should not each have to import a transport.
 */
@Global()
@Module({
  imports: [SupabaseTokenModule, NotificationsModule],
  controllers: [PushController, ScheduledPushController],
  providers: [
    PushService,
    DeliveryService,
    ActivityPushService,
    ScheduledPushService,
  ],
  exports: [PushService, DeliveryService],
})
export class PushModule {}
