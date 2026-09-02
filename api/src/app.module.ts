import { Module } from '@nestjs/common';
import { GatewayModule } from './modules/gateway/gateway.module';
import { FeedModule } from './modules/feed/feed.module';
import { MediaModule } from './modules/media/media.module';
import { ModerationModule } from './modules/moderation/moderation.module';
import { IdentityModule } from './modules/identity/identity.module';
import { CommonModule } from './modules/common/common.module';
import { PrismaModule } from './infrastructure/prisma/prisma.module';
import { AppConfigModule } from './config/config.module';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
import { ProfileModule } from './modules/profile/profile.module';
import { LinksModule } from './modules/links/links.module';

@Module({
  imports: [
    AppConfigModule,
    PrismaModule,
    CommonModule,
    IdentityModule,
    MediaModule,
    FeedModule,
    ModerationModule,
    GatewayModule,
    UsersModule,
    AuthModule,
    ProfileModule,
    LinksModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
