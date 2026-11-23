import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import {
  CreatorWithdrawalApprovalDto,
  PayoutOperationsReportQueryDto,
  ReprocessPayoutProviderEventDto,
  RequestPayoutManualReviewDto,
  ResolvePayoutManualReviewDto,
} from './financial-operations.dto';

describe('financial operations DTOs', () => {
  it('converts bounded report query parameters to numbers', async () => {
    const dto = plainToInstance(PayoutOperationsReportQueryDto, {
      staleAfterMinutes: '30',
      limit: '25',
    });

    expect(dto.staleAfterMinutes).toBe(30);
    expect(dto.limit).toBe(25);
    await expect(validate(dto)).resolves.toHaveLength(0);
  });

  it('rejects report limits outside the supported bounds', async () => {
    const dto = plainToInstance(PayoutOperationsReportQueryDto, {
      staleAfterMinutes: '0',
      limit: '501',
    });

    await expect(validate(dto)).resolves.not.toHaveLength(0);
  });

  it('accepts a valid manual-review request', async () => {
    const dto = plainToInstance(RequestPayoutManualReviewDto, {
      requestId: 'review-request-01',
      reasonCode: 'UNKNOWN_PROVIDER_OUTCOME',
    });

    await expect(validate(dto)).resolves.toHaveLength(0);
  });

  it('rejects an unknown manual-review reason', async () => {
    const dto = plainToInstance(RequestPayoutManualReviewDto, {
      requestId: 'review-request-02',
      reasonCode: 'RELEASE_FUNDS',
    });

    await expect(validate(dto)).resolves.not.toHaveLength(0);
  });

  it('requires a valid request key when resolving a review', async () => {
    const dto = plainToInstance(ResolvePayoutManualReviewDto, {
      requestId: 'bad key',
      resolutionCode: 'NO_ACTION_REQUIRED',
    });

    await expect(validate(dto)).resolves.not.toHaveLength(0);
  });

  it('validates request keys for provider-event reprocessing', async () => {
    const dto = plainToInstance(ReprocessPayoutProviderEventDto, {
      requestId: 'provider-replay-01',
    });

    await expect(validate(dto)).resolves.toHaveLength(0);
  });
  it('validates dual-control withdrawal approval request keys', async () => {
    const dto = plainToInstance(CreatorWithdrawalApprovalDto, {
      requestId: 'withdrawal-approval-01',
    });

    await expect(validate(dto)).resolves.toHaveLength(0);
  });

  it('rejects malformed dual-control approval request keys', async () => {
    const dto = plainToInstance(CreatorWithdrawalApprovalDto, {
      requestId: 'bad key',
    });

    await expect(validate(dto)).resolves.not.toHaveLength(0);
  });
});
