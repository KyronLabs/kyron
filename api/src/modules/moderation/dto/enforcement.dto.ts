import { Transform } from 'class-transformer';
import {
  IsBoolean,
  IsEnum,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';
import { ModerationKind, ReportReason, ReportTarget } from '@prisma/client';

const trimmed = ({ value }: { value: unknown }) =>
  typeof value === 'string' ? value.trim() : value;

/** A decision about an account, and about a post or comment of its. */
export class ActDto {
  /** Whose account. Optional when [targetId] names a post or comment. */
  @IsOptional()
  @IsUUID('4', { message: 'subjectId must be an account id.' })
  subjectId?: string;

  @IsEnum(ModerationKind, {
    message: 'kind is REMOVE, WARN, SUSPEND or BAN.',
  })
  kind!: ModerationKind;

  @IsEnum(ReportReason, { message: 'That is not a rule Kyron has.' })
  rule!: ReportReason;

  /**
   * What the account is told. Required, and long enough to say something:
   * "violated rules" tells nobody what to do differently.
   */
  @IsString()
  @Transform(trimmed)
  @MinLength(20, {
    message: 'Tell them what was wrong in at least a sentence.',
  })
  @MaxLength(2000)
  message!: string;

  /** For the team only. */
  @IsOptional()
  @IsString()
  @Transform(trimmed)
  @MaxLength(2000)
  note?: string;

  @IsOptional()
  @IsIn([ReportTarget.POST, ReportTarget.COMMENT], {
    message: 'target is POST or COMMENT.',
  })
  target?: ReportTarget;

  @IsOptional()
  @IsUUID('4', { message: 'targetId must be an id.' })
  targetId?: string;

  /**
   * Whether the post or comment comes down with the decision. Default yes;
   * no is for a warning about something that can stay up.
   */
  @IsOptional()
  @IsBoolean({ message: 'removeContent is true or false.' })
  removeContent?: boolean;

  /** How long a SUSPEND lasts. */
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(365)
  days?: number;
}

/** Closing a report with nothing done. */
export class DismissDto {
  @IsEnum(ReportTarget, { message: 'target is POST, COMMENT or USER.' })
  target!: ReportTarget;

  @IsUUID('4', { message: 'targetId must be an id.' })
  targetId!: string;
}

/** Why a decision is being undone, or what an appeal's answer is. */
export class ReasonDto {
  @IsString()
  @Transform(trimmed)
  @MinLength(10, { message: 'Say why, in at least a few words.' })
  @MaxLength(2000)
  reason!: string;
}

export class DecideAppealDto {
  @IsBoolean({ message: 'overturn is true or false.' })
  overturn!: boolean;

  /** What the account is told. */
  @IsString()
  @Transform(trimmed)
  @MinLength(10, { message: 'Tell them why, in at least a few words.' })
  @MaxLength(2000)
  response!: string;
}

export class AppealDto {
  /**
   * Why the decision was wrong. Long enough that the reviewer has something
   * to weigh: "unfair" alone gives them nothing to look at again.
   */
  @IsString()
  @Transform(trimmed)
  @MinLength(20, {
    message: 'Say what was wrong with the decision, in at least a sentence.',
  })
  @MaxLength(2000)
  statement!: string;
}
