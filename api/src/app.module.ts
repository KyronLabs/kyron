import { Module } from '@nestjs/common';
import { GatewayModule } from './modules/gateway/gateway.module';
import { FeedModule } from './modules/feed/feed.module';
import { MediaModule } from './modules/media/media.module';
import { IdentityModule } from './modules/identity/identity.module';
import { CommonModule } from './modules/common/common.module';
import { PrismaModule } from './infrastructure/prisma/prisma.module';
import { AppConfigModule } from './config/config.module';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';

@Module({
  imports: [
    AppConfigModule,
    PrismaModule,
    CommonModule,
    IdentityModule,
    MediaModule,
    FeedModule,
    GatewayModule,
    UsersModule,
    AuthModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
