import { RealtimeEvent, RealtimeService } from './realtime.service';

/**
 * A realtime service that records instead of sending.
 *
 * Services take RealtimeService in their constructor, so a spec that builds
 * one by hand needs something to pass. This keeps what it was told, so a test
 * can assert that an event was raised without standing up a socket server.
 */
export class RecordingRealtime extends RealtimeService {
  readonly sent: { userIds: string[]; event: RealtimeEvent }[] = [];

  override emitToMany(userIds: readonly string[], event: RealtimeEvent): void {
    this.sent.push({ userIds: [...userIds], event });
  }

  override emitTo(userId: string, event: RealtimeEvent): void {
    this.emitToMany([userId], event);
  }

  /** Every event of one type, for asserting on one thing at a time. */
  ofType(type: RealtimeEvent['type']): RealtimeEvent[] {
    return this.sent.filter((s) => s.event.type === type).map((s) => s.event);
  }
}
