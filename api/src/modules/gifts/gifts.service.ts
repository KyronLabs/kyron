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
  /** The post's gift count after this one. */
  gifts: number;
}

export interface GiftSummary {
  total: number;
  byType: (GiftType & { count: number })[];
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

  async send(
    senderId: string,
    postId: string,
    input: { type: string; requestId: string },
    now = new Date(),
  ): Promise<SentGift> {
    const kind = giftType(input.type);
    if (!kind) throw new BadRequestException('There is no such gift.');

    const post = await this.prisma.post.findFirst({
      where: {
        id: postId,
        deletedAt: null,
        author: { status: { not: AccountStatus.BANNED } },
      },
      select: { authorId: true },
    });
    if (!post) throw new NotFoundException('Post not found.');
    if (post.authorId === senderId) {
      throw new BadRequestException("You can't send a gift to your own post.");
    }
    // NotFound, as the feed answers: a block does not confirm the post exists.
    if (await this.blockedEitherWay(senderId, post.authorId)) {
      throw new NotFoundException('Post not found.');
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
        if (earlier.postId !== postId || earlier.type !== kind.type) {
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
          recipientId: post.authorId,
          postId,
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
            userId: post.authorId,
            kind: CoinKind.EARN,
            amount: kind.coins,
            key: `gift:${gift.id}:earn`,
            giftId: gift.id,
          },
        ],
      });
      await tx.post.update({
        where: { id: postId },
        data: { giftCount: { increment: 1 } },
      });
      return {
        result: await this.answer(tx, gift, senderId, now),
        created: true,
      };
    });

    // Over the socket only. A push needs its words in every language the
    // push catalogue carries (push/copy), which a test version does not.
    if (created) {
      this.delivery.tell(post.authorId, {
        type: 'notification.new',
        kind: 'gift',
        actorId: senderId,
        postId,
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
      where: { postId },
      _count: { _all: true },
    });
    const byType = GIFT_CATALOGUE.map((kind) => ({
      ...kind,
      count: counts.find((row) => row.type === kind.type)?._count._all ?? 0,
    })).filter((row) => row.count > 0);
    return { total: post.giftCount, byType };
  }

  private async answer(
    tx: Tx,
    gift: {
      id: string;
      type: string;
      coins: number;
      createdAt: Date;
      postId: string;
    },
    senderId: string,
    now: Date,
  ): Promise<SentGift> {
    const post = await tx.post.findUnique({
      where: { id: gift.postId },
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
      gifts: post?.giftCount ?? 0,
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
