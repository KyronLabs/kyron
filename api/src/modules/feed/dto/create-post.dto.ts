import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
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

  /** How long a voice recording runs, in milliseconds. Capped at ten
   * minutes, which is the longest the composer will record. */
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(10 * 60 * 1000)
  durationMs?: number;

  /**
   * Loudness over time, 0-100, one value per waveform bar.
   *
   * Bounded on both the count and each value: it is drawn straight into a
   * row of bars, so an unbounded array is an unbounded row and a value
   * outside 0-100 is a bar taller than its container.
   */
  @IsOptional()
  @IsArray()
  @ArrayMaxSize(256)
  @IsInt({ each: true })
  @Min(0, { each: true })
  @Max(100, { each: true })
  waveform?: number[];

  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(20000)
  height?: number;

  /**
   * A still from a video, uploaded beside it.
   *
   * Same rule as the attachment itself: it must be a URL this deployment
   * served, or a post could point a reader's device at anything.
   */
  @IsOptional()
  @IsUrl({ require_protocol: true, protocols: ['https'] })
  @MaxLength(2048)
  thumbnailUrl?: string;

  @IsOptional()
  @IsString()
  @MaxLength(400)
  alt?: string;
}

export class CreatePollDto {
  /**
   * Between two and four answers. Bounded here so an unreasonable array never
   * reaches the service; the service checks the same thing, because it is also
   * the last point before rows are written.
   */
  @IsArray()
  @ArrayMinSize(2, { message: 'A poll needs at least two answers.' })
  @ArrayMaxSize(4, { message: 'A poll can have at most four answers.' })
  @IsString({ each: true })
  @MaxLength(80, { each: true })
  options!: string[];

  /** Five minutes to seven days. */
  @Type(() => Number)
  @IsInt()
  @Min(5)
  @Max(7 * 24 * 60)
  durationMinutes!: number;
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

  /** Attach a poll. The service enforces the answer count and duration. */
  @IsOptional()
  @ValidateNested()
  @Type(() => CreatePollDto)
  poll?: CreatePollDto;

  // authorId used to be accepted here. With the route unguarded that let any
  // caller post as any user by naming them in the body; the author now comes
  // from the verified token and cannot be supplied at all.
}
