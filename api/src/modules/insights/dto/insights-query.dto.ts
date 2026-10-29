import { Transform } from 'class-transformer';
import { IsIn, IsInt, IsOptional, Max, Min } from 'class-validator';

export class InsightsQueryDto {
  /** The period, in days: 7, 30 or 90. */
  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsIn([7, 30, 90], { message: 'days must be 7, 30 or 90.' })
  days?: number;

  /**
   * The reader's offset from UTC in minutes, east positive, so a day on the
   * chart is their day rather than Greenwich's.
   */
  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'tzOffset must be a whole number of minutes.' })
  @Min(-14 * 60)
  @Max(14 * 60)
  tzOffset?: number;
}
