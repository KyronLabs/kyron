import {
  BadRequestException,
  ConflictException,
  Injectable,
  ServiceUnavailableException,
} from '@nestjs/common';
import { CoinKind, GooglePlayPurchaseStatus, Prisma } from '@prisma/client';
import { createCipheriv, createHash, randomBytes } from 'node:crypto';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { LedgerService } from '../financial-ledger/ledger.service';
import {
  GooglePlayDeveloperApiProvider,
  type GooglePlayOrder,
  type GooglePlayProductPurchaseV2,
} from './google-play-developer-api.provider';

const DEFAULT_PACKAGE_NAME = 'so.kyron.app';
const MAX_POSTGRES_INT = 2_147_483_647;
const MAX_PURCHASE_QUANTITY = 1000;
const TOKEN_PREFIX = 'v1';

export interface GooglePlayCoinProduct {
  productId: string;
  coins: number;
}

export interface GooglePlayCatalogue {
  enabled: boolean;
  packageName: string;
  accountObfuscationId: string | null;
  products: GooglePlayCoinProduct[];
}

interface PurchaseMoney {
  currencyCode: string;
  amountNanos: bigint;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return value !== null && typeof value === 'object' && !Array.isArray(value);
}

function parseProducts(raw: string | undefined): GooglePlayCoinProduct[] | null {
  if (!raw) return null;
  try {
    const parsed: unknown = JSON.parse(raw);
    if (!Array.isArray(parsed) || parsed.length === 0 || parsed.length > 100) {
      return null;
    }
    const seen = new Set<string>();
    const products: GooglePlayCoinProduct[] = [];
    for (const item of parsed) {
      if (!isRecord(item)) return null;
      const productId = item.productId;
      const coins = item.coins;
      if (
        typeof productId !== 'string' ||
        !/^[A-Za-z0-9._-]{1,160}$/.test(productId) ||
        seen.has(productId) ||
        typeof coins !== 'number' ||
        !Number.isSafeInteger(coins) ||
        coins <= 0 ||
        coins > MAX_POSTGRES_INT
      ) {
        return null;
      }
      seen.add(productId);
      products.push({ productId, coins });
    }
    return products;
  } catch {
    return null;
  }
}

function tokenHash(token: string): string {
  return createHash('sha256').update(token, 'utf8').digest('hex');
}

function accountObfuscationId(userId: string): string {
  return createHash('sha256')
    .update('kyron/google-play/account/v1:', 'utf8')
    .update(userId, 'utf8')
    .digest('hex');
}

function encryptionKey(): Buffer | null {
  const raw = process.env.GOOGLE_PLAY_TOKEN_ENCRYPTION_KEY;
  if (!raw || !/^[A-Za-z0-9+/]+={0,2}$/.test(raw)) return null;
  const decoded = Buffer.from(raw, 'base64');
  if (
    decoded.length !== 32 ||
    decoded.toString('base64').replace(/=+$/, '') !== raw.replace(/=+$/, '')
  ) {
    return null;
  }
  return decoded;
}

function encryptPurchaseToken(token: string, key: Buffer): string {
  const nonce = randomBytes(12);
  const cipher = createCipheriv('aes-256-gcm', key, nonce);
  const ciphertext = Buffer.concat([
    cipher.update(token, 'utf8'),
    cipher.final(),
  ]);
  const tag = cipher.getAuthTag();
  return [
    TOKEN_PREFIX,
    nonce.toString('base64url'),
    tag.toString('base64url'),
    ciphertext.toString('base64url'),
  ].join('.');
}

function moneyNanos(
  money:
    | { currencyCode?: string; units?: string; nanos?: number }
    | null
    | undefined,
): PurchaseMoney | null {
  if (
    !money ||
    typeof money.currencyCode !== 'string' ||
    !/^[A-Z]{3}$/.test(money.currencyCode) ||
    (money.units !== undefined && !/^-?\d+$/.test(money.units)) ||
    (money.nanos !== undefined &&
      (!Number.isInteger(money.nanos) ||
        Math.abs(money.nanos) > 999_999_999))
  ) {
    return null;
  }
  try {
    const units = BigInt(money.units ?? '0');
    const nanos = BigInt(money.nanos ?? 0);
    return {
      currencyCode: money.currencyCode,
      amountNanos: units * 1_000_000_000n + nanos,
    };
  } catch {
    return null;
  }
}

function acknowledgementState(value: string | undefined): number {
  return value === 'ACKNOWLEDGEMENT_STATE_ACKNOWLEDGED' ? 1 : 0;
}

function isConsumed(value: string | undefined): boolean {
  return value === 'CONSUMPTION_STATE_CONSUMED';
}

function purchaseLine(
  purchase: GooglePlayProductPurchaseV2,
  productId: string,
) {
  const lines = purchase.productLineItem ?? [];
  if (lines.length !== 1 || lines[0]?.productId !== productId) {
    throw new BadRequestException(
      'The Google Play purchase does not match this coin product.',
    );
  }
  return lines[0];
}

function orderLine(order: GooglePlayOrder, productId: string) {
  const lines = order.lineItems ?? [];
  if (lines.length !== 1 || lines[0]?.productId !== productId) {
    throw new BadRequestException(
      'The Google Play order does not match this coin product.',
    );
  }
  const details = lines[0]?.oneTimePurchaseDetails;
  if (!details) {
    throw new BadRequestException(
      'The Google Play order is not a one-time coin purchase.',
    );
  }
  return lines[0];
}

@Injectable()
export class GooglePlayPurchasesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly ledger: LedgerService,
    private readonly googlePlay: GooglePlayDeveloperApiProvider,
  ) {}

  catalogue(userId: string): GooglePlayCatalogue {
    const products = parseProducts(process.env.GOOGLE_PLAY_COIN_PRODUCTS);
    const packageName =
      process.env.GOOGLE_PLAY_PACKAGE_NAME?.trim() || DEFAULT_PACKAGE_NAME;
    const enabled =
      process.env.GOOGLE_PLAY_PURCHASES_ENABLED === 'true' &&
      packageName.length <= 255 &&
      products !== null &&
      this.googlePlay.isConfigured() &&
      encryptionKey() !== null;

    return {
      enabled,
      packageName,
      accountObfuscationId: enabled ? accountObfuscationId(userId) : null,
      products: enabled && products ? products : [],
    };
  }

  async verify(
    userId: string,
    productId: string,
    purchaseToken: string,
  ): Promise<{
    purchaseId: string;
    productId: string;
    quantity: number;
    coinsGranted: number;
    status: 'CONSUMED' | 'VERIFIED';
    consumed: boolean;
    duplicate: boolean;
  }> {
    if (process.env.GOOGLE_PLAY_PURCHASES_ENABLED !== 'true') {
      throw new ServiceUnavailableException(
        'Google Play coin purchases are not enabled.',
      );
    }

    const product = parseProducts(process.env.GOOGLE_PLAY_COIN_PRODUCTS)
      ?.find((item) => item.productId === productId);
    const key = encryptionKey();
    if (
      !product ||
      !this.googlePlay.isConfigured() ||
      !key ||
      (process.env.GOOGLE_PLAY_PACKAGE_NAME?.trim() || DEFAULT_PACKAGE_NAME)
        .length > 255
    ) {
      throw new ServiceUnavailableException(
        'Google Play coin purchases are not fully configured.',
      );
    }
    if (
      typeof purchaseToken !== 'string' ||
      purchaseToken.length < 20 ||
      purchaseToken.length > 4096
    ) {
      throw new BadRequestException('A valid Google Play purchase token is required.');
    }

    const digest = tokenHash(purchaseToken);
    const prior = await this.prisma.googlePlayPurchase.findUnique({
      where: { purchaseTokenHash: digest },
    });
    if (prior && (prior.userId !== userId || prior.productId !== productId)) {
      throw new ConflictException(
        'This Google Play purchase token has already been used.',
      );
    }
    if (
      prior?.status === GooglePlayPurchaseStatus.VOIDED ||
      prior?.status === GooglePlayPurchaseStatus.REFUNDED
    ) {
      throw new ConflictException(
        'This Google Play purchase is no longer eligible for coins.',
      );
    }

    const purchase = await this.googlePlay.getProductPurchase(purchaseToken);
    if (
      purchase.purchaseStateContext?.purchaseState !== 'PURCHASED' ||
      purchase.obfuscatedExternalAccountId !== accountObfuscationId(userId)
    ) {
      throw new BadRequestException(
        'Google Play could not verify a completed purchase for this account.',
      );
    }

    const line = purchaseLine(purchase, productId);
    const orderId = purchase.orderId?.trim();
    const completedAt = purchase.purchaseCompletionTime
      ? new Date(purchase.purchaseCompletionTime)
      : new Date(Number.NaN);
    if (
      !orderId ||
      !Number.isFinite(completedAt.getTime()) ||
      completedAt.getTime() <= 0
    ) {
      throw new BadRequestException(
        'Google Play purchase details are incomplete.',
      );
    }

    const order = await this.googlePlay.getOrder(orderId);
    if (
      order.state !== 'PROCESSED' ||
      (order.purchaseToken && order.purchaseToken !== purchaseToken)
    ) {
      throw new BadRequestException(
        'Google Play has not confirmed this order as processed.',
      );
    }
    const orderItem = orderLine(order, productId);
    const quantity = line.productOfferDetails?.quantity ?? 1;
    const orderedQuantity =
      orderItem.oneTimePurchaseDetails?.quantity ?? 1;
    if (
      !Number.isSafeInteger(quantity) ||
      quantity <= 0 ||
      quantity > MAX_PURCHASE_QUANTITY ||
      orderedQuantity !== quantity
    ) {
      throw new BadRequestException(
        'Google Play returned an invalid purchase quantity.',
      );
    }

    const coinsGranted = product.coins * quantity;
    if (
      !Number.isSafeInteger(coinsGranted) ||
      coinsGranted <= 0 ||
      coinsGranted > MAX_POSTGRES_INT
    ) {
      throw new BadRequestException(
        'The configured coin product exceeds the wallet limit.',
      );
    }

    const gross = moneyNanos(orderItem.total ?? order.total);
    const developerRevenue = moneyNanos(
      order.developerRevenueInBuyerCurrency,
    );
    if (!gross || gross.amountNanos <= 0n) {
      throw new BadRequestException(
        'Google Play did not return a valid purchase amount.',
      );
    }
    if (
      developerRevenue &&
      (developerRevenue.currencyCode !== gross.currencyCode ||
        developerRevenue.amountNanos < 0n)
    ) {
      throw new BadRequestException(
        'Google Play returned inconsistent purchase accounting details.',
      );
    }

    const consumedByGoogle = isConsumed(
      line.productOfferDetails?.consumptionState,
    );
    const priorConsumed = prior?.status === GooglePlayPurchaseStatus.CONSUMED;
    if (consumedByGoogle && !prior) {
      throw new ConflictException(
        'This purchase was consumed before Kyron recorded its coin grant.',
      );
    }

    const purchaseRecord = await this.recordVerifiedPurchase({
      userId,
      productId,
      quantity,
      coinsGranted,
      purchaseToken,
      purchaseTokenHash: digest,
      orderId,
      purchaseTime: completedAt,
      acknowledgementState: acknowledgementState(
        purchase.acknowledgementState,
      ),
      currencyCode: gross.currencyCode,
      grossAmountNanos: gross.amountNanos,
      developerRevenueNanos:
        developerRevenue?.amountNanos ?? null,
      encryptionKey: key,
    });

    if (priorConsumed || consumedByGoogle) {
      await this.markConsumed(purchaseRecord.id);
      return {
        purchaseId: purchaseRecord.id,
        productId,
        quantity,
        coinsGranted,
        status: 'CONSUMED',
        consumed: true,
        duplicate: true,
      };
    }

    try {
      await this.googlePlay.consume(productId, purchaseToken);
      await this.markConsumed(purchaseRecord.id);
      return {
        purchaseId: purchaseRecord.id,
        productId,
        quantity,
        coinsGranted,
        status: 'CONSUMED',
        consumed: true,
        duplicate: !!prior,
      };
    } catch {
      // Coins have already been committed exactly once. The token remains
      // VERIFIED; a retry will check Play's state and complete consumption.
      return {
        purchaseId: purchaseRecord.id,
        productId,
        quantity,
        coinsGranted,
        status: 'VERIFIED',
        consumed: false,
        duplicate: !!prior,
      };
    }
  }

  private async recordVerifiedPurchase(input: {
    userId: string;
    productId: string;
    quantity: number;
    coinsGranted: number;
    purchaseToken: string;
    purchaseTokenHash: string;
    orderId: string;
    purchaseTime: Date;
    acknowledgementState: number;
    currencyCode: string;
    grossAmountNanos: bigint;
    developerRevenueNanos: bigint | null;
    encryptionKey: Buffer;
  }) {
    try {
      return await this.prisma.$transaction(async (tx) => {
        // Serialize purchased credits with gift spending on this wallet.
        await tx.$queryRaw`SELECT id FROM "User" WHERE id = ${input.userId}::uuid FOR UPDATE`;
        const existing = await tx.googlePlayPurchase.findUnique({
          where: { purchaseTokenHash: input.purchaseTokenHash },
        });
        if (existing) {
          if (
            existing.userId !== input.userId ||
            existing.productId !== input.productId ||
            existing.coinAmount !== input.coinsGranted ||
            existing.quantity !== input.quantity
          ) {
            throw new ConflictException(
              'This Google Play purchase token has already been used.',
            );
          }
          if (
            existing.status === GooglePlayPurchaseStatus.VOIDED ||
            existing.status === GooglePlayPurchaseStatus.REFUNDED
          ) {
            throw new ConflictException(
              'This Google Play purchase is no longer eligible for coins.',
            );
          }
          return existing;
        }

        const coinEntryKey = `google-play-purchase:${input.purchaseTokenHash}`;
        const purchase = await tx.googlePlayPurchase.create({
          data: {
            userId: input.userId,
            purchaseTokenHash: input.purchaseTokenHash,
            encryptedToken: encryptPurchaseToken(
              input.purchaseToken,
              input.encryptionKey,
            ),
            productId: input.productId,
            orderId: input.orderId,
            quantity: input.quantity,
            coinAmount: input.coinsGranted,
            purchaseTime: input.purchaseTime,
            acknowledgementState: input.acknowledgementState,
            status: GooglePlayPurchaseStatus.VERIFIED,
            coinEntryKey,
            purchaseCurrencyCode: input.currencyCode,
            grossAmountNanos: input.grossAmountNanos,
            developerRevenueNanos: input.developerRevenueNanos,
          },
        });

        await tx.coinEntry.create({
          data: {
            userId: input.userId,
            kind: CoinKind.PURCHASE_GRANT,
            amount: input.coinsGranted,
            key: coinEntryKey,
          },
        });

        await this.ledger.postInTransaction(tx, {
          idempotencyKey: `google-play-purchase:${input.purchaseTokenHash}`,
          eventType: 'GOOGLE_PLAY_COIN_PURCHASE',
          sourceType: 'GOOGLE_PLAY_PURCHASE',
          sourceId: purchase.id,
          currencyCode: 'KCOIN',
          description: 'Verified Google Play coin purchase',
          actorId: input.userId,
          metadata: {
            productId: input.productId,
            quantity: input.quantity,
            coinAmount: input.coinsGranted,
            orderId: input.orderId,
            purchaseTokenHash: input.purchaseTokenHash,
            purchaseCurrencyCode: input.currencyCode,
            grossAmountNanos: input.grossAmountNanos.toString(),
            developerRevenueNanos:
              input.developerRevenueNanos?.toString() ?? null,
          },
          postings: [
            {
              accountKey: 'SYSTEM:GOOGLE_PLAY:KCOIN:ISSUANCE_CLEARING',
              name: 'Google Play purchased coin issuance clearing',
              accountType: 'ASSET',
              normalSide: 'DEBIT',
              side: 'DEBIT',
              amount: String(input.coinsGranted),
            },
            {
              accountKey: `USER:${input.userId}:KCOIN:PURCHASED`,
              name: 'Purchased coin wallet liability',
              accountType: 'LIABILITY',
              normalSide: 'CREDIT',
              ownerId: input.userId,
              side: 'CREDIT',
              amount: String(input.coinsGranted),
            },
          ],
        });

        await tx.financialSourceRecord.create({
          data: {
            sourceType: 'GOOGLE_PLAY_PURCHASE',
            sourceId: purchase.id,
            eventType: 'GOOGLE_PLAY_COIN_PURCHASE_VERIFIED',
            actorId: input.userId,
            beneficiaryId: input.userId,
            relatedIds: {
              coinEntryKey,
              orderId: input.orderId,
            },
            amount: input.coinsGranted,
            unitCode: 'KCOIN',
            payload: {
              productId: input.productId,
              quantity: input.quantity,
              currencyCode: input.currencyCode,
              grossAmountNanos: input.grossAmountNanos.toString(),
              developerRevenueNanos:
                input.developerRevenueNanos?.toString() ?? null,
            },
            occurredAt: input.purchaseTime,
          },
        });

        await tx.financialAuditEvent.create({
          data: {
            actorId: input.userId,
            eventType: 'GOOGLE_PLAY_COIN_PURCHASE_VERIFIED',
            subjectType: 'GOOGLE_PLAY_PURCHASE',
            subjectId: purchase.id,
            requestId: input.purchaseTokenHash,
            metadata: {
              productId: input.productId,
              quantity: input.quantity,
              coinAmount: input.coinsGranted,
              orderId: input.orderId,
            },
          },
        });
        return purchase;
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        const existing = await this.prisma.googlePlayPurchase.findUnique({
          where: { purchaseTokenHash: input.purchaseTokenHash },
        });
        if (
          existing &&
          existing.userId === input.userId &&
          existing.productId === input.productId &&
          existing.coinAmount === input.coinsGranted
        ) {
          return existing;
        }
        if (existing) {
          throw new ConflictException(
            'This Google Play purchase token has already been used.',
          );
        }
      }
      throw error;
    }
  }

  private async markConsumed(purchaseId: string): Promise<void> {
    await this.prisma.$transaction(async (tx) => {
      const updated = await tx.googlePlayPurchase.updateMany({
        where: {
          id: purchaseId,
          status: GooglePlayPurchaseStatus.VERIFIED,
        },
        data: {
          status: GooglePlayPurchaseStatus.CONSUMED,
          acknowledgementState: 1,
        },
      });
      if (updated.count > 0) {
        await tx.financialAuditEvent.create({
          data: {
            eventType: 'GOOGLE_PLAY_COIN_PURCHASE_CONSUMED',
            subjectType: 'GOOGLE_PLAY_PURCHASE',
            subjectId: purchaseId,
            metadata: { consumed: true },
          },
        });
      }
    });
  }
}
