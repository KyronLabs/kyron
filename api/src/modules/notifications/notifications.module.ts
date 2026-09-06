import { Module } from '@nestjs/common';
import { NotificationsController } from './notifications.controller';
import { NotificationsService } from './notifications.service';
import { SupabaseTokenModule } from '../auth/supabase-token.module';

@Module({
  // AuthGuard needs SupabaseTokenService in scope to be constructible.
  imports: [SupabaseTokenModule],
  controllers: [NotificationsController],
  providers: [NotificationsService],
  exports: [NotificationsService],
})
export class NotificationsModule {}
