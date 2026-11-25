import {
  Controller,
  Get,
  Headers,
  HttpCode,
  NotFoundException,
  Post,
  UseGuards,
} from '@nestjs/common';
import { createHash, timingSafeEqual } from 'node:crypto';
import { AuthGuard } from '../../common/guards/auth.guard';
import { FinancialOperationsGuard } from '../financial-ledger/financial-operations.guard';
import { GooglePlayRecoveryService } from './google-play-recovery.service';

export function requireRecoveryKey(key: string | undefined): void {
  const expected = process.env.GOOGLE_PLAY_RECOVERY_CRON_KEY;
  if (
    !expected ||
    expected.length < 32 ||
    typeof key !== 'string' ||
    key.length > 512 ||
    !timingSafeEqual(
      createHash('sha256').update(key).digest(),
      createHash('sha256').update(expected).digest(),
    )
  ) {
    throw new NotFoundException();
  }
}

@Controller('internal/google-play/void-recovery')
export class GooglePlayRecoveryController {
  constructor(private readonly recovery: GooglePlayRecoveryService) {}

  @Post()
  @HttpCode(200)
  run(@Headers('x-recovery-key') key: string | undefined) {
    requireRecoveryKey(key);
    return this.recovery.runPage();
  }
}

@Controller('financial-operations/google-play/void-recovery')
@UseGuards(AuthGuard, FinancialOperationsGuard)
export class GooglePlayRecoveryOperationsController {
  constructor(private readonly recovery: GooglePlayRecoveryService) {}

  @Get()
  status() {
    return this.recovery.status();
  }
}
