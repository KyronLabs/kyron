import { Transform } from 'class-transformer';
import {
  IsInt,
  IsOptional,
  IsString,
  Matches,
  Max,
  Min,
} from 'class-validator';

/**
 * A cursor is either a post id or a ranked position.
 *
 * The chronological lists page by the id of the last row they returned. The
 * ranked feed cannot: it recomputes an order per request, so an id names a
 * position that may not exist next time. Its cursor carries the session seed
 * and an offset instead -- `r<seed>-<offset>` -- and both shapes come through
 * this one field.
 */
const CURSOR =
  /^(?:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|r\d{1,10}-\d{1,7})$/i;

export class ListFeedDto {
  /** Omit for the first page. */
  @IsOptional()
  @Matches(CURSOR, {
    message: 'cursor must come from a previous page.',
  })
  cursor?: string;

  // Capped so one request cannot ask for the whole table.
  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(50)
  limit?: number;

  /**
   * Narrows an author's posts to those carrying an attachment of one kind --
   * what the profile's Media and Videos tabs read.
   *
   * Anything unrecognised is ignored rather than rejected: a newer client
   * asking for a kind this deployment does not know should get the unfiltered
   * list, not an error.
   */
  @IsOptional()
  @IsString()
  @Transform(({ value }: { value: unknown }) =>
    typeof value === 'string' ? value.trim().toLowerCase() : value,
  )
  has?: string;
}
