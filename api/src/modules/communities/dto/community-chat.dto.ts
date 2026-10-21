import { Transform, Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  IsBoolean,
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  ValidateIf,
  ValidateNested,
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

/** A photo, clip or voice note going in a message: what POST /media/chat
 * answered, and what the phone measured. */
export class CommunityChatMediaDto {
  @IsString()
  @MaxLength(300)
  ref!: string;

  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(20000)
  width?: number;

  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(20000)
  height?: number;

  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(3_600_000)
  durationMs?: number;

  @IsOptional()
  @IsArray()
  @ArrayMaxSize(200)
  @IsInt({ each: true })
  waveform?: number[];
}

/** A poll: the message's body is its question. */
export class CommunityChatPollDto {
  @IsArray()
  @ArrayMinSize(2, { message: 'A poll needs at least two answers.' })
  @ArrayMaxSize(10, { message: 'A poll can have at most ten answers.' })
  @IsString({ each: true })
  @MaxLength(100, {
    each: true,
    message: 'An answer can be at most 100 characters.',
  })
  options!: string[];

  @IsOptional()
  @IsBoolean()
  multiple?: boolean;
}

export class SendCommunityChatMessageDto {
  /** Optional only with media: words under a picture can be none. */
  @IsOptional()
  @IsString()
  @MaxLength(2000, { message: 'A message can be at most 2,000 characters.' })
  body?: string;

  @IsOptional()
  @IsUUID('4', { message: 'replyToId must be a message id.' })
  replyToId?: string;

  @IsOptional()
  @IsArray()
  @ArrayMaxSize(4, {
    message: 'A message can carry at most 4 photos or clips.',
  })
  @ValidateNested({ each: true })
  @Type(() => CommunityChatMediaDto)
  media?: CommunityChatMediaDto[];

  @IsOptional()
  @ValidateNested()
  @Type(() => CommunityChatPollDto)
  poll?: CommunityChatPollDto;
}

export class EditCommunityChatMessageDto {
  @IsString()
  @MaxLength(2000, { message: 'A message can be at most 2,000 characters.' })
  body!: string;
}

export class CommunityChatVoteDto {
  @IsArray()
  @ArrayMinSize(1, { message: 'Choose an answer.' })
  @ArrayMaxSize(10)
  @IsUUID('4', { each: true, message: 'Each answer must be an option id.' })
  optionIds!: string[];
}

export class SearchCommunityChatDto {
  @IsString()
  @MaxLength(100, { message: 'That search is too long.' })
  q!: string;
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
