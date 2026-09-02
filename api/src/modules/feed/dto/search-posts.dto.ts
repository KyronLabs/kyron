import { Transform } from 'class-transformer';
import {
  IsInt,
  IsISO8601,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

/**
 * A post search, with the filters the search screen offers.
 *
 * Every filter is optional, but at least one of `q` and `from` has to be
 * present -- the service enforces that, because "everything, unfiltered" is
 * the recent feed and not a search.
 */
export class SearchPostsDto {
  @IsOptional()
  @IsString()
  @MinLength(2, { message: 'Search for at least two characters.' })
  @MaxLength(200)
  q?: string;

  /** A handle, without its leading @. Posts by this account only. */
  @IsOptional()
  @IsString()
  @MaxLength(64)
  @Transform(({ value }: { value: unknown }) =>
    typeof value === 'string' ? value.trim().replace(/^@/, '') : value,
  )
  from?: string;

  /** Posted on or after this date. */
  @IsOptional()
  @IsISO8601({}, { message: 'after must be a date.' })
  after?: string;

  /** Posted before this date. */
  @IsOptional()
  @IsISO8601({}, { message: 'before must be a date.' })
  before?: string;

  /** Only posts carrying an attachment of this kind. */
  @IsOptional()
  @IsString()
  @Transform(({ value }: { value: unknown }) =>
    typeof value === 'string' ? value.trim().toLowerCase() : value,
  )
  has?: string;

  @IsOptional()
  @IsUUID('4', { message: 'cursor must be a post id from a previous page.' })
  cursor?: string;

  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(50)
  limit?: number;
}
