import {
  listPurchasedCoinNotices,
  netPurchasedCoinRecovery,
  PURCHASE_RECOVERY_CORRECTION,
  PURCHASE_RECOVERY_SOURCE,
} from '../financial-ledger/purchased-coin-recovery';
import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { AccountStatus, CoinKind, Prisma } from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { DeliveryService } from '../push/delivery.service';
import { planCreatorEarning } from '../financial-ledger/creator-earnings.service';
import { GIFT_CATALOGUE, type GiftType, giftType } from './gift-catalogue';

/** What a wallet screen shows. */
export interface Wallet {
  /** All spendable legacy, reward-promotional and purchased coins, less gifts sent. */
  coins: number;
  /** Purchased coins remaining after gifts; separate for transparent wallet reporting. */
  purchased: number;
  /** Remaining balance from the retired weekly complimentary grant. */
  legacyComplimentary: number;
  /** All non-spendable creator proceeds, including legacy complimentary proceeds. */
  earned: number;
  /** All proceeds eligible for withdrawal: purchased-coin and reward-funded gifts. */
  withdrawableEarned: number;
  /** Source breakdown; purchase-funded proceeds are withdrawable. */
  purchaseFundedEarned: number;
  /** Source breakdown; approved reward-funded proceeds are also withdrawable. */
  rewardFundedEarned: number;
  /** Historical proceeds from retired weekly complimentary credits; not withdrawable. */
  promotionalEarned: number;
  /** Unspent promotional reward credits. */
  promotional: number;
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
 * The original weekly complimentary grant is retired. Existing unspent
 * grants remain as grandfathered legacy balances; no new automatic grants
 * are issued. The ledger keeps the source of every spend and creator credit
 * explicit so later purchase and payout systems cannot mix promotional value:
 *
 * - **A ledger, not a balance.** Every movement is a CoinEntry, and a balance
 *   is their sum. Nothing is ever updated in place.
 * - **Reward proceeds are withdrawable.** Approved reward-coin spending
 *   creates REWARD_EARN, on the same terms as purchase-funded PURCHASE_EARN.
 *   Retired weekly complimentary spending stays PROMOTIONAL_EARN and is not
 *   withdrawable. Legacy EARN rows have unknown provenance and stay excluded.
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

  /** The reader's current wallet; reading it never issues new coins. */
  async walletWithNotices(userId: string) {
    return this.prisma.$transaction(async (tx) => {
      await this.lock(tx, userId);
      const wallet = await this.balances(tx, userId);
      const recoveryNotices = await listPurchasedCoinNotices(tx, userId);
      return { ...wallet, recoveryNotices };
    });
  }

  async wallet(userId: string, _at?: Date): Promise<Wallet> {
    // Retain the former optional timestamp argument for callers compiled
    // against the earlier wallet API; it no longer drives a refill.
    void _at;
    return this.prisma.$transaction(async (tx) => {
      await this.lock(tx, userId);
      return this.balances(tx, userId);
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

      const { coins } = await this.balances(tx, senderId);
      if (coins < kind.coins) {
        throw new BadRequestException(
          `A ${kind.name} costs ${kind.coins} coins and you have ${coins}. ` +
            'New coins are issued through Kyron reward programmes; wallets are not refilled automatically.',
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
      // Capture the financial facts before any social record can be deleted.
      // This snapshot has no FK to the sender, recipient, post or comment.
      await tx.financialSourceRecord.create({
        data: {
          sourceType: 'GIFT',
          sourceId: gift.id,
          eventType: 'GIFT_SENT',
          actorId: senderId,
          beneficiaryId: recipientId,
          relatedIds: { postId, commentId },
          amount: kind.coins,
          unitCode: 'COIN',
          payload: {
            type: kind.type,
            coins: kind.coins,
            requestId: input.requestId,
          },
          occurredAt: gift.createdAt,
        },
      });
      const spendEntries = await this.spendFromWallet(
        tx,
        senderId,
        kind.coins,
        gift.id,
      );
      // Preserve the source of the coins used for this gift. Proceeds funded
      // by approved rewards are withdrawable exactly like PURCHASE_EARN;
      // historical weekly complimentary proceeds keep their old treatment.
      const creatorEarnings = spendEntries.map((entry) => {
        const rewardFunded = entry.kind === CoinKind.REWARD_SPEND;
        const purchaseFunded = entry.kind === CoinKind.PURCHASE_SPEND;
        const source = rewardFunded
          ? 'reward'
          : purchaseFunded
            ? 'purchase'
            : 'legacy';
        return {
          userId: recipientId,
          kind: rewardFunded
            ? CoinKind.REWARD_EARN
            : purchaseFunded
              ? CoinKind.PURCHASE_EARN
              : CoinKind.PROMOTIONAL_EARN,
          amount: -entry.amount,
          key: `gift:${gift.id}:${source}-earn`,
          giftId: gift.id,
        };
      });
      await tx.coinEntry.createMany({
        data: [...spendEntries, ...creatorEarnings],
      });
      await tx.creatorEarning.createMany({
        data: creatorEarnings.map((entry) =>
          planCreatorEarning({
            userId: entry.userId,
            kind: entry.kind,
            amount: entry.amount,
            key: entry.key,
            giftId: entry.giftId ?? null,
          }),
        ),
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
    // Idempotent retries do not depend on a wallet/refill timestamp anymore.
    void now;
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
      wallet: await this.balances(tx, senderId),
      gifts: target?.giftCount ?? 0,
    };
  }

  private async balances(tx: Tx, userId: string): Promise<Wallet> {
    const balances = await this.ledgerBalances(tx, userId);
    return {
      coins:
        balances.legacyComplimentary +
        balances.promotional +
        balances.purchased,
      legacyComplimentary: balances.legacyComplimentary,
      purchased: balances.purchased,
      earned:
        balances.earned +
        balances.purchaseFundedEarned +
        balances.rewardFundedEarned +
        balances.promotionalEarned,
      withdrawableEarned:
        balances.purchaseFundedEarned + balances.rewardFundedEarned,
      purchaseFundedEarned: balances.purchaseFundedEarned,
      rewardFundedEarned: balances.rewardFundedEarned,
      promotionalEarned: balances.promotionalEarned,
      promotional: balances.promotional,
    };
  }

  /**
   * Grandfathered complimentary credits and reward credits are separate
   * spendable buckets. No code path replenishes the legacy balance.
   */
  private async ledgerBalances(
    tx: Tx,
    userId: string,
  ): Promise<{
    legacyComplimentary: number;
    promotional: number;
    purchased: number;
    earned: number;
    purchaseFundedEarned: number;
    promotionalEarned: number;
    rewardFundedEarned: number;
  }> {
    const sums = await tx.coinEntry.groupBy({
      by: ['kind'],
      where: { userId },
      _sum: { amount: true },
    });
    const sum = (kind: CoinKind) =>
      sums.find((row) => row.kind === kind)?._sum.amount ?? 0;
    return {
      // GRANT/SPEND are retained only to honour balances issued before the
      // weekly complimentary programme was retired.
      legacyComplimentary: sum(CoinKind.GRANT) + sum(CoinKind.SPEND),
      promotional: sum(CoinKind.REWARD_GRANT) + sum(CoinKind.REWARD_SPEND),
      purchased:
        sum(CoinKind.PURCHASE_GRANT) +
        sum(CoinKind.PURCHASE_SPEND) -
        (await netPurchasedCoinRecovery(tx, userId)),
      // EARN is legacy test history with unknown provenance and remains
      // outside the withdrawable amount.
      earned: sum(CoinKind.EARN),
      purchaseFundedEarned: sum(CoinKind.PURCHASE_EARN),
      rewardFundedEarned: sum(CoinKind.REWARD_EARN),
      promotionalEarned: sum(CoinKind.PROMOTIONAL_EARN),
    };
  }

  /** Spend grandfathered credits, then reward credits, then purchased coins. */
  private async spendFromWallet(
    tx: Tx,
    userId: string,
    amount: number,
    giftId: string,
  ): Promise<Prisma.CoinEntryCreateManyInput[]> {
    const balances = await this.ledgerBalances(tx, userId);
    const legacyComplimentary = Math.max(0, balances.legacyComplimentary);
    const promotional = Math.max(0, balances.promotional);
    const purchased = Math.max(0, balances.purchased);
    if (legacyComplimentary + promotional + purchased < amount) {
      throw new BadRequestException('Your wallet no longer covers this gift.');
    }

    const legacySpend = Math.min(legacyComplimentary, amount);
    const promotionalSpend = Math.min(promotional, amount - legacySpend);
    const purchasedSpend = amount - legacySpend - promotionalSpend;
    const entries: Prisma.CoinEntryCreateManyInput[] = [];
    if (legacySpend > 0) {
      entries.push({
        userId,
        kind: CoinKind.SPEND,
        amount: -legacySpend,
        key: `gift:${giftId}:legacy-spend`,
        giftId,
      });
    }
    if (promotionalSpend > 0) {
      entries.push({
        userId,
        kind: CoinKind.REWARD_SPEND,
        amount: -promotionalSpend,
        key: `gift:${giftId}:reward-spend`,
        giftId,
      });
    }
    if (purchasedSpend > 0) {
      await this.recordPurchasedSpendAllocation(
        tx,
        userId,
        giftId,
        purchasedSpend,
      );
      entries.push({
        userId,
        kind: CoinKind.PURCHASE_SPEND,
        amount: -purchasedSpend,
        key: `gift:${giftId}:purchase-spend`,
        giftId,
      });
    }
    return entries;
  }

  private async recordPurchasedSpendAllocation(
    tx: Tx,
    userId: string,
    giftId: string,
    purchasedSpend: number,
  ) {
    // The caller holds the buyer wallet lock. Historical spends could have
    // come from any prior credit, so reserve the unknown amount against
    // each lot rather than assigning an invented historical FIFO order.
    const lots = await tx.$queryRaw<
      { purchaseId: string; available: bigint }[]
    >`
      WITH allocations AS (
        SELECT item."purchaseId", SUM(item.coins) AS coins
        FROM "FinancialSourceRecord" evidence
        CROSS JOIN LATERAL jsonb_to_recordset(evidence.payload->'allocations')
          AS item("purchaseId" uuid, coins integer)
        WHERE evidence."sourceType" = 'GIFT_PURCHASE_SPEND_ALLOCATION'
          AND evidence."beneficiaryId" = ${userId}::uuid
        GROUP BY item."purchaseId"
      ), recoveries AS (
        SELECT evidence."relatedIds"->>'purchaseId' AS purchase_id,
               SUM(CASE WHEN evidence."sourceType" = ${PURCHASE_RECOVERY_SOURCE}
                        THEN evidence.amount ELSE -evidence.amount END) AS coins
        FROM "FinancialSourceRecord" evidence
        WHERE evidence."sourceType" IN (
          ${PURCHASE_RECOVERY_SOURCE}, ${PURCHASE_RECOVERY_CORRECTION}
        )
          AND evidence."beneficiaryId" = ${userId}::uuid
        GROUP BY evidence."relatedIds"->>'purchaseId'
      ), unknown_spend AS (
        SELECT GREATEST(
          COALESCE(SUM(-entry.amount::bigint), 0) -
          (SELECT COALESCE(SUM(coins), 0) FROM allocations), 0
        ) AS coins
        FROM "CoinEntry" entry
        WHERE entry."userId" = ${userId}::uuid AND entry.kind = 'PURCHASE_SPEND'
          AND entry.amount < 0
      )
      SELECT purchase.id AS "purchaseId", balance.available
      FROM "GooglePlayPurchase" purchase
      JOIN "CoinEntry" credit ON credit.key = purchase."coinEntryKey"
      LEFT JOIN allocations ON allocations."purchaseId" = purchase.id
      LEFT JOIN recoveries ON recoveries.purchase_id = purchase.id::text
      CROSS JOIN unknown_spend
      CROSS JOIN LATERAL (
        SELECT (
          credit.amount - COALESCE(allocations.coins, 0) -
          unknown_spend.coins - COALESCE(recoveries.coins, 0)
        )::bigint AS available
      ) balance
      WHERE purchase."userId" = ${userId}::uuid
        AND credit."userId" = purchase."userId"
        AND credit.kind = 'PURCHASE_GRANT'
        AND credit.amount = purchase."coinAmount"
        AND purchase.status IN ('VERIFIED', 'CONSUMED')
        AND balance.available > 0
      ORDER BY credit."createdAt", purchase.id
    `;
    let remaining = purchasedSpend;
    const allocations = [];
    for (const lot of lots) {
      if (remaining === 0) break;
      const coins = Math.min(remaining, Number(lot.available));
      allocations.push({ purchaseId: lot.purchaseId, coins });
      remaining -= coins;
    }

    await tx.financialSourceRecord.create({
      data: {
        sourceType: 'GIFT_PURCHASE_SPEND_ALLOCATION',
        sourceId: giftId,
        eventType: 'PURCHASED_COINS_SPENT',
        actorId: userId,
        beneficiaryId: userId,
        relatedIds: { giftId },
        amount: purchasedSpend,
        unitCode: 'COIN',
        payload: { allocations, unattributedCoins: remaining },
        occurredAt: new Date(),
      },
    });
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
