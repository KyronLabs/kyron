import { Transform } from 'class-transformer';
import {
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateCommentDto {
  @IsString()
  @Transform(({ value }: { value: unknown }) =>
    typeof value === 'string' ? value.trim() : value,
  )
  @MinLength(1, { message: 'A comment cannot be empty.' })
  // Shorter than a post on purpose: a reply is a reply.
  @MaxLength(500, { message: 'A comment is at most 500 characters.' })
  content!: string;

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
