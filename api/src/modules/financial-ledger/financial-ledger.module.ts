import { Module } from '@nestjs/common';

import { LedgerService } from './ledger.service';
import { CreatorEarningsService } from './creator-earnings.service';
import { DisabledPayoutWebhookProvider, PayoutReconciliationService, PayoutWebhookProvider } from './payout-reconciliation.service';
import {
  BankPayoutProvider,
  CreatorWithdrawalsService,
  DisabledBankPayoutProvider,
  DisabledFxQuoteProvider,
  FxQuoteProvider,
} from './creator-withdrawals.service';

@Module({
  providers: [
    LedgerService,
    CreatorEarningsService,
    CreatorWithdrawalsService,
    PayoutReconciliationService,
    DisabledPayoutWebhookProvider,
    { provide: PayoutWebhookProvider, useExisting: DisabledPayoutWebhookProvider },
    DisabledFxQuoteProvider,
    DisabledBankPayoutProvider,
    { provide: FxQuoteProvider, useExisting: DisabledFxQuoteProvider },
    { provide: BankPayoutProvider, useExisting: DisabledBankPayoutProvider },
  ],
  exports: [LedgerService, CreatorEarningsService, CreatorWithdrawalsService, PayoutReconciliationService],
})
export class FinancialLedgerModule {}
