import { IsUUID } from 'class-validator';

export class OpenConversationDto {
  /** Who to talk to. The other side comes from the verified token. */
  @IsUUID('4', { message: 'userId must be an account id.' })
  userId!: string;
}
