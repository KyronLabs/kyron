import { IsIn, IsUUID } from 'class-validator';

import { GIFT_TYPES } from '../gift-catalogue';

export class SendGiftDto {
  @IsIn(GIFT_TYPES, {
    message: `type must be one of ${GIFT_TYPES.join(', ')}.`,
  })
  type!: string;

  /**
   * Made by the app for each tap. Sending the same one again answers with the
   * gift it already made, so a retry after a dropped connection never charges
   * twice.
   */
  @IsUUID('4', { message: 'requestId must be a UUID.' })
  requestId!: string;
}
