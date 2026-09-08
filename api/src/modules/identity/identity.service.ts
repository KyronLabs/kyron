import {
  BadRequestException,
  ConflictException,
  Injectable,
  Logger,
} from '@nestjs/common';
import { randomBytes } from 'node:crypto';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { verifyDidSignature } from './did-key';

/** What the app is asked to sign, and until when. */
export interface Challenge {
  challenge: string;
  /**
   * The exact bytes to sign, as a string.
   *
   * Handed over rather than left for the client to assemble from the parts.
   * The format is one thing in two languages, and a client that rebuilt it
   * with a character out of place would produce a signature that verifies
   * against nothing, on every device, with no way to tell why. The server
   * still verifies against its own reconstruction, so this is a convenience
   * for the honest caller and no help at all to a dishonest one.
   */
  message: string;
  expiresAt: string;
}

@Injectable()
export class IdentityService {
  private readonly logger = new Logger(IdentityService.name);

  /** How long a challenge is good for. Long enough to sign, short enough that
   *  one seen over somebody's shoulder is worthless by the time it is used. */
  static readonly challengeTtlMs = 5 * 60_000;

  /** A ceiling, so a flood of requests cannot grow this without bound. */
  static readonly maxPending = 10_000;

  /**
   * Outstanding challenges, per account.
   *
   * In memory, which is correct for what this is: a nonce that lives five
   * minutes and whose only job is to stop a signature being replayed. A
   * restart drops them and the app asks for another, which is the same
   * recovery as a challenge simply expiring. It is also per process -- see the
   * one-instance section of docs/OBSERVABILITY.md -- and this is one of the
   * things that would need somewhere shared at instance two.
   */
  private readonly pending = new Map<
    string,
    { challenge: string; expiresAt: number }
  >();

  constructor(private readonly prisma: PrismaService) {}

  /**
   * A fresh nonce for this account to sign.
   *
   * One outstanding challenge per account: asking again replaces the last,
   * so a stack of live nonces cannot accumulate for one person.
   */
  issueChallenge(userId: string): Challenge {
    this.evictExpired();

    const challenge = randomBytes(32).toString('base64url');
    const expiresAt = Date.now() + IdentityService.challengeTtlMs;
    this.pending.set(userId, { challenge, expiresAt });

    return {
      challenge,
      message: IdentityService.messageFor(userId, challenge).toString('utf8'),
      expiresAt: new Date(expiresAt).toISOString(),
    };
  }

  /**
   * What the signature has to be over.
   *
   * The account id is in it, not just the nonce: without that, a signature
   * proved possession of a key and nothing about *whose* claim it was
   * answering, and one lifted from anywhere could be presented against
   * another account. The version prefix is so this can be changed later
   * without a signature made for the old shape counting for the new one.
   */
  static messageFor(userId: string, challenge: string): Buffer {
    return Buffer.from(
      `${IdentityService.messagePrefix}${userId}:${challenge}`,
      'utf8',
    );
  }

  /**
   * What every message this asks for starts with.
   *
   * The client checks for it before signing. Signing whatever a server sends
   * is how a challenge-response becomes a signing oracle -- an identifier's
   * whole value is that its holder only ever signs things they meant to.
   */
  static readonly messagePrefix = 'kyron-did-claim:v1:';

  /**
   * Records a DID once the account has proved it holds the matching key.
   *
   * Nothing here trusts the claim: the identifier *is* the public key, so a
   * signature over this account's own challenge is the whole proof, and it is
   * one anybody else can repeat without asking us.
   */
  async claimDid(userId: string, did: string, signature: string) {
    const outstanding = this.pending.get(userId);
    if (!outstanding || outstanding.expiresAt < Date.now()) {
      this.pending.delete(userId);
      throw new BadRequestException(
        'No challenge is outstanding for this account, or it has expired. ' +
          'Ask for a new one and sign that.',
      );
    }

    let raw: Buffer;
    try {
      raw = Buffer.from(signature, 'base64url');
    } catch {
      throw new BadRequestException('The signature is not base64url.');
    }

    const proved = verifyDidSignature(
      did,
      IdentityService.messageFor(userId, outstanding.challenge),
      raw,
    );
    if (!proved) {
      // Spent either way. A challenge that survives a failed attempt is a
      // challenge somebody can keep guessing against.
      this.pending.delete(userId);
      throw new BadRequestException(
        'That signature does not prove control of that identifier.',
      );
    }

    this.pending.delete(userId);

    try {
      await this.prisma.user.update({ where: { id: userId }, data: { did } });
    } catch (error) {
      // The column is unique across accounts, which is the point: an
      // identifier that two people hold identifies neither.
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new ConflictException(
          'That identifier already belongs to another account.',
        );
      }
      throw error;
    }

    this.logger.log(`${userId} claimed a DID`);
    return { did };
  }

  /** The account's identifier, or null when it has not made one. */
  async didFor(userId: string): Promise<{ did: string | null }> {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { did: true },
    });
    return { did: user?.did ?? null };
  }

  private evictExpired(): void {
    const now = Date.now();
    for (const [userId, held] of this.pending) {
      if (held.expiresAt < now) this.pending.delete(userId);
    }
    // Still too many means they are all live, and something is wrong. Drop
    // the oldest rather than grow: a refused claim is recoverable, a process
    // out of memory is not.
    while (this.pending.size > IdentityService.maxPending) {
      const oldest = this.pending.keys().next().value;
      if (oldest === undefined) break;
      this.pending.delete(oldest);
    }
  }
}
