import { Transform } from 'class-transformer';
import {
  IsIn,
  IsISO8601,
  IsObject,
  IsOptional,
  IsString,
  IsUUID,
  Matches,
  MaxLength,
  MinLength,
} from 'class-validator';
import { RewardProgramStatus } from '@prisma/client';

const trimmed = ({ value }: { value: unknown }) =>
  typeof value === 'string' ? value.trim() : value;

export class NominatePostDto {
  @IsUUID('4', { message: 'postId must be a post id.' })
  postId!: string;

  @IsString()
  @Transform(trimmed)
  @MinLength(20, {
    message: 'Explain what makes this post exceptional in at least a sentence.',
  })
  @MaxLength(1000)
  reason!: string;
}

export class CreateRewardProgramDto {
  @IsString()
  @Transform(trimmed)
  @Matches(/^[a-z0-9][a-z0-9._-]{2,63}$/, {
    message: 'key must be 3-64 lowercase letters, numbers, dots, underscores or hyphens.',
  })
  key!: string;

  @IsString()
  @Transform(trimmed)
  @MinLength(3)
  @MaxLength(100)
  name!: string;

  @IsOptional()
  @IsString()
  @Transform(trimmed)
  @MaxLength(1000)
  description?: string;

  @IsObject()
  policy!: Record<string, unknown>;

  @IsOptional()
  @IsISO8601()
  startsAt?: string;

  @IsOptional()
  @IsISO8601()
  endsAt?: string;
}

export class UpdateRewardProgramDto {
  @IsOptional()
  @IsString()
  @Transform(trimmed)
  @MinLength(3)
  @MaxLength(100)
  name?: string;

  @IsOptional()
  @IsString()
  @Transform(trimmed)
  @MaxLength(1000)
  description?: string | null;

  @IsOptional()
  @IsIn(Object.values(RewardProgramStatus))
  status?: RewardProgramStatus;

  @IsOptional()
  @IsObject()
  policy?: Record<string, unknown>;

  @IsOptional()
  @IsISO8601()
  startsAt?: string | null;

  @IsOptional()
  @IsISO8601()
  endsAt?: string | null;
}

export class DecidePostRewardNominationDto {
  @IsIn(['APPROVE', 'DECLINE'])
  decision!: 'APPROVE' | 'DECLINE';

  @IsOptional()
  @IsString()
  @Transform(trimmed)
  @MaxLength(2000)
  note?: string;
}
