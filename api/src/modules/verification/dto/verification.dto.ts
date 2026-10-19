import { Transform } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  IsBoolean,
  IsEnum,
  IsOptional,
  IsString,
  IsUrl,
  MaxLength,
  MinLength,
} from 'class-validator';
import { VerificationCategory } from '@prisma/client';

const trimmed = ({ value }: { value: unknown }) =>
  typeof value === 'string' ? value.trim() : value;

/** Asking for the badge. */
export class ApplyDto {
  @IsEnum(VerificationCategory, {
    message:
      'category is CREATOR, PUBLIC_FIGURE, JOURNALIST, ORGANISATION or OTHER.',
  })
  category!: VerificationCategory;

  /**
   * Who they are. Long enough to say something the reviewer can check:
   * "it's me" gives them nothing to look for.
   */
  @IsString()
  @Transform(trimmed)
  @MinLength(30, {
    message: 'Say who you are in a sentence or two, at least 30 characters.',
  })
  @MaxLength(1000)
  about!: string;

  /**
   * Where the reviewer can check it: a site, or another profile, that says
   * this Kyron account is yours.
   */
  @IsArray()
  @ArrayMinSize(1, { message: 'Give at least one link we can check.' })
  @ArrayMaxSize(3, { message: 'Three links at most.' })
  @Transform(({ value }: { value: unknown }): unknown =>
    Array.isArray(value)
      ? value.map((v: unknown) => (typeof v === 'string' ? v.trim() : v))
      : value,
  )
  @IsUrl(
    { protocols: ['https', 'http'], require_protocol: true },
    { each: true, message: 'Each link must be a full web address.' },
  )
  @MaxLength(300, { each: true })
  links!: string[];
}

/** The team's answer to a request. */
export class DecideVerificationDto {
  @IsBoolean({ message: 'approve is true or false.' })
  approve!: boolean;

  /** What the account is told. Required when the answer is no. */
  @IsOptional()
  @IsString()
  @Transform(trimmed)
  @MaxLength(1000)
  response?: string;
}

/** Giving or taking the badge without a request. */
export class SetVerifiedDto {
  @IsBoolean({ message: 'verified is true or false.' })
  verified!: boolean;

  @IsString()
  @Transform(trimmed)
  @MinLength(10, { message: 'Say why, in at least a few words.' })
  @MaxLength(1000)
  reason!: string;
}
