import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  IsArray,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
  ValidateNested,
} from 'class-validator';
import { PostMediaDto } from '../../feed/dto/create-post.dto';

export class SendMessageDto {
  // Not IsNotEmpty: whitespace-only is also empty, and a message carrying only
  // a picture is a message. The service decides, so the rule lives in one
  // place.
  //
  // The ceiling here is the sealed one: a sealed body is ciphertext plus the
  // message key wrapped for every device, longer than what was typed. The
  // service holds a plain body to 4000 itself.
  @IsString()
  @IsOptional()
  @MaxLength(24000, { message: 'A message cannot exceed 4000 characters.' })
  body?: string;

  /**
   * The message this one answers, if it answers one.
   *
   * The id only, never the quoted text. A direct message is sealed before it
   * leaves the phone; a reply carrying the words would write them into the
   * database in the clear. The client holds the thread decrypted and resolves
   * the quote itself.
   */
  @IsOptional()
  @IsUUID()
  replyToId?: string;

  /**
   * The card for the first link in the body, sealed on the sender's phone.
   *
   * Room for a small picture: the card carries its own copy, so a reader is
   * never sent to the linked site to fetch it. The service checks the rest.
   */
  @IsOptional()
  @IsString()
  @MaxLength(96000, { message: 'That link card is too large.' })
  linkCard?: string;

  /** Attachments, already uploaded. The same shape a post's take. */
  @IsOptional()
  @IsArray()
  @ArrayMaxSize(10, {
    message: 'A message can carry at most 10 attachments.',
  })
  @ValidateNested({ each: true })
  @Type(() => PostMediaDto)
  media?: PostMediaDto[];
}
