import { Transform } from 'class-transformer';
import { IsIn, IsInt, IsISO8601, IsOptional, Max, Min } from 'class-validator';

export const NOTIFICATION_KINDS = [
  'like',
  'comment',
  'follow',
  'repost',
  'account',
  'report',
  'gift',
] as const;

/**
 * Rows an app has to ask for, because an app from before them reads an
 * unknown row as "Someone liked your post". Comma-separated:
 * `include=moderation,gifts`.
 */
export const NOTIFICATION_EXTRAS = ['moderation', 'gifts'] as const;
export type NotificationExtra = (typeof NOTIFICATION_EXTRAS)[number];

const extras = ({ value }: { value: unknown }): unknown =>
  typeof value === 'string'
    ? value
        .split(',')
        .map((part) => part.trim())
        .filter(Boolean)
    : value;

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

  /** "moderation" adds decisions about the account and what came of its
   * reports; "gifts" adds gifts sent to its posts. */
  @IsOptional()
  @Transform(extras)
  @IsIn(NOTIFICATION_EXTRAS, {
    each: true,
    message: `include must list only ${NOTIFICATION_EXTRAS.join(', ')}.`,
  })
  include?: NotificationExtra[];
}

/** For the badge: the same opt-in as the list. */
export class UnreadNotificationsDto {
  @IsOptional()
  @Transform(extras)
  @IsIn(NOTIFICATION_EXTRAS, {
    each: true,
    message: `include must list only ${NOTIFICATION_EXTRAS.join(', ')}.`,
  })
  include?: NotificationExtra[];
}
