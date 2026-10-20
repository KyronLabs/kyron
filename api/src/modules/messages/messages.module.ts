import { Module } from '@nestjs/common';
import { MessagesController } from './messages.controller';
import { MessagesService } from './messages.service';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';
import { PresenceService } from './presence.service';
import { WallpapersService } from './wallpapers.service';
import { KeySharesService } from './key-shares.service';
import { GroupsService } from './groups.service';
import { ViewOnceService } from './view-once.service';

@Module({
  // AuthGuard needs SupabaseTokenService in scope to be constructible.
  // Storage, for the wallpaper folder.
  imports: [SupabaseTokenModule, SupabaseModule],
  controllers: [MessagesController],
  providers: [
    MessagesService,
    PresenceService,
    WallpapersService,
    KeySharesService,
    GroupsService,
    ViewOnceService,
  ],
  exports: [MessagesService],
})
export class MessagesModule {}
