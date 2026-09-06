import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  IsArray,
  IsOptional,
  IsString,
  MaxLength,
  ValidateNested,
} from 'class-validator';
import { PostMediaDto } from '../../feed/dto/create-post.dto';

export class SendMessageDto {
  // Not IsNotEmpty: whitespace-only is also empty, and a message carrying only
  // a picture is a message. The service decides, so the rule lives in one
  // place.
  @IsString()
  @IsOptional()
  @MaxLength(4000, { message: 'A message cannot exceed 4000 characters.' })
  body?: string;

  /** Attachments, already uploaded. The same shape a post's take. */
  @IsOptional()
  @IsArray()
  @ArrayMaxSize(4, {
    message: 'A message can carry at most 4 attachments.',
  })
  @ValidateNested({ each: true })
  @Type(() => PostMediaDto)
  media?: PostMediaDto[];
}
