import {
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { IsOptional, IsUUID } from 'class-validator';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { FinancialOperationsGuard } from '../financial-ledger/financial-operations.guard';
import { GooglePlayReconciliationService } from './google-play-reconciliation.service';

export class GooglePlayEvidenceListQuery {
  @IsOptional()
  @IsUUID()
  after?: string;
}

@Controller('financial-operations/google-play/notifications')
@UseGuards(AuthGuard, FinancialOperationsGuard)
export class GooglePlayReconciliationController {
  constructor(
    private readonly reconciliation: GooglePlayReconciliationService,
  ) {}

  @Get()
  list(@Query() query: GooglePlayEvidenceListQuery) {
    return this.reconciliation.listPending(query.after);
  }

  @Post(':id/reconcile')
  reconcile(
    @Param('id', ParseUUIDPipe) id: string,
    @Req() request: AuthRequest,
  ) {
    return this.reconciliation.reconcile(id, request.user.id);
  }
}

@Controller('financial-operations/google-play/chargeback-evidence')
@UseGuards(AuthGuard, FinancialOperationsGuard)
export class GooglePlayChargebackEvidenceController {
  constructor(
    private readonly reconciliation: GooglePlayReconciliationService,
  ) {}

  @Get()
  list(@Query() query: GooglePlayEvidenceListQuery) {
    return this.reconciliation.listChargebackEvidence(query.after);
  }
}
