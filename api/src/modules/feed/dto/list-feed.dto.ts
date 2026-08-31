import { Transform } from 'class-transformer';
import { IsInt, IsOptional, IsUUID, Max, Min } from 'class-validator';

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
}
