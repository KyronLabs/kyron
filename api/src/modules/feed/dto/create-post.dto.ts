import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  IsArray,
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUrl,
  IsUUID,
  Max,
  MaxLength,
  Min,
  ValidateNested,
} from 'class-validator';
import { MediaKind, ReplyPolicy } from '@prisma/client';

export class PostMediaDto {
  // Must be a URL this deployment served. Accepting an arbitrary one would let
  // a post embed anything from anywhere under our name, and hand a tracker a
  // view of everyone who scrolls past.
  @IsUrl({ require_protocol: true, protocols: ['https'] })
  @MaxLength(2048)
  url!: string;

  @IsOptional()
  @IsEnum(MediaKind)
  kind?: MediaKind;

  // Carried so a list can reserve the right space before the bytes arrive.
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
  @IsString()
  @MaxLength(400)
  alt?: string;
}

export class CreatePostDto {
  // Not IsNotEmpty: a post carrying only an image is a post. The service
  // rejects one that is empty *and* unattached.
  @IsString()
  @MaxLength(3000, { message: 'A post cannot exceed 3000 characters.' })
  content!: string;

  @IsOptional()
  @IsArray()
  @ArrayMaxSize(4, { message: 'A post can carry at most 4 attachments.' })
  @ValidateNested({ each: true })
  @Type(() => PostMediaDto)
  media?: PostMediaDto[];

  /** Set to quote another post. A repost without a quote is not a post. */
  @IsOptional()
  @IsUUID('4', { message: 'quotedPostId must be a post id.' })
  quotedPostId?: string;

  @IsOptional()
  @IsEnum(ReplyPolicy, { message: 'That is not a reply setting we recognise.' })
  replyPolicy?: ReplyPolicy;

  // authorId used to be accepted here. With the route unguarded that let any
  // caller post as any user by naming them in the body; the author now comes
  // from the verified token and cannot be supplied at all.
}
