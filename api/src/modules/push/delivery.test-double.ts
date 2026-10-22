import type { RealtimeEvent } from '../realtime/realtime.service';
import { RealtimeService } from '../realtime/realtime.service';
import type { Activity } from './activity-push.service';
import { DeliveryService } from './delivery.service';
import type { PushMessage } from './push.service';
import { PushService } from './push.service';

/**
 * A delivery service that records instead of sending.
 *
 * Services take DeliveryService in their constructor, so a spec that builds
 * one by hand needs something to pass. This keeps what it was told, so a test
 * can assert an event was raised without a socket server or a Firebase
 * project.
 */
export class RecordingDelivery extends DeliveryService {
  readonly told: {
    userIds: string[];
    event: RealtimeEvent;
    push?: PushMessage;
  }[] = [];

  constructor() {
    // Real instances, never reached: every method that would use them is
    // overridden below.
    super(new RealtimeService(), null as unknown as PushService);
  }

  override tell(
    userId: string,
    event: RealtimeEvent,
    push?: PushMessage,
  ): void {
    this.tellMany([userId], event, push);
  }

  override tellMany(
    userIds: readonly string[],
    event: RealtimeEvent,
    push?: PushMessage,
  ): void {
    this.told.push({ userIds: [...userIds], event, push });
  }

  /** Activity told to somebody, whose push is worked out later. */
  readonly activities: { userId: string; activity: Activity }[] = [];

  override tellActivity(
    userId: string,
    event: RealtimeEvent,
    activity: Activity,
  ): void {
    this.told.push({ userIds: [userId], event });
    this.activities.push({ userId, activity });
  }

  /** Pushes with no event of their own. */
  readonly pushed: { userIds: string[]; push: PushMessage }[] = [];

  override pushMany(userIds: readonly string[], push: PushMessage): void {
    this.pushed.push({ userIds: [...userIds], push });
  }

  /** Everything of one type, for asserting on one thing at a time. */
  ofType(type: RealtimeEvent['type']): RealtimeEvent[] {
    return this.told.filter((t) => t.event.type === type).map((t) => t.event);
  }
}
