import { IsEnum } from 'class-validator';
import { ReplyPolicy } from '@prisma/client';

export class ReplyPolicyDto {
  @IsEnum(ReplyPolicy, { message: 'That is not a reply setting we recognise.' })
  replyPolicy!: ReplyPolicy;
}
