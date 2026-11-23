import { Module } from '@nestjs/common';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { FinancialOperationsController } from './financial-operations.controller';
import { FinancialOperationsGuard } from './financial-operations.guard';

import { LedgerService } from './ledger.service';
import { CreatorEarningsService } from './creator-earnings.service';
import { PayoutOperationsService } from './payout-operations.service';
import {
  DisabledPayoutWebhookProvider,
  PayoutReconciliationService,
  PayoutWebhookProvider,
} from './payout-reconciliation.service';
import {
  BankPayoutProvider,
  CreatorWithdrawalsService,
  DisabledBankPayoutProvider,
  DisabledFxQuoteProvider,
  FxQuoteProvider,
} from './creator-withdrawals.service';

@Module({
  imports: [SupabaseTokenModule],
  controllers: [FinancialOperationsController],
  providers: [
    LedgerService,
    CreatorEarningsService,
    CreatorWithdrawalsService,
    PayoutReconciliationService,
    PayoutOperationsService,
    FinancialOperationsGuard,
    DisabledPayoutWebhookProvider,
    {
      provide: PayoutWebhookProvider,
      useExisting: DisabledPayoutWebhookProvider,
    },
    DisabledFxQuoteProvider,
    DisabledBankPayoutProvider,
    { provide: FxQuoteProvider, useExisting: DisabledFxQuoteProvider },
    { provide: BankPayoutProvider, useExisting: DisabledBankPayoutProvider },
  ],
  exports: [
    LedgerService,
    CreatorEarningsService,
    CreatorWithdrawalsService,
    PayoutReconciliationService,
    PayoutOperationsService,
  ],
})
export class FinancialLedgerModule {}
