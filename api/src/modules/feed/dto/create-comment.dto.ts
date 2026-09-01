import { Transform, Type } from 'class-transformer';
import {
  ArrayMaxSize,
  IsArray,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
  ValidateNested,
} from 'class-validator';
import { PostMediaDto } from './create-post.dto';

export class CreateCommentDto {
  // Not MinLength(1): a reply carrying only a picture is a reply. The service
  // rejects one that is empty *and* unattached.
  @IsString()
  @Transform(({ value }: { value: unknown }) =>
    typeof value === 'string' ? value.trim() : value,
  )
  // Shorter than a post on purpose: a reply is a reply.
  @MaxLength(500, { message: 'A comment is at most 500 characters.' })
  content!: string;

  @IsOptional()
  @IsArray()
  @ArrayMaxSize(4, { message: 'A comment can carry at most 4 attachments.' })
  @ValidateNested({ each: true })
  @Type(() => PostMediaDto)
  media?: PostMediaDto[];

  /**
   * The comment being replied to. Omit for a top-level comment.
   *
   * A reply to a reply is attached to the same thread, so this only ever needs
   * to name a comment on the post being commented on.
   */
  @IsOptional()
  @IsUUID('4', { message: 'parentId must be a comment id.' })
  parentId?: string;
}
