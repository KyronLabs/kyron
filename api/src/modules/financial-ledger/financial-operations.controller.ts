import {
  Body,
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { FinancialOperationsGuard } from './financial-operations.guard';
import {
  CreatorWithdrawalApprovalDto,
  PayoutOperationsReportQueryDto,
  ReprocessPayoutProviderEventDto,
  RequestPayoutManualReviewDto,
  ResolvePayoutManualReviewDto,
} from './financial-operations.dto';
import { CreatorWithdrawalsService } from './creator-withdrawals.service';
import { PayoutOperationsService } from './payout-operations.service';

/**
 * Internal financial-operations API. Authentication is verified by AuthGuard;
 * FinancialOperationsGuard then requires an ADMIN account and an AAL2 session
 * on every route, regardless of the general staff second-factor setting.
 */
@Controller('financial-operations')
@UseGuards(AuthGuard, FinancialOperationsGuard)
export class FinancialOperationsController {
  constructor(
    private readonly operations: PayoutOperationsService,
    private readonly withdrawals: CreatorWithdrawalsService,
  ) {}

  /** Read-only report of stale attempts, unmatched evidence and reviews. */
  @Get('payouts')
  report(
    @Req() request: AuthRequest,
    @Query() query: PayoutOperationsReportQueryDto,
  ) {
    return this.operations.getOperationalReportForOperator(
      query,
      request.user.id,
    );
  }

  /** Opens an auditable manual-review item for an unresolved payout attempt. */
  @Post('payout-attempts/:id/manual-review')
  requestManualReview(
    @Req() request: AuthRequest,
    @Param('id', ParseUUIDPipe) payoutAttemptId: string,
    @Body() dto: RequestPayoutManualReviewDto,
  ) {
    return this.operations.requestManualReview({
      payoutAttemptId,
      actorId: request.user.id,
      requestId: dto.requestId,
      reasonCode: dto.reasonCode,
    });
  }

  /** Closes a review without changing payout financial state. */
  @Post('payout-attempts/:id/manual-review/resolve')
  resolveManualReview(
    @Req() request: AuthRequest,
    @Param('id', ParseUUIDPipe) payoutAttemptId: string,
    @Body() dto: ResolvePayoutManualReviewDto,
  ) {
    return this.operations.resolveManualReview({
      payoutAttemptId,
      actorId: request.user.id,
      requestId: dto.requestId,
      resolutionCode: dto.resolutionCode,
    });
  }

  /**
   * Replays only an unmatched authenticated terminal event. The operations
   * service delegates to the existing reconciliation checks; no payout is
   * submitted and no new payout attempt is created.
   */
  @Post('provider-events/:id/reprocess')
  reprocessProviderEvent(
    @Req() request: AuthRequest,
    @Param('id', ParseUUIDPipe) providerEventId: string,
    @Body() dto: ReprocessPayoutProviderEventDto,
  ) {
    return this.operations.reprocessUnmatchedProviderEvent({
      providerEventId,
      actorId: request.user.id,
      requestId: dto.requestId,
    });
  }
  /** First administrator requests approval; withdrawal state is unchanged. */
  @Post('creator-withdrawals/:id/approval-request')
  requestWithdrawalApproval(
    @Req() request: AuthRequest,
    @Param('id', ParseUUIDPipe) withdrawalId: string,
    @Body() dto: CreatorWithdrawalApprovalDto,
  ) {
    return this.withdrawals.requestApproval({
      withdrawalId,
      actorId: request.user.id,
      requestId: dto.requestId,
    });
  }

  /** A different AAL2 administrator completes the approval transition. */
  @Post('creator-withdrawals/:id/approve')
  approveWithdrawal(
    @Req() request: AuthRequest,
    @Param('id', ParseUUIDPipe) withdrawalId: string,
    @Body() dto: CreatorWithdrawalApprovalDto,
  ) {
    return this.withdrawals.approve(
      withdrawalId,
      request.user.id,
      dto.requestId,
    );
  }

}
