import { Module } from '@nestjs/common';

import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { FinancialLedgerModule } from '../financial-ledger/financial-ledger.module';
import { FinancialOperationsGuard } from '../financial-ledger/financial-operations.guard';
import { GooglePlayPurchasesController } from './google-play-purchases.controller';
import { GooglePlayDeveloperApiProvider } from './google-play-developer-api.provider';
import { GooglePlayPurchasesService } from './google-play-purchases.service';
import { GooglePlayNotificationsController } from './google-play-notifications.controller';
import {
  GooglePlayChargebackEvidenceController,
  GooglePlayReconciliationController,
} from './google-play-reconciliation.controller';
import { GooglePlayReconciliationService } from './google-play-reconciliation.service';
import {
  GooglePlayRecoveryController,
  GooglePlayRecoveryOperationsController,
} from './google-play-recovery.controller';
import { GooglePlayRecoveryService } from './google-play-recovery.service';
import {
  GooglePlayRefundWorkerController,
  GooglePlayRefundWorkerOperationsController,
} from './google-play-refund-worker.controller';
import { GooglePlayRefundWorkerService } from './google-play-refund-worker.service';
import {
  GooglePlayNotificationAuth,
  GooglePlayNotificationsService,
} from './google-play-notifications.service';

@Module({
  imports: [SupabaseTokenModule, FinancialLedgerModule],
  controllers: [
    GooglePlayPurchasesController,
    GooglePlayNotificationsController,
    GooglePlayReconciliationController,
    GooglePlayChargebackEvidenceController,
    GooglePlayRecoveryController,
    GooglePlayRecoveryOperationsController,
    GooglePlayRefundWorkerController,
    GooglePlayRefundWorkerOperationsController,
  ],
  providers: [
    GooglePlayDeveloperApiProvider,
    GooglePlayPurchasesService,
    GooglePlayNotificationAuth,
    GooglePlayNotificationsService,
    GooglePlayReconciliationService,
    GooglePlayRecoveryService,
    GooglePlayRefundWorkerService,
    FinancialOperationsGuard,
  ],
  exports: [GooglePlayPurchasesService],
})
export class GooglePlayModule {}
