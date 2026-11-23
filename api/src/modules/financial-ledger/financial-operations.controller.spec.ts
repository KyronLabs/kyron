import 'reflect-metadata';
import { Test } from '@nestjs/testing';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import {
  FinancialOperationsController,
} from './financial-operations.controller';
import { FinancialOperationsGuard } from './financial-operations.guard';
import { PayoutOperationsService } from './payout-operations.service';

describe('FinancialOperationsController', () => {
  const getOperationalReportForOperator = jest.fn();
  const requestManualReview = jest.fn();
  const resolveManualReview = jest.fn();
  const reprocessUnmatchedProviderEvent = jest.fn();

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
  });

  it('applies token authentication before financial access control', () => {
    const guards: unknown = Reflect.getMetadata(
      '__guards__',
      FinancialOperationsController,
    );

    expect(guards).toEqual([AuthGuard, FinancialOperationsGuard]);
  });

  it('audits report reads under the authenticated actor', async () => {
    await (await controller()).report(request, {
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
    await (await controller()).requestManualReview(
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
    await (await controller()).resolveManualReview(
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
    await (await controller()).reprocessProviderEvent(
      request,
      '22222222-2222-4222-8222-222222222222',
      { requestId: 'provider-replay-01' },
    );

    expect(reprocessUnmatchedProviderEvent).toHaveBeenCalledWith({
      providerEventId: '22222222-2222-4222-8222-222222222222',
      actorId: 'admin-1',
      requestId: 'provider-replay-01',
    });
  });
});
