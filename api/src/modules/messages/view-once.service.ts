import {
  ForbiddenException,
  GoneException,
  Injectable,
  Logger,
  NotFoundException,
  OnModuleDestroy,
  OnModuleInit,
} from '@nestjs/common';
import { MediaKind, Prisma } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { MediaService } from '../media/media.service';
import { DeliveryService } from '../push/delivery.service';

/** Where a view-once message stands, as the client draws it. */
export interface OnceState {
  /** The reader has opened it. Always false for whoever sent it. */
  opened: boolean;
  /** How many of the people it was sent to have opened it. */
  openedCount: number;
  /** How many people it was sent to: everybody in the conversation when it
   * was sent, but the sender. */
  recipients: number;
  /** Deleted, or past the time it could be opened in. Nothing to open. */
  gone: boolean;
}

/** What an open hands back: a link that lasts minutes, and what it is. */
export interface OnceOpened {
  url: string;
  expiresAt: Date;
  kind: MediaKind;
  width: number | null;
  height: number | null;
  durationMs: number | null;
  waveform: number[];
}

/** One attachment as a view-once message sends it: a reference into the
 * private bucket, from POST /media/once, and what it is. */
export interface OnceMediaInput {
  ref: string;
  kind: MediaKind;
  width?: number;
  height?: number;
  durationMs?: number;
  waveform?: number[];
}

/**
 * View-once attachments: opened once by each person they were sent to, then
 * deleted.
 *
 * What "once" rests on is that nobody is ever given a lasting address. The
 * file sits in the private bucket; its row holds the path, which is never
 * sent to a client; an open records who opened it and hands back a link that
 * stops working in minutes. A second open is refused by the table's primary
 * key, not by the app. Once everybody has opened it -- or it has waited
 * [ttlDays] -- the file is deleted. See docs/MESSAGING.md, which also says
 * what this cannot stop: a screenshot on iOS, or a camera pointed at a
 * screen.
 */
@Injectable()
export class ViewOnceService implements OnModuleInit, OnModuleDestroy {
  private readonly logger = new Logger(ViewOnceService.name);
  private timer: NodeJS.Timeout | null = null;

  constructor(
    private readonly prisma: PrismaService,
    private readonly supabase: SupabaseService,
    private readonly delivery: DeliveryService,
  ) {}

  /** How long an unopened view-once attachment is kept. */
  static readonly ttlDays = 14;

  /** How often expired and fully opened attachments are swept away. */
  static readonly sweepMs = 10 * 60_000;

  /** The kinds that can go view once. A GIF is somebody else's picture. */
  static readonly kinds: ReadonlySet<MediaKind> = new Set([
    MediaKind.IMAGE,
    MediaKind.VIDEO,
    MediaKind.VOICE,
  ]);

  /**
   * How long an opened link works. Long enough to load a picture, or to play
   * a clip or a voice note through from where it was opened, and no longer.
   */
  static linkSeconds(kind: MediaKind, durationMs: number | null): number {
    if (kind === MediaKind.IMAGE) return 120;
    const playing = Math.ceil((durationMs ?? 0) / 1000) + 60;
    return Math.min(15 * 60, Math.max(120, playing));
  }

  /** A reference [userId] uploaded through POST /media/once, and nobody
   * else's: the name starts with the uploader's id. */
  static isOwnRef(ref: string, userId: string): boolean {
    const prefix = `${MediaService.onceFolder}/${userId}_`;
    return (
      ref.startsWith(prefix) &&
      /^[A-Za-z0-9_.-]+$/.test(ref.slice(prefix.length))
    );
  }

  /** Whether it is past the time it could be opened in. */
  static expired(createdAt: Date, now = new Date()): boolean {
    return (
      now.getTime() - createdAt.getTime() > ViewOnceService.ttlDays * 86_400_000
    );
  }

  /**
   * Who a message was sent to: everybody in the conversation when it was
   * written, but its sender. Somebody added later was not sent it.
   */
  static recipientsOf(
    message: { senderId: string; createdAt: Date },
    members: ReadonlyArray<{ userId: string; joinedAt: Date }>,
  ): string[] {
    return members
      .filter(
        (m) => m.userId !== message.senderId && m.joinedAt <= message.createdAt,
      )
      .map((m) => m.userId);
  }

  /** Where a view-once message stands for [viewerId]. */
  static stateFor(
    viewerId: string,
    message: {
      senderId: string;
      createdAt: Date;
      mediaGoneAt: Date | null;
      opens: ReadonlyArray<{ userId: string }>;
    },
    members: ReadonlyArray<{ userId: string; joinedAt: Date }>,
    now = new Date(),
  ): OnceState {
    const recipients = ViewOnceService.recipientsOf(message, members);
    return {
      opened:
        viewerId !== message.senderId &&
        message.opens.some((o) => o.userId === viewerId),
      openedCount: message.opens.length,
      recipients: recipients.length,
      gone:
        message.mediaGoneAt !== null ||
        ViewOnceService.expired(message.createdAt, now),
    };
  }

  /**
   * A view-once message's attachments as a client may see them: what kind,
   * how big, how long -- and no address. The URL is empty and the path is
   * never selected.
   */
  static withoutAddress<T extends { url: string; thumbnailUrl: string | null }>(
    media: T[],
  ): T[] {
    return media.map((m) => ({ ...m, url: '', thumbnailUrl: null }));
  }

  /**
   * Opens a view-once message, once.
   *
   * Recorded before the link is made, and the record is what decides: a
   * second request finds the row and is refused, whatever happened to the
   * first link. The trade is the one every view-once feature makes -- an
   * open that dies on a bad connection is still an open.
   */
  async open(
    viewerId: string,
    conversationId: string,
    messageId: string,
  ): Promise<OnceOpened> {
    const message = await this.prisma.message.findFirst({
      where: {
        id: messageId,
        conversationId,
        deletedAt: null,
        conversation: { members: { some: { userId: viewerId } } },
      },
      select: {
        id: true,
        senderId: true,
        createdAt: true,
        viewOnce: true,
        mediaGoneAt: true,
        media: {
          select: {
            kind: true,
            privatePath: true,
            width: true,
            height: true,
            durationMs: true,
            waveform: true,
          },
          take: 1,
        },
        conversation: {
          select: { members: { select: { userId: true, joinedAt: true } } },
        },
      },
    });
    // Not found for one the reader is not in, or that is not view once:
    // neither is anything they can open this way.
    if (!message || !message.viewOnce) {
      throw new NotFoundException('That message is gone.');
    }
    if (message.senderId === viewerId) {
      throw new ForbiddenException(
        'You sent this to be viewed once. It cannot be opened again from here.',
      );
    }
    const recipients = ViewOnceService.recipientsOf(
      message,
      message.conversation.members,
    );
    if (!recipients.includes(viewerId)) {
      throw new NotFoundException('That message is gone.');
    }
    const media = message.media[0];
    if (
      !media?.privatePath ||
      message.mediaGoneAt ||
      ViewOnceService.expired(message.createdAt)
    ) {
      throw new GoneException('This has expired.');
    }

    try {
      await this.prisma.messageOpen.create({
        data: { messageId, userId: viewerId },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new GoneException('You have already opened this.');
      }
      throw error;
    }

    const seconds = ViewOnceService.linkSeconds(media.kind, media.durationMs);
    const url = await this.supabase.signPrivate(media.privatePath, seconds);
    const expiresAt = new Date(Date.now() + seconds * 1000);

    // Everybody it went to has opened it: it can go once the last link has
    // run out, and not before -- deleting it now would cut off the person
    // who is loading it.
    const opened = await this.prisma.messageOpen.count({
      where: { messageId, userId: { in: recipients } },
    });
    if (opened >= recipients.length) {
      await this.prisma.message.update({
        where: { id: messageId },
        data: { purgeAfter: expiresAt },
      });
    }

    // So the sender's bubble says Opened without waiting for a refresh. Ids
    // only, like every other message event.
    this.delivery.tell(message.senderId, {
      type: 'message.opened',
      conversationId,
      messageId,
    });

    return {
      url,
      expiresAt,
      kind: media.kind,
      width: media.width,
      height: media.height,
      durationMs: media.durationMs,
      waveform: media.waveform,
    };
  }

  onModuleInit(): void {
    this.timer = setInterval(() => void this.sweep(), ViewOnceService.sweepMs);
    // So a pending tick cannot hold the process open on shutdown.
    this.timer.unref();
  }

  onModuleDestroy(): void {
    if (this.timer) clearInterval(this.timer);
    this.timer = null;
  }

  /**
   * Deletes what is done with: opened by everybody, withdrawn by its sender,
   * or kept [ttlDays] unopened. Answers how many messages it cleared.
   *
   * Storage first, then the rows: a file deleted whose row still points at it
   * is retried next time and the delete is a no-op, while a row cleared whose
   * file survived would leave a file nothing can find.
   */
  async sweep(now = new Date()): Promise<number> {
    try {
      const due = await this.prisma.message.findMany({
        where: {
          viewOnce: true,
          mediaGoneAt: null,
          OR: [
            { purgeAfter: { lte: now } },
            { deletedAt: { not: null } },
            {
              createdAt: {
                lte: new Date(
                  now.getTime() - ViewOnceService.ttlDays * 86_400_000,
                ),
              },
            },
          ],
        },
        select: { id: true, media: { select: { privatePath: true } } },
        take: 200,
      });
      if (due.length === 0) return 0;

      const paths = due.flatMap((m) =>
        m.media.flatMap((media) =>
          media.privatePath ? [media.privatePath] : [],
        ),
      );
      await this.supabase.removePrivate(paths);
      const ids = due.map((m) => m.id);
      await this.prisma.$transaction([
        this.prisma.media.updateMany({
          where: { messageId: { in: ids } },
          data: { privatePath: null },
        }),
        this.prisma.message.updateMany({
          where: { id: { in: ids } },
          data: { mediaGoneAt: now },
        }),
      ]);
      this.logger.log(`view-once: cleared ${ids.length} attachment(s)`);
      return ids.length;
    } catch (error) {
      // Tried again on the next tick. Nothing here is lost by waiting.
      this.logger.warn(`view-once sweep failed: ${String(error)}`);
      return 0;
    }
  }
}
