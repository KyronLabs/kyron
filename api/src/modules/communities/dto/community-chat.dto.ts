import { Transform } from 'class-transformer';
import {
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  ValidateIf,
} from 'class-validator';
import { CommunityChatWriters } from '@prisma/client';

/**
 * Bodies for community chats. These keep a request sane; the rules -- who
 * may, how long, how often -- are CommunityChatsService's, and are checked
 * there whatever arrives here.
 */

export class CreateCommunityChatDto {
  @IsString()
  @MaxLength(40, { message: "A chat's name can be at most 40 characters." })
  name!: string;

  @IsOptional()
  @IsString()
  @MaxLength(200, { message: 'A description can be at most 200 characters.' })
  description?: string;

  @IsOptional()
  @IsEnum(CommunityChatWriters)
  writers?: CommunityChatWriters;
}

export class UpdateCommunityChatDto {
  @IsOptional()
  @IsString()
  @MaxLength(40, { message: "A chat's name can be at most 40 characters." })
  name?: string;

  /** Null clears it. */
  @IsOptional()
  @ValidateIf((_, value) => value !== null)
  @IsString()
  @MaxLength(200, { message: 'A description can be at most 200 characters.' })
  description?: string | null;

  @IsOptional()
  @IsEnum(CommunityChatWriters)
  writers?: CommunityChatWriters;

  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(3600)
  slowModeSeconds?: number;

  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(1000)
  position?: number;
}

export class SendCommunityChatMessageDto {
  @IsString()
  @MaxLength(2000, { message: 'A message can be at most 2,000 characters.' })
  body!: string;

  @IsOptional()
  @IsUUID('4', { message: 'replyToId must be a message id.' })
  replyToId?: string;
}

export class CommunityChatReactionDto {
  @IsString()
  @MaxLength(32)
  emoji!: string;
}

export class PinCommunityChatMessageDto {
  @IsUUID('4', { message: 'messageId must be a message id.' })
  messageId!: string;
}

export class ListCommunityChatMessagesDto {
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
