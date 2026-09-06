import { Controller, Get, Put, Query, Req, UseGuards } from '@nestjs/common';
import { NotificationsService } from './notifications.service';
import { ListNotificationsDto } from './dto/list-notifications.dto';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';

@Controller('notifications')
// All of it. Notifications are about one account and nobody else's business.
@UseGuards(AuthGuard)
export class NotificationsController {
  constructor(private readonly svc: NotificationsService) {}

  @Get()
  list(@Req() req: AuthRequest, @Query() query: ListNotificationsDto) {
    return this.svc.list(req.user.id, {
      limit: query.limit,
      cursor: query.cursor,
      kind: query.kind,
    });
  }

  /** Declared above nothing, but kept fixed-first out of habit. */
  @Get('unread')
  unread(@Req() req: AuthRequest) {
    return this.svc.unreadCount(req.user.id);
  }

  @Put('seen')
  seen(@Req() req: AuthRequest) {
    return this.svc.markSeen(req.user.id);
  }
}
