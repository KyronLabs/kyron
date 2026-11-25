import {
  Controller,
  Get,
  Headers,
  HttpCode,
  Post,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { FinancialOperationsGuard } from '../financial-ledger/financial-operations.guard';
import { requireRecoveryKey } from './google-play-recovery.controller';
import { GooglePlayRefundWorkerService } from './google-play-refund-worker.service';

@Controller('internal/google-play/refund-reconciliation')
export class GooglePlayRefundWorkerController {
  constructor(private readonly worker: GooglePlayRefundWorkerService) {}

  @Post()
  @HttpCode(200)
  run(@Headers('x-recovery-key') key: string | undefined) {
    requireRecoveryKey(key);
    return this.worker.runBatch();
  }
}

@Controller('financial-operations/google-play/refund-reconciliation')
@UseGuards(AuthGuard, FinancialOperationsGuard)
export class GooglePlayRefundWorkerOperationsController {
  constructor(private readonly worker: GooglePlayRefundWorkerService) {}

  @Get()
  status() {
    return this.worker.status();
  }
}
