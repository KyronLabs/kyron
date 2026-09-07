import { Injectable } from '@nestjs/common';

import { RealtimeEvent, RealtimeService } from '../realtime/realtime.service';
import { PushMessage, PushService } from './push.service';

/**
 * Tells somebody something, by whichever route will reach them.
 *
 * The socket if they have the app open, a push if they do not. Both would be
 * a phone that buzzes for a message already on screen, so the socket wins
 * where it can -- and the check is per person, not per event, because two
 * people in the same conversation are rarely in the same place.
 */
@Injectable()
export class DeliveryService {
  constructor(
    private readonly realtime: RealtimeService,
    private readonly push: PushService,
  ) {}

  /** One person. [push] is what their phone shows if they are not connected. */
  tell(userId: string, event: RealtimeEvent, push?: PushMessage): void {
    this.realtime.emitTo(userId, event);
    if (push && !this.realtime.isConnected(userId)) {
      this.pushLater(userId, push);
    }
  }

  /** The same to several people, each by whichever route reaches them. */
  tellMany(
    userIds: readonly string[],
    event: RealtimeEvent,
    push?: PushMessage,
  ): void {
    this.realtime.emitToMany(userIds, event);
    if (!push) return;
    for (const userId of new Set(userIds)) {
      if (!this.realtime.isConnected(userId)) this.pushLater(userId, push);
    }
  }

  /**
   * Sends without making the caller wait.
   *
   * A round trip to Google must not sit between somebody pressing send and
   * their message appearing. Rejected sends are logged inside PushService;
   * this catch is only here so an unhandled rejection cannot take the process
   * down for a notification.
   */
  private pushLater(userId: string, message: PushMessage): void {
    void this.push.sendTo(userId, message).catch(() => {});
  }
}
