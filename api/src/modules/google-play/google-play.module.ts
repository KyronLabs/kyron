import { Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { FinancialLedgerModule } from '../financial-ledger/financial-ledger.module';
import { GooglePlayPurchasesController } from './google-play-purchases.controller';
import { GooglePlayDeveloperApiProvider } from './google-play-developer-api.provider';
import { GooglePlayPurchasesService } from './google-play-purchases.service';
import { GooglePlayNotificationsController } from './google-play-notifications.controller';
import {
  GooglePlayNotificationAuth,
  GooglePlayNotificationsService,
} from './google-play-notifications.service';

@Module({
  imports: [SupabaseTokenModule, FinancialLedgerModule],
  controllers: [
    GooglePlayPurchasesController,
    GooglePlayNotificationsController,
  ],
  providers: [
    GooglePlayDeveloperApiProvider,
    GooglePlayPurchasesService,
    GooglePlayNotificationAuth,
    GooglePlayNotificationsService,
  ],
  exports: [GooglePlayPurchasesService],
})
export class GooglePlayModule {}
