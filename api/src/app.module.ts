import { Module } from '@nestjs/common';
import { GatewayModule } from './modules/gateway/gateway.module';
import { RealtimeModule } from './modules/realtime/realtime.module';
import { PushModule } from './modules/push/push.module';
import { KeysModule } from './modules/keys/keys.module';
import { FeedModule } from './modules/feed/feed.module';
import { MessagesModule } from './modules/messages/messages.module';
import { NotificationsModule } from './modules/notifications/notifications.module';
import { CommunitiesModule } from './modules/communities/communities.module';
import { MediaModule } from './modules/media/media.module';
import { ModerationModule } from './modules/moderation/moderation.module';
import { IdentityModule } from './modules/identity/identity.module';
import { CommonModule } from './modules/common/common.module';
import { PrismaModule } from './infrastructure/prisma/prisma.module';
import { ObservabilityModule } from './infrastructure/observability/observability.module';
import { AppConfigModule } from './config/config.module';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
import { ProfileModule } from './modules/profile/profile.module';
import { LinksModule } from './modules/links/links.module';

@Module({
  imports: [
    AppConfigModule,
    ObservabilityModule,
    PrismaModule,
    CommonModule,
    IdentityModule,
    MediaModule,
    FeedModule,
    MessagesModule,
    NotificationsModule,
    CommunitiesModule,
    ModerationModule,
    GatewayModule,
    RealtimeModule,
    PushModule,
    KeysModule,
    UsersModule,
    AuthModule,
    ProfileModule,
    LinksModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
