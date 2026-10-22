import { Transform } from 'class-transformer';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsUUID,
  Max,
  Min,
} from 'class-validator';

export class ListConversationsDto {
  @IsOptional()
  @IsUUID('4', { message: 'cursor must come from a previous page.' })
  cursor?: string;

  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(50)
  limit?: number;

  /** The Unread tab. Narrowed by the server, not by the client. */
  @IsOptional()
  @Transform(({ value }) => value === true || value === 'true')
  @IsBoolean()
  unreadOnly?: boolean;

  /**
   * Which conversations: every one, those with something unread, those
   * whose last word was the other person's, groups, or those the reader
   * removed from their list. Takes over from [unreadOnly], which older apps
   * send.
   */
  @IsOptional()
  @IsIn(['all', 'unread', 'unanswered', 'groups', 'hidden'])
  filter?: ConversationFilter;
}

export type ConversationFilter =
  | 'all'
  | 'unread'
  | 'unanswered'
  | 'groups'
  | 'hidden';

export class MessagingSettingsDto {
  @IsOptional()
  @IsBoolean()
  readReceipts?: boolean;

  @IsOptional()
  @IsBoolean()
  showOnline?: boolean;
}

export class ListMessagesDto {
  @IsOptional()
  @IsUUID('4', { message: 'cursor must come from a previous page.' })
  cursor?: string;

  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(100)
  limit?: number;
}
