import { Transform } from 'class-transformer';
import { IsInt, IsOptional, IsString, IsUUID, Max, Min } from 'class-validator';

export class ListFeedDto {
  /** Newest first; omit for the first page. */
  @IsOptional()
  @IsUUID('4', { message: 'cursor must be a post id from a previous page.' })
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
