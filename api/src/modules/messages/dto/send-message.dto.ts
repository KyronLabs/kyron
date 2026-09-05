import { IsString, MaxLength } from 'class-validator';

export class SendMessageDto {
  // Not IsNotEmpty: whitespace-only is also empty, and the service is where
  // that is decided so the rule lives in one place.
  @IsString()
  @MaxLength(4000, { message: 'A message cannot exceed 4000 characters.' })
  body!: string;
}
