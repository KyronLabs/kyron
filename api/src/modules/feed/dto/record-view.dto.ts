import { Type } from 'class-transformer';
import { IsInt, IsOptional, Min } from 'class-validator';

export class RecordViewDto {
  /**
   * How long the reader stayed, in milliseconds, sent when the post leaves
   * the screen. Absent on the way in, which is the call that records the open
   * itself.
   *
   * There is no upper bound here on purpose. A ceiling in validation would
   * answer 400 to a phone that was locked mid-post, which is a normal thing
   * for a phone to do and not something the reader should see an error for;
   * the service clamps it instead.
   */
  @IsOptional()
  @Type(() => Number)
  @IsInt({ message: 'dwellMs must be a whole number of milliseconds.' })
  @Min(0, { message: 'dwellMs cannot be negative.' })
  dwellMs?: number;
}
