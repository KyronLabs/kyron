import { Transform, Type } from 'class-transformer';
import {
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Matches,
  Max,
  MaxLength,
  Min,
} from 'class-validator';
import {
  PAYOUT_MANUAL_REVIEW_REASON_CODES,
  PAYOUT_MANUAL_REVIEW_RESOLUTION_CODES,
  type PayoutManualReviewReasonCode,
  type PayoutManualReviewResolutionCode,
} from './payout-operations.service';

const trimmed = ({ value }: { value: unknown }) =>
  typeof value === 'string' ? value.trim() : value;

/**
 * Report bounds are explicit and capped so an operator cannot accidentally
 * request an unbounded scan of payout history.
 */
export class PayoutOperationsReportQueryDto {
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(10_080)
  staleAfterMinutes?: number;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(500)
  limit?: number;
}

/** Idempotent request for a human review of an unresolved attempt. */
export class RequestPayoutManualReviewDto {
  @IsString()
  @Transform(trimmed)
  @Matches(/^[A-Za-z0-9][A-Za-z0-9._:-]{7,159}$/)
  requestId!: string;

  @IsIn([...PAYOUT_MANUAL_REVIEW_REASON_CODES])
  reasonCode!: PayoutManualReviewReasonCode;
}

/** Close one previously opened review without changing financial state. */
export class ResolvePayoutManualReviewDto {
  @IsString()
  @Transform(trimmed)
  @Matches(/^[A-Za-z0-9][A-Za-z0-9._:-]{7,159}$/)
  requestId!: string;

  @IsIn([...PAYOUT_MANUAL_REVIEW_RESOLUTION_CODES])
  resolutionCode!: PayoutManualReviewResolutionCode;
}

/** Idempotent operational request to replay stored terminal provider evidence. */
export class ReprocessPayoutProviderEventDto {
  @IsString()
  @Transform(trimmed)
  @Matches(/^[A-Za-z0-9][A-Za-z0-9._:-]{7,159}$/)
  requestId!: string;
}
