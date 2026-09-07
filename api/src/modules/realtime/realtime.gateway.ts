import { Logger } from '@nestjs/common';
import {
  OnGatewayConnection,
  OnGatewayDisconnect,
  WebSocketGateway,
} from '@nestjs/websockets';
import type { IncomingMessage } from 'http';
import type { WebSocket } from 'ws';

import { SupabaseTokenService } from '../auth/supabase-token.service';
import { RealtimeService } from './realtime.service';

/** Closed with this when the token is missing, unreadable or expired. */
const POLICY_VIOLATION = 1008;

/**
 * How long a socket may stay quiet before it is assumed gone.
 *
 * A phone that loses signal does not close its socket -- the server keeps a
 * half-open connection and goes on writing into it. Ping every half minute,
 * drop anything that has not answered by the next one.
 */
const HEARTBEAT_MS = 30_000;

/**
 * The socket a signed-in reader holds open.
 *
 * Read-only from the client's side: it sends nothing but a `ping`, and the
 * server tells it what happened. Everything a client can *do* is a REST call
 * that already exists, so there is no second, less-guarded way to write.
 */
@WebSocketGateway({ path: '/realtime' })
export class RealtimeGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  private readonly logger = new Logger(RealtimeGateway.name);

  /** Which reader each socket belongs to, so a disconnect can be unwound. */
  private readonly owner = new WeakMap<WebSocket, string>();

  /** Sockets that have answered since the last sweep. */
  private readonly alive = new WeakSet<WebSocket>();

  private heartbeat: NodeJS.Timeout | null = null;

  constructor(
    private readonly realtime: RealtimeService,
    private readonly supabaseToken: SupabaseTokenService,
  ) {}

  async handleConnection(
    socket: WebSocket,
    request: IncomingMessage,
  ): Promise<void> {
    // From the query string, not a header: a browser's WebSocket constructor
    // cannot set one, and the mobile client should not need a second way to
    // present the same credential.
    const token = this.tokenFrom(request);
    if (!token) {
      socket.close(POLICY_VIOLATION, 'A token is required.');
      return;
    }

    const claims = await this.supabaseToken.verify(token);
    if (!claims?.sub) {
      socket.close(POLICY_VIOLATION, 'That token could not be verified.');
      return;
    }

    this.owner.set(socket, claims.sub);
    this.alive.add(socket);
    this.realtime.register(claims.sub, socket);

    socket.on('pong', () => this.alive.add(socket));
    this.startHeartbeat(socket);
  }

  handleDisconnect(socket: WebSocket): void {
    const userId = this.owner.get(socket);
    if (!userId) return;
    this.realtime.unregister(userId, socket);
    this.owner.delete(socket);
  }

  /** The access token, from `?token=` on the upgrade request. */
  private tokenFrom(request: IncomingMessage): string | null {
    const url = request.url;
    if (!url) return null;
    // A relative URL needs a base to parse against; the host is irrelevant.
    const query = new URL(url, 'http://localhost').searchParams;
    const token = query.get('token')?.trim();
    return token && token.length > 0 ? token : null;
  }

  private startHeartbeat(socket: WebSocket): void {
    this.heartbeat ??= setInterval(() => this.sweep(), HEARTBEAT_MS);
    // The interval is shared, so it must not hold the process open on its own.
    this.heartbeat.unref?.();
  }

  /**
   * Pings everything open and closes whatever did not answer the last one.
   *
   * Iterating the server's own client set rather than a list of our own: the
   * two cannot drift, and a socket closed underneath us has already left it.
   */
  private sweep(): void {
    const server = (
      this as unknown as { server?: { clients?: Set<WebSocket> } }
    ).server;
    const clients = server?.clients;
    if (!clients) return;

    for (const socket of clients) {
      if (!this.alive.has(socket)) {
        this.logger.debug('Closing a socket that stopped answering pings.');
        socket.terminate();
        continue;
      }
      this.alive.delete(socket);
      try {
        socket.ping();
      } catch {
        socket.terminate();
      }
    }
  }
}
