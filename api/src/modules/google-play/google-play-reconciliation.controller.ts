import {
  Body,
  Controller,
  Get,
  HttpCode,
  Param,
  ParseUUIDPipe,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { IsEnum, IsOptional, IsUUID } from 'class-validator';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { FinancialOperationsGuard } from '../financial-ledger/financial-operations.guard';
import {
  ChargebackReviewDecision,
  GooglePlayReconciliationService,
} from './google-play-reconciliation.service';

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

export class GooglePlayChargebackReviewDto {
  @IsEnum(ChargebackReviewDecision)
  decision!: ChargebackReviewDecision;
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

  @Post(':id/review')
  @HttpCode(200)
  review(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() body: GooglePlayChargebackReviewDto,
    @Req() request: AuthRequest,
  ) {
    return this.reconciliation.reviewChargebackEvidence(
      id,
      request.user.id,
      body.decision,
    );
  }
}

export class GooglePlayRecoveryNoticeDto {
  @IsUUID()
  noticeId!: string;
}

export class GooglePlayPostRecoveryDto extends GooglePlayRecoveryNoticeDto {
  @IsUUID()
  requestId!: string;
}

@Controller('financial-operations/google-play/purchases')
@UseGuards(AuthGuard, FinancialOperationsGuard)
export class GooglePlayRefundReversalController {
  constructor(
    private readonly reconciliation: GooglePlayReconciliationService,
  ) {}

  @Get(':id/reversal-preview')
  preview(@Param('id', ParseUUIDPipe) id: string) {
    return this.reconciliation.previewRefundReversal(id);
  }
  @Post(':id/recover')
  @HttpCode(200)
  recover(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() body: GooglePlayPostRecoveryDto,
    @Req() request: AuthRequest,
  ) {
    return this.reconciliation.recoverVerifiedRefund(
      id,
      request.user.id,
      body.requestId,
      body.noticeId,
    );
  }

  @Post(':id/recoveries/:recoveryId/correct')
  @HttpCode(200)
  correct(
    @Param('id', ParseUUIDPipe) id: string,
    @Param('recoveryId', ParseUUIDPipe) recoveryId: string,
    @Body() body: GooglePlayRecoveryNoticeDto,
    @Req() request: AuthRequest,
  ) {
    return this.reconciliation.correctRefundRecovery(
      id,
      recoveryId,
      request.user.id,
      body.noticeId,
    );
  }
}
