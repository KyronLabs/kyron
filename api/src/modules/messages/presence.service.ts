import { Injectable, Logger, OnModuleDestroy } from '@nestjs/common';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { Sendable } from '../realtime/realtime.service';
import { RealtimeService } from '../realtime/realtime.service';

/**
 * Who is online, and who may be told.
 *
 * "Online" is the app open and in front on some device -- RealtimeService
 * knows that from the socket and the app's own presence frames. Who may be
 * told is narrower, and is the whole of this class:
 *
 * - only people the account has a conversation with, so a stranger cannot
 *   watch somebody come and go from their profile;
 * - only while the account shows it (`User.showOnline`), and only to people
 *   who show theirs -- the same trade read receipts make, so nobody can
 *   watch without being seen;
 * - never across a block, either way.
 *
 * Going offline waits [graceMs] before it is said. A phone changing networks
 * drops its socket and has a new one a few seconds later, and a dot that
 * blinks off and on for that is a dot nobody trusts.
 */
@Injectable()
export class PresenceService implements OnModuleDestroy {
  private readonly logger = new Logger(PresenceService.name);

  static readonly graceMs = 15_000;

  /** Who the people they talk to have last been told is online. */
  private readonly shownOnline = new Set<string>();

  /** Offline announcements waiting out the grace period. */
  private readonly leaving = new Map<string, NodeJS.Timeout>();

  constructor(
    private readonly realtime: RealtimeService,
    private readonly prisma: PrismaService,
  ) {
    realtime.onPresence((userId) => this.changed(userId));
    realtime.onConnect((userId, socket) => void this.snapshot(userId, socket));
  }

  /**
   * Who [userId] may see online, sent to the socket that just connected.
   * Empty for somebody who hides their own: they see nobody's.
   */
  private async snapshot(userId: string, socket: Sendable): Promise<void> {
    try {
      const me = await this.prisma.user.findUnique({
        where: { id: userId },
        select: { showOnline: true },
      });
      const online = me?.showOnline
        ? (await this.audience(userId, { connectedOnly: false })).filter((id) =>
            this.realtime.isOnline(id),
          )
        : [];
      this.realtime.sendTo(socket, { type: 'presence.snapshot', online });
    } catch (error) {
      this.logger.warn(`Could not send a presence snapshot: ${String(error)}`);
    }
  }

  onModuleDestroy(): void {
    for (const timer of this.leaving.values()) clearTimeout(timer);
    this.leaving.clear();
  }

  /**
   * Whether a reader who [viewerShows] their own may see [person] online.
   * For the people on a conversation list or at the top of a thread.
   */
  visible(
    viewerShows: boolean,
    person: { id: string; showOnline?: boolean },
  ): boolean {
    return (
      viewerShows &&
      person.showOnline !== false &&
      this.realtime.isOnline(person.id)
    );
  }

  /** Somebody's sockets changed; say so if what they look like did. */
  changed(userId: string): void {
    if (this.realtime.isOnline(userId)) {
      const pending = this.leaving.get(userId);
      if (pending) {
        clearTimeout(pending);
        this.leaving.delete(userId);
      }
      if (!this.shownOnline.has(userId)) {
        this.shownOnline.add(userId);
        void this.announce(userId, true);
      }
      return;
    }

    if (!this.shownOnline.has(userId) || this.leaving.has(userId)) return;
    const timer = setTimeout(() => {
      this.leaving.delete(userId);
      if (this.realtime.isOnline(userId)) return;
      this.shownOnline.delete(userId);
      void this.announce(userId, false);
    }, PresenceService.graceMs);
    timer.unref?.();
    this.leaving.set(userId, timer);
  }

  /**
   * The account turned showing it on or off. Off takes the dot away from
   * everybody at once; on shows it, if they are here.
   */
  async settingChanged(userId: string, showOnline: boolean): Promise<void> {
    const online = showOnline && this.realtime.isOnline(userId);
    if (online) {
      this.shownOnline.add(userId);
    } else {
      this.shownOnline.delete(userId);
    }
    await this.tell(userId, online);
    // And the account's own app, which sees nobody now -- or everybody it
    // may, now that it shows itself again.
    const visible = showOnline
      ? (await this.audience(userId, { connectedOnly: false })).filter((id) =>
          this.realtime.isOnline(id),
        )
      : [];
    this.realtime.emitTo(userId, {
      type: 'presence.snapshot',
      online: visible,
    });
  }

  private async announce(userId: string, online: boolean): Promise<void> {
    try {
      const me = await this.prisma.user.findUnique({
        where: { id: userId },
        select: { showOnline: true },
      });
      // Hidden: nobody was shown a dot, so there is nothing to take back.
      if (!me?.showOnline) return;
      await this.tell(userId, online);
    } catch (error) {
      this.logger.warn(`Could not announce presence: ${String(error)}`);
    }
  }

  private async tell(userId: string, online: boolean): Promise<void> {
    const audience = await this.audience(userId);
    if (audience.length === 0) return;
    this.realtime.emitToMany(audience, { type: 'presence', userId, online });
  }

  /**
   * Who may hear about [userId]: everyone they share a conversation with who
   * shows their own and is not blocked by or blocking them -- and of those,
   * whoever has a socket to hear it on.
   */
  private async audience(
    userId: string,
    { connectedOnly = true } = {},
  ): Promise<string[]> {
    const rows = await this.prisma.conversationMember.findMany({
      where: {
        userId: { not: userId },
        conversation: { members: { some: { userId } } },
        user: {
          showOnline: true,
          blocking: { none: { blockedId: userId } },
          blockedBy: { none: { blockerId: userId } },
        },
      },
      select: { userId: true },
      distinct: ['userId'],
    });
    const ids = rows.map((row) => row.userId);
    return connectedOnly
      ? ids.filter((id) => this.realtime.isConnected(id))
      : ids;
  }
}
