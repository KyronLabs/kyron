import { Transform } from 'class-transformer';
import { IsIn, IsInt, IsISO8601, IsOptional, Max, Min } from 'class-validator';

export const NOTIFICATION_KINDS = [
  'like',
  'comment',
  'follow',
  'repost',
  'mention',
  'account',
  'report',
  'gift',
] as const;

/** What `include` may ask for. */
export const INCLUDES = ['moderation', 'mentions', 'gifts'] as const;
export type Include = (typeof INCLUDES)[number];

/** "moderation,mentions" -> ['moderation', 'mentions']. */
function includeList({ value }: { value: unknown }): unknown {
  return typeof value === 'string'
    ? value
        .split(',')
        .map((part) => part.trim())
        .filter(Boolean)
    : value;
}

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

  /** Rows an older app would misread, asked for by name, comma-separated:
   * "moderation" adds decisions about the account and what came of its
   * reports, "mentions" adds where somebody wrote @you, "gifts" adds gifts
   * sent to its posts. An app from before any of them reads an unknown row
   * as a like. */
  @IsOptional()
  @Transform(includeList)
  @IsIn(INCLUDES, {
    each: true,
    message: `include must be any of ${INCLUDES.join(', ')}.`,
  })
  include?: Include[];
}

/** For the badge: the same opt-in as the list. */
export class UnreadNotificationsDto {
  @IsOptional()
  @Transform(includeList)
  @IsIn(INCLUDES, {
    each: true,
    message: `include must be any of ${INCLUDES.join(', ')}.`,
  })
  include?: Include[];
}
