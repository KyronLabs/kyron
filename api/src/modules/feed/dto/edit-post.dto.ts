import { IsString, MaxLength } from 'class-validator';

/** New words for a post. Its attachments, poll and topics stay as they are. */
export class EditPostDto {
  // As a new post's: empty is allowed when the post carries something else.
  @IsString()
  @MaxLength(3000, { message: 'A post cannot exceed 3000 characters.' })
  content!: string;
}
