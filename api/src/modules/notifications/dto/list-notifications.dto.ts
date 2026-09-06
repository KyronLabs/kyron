import { Transform } from 'class-transformer';
import { IsIn, IsInt, IsISO8601, IsOptional, Max, Min } from 'class-validator';

export const NOTIFICATION_KINDS = [
  'like',
  'comment',
  'follow',
  'repost',
] as const;

export class ListNotificationsDto {
  /** The timestamp of the last row of the previous page. */
  @IsOptional()
  @IsISO8601({}, { message: 'cursor must come from a previous page.' })
  cursor?: string;

  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(50)
  limit?: number;

  /** The Likes, Comments and Follows tabs. Narrowed by the server. */
  @IsOptional()
  @IsIn(NOTIFICATION_KINDS, {
    message: `kind must be one of ${NOTIFICATION_KINDS.join(', ')}.`,
  })
  kind?: (typeof NOTIFICATION_KINDS)[number];
}
