import { Module } from '@nestjs/common';

import { LedgerService } from './ledger.service';
import { CreatorEarningsService } from './creator-earnings.service';

@Module({
  providers: [LedgerService, CreatorEarningsService],
  exports: [LedgerService, CreatorEarningsService],
})
export class FinancialLedgerModule {}
