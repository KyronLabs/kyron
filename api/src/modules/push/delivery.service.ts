import { Injectable, Logger, Optional } from '@nestjs/common';

import { RealtimeEvent, RealtimeService } from '../realtime/realtime.service';
import { Activity, ActivityPushService } from './activity-push.service';
import { PushMessage, PushService } from './push.service';

/**
 * Tells somebody something, by every route that might reach them.
 *
 * Over the socket, so an open app updates at once, and as a push, so a phone
 * in a pocket hears about it.
 *
 * This used to send the push only to people with no socket open, on the
 * reasoning that an open socket meant the app was on screen. It does not.
 * Android keeps a backgrounded app's process -- and its socket -- alive for
 * minutes, so a message that arrived with the screen off or another app in
 * front went to a socket nobody was looking at, and nothing buzzed. The
 * socket cannot tell an app on screen from one in the background; the phone
 * can, and it already does the right thing with the push: a notification
 * that arrives while the app is in front is handed to the app rather than
 * shown, and this app shows nothing for one. So both, always, and the phone
 * decides.
 */
@Injectable()
export class DeliveryService {
  private readonly logger = new Logger(DeliveryService.name);

  constructor(
    private readonly realtime: RealtimeService,
    private readonly push: PushService,
    // Optional so a spec that builds this by hand need not supply it; with
    // none, activity is told over the socket and not pushed.
    @Optional() private readonly activity?: ActivityPushService,
  ) {}

  /** One person. [push] is what their phone shows when the app is not in
   * front. */
  tell(userId: string, event: RealtimeEvent, push?: PushMessage): void {
    this.realtime.emitTo(userId, event);
    if (push) this.pushLater(userId, push);
  }

  /** The same to several people. */
  tellMany(
    userIds: readonly string[],
    event: RealtimeEvent,
    push?: PushMessage,
  ): void {
    this.realtime.emitToMany(userIds, event);
    if (!push) return;
    for (const userId of new Set(userIds)) this.pushLater(userId, push);
  }

  /**
   * Somebody did something to [userId]'s post or account. The socket hears
   * at once; the push, which names who and says on what, is worked out
   * afterwards, so the like or follow that caused it does not wait on the
   * queries that takes.
   */
  tellActivity(userId: string, event: RealtimeEvent, activity: Activity): void {
    this.realtime.emitTo(userId, event);
    const words = this.activity;
    if (!words) return;
    void words
      .message(userId, activity)
      .then((message) => (message ? this.push.sendTo(userId, message) : null))
      .catch((error: unknown) =>
        this.logger.warn(
          `no ${activity.kind} push for ${userId}: ${String(error)}`,
        ),
      );
  }

  /** A push alone, for something the socket has already been told about:
   * a community chat raises its event for everybody in it, and pushes only
   * to some. */
  pushMany(userIds: readonly string[], push: PushMessage): void {
    for (const userId of new Set(userIds)) this.pushLater(userId, push);
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
