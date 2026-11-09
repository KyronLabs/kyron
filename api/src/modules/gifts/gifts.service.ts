import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { AccountStatus, CoinKind, Prisma } from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { DeliveryService } from '../push/delivery.service';
import {
  GIFT_CATALOGUE,
  type GiftType,
  WEEKLY_COINS,
  giftType,
  nextRefill,
  weekStart,
} from './gift-catalogue';

/** What a wallet screen shows. */
export interface Wallet {
  /** What can be spent: test coins from the weekly refill, less gifts sent. */
  coins: number;
  /** What this account's posts have been given. Cannot be spent. */
  earned: number;
  /** What the refill tops coins up to. */
  weeklyCoins: number;
  refillsAt: Date;
}

export interface SentGift {
  gift: { id: string; type: string; coins: number; createdAt: Date };
  wallet: Wallet;
  /** The gift count, after this one, of what it was sent to. */
  gifts: number;
}

export interface GiftSummary {
  total: number;
  byType: (GiftType & { count: number })[];
  /** Who gave it something, and what: the biggest giver first. */
  senders: GiftSender[];
}

/** One person who gave a post gifts, and every gift they gave it. */
export interface GiftSender {
  user: {
    id: string;
    name: string | null;
    username: string | null;
    avatarUrl: string | null;
    verified: boolean;
  };
  /** What they spent on it in all. */
  coins: number;
  /** Each kind they sent and how many, most valuable first. */
  gifts: { type: string; name: string; count: number }[];
  /** When they last gave it one. */
  lastAt: Date;
}

type Tx = Prisma.TransactionClient;

/**
 * Gifts: spending coins on somebody else's post.
 *
 * A test version. Coins come only from the weekly refill and earnings cannot
 * be withdrawn, so nothing here is money yet. It is built the way money
 * needs it anyway, because retrofitting that is the expensive part:
 *
 * - **A ledger, not a balance.** Every movement is a CoinEntry, and a balance
 *   is their sum. Nothing is ever updated in place.
 * - **Nothing twice.** Each entry has a unique key, and each send carries the
 *   app's requestId, so a retry or a double tap is the same gift.
 * - **One spender at a time.** Every change to a wallet locks the account's
 *   row first, so two gifts sent at once cannot both spend the same coins.
 *
 * Gifts are shown on a post and tell its author. They are not read by
 * ranking: see Post.giftCount.
 */
@Injectable()
export class GiftsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly delivery: DeliveryService,
  ) {}

  catalogue(): readonly GiftType[] {
    return GIFT_CATALOGUE;
  }

  /** The reader's wallet, refilled first if a new week has started. */
  async wallet(userId: string, now = new Date()): Promise<Wallet> {
    return this.prisma.$transaction(async (tx) => {
      await this.lock(tx, userId);
      await this.refill(tx, userId, now);
      return this.balances(tx, userId, now);
    });
  }

  /** A gift to a post. */
  async send(
    senderId: string,
    postId: string,
    input: { type: string; requestId: string },
    now = new Date(),
  ): Promise<SentGift> {
    const post = await this.prisma.post.findFirst({
      where: {
        id: postId,
        deletedAt: null,
        author: { status: { not: AccountStatus.BANNED } },
      },
      select: { authorId: true },
    });
    if (!post) throw new NotFoundException('Post not found.');
    return this.sendTo(
      senderId,
      { postId, commentId: null, recipientId: post.authorId, what: 'post' },
      input,
      now,
    );
  }

  /**
   * A gift to a comment: to whoever wrote it, not to the post's author.
   *
   * The same ledger, the same idempotency and the same wallet lock as a gift
   * to a post. The row keeps the post it was written under, so a post's page
   * can find it, but it counts on the comment -- Comment.giftCount -- and
   * never on the post.
   */
  async sendToComment(
    senderId: string,
    commentId: string,
    input: { type: string; requestId: string },
    now = new Date(),
  ): Promise<SentGift> {
    const comment = await this.prisma.comment.findFirst({
      where: {
        id: commentId,
        deletedAt: null,
        author: { status: { not: AccountStatus.BANNED } },
        post: {
          deletedAt: null,
          author: { status: { not: AccountStatus.BANNED } },
        },
      },
      select: { authorId: true, postId: true },
    });
    if (!comment) throw new NotFoundException('Comment not found.');
    return this.sendTo(
      senderId,
      {
        postId: comment.postId,
        commentId,
        recipientId: comment.authorId,
        what: 'comment',
      },
      input,
      now,
    );
  }

  private async sendTo(
    senderId: string,
    target: {
      postId: string;
      commentId: string | null;
      recipientId: string;
      what: 'post' | 'comment';
    },
    input: { type: string; requestId: string },
    now: Date,
  ): Promise<SentGift> {
    const kind = giftType(input.type);
    if (!kind) throw new BadRequestException('There is no such gift.');

    const { postId, commentId, recipientId, what } = target;
    const missing = what === 'post' ? 'Post not found.' : 'Comment not found.';
    if (recipientId === senderId) {
      throw new BadRequestException(
        `You can't send a gift to your own ${what}.`,
      );
    }
    // NotFound, as the feed answers: a block does not confirm it exists.
    if (await this.blockedEitherWay(senderId, recipientId)) {
      throw new NotFoundException(missing);
    }

    const { result, created } = await this.prisma.$transaction(async (tx) => {
      // Before anything is read, so a second request for the same wallet
      // waits here and then sees what the first one wrote.
      await this.lock(tx, senderId);

      const earlier = await tx.gift.findUnique({
        where: {
          senderId_requestId: { senderId, requestId: input.requestId },
        },
      });
      if (earlier) {
        if (
          earlier.postId !== postId ||
          earlier.commentId !== commentId ||
          earlier.type !== kind.type
        ) {
          throw new ConflictException(
            'That request was already used for a different gift.',
          );
        }
        return {
          result: await this.answer(tx, earlier, senderId, now),
          created: false,
        };
      }

      await this.refill(tx, senderId, now);
      const { coins } = await this.balances(tx, senderId, now);
      if (coins < kind.coins) {
        throw new BadRequestException(
          `A ${kind.name} costs ${kind.coins} coins and you have ${coins}. ` +
            'Your coins refill every Monday.',
        );
      }

      const gift = await tx.gift.create({
        data: {
          senderId,
          recipientId,
          postId,
          commentId,
          type: kind.type,
          coins: kind.coins,
          requestId: input.requestId,
        },
      });
      await tx.coinEntry.createMany({
        data: [
          {
            userId: senderId,
            kind: CoinKind.SPEND,
            amount: -kind.coins,
            key: `gift:${gift.id}:spend`,
            giftId: gift.id,
          },
          {
            userId: recipientId,
            kind: CoinKind.EARN,
            amount: kind.coins,
            key: `gift:${gift.id}:earn`,
            giftId: gift.id,
          },
        ],
      });
      // One statement, so two gifts of new kinds arriving at once both land:
      // a read-then-write would lose one of them.
      if (commentId === null) {
        await tx.$executeRaw`
          UPDATE "Post"
          SET "giftCount" = "giftCount" + 1,
              "giftTypes" = CASE
                WHEN ${kind.type} = ANY("giftTypes") THEN "giftTypes"
                ELSE array_append("giftTypes", ${kind.type}::text)
              END
          WHERE id = ${postId}::uuid
        `;
      } else {
        await tx.$executeRaw`
          UPDATE "Comment"
          SET "giftCount" = "giftCount" + 1,
              "giftTypes" = CASE
                WHEN ${kind.type} = ANY("giftTypes") THEN "giftTypes"
                ELSE array_append("giftTypes", ${kind.type}::text)
              END
          WHERE id = ${commentId}::uuid
        `;
      }
      return {
        result: await this.answer(tx, gift, senderId, now),
        created: true,
      };
    });

    // Over the socket only. A push needs its words in every language the
    // push catalogue carries (push/copy), which a test version does not.
    if (created) {
      this.delivery.tell(recipientId, {
        type: 'notification.new',
        kind: 'gift',
        actorId: senderId,
        postId,
        ...(commentId === null ? {} : { commentId }),
      });
    }
    return result;
  }

  /** How many of each gift a post has been given. */
  async summary(postId: string, viewerId: string): Promise<GiftSummary> {
    const post = await this.prisma.post.findFirst({
      where: {
        id: postId,
        deletedAt: null,
        author: { status: { not: AccountStatus.BANNED } },
      },
      select: { authorId: true, giftCount: true },
    });
    if (!post) throw new NotFoundException('Post not found.');
    if (
      post.authorId !== viewerId &&
      (await this.blockedEitherWay(viewerId, post.authorId))
    ) {
      throw new NotFoundException('Post not found.');
    }

    const counts = await this.prisma.gift.groupBy({
      by: ['type'],
      // The post's own gifts: those sent to its replies are theirs.
      where: { postId, commentId: null },
      _count: { _all: true },
    });
    const byType = GIFT_CATALOGUE.map((kind) => ({
      ...kind,
      count: counts.find((row) => row.type === kind.type)?._count._all ?? 0,
    })).filter((row) => row.count > 0);
    return {
      total: post.giftCount,
      byType,
      senders: await this.senders(postId, viewerId),
    };
  }

  /** The most people a post's list of givers names. */
  static readonly sendersShown = 100;

  /**
   * Who gave [postId] gifts, grouped by person, the biggest giver first --
   * the list the gift pill opens. Not those either side has blocked, nobody
   * whose account has gone, and nobody banned.
   */
  private async senders(
    postId: string,
    viewerId: string,
  ): Promise<GiftSender[]> {
    const blocks = await this.prisma.block.findMany({
      where: { OR: [{ blockerId: viewerId }, { blockedId: viewerId }] },
      select: { blockerId: true, blockedId: true },
    });
    const blocked = blocks.map((b) =>
      b.blockerId === viewerId ? b.blockedId : b.blockerId,
    );
    const rows = await this.prisma.gift.findMany({
      where: {
        postId,
        commentId: null,
        senderId: { not: null, notIn: blocked },
        sender: { status: { not: AccountStatus.BANNED } },
      },
      orderBy: { createdAt: 'desc' },
      // A post's gifts, not a feed's: thousands at the very most.
      take: 5000,
      select: {
        type: true,
        coins: true,
        createdAt: true,
        sender: {
          select: {
            id: true,
            name: true,
            username: true,
            verifiedAt: true,
            profile: { select: { avatarUrl: true } },
          },
        },
      },
    });

    const price = (type: string) => giftType(type)?.coins ?? 0;
    const people = new Map<
      string,
      GiftSender & { kinds: Map<string, number> }
    >();
    for (const row of rows) {
      const who = row.sender;
      if (!who) continue;
      let entry = people.get(who.id);
      if (!entry) {
        entry = {
          user: {
            id: who.id,
            name: who.name,
            username: who.username,
            avatarUrl: who.profile?.avatarUrl ?? null,
            verified: !!who.verifiedAt,
          },
          coins: 0,
          gifts: [],
          // Rows come newest first: the first one seen is the latest.
          lastAt: row.createdAt,
          kinds: new Map(),
        };
        people.set(who.id, entry);
      }
      entry.coins += row.coins;
      entry.kinds.set(row.type, (entry.kinds.get(row.type) ?? 0) + 1);
    }

    return [...people.values()]
      .sort(
        (a, b) => b.coins - a.coins || b.lastAt.getTime() - a.lastAt.getTime(),
      )
      .slice(0, GiftsService.sendersShown)
      .map(({ kinds, ...sender }) => ({
        ...sender,
        gifts: [...kinds.entries()]
          .sort(([a], [b]) => price(b) - price(a))
          .map(([type, count]) => ({
            type,
            name: giftType(type)?.name ?? 'Gift',
            count,
          })),
      }));
  }

  private async answer(
    tx: Tx,
    gift: {
      id: string;
      type: string;
      coins: number;
      createdAt: Date;
      postId: string;
      commentId: string | null;
    },
    senderId: string,
    now: Date,
  ): Promise<SentGift> {
    // The count of whatever the gift went to.
    const target =
      gift.commentId === null
        ? await tx.post.findUnique({
            where: { id: gift.postId },
            select: { giftCount: true },
          })
        : await tx.comment.findUnique({
            where: { id: gift.commentId },
            select: { giftCount: true },
          });
    return {
      gift: {
        id: gift.id,
        type: gift.type,
        coins: gift.coins,
        createdAt: gift.createdAt,
      },
      wallet: await this.balances(tx, senderId, now),
      gifts: target?.giftCount ?? 0,
    };
  }

  /**
   * Tops the wallet up to [WEEKLY_COINS], once a week.
   *
   * The week's entry is written even when it adds nothing. Without it, an
   * account that started the week full would be refilled again after its
   * first gift, and every gift after that.
   */
  private async refill(tx: Tx, userId: string, now: Date): Promise<void> {
    const key = `grant:${userId}:${weekStart(now).toISOString().slice(0, 10)}`;
    const done = await tx.coinEntry.findUnique({
      where: { key },
      select: { id: true },
    });
    if (done) return;
    const { coins } = await this.balances(tx, userId, now);
    await tx.coinEntry.create({
      data: {
        userId,
        kind: CoinKind.GRANT,
        amount: Math.max(0, WEEKLY_COINS - coins),
        key,
      },
    });
  }

  private async balances(tx: Tx, userId: string, now: Date): Promise<Wallet> {
    const sums = await tx.coinEntry.groupBy({
      by: ['kind'],
      where: { userId },
      _sum: { amount: true },
    });
    const sum = (kind: CoinKind) =>
      sums.find((row) => row.kind === kind)?._sum.amount ?? 0;
    return {
      coins: sum(CoinKind.GRANT) + sum(CoinKind.SPEND),
      earned: sum(CoinKind.EARN),
      weeklyCoins: WEEKLY_COINS,
      refillsAt: nextRefill(now),
    };
  }

  /** Holds the account's row until the transaction ends. */
  private async lock(tx: Tx, userId: string): Promise<void> {
    await tx.$queryRaw`SELECT 1 FROM "User" WHERE id = ${userId}::uuid FOR UPDATE`;
  }

  private async blockedEitherWay(a: string, b: string): Promise<boolean> {
    const block = await this.prisma.block.findFirst({
      where: {
        OR: [
          { blockerId: a, blockedId: b },
          { blockerId: b, blockedId: a },
        ],
      },
      select: { id: true },
    });
    return block !== null;
  }
}
