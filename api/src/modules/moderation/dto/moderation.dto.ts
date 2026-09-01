import { Transform } from 'class-transformer';
import {
  IsEnum,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
  MinLength,
} from 'class-validator';
import { InterestKind, ReportReason, ReportTarget } from '@prisma/client';

export class MutePhraseDto {
  @IsString()
  @Transform(({ value }: { value: unknown }) =>
    typeof value === 'string' ? value.trim() : value,
  )
  @MinLength(2, { message: 'A muted word needs at least two characters.' })
  @MaxLength(60)
  phrase!: string;
}

export class InterestDto {
  @IsEnum(InterestKind, { message: 'kind must be MORE or LESS.' })
  kind!: InterestKind;
}

export class CreateReportDto {
  @IsEnum(ReportTarget, { message: 'target must be POST, COMMENT or USER.' })
  target!: ReportTarget;

  @IsUUID('4', { message: 'targetId must be an id.' })
  targetId!: string;

  @IsEnum(ReportReason, { message: 'That is not a reason we recognise.' })
  reason!: ReportReason;

  /** What the reporter wants to add in their own words. */
  @IsOptional()
  @IsString()
  @Transform(({ value }: { value: unknown }) =>
    typeof value === 'string' ? value.trim() : value,
  )
  @MaxLength(1000)
  detail?: string;
}
