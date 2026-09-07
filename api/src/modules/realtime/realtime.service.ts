import { Injectable, Logger } from '@nestjs/common';

/** What a client can be told about without asking. */
export type RealtimeEvent =
  /** A message arrived in a conversation the reader is in. */
  | { type: 'message.new'; conversationId: string; messageId: string }
  /** Somebody read up to here, so the reader's own bubbles are seen. */
  | { type: 'message.read'; conversationId: string; readerId: string }
  /** A message was withdrawn. */
  | { type: 'message.deleted'; conversationId: string; messageId: string }
  /** Something happened that the notifications screen would show. */
  | { type: 'notification.new'; kind: string; actorId: string };

/**
 * One socket, or none, per connection; one entry per reader.
 *
 * Held in memory on purpose. This process is the only one that can reach the
 * sockets it holds, so a second instance would need a bus between them -- and
 * the point of this layer is that a client which misses an event is only ever
 * as stale as its next poll, never wrong. Adding Redis for fan-out is a
 * scaling decision to take when there is a second instance, not before.
 */
@Injectable()
export class RealtimeService {
  private readonly logger = new Logger(RealtimeService.name);

  /** Reader id to their open sockets. Somebody on a phone and a laptop has two. */
  private readonly sockets = new Map<string, Set<Sendable>>();

  register(userId: string, socket: Sendable): void {
    const existing = this.sockets.get(userId);
    if (existing) {
      existing.add(socket);
      return;
    }
    this.sockets.set(userId, new Set([socket]));
  }

  unregister(userId: string, socket: Sendable): void {
    const open = this.sockets.get(userId);
    if (!open) return;
    open.delete(socket);
    // Dropped rather than left empty: a reader who signs out on their last
    // device should not keep a key in this map for the life of the process.
    if (open.size === 0) this.sockets.delete(userId);
  }

  /** Whether anybody is listening. Lets a caller skip work nobody will see. */
  isConnected(userId: string): boolean {
    return (this.sockets.get(userId)?.size ?? 0) > 0;
  }

  /** Tells one reader something, on every device they have open. */
  emitTo(userId: string, event: RealtimeEvent): void {
    this.emitToMany([userId], event);
  }

  /** The same event to several readers -- everyone in a conversation, say. */
  emitToMany(userIds: readonly string[], event: RealtimeEvent): void {
    const payload = JSON.stringify(event);

    for (const userId of new Set(userIds)) {
      const open = this.sockets.get(userId);
      if (!open) continue;

      for (const socket of open) {
        try {
          socket.send(payload);
        } catch (error) {
          // A send that throws is a socket that has gone without saying so.
          // Dropped here rather than left to accumulate, and logged rather
          // than swallowed: a run of these means connections are being lost
          // somewhere upstream.
          this.logger.warn(
            `Dropping a dead socket for ${userId}: ${String(error)}`,
          );
          open.delete(socket);
        }
      }
      if (open.size === 0) this.sockets.delete(userId);
    }
  }

  /** How many readers are connected. For the health endpoint. */
  get connectedReaders(): number {
    return this.sockets.size;
  }
}

/** The part of a WebSocket this service uses. Narrow, so it can be faked. */
export interface Sendable {
  send(data: string): void;
}
