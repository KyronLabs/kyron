import { Body, Controller, Headers, HttpCode, Post } from '@nestjs/common';
import { GooglePlayNotificationsService } from './google-play-notifications.service';

/** Pub/Sub uses its own Google OIDC identity, not a Kyron user session. */
@Controller('purchases/google-play/notifications')
export class GooglePlayNotificationsController {
  constructor(private readonly notifications: GooglePlayNotificationsService) {}

  @Post()
  @HttpCode(200)
  ingest(
    @Headers('authorization') authorization: string | undefined,
    @Body() body: unknown,
  ) {
    return this.notifications.ingest(authorization, body);
  }
}
