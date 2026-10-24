import type { RealtimeEvent } from '../realtime/realtime.service';
import { RealtimeService } from '../realtime/realtime.service';
import type { Activity } from './activity-push.service';
import { DeliveryService } from './delivery.service';
import type { PushMessage, RenderedPush } from './push.service';
import { PushService, renderPush } from './push.service';

/**
 * A delivery service that records instead of sending.
 *
 * Services take DeliveryService in their constructor, so a spec that builds
 * one by hand needs something to pass. This keeps what it was told, so a test
 * can assert an event was raised without a socket server or a Firebase
 * project. Pushes are kept as an English phone would show them, so a spec
 * says what the words are rather than which phrase keys made them.
 */
export class RecordingDelivery extends DeliveryService {
  readonly told: {
    userIds: string[];
    event: RealtimeEvent;
    push?: RenderedPush;
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
    this.told.push({
      userIds: [...userIds],
      event,
      ...(push ? { push: renderPush(push, 'en') } : {}),
    });
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
  readonly pushed: { userIds: string[]; push: RenderedPush }[] = [];

  override pushMany(userIds: readonly string[], push: PushMessage): void {
    this.pushed.push({ userIds: [...userIds], push: renderPush(push, 'en') });
  }

  /** Everything of one type, for asserting on one thing at a time. */
  ofType(type: RealtimeEvent['type']): RealtimeEvent[] {
    return this.told.filter((t) => t.event.type === type).map((t) => t.event);
  }
}
