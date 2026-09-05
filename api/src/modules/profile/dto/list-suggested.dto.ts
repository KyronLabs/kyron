import { Transform } from 'class-transformer';
import { IsInt, IsOptional, Max, Min } from 'class-validator';

export class ListSuggestedDto {
  /**
   * How far into the ranking this page starts.
   *
   * A number rather than a row id, because the order is computed in the
   * service and not by the database: there is no row a cursor could name.
   */
  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'cursor must come from a previous page.' })
  @Min(0)
  cursor?: number;

  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(50)
  limit?: number;
}
