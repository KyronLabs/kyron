import { Injectable, Logger } from '@nestjs/common';

/** What a client can be told about without asking. */
export type RealtimeEvent =
  /** A message arrived in a conversation the reader is in. */
  | { type: 'message.new'; conversationId: string; messageId: string }
  /** Somebody read up to here, so the reader's own bubbles are seen. */
  | { type: 'message.read'; conversationId: string; readerId: string }
  /** A message was withdrawn. */
  | { type: 'message.deleted'; conversationId: string; messageId: string }
  /**
   * Somebody reacted to a message, or took a reaction back. Ids only, like
   * every event here: the client asks for the reactions over HTTP, so nothing
   * readable reaches a socket whose token has since been revoked.
   */
  | { type: 'message.reaction'; conversationId: string; messageId: string }
  /** Somebody is writing in a conversation the reader is in. */
  | { type: 'message.typing'; conversationId: string; userId: string }
  /**
   * A device in a conversation the reader is in asked for the keys of
   * messages it was not sealed for. Any of the reader's devices that can open
   * them answers (KeySharesService).
   */
  | { type: 'message.keys.requested'; conversationId: string }
  /** One of the reader's requests was answered: the thread can open more. */
  | { type: 'message.keys.shared'; conversationId: string }
  /** Something happened that the notifications screen would show. */
  | {
      type: 'notification.new';
      kind: string;
      actorId: string;
      /** The post it is about, when it is about one. */
      postId?: string;
    }
  /**
   * Somebody the reader talks to opened the app or put it away. Only ever
   * sent where both of them show their own (PresenceService).
   */
  | { type: 'presence'; userId: string; online: boolean }
  /**
   * Everybody the reader may see who is online right now, sent to a socket
   * as it connects: whatever changed while it was gone was not sent to it,
   * so the app starts again from this rather than from what it last heard.
   */
  | { type: 'presence.snapshot'; online: string[] }
  /**
   * Something changed in the reader's own standing: a decision about their
   * account, an answer to their appeal, or an outcome for a report they
   * made. The app asks GET /moderation/standing for what.
   */
  | { type: 'moderation.updated' }
  /** A report or an appeal is waiting. Sent to the team only. */
  | { type: 'moderation.queue' };

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

  /**
   * Sockets whose app has said it is in the background.
   *
   * A phone keeps its socket for a while after the app is put away -- until
   * the system reclaims it, which can be minutes -- so "has a socket" is not
   * "is here". The app says which it is (`presence` frames, see the
   * gateway), and this is where that is kept.
   */
  private readonly away = new WeakSet<Sendable>();

  /** Told whenever somebody's [isOnline] may have changed. */
  private readonly presenceListeners: ((userId: string) => void)[] = [];

  /** Told about each socket as it connects. */
  private readonly connectListeners: ((
    userId: string,
    socket: Sendable,
  ) => void)[] = [];

  register(userId: string, socket: Sendable): void {
    const existing = this.sockets.get(userId);
    if (existing) {
      existing.add(socket);
    } else {
      this.sockets.set(userId, new Set([socket]));
    }
    this.presenceMayHaveChanged(userId);
    for (const listener of this.connectListeners) {
      try {
        listener(userId, socket);
      } catch (error) {
        this.logger.warn(`A connect listener failed: ${String(error)}`);
      }
    }
  }

  /** Asks to be told about each socket as it connects. */
  onConnect(listener: (userId: string, socket: Sendable) => void): void {
    this.connectListeners.push(listener);
  }

  /** Says something to one socket only -- the one that just connected. */
  sendTo(socket: Sendable, event: RealtimeEvent): void {
    try {
      socket.send(JSON.stringify(event));
    } catch (error) {
      this.logger.warn(`Could not write to a new socket: ${String(error)}`);
    }
  }

  unregister(userId: string, socket: Sendable): void {
    const open = this.sockets.get(userId);
    if (!open) return;
    open.delete(socket);
    // Dropped rather than left empty: a reader who signs out on their last
    // device should not keep a key in this map for the life of the process.
    if (open.size === 0) this.sockets.delete(userId);
    this.presenceMayHaveChanged(userId);
  }

  /** The app on [socket] went to the background, or came back. */
  setAway(userId: string, socket: Sendable, away: boolean): void {
    if (away) {
      this.away.add(socket);
    } else {
      this.away.delete(socket);
    }
    this.presenceMayHaveChanged(userId);
  }

  /** Whether anybody is listening. Lets a caller skip work nobody will see. */
  isConnected(userId: string): boolean {
    return (this.sockets.get(userId)?.size ?? 0) > 0;
  }

  /**
   * Whether [userId] has the app open and in front, on any device. Says
   * nothing about whether anybody may be told so -- that is PresenceService.
   */
  isOnline(userId: string): boolean {
    const open = this.sockets.get(userId);
    if (!open) return false;
    for (const socket of open) {
      if (!this.away.has(socket)) return true;
    }
    return false;
  }

  /** Asks to be told when somebody's [isOnline] may have changed. */
  onPresence(listener: (userId: string) => void): void {
    this.presenceListeners.push(listener);
  }

  private presenceMayHaveChanged(userId: string): void {
    for (const listener of this.presenceListeners) {
      try {
        listener(userId);
      } catch (error) {
        this.logger.warn(`A presence listener failed: ${String(error)}`);
      }
    }
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
      if (open.size === 0) {
        this.sockets.delete(userId);
        this.presenceMayHaveChanged(userId);
      }
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
