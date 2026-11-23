import 'reflect-metadata';
import { Test } from '@nestjs/testing';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { FinancialOperationsController } from './financial-operations.controller';
import { FinancialOperationsGuard } from './financial-operations.guard';
import { CreatorWithdrawalsService } from './creator-withdrawals.service';
import { PayoutOperationsService } from './payout-operations.service';

describe('FinancialOperationsController', () => {
  const getOperationalReportForOperator = jest.fn();
  const requestManualReview = jest.fn();
  const resolveManualReview = jest.fn();
  const reprocessUnmatchedProviderEvent = jest.fn();
  const requestApproval = jest.fn();
  const approve = jest.fn();
  const getSubmissionReadinessForOperator = jest.fn();

  const request = {
    user: { id: 'admin-1' },
    aal: 'aal2',
  } as AuthRequest;

  const controller = async () => {
    const module = await Test.createTestingModule({
      controllers: [FinancialOperationsController],
      providers: [
        {
          provide: PayoutOperationsService,
          useValue: {
            getOperationalReportForOperator,
            requestManualReview,
            resolveManualReview,
            reprocessUnmatchedProviderEvent,
          },
        },
        {
          provide: CreatorWithdrawalsService,
          useValue: {
            requestApproval,
            approve,
            getSubmissionReadinessForOperator,
          },
        },
      ],
    })
      .overrideGuard(AuthGuard)
      .useValue({ canActivate: () => true })
      .overrideGuard(FinancialOperationsGuard)
      .useValue({ canActivate: () => true })
      .compile();

    return module.get(FinancialOperationsController);
  };

  beforeEach(() => {
    jest.clearAllMocks();
    getOperationalReportForOperator.mockResolvedValue({ staleAttemptCount: 0 });
    requestManualReview.mockResolvedValue({ status: 'REVIEW_REQUESTED' });
    resolveManualReview.mockResolvedValue({ status: 'RESOLVED' });
    reprocessUnmatchedProviderEvent.mockResolvedValue({ status: 'PAID' });
    requestApproval.mockResolvedValue({ status: 'REQUESTED' });
    approve.mockResolvedValue({ status: 'APPROVED' });
    getSubmissionReadinessForOperator.mockResolvedValue({ ready: false, blockers: [] });
  });

  it('applies token authentication before financial access control', () => {
    const guards: unknown = Reflect.getMetadata(
      '__guards__',
      FinancialOperationsController,
    );

    expect(guards).toEqual([AuthGuard, FinancialOperationsGuard]);
  });

  it('audits report reads under the authenticated actor', async () => {
    const instance = await controller();
    await instance.report(request, {
      staleAfterMinutes: 30,
      limit: 25,
    });

    expect(getOperationalReportForOperator).toHaveBeenCalledWith(
      {
        staleAfterMinutes: 30,
        limit: 25,
      },
      'admin-1',
    );
  });

  it('uses the authenticated actor for manual reviews', async () => {
    const instance = await controller();
    await instance.requestManualReview(
      request,
      '11111111-1111-4111-8111-111111111111',
      {
        requestId: 'review-request-01',
        reasonCode: 'UNKNOWN_PROVIDER_OUTCOME',
      },
    );

    expect(requestManualReview).toHaveBeenCalledWith({
      payoutAttemptId: '11111111-1111-4111-8111-111111111111',
      actorId: 'admin-1',
      requestId: 'review-request-01',
      reasonCode: 'UNKNOWN_PROVIDER_OUTCOME',
    });
  });

  it('uses the authenticated actor when resolving reviews', async () => {
    const instance = await controller();
    await instance.resolveManualReview(
      request,
      '11111111-1111-4111-8111-111111111111',
      {
        requestId: 'review-request-01',
        resolutionCode: 'NO_ACTION_REQUIRED',
      },
    );

    expect(resolveManualReview).toHaveBeenCalledWith({
      payoutAttemptId: '11111111-1111-4111-8111-111111111111',
      actorId: 'admin-1',
      requestId: 'review-request-01',
      resolutionCode: 'NO_ACTION_REQUIRED',
    });
  });

  it('uses the authenticated actor when replaying evidence', async () => {
    const instance = await controller();
    await instance.reprocessProviderEvent(
      request,
      '22222222-2222-4222-8222-222222222222',
      {
        requestId: 'provider-replay-01',
      },
    );

    expect(reprocessUnmatchedProviderEvent).toHaveBeenCalledWith({
      providerEventId: '22222222-2222-4222-8222-222222222222',
      actorId: 'admin-1',
      requestId: 'provider-replay-01',
    });
  });
  it('requests dual-control approval under the authenticated actor', async () => {
    const instance = await controller();
    await instance.requestWithdrawalApproval(
      request,
      '33333333-3333-4333-8333-333333333333',
      { requestId: 'withdrawal-approval-01' },
    );

    expect(requestApproval).toHaveBeenCalledWith({
      withdrawalId: '33333333-3333-4333-8333-333333333333',
      actorId: 'admin-1',
      requestId: 'withdrawal-approval-01',
    });
  });

  it('approves using the authenticated second administrator', async () => {
    const instance = await controller();
    await instance.approveWithdrawal(
      request,
      '33333333-3333-4333-8333-333333333333',
      { requestId: 'withdrawal-approval-01' },
    );

    expect(approve).toHaveBeenCalledWith(
      '33333333-3333-4333-8333-333333333333',
      'admin-1',
      'withdrawal-approval-01',
    );
  });

  it('reads payout submission readiness under the authenticated actor', async () => {
    const instance = await controller();
    await instance.submissionReadiness(
      request,
      '33333333-3333-4333-8333-333333333333',
    );

    expect(getSubmissionReadinessForOperator).toHaveBeenCalledWith(
      '33333333-3333-4333-8333-333333333333',
      'admin-1',
    );
  });
});
