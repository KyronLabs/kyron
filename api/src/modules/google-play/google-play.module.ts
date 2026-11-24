import { Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { FinancialLedgerModule } from '../financial-ledger/financial-ledger.module';
import { GooglePlayPurchasesController } from './google-play-purchases.controller';
import { GooglePlayDeveloperApiProvider } from './google-play-developer-api.provider';
import { GooglePlayPurchasesService } from './google-play-purchases.service';

@Module({
  imports: [SupabaseTokenModule, FinancialLedgerModule],
  controllers: [GooglePlayPurchasesController],
  providers: [GooglePlayDeveloperApiProvider, GooglePlayPurchasesService],
  exports: [GooglePlayPurchasesService],
})
export class GooglePlayModule {}
