import { Injectable, Logger } from '@nestjs/common';
import {
  createRemoteJWKSet,
  decodeJwt,
  decodeProtectedHeader,
  jwtVerify,
  type JWTPayload,
} from 'jose';

/**
 * Claims we rely on from a Supabase access token.
 *
 * How a project signs these depends on whether it has moved to JWT signing
 * keys. A migrated project signs ES256 and publishes the public half at
 * /auth/v1/.well-known/jwks.json; one still on the legacy shared secret signs
 * HS256 and serves an empty key set. Both are supported, because a project
 * cannot be migrated from inside this repository and an API that only reads
 * JWKS rejects every token from a project that has not been.
 */
export interface SupabaseClaims extends JWTPayload {
  sub: string;
  email?: string;
  role?: string;
  user_metadata?: {
    full_name?: string;
    name?: string;
    user_name?: string;
    preferred_username?: string;
  };
}

/** Algorithms accepted on each path. Pinned, never taken from the token. */
const ASYMMETRIC_ALGS = ['ES256', 'RS256'];
const SYMMETRIC_ALGS = ['HS256'];

@Injectable()
export class SupabaseTokenService {
  private readonly logger = new Logger(SupabaseTokenService.name);
  private readonly issuer: string | null;
  private readonly jwks: ReturnType<typeof createRemoteJWKSet> | null;
  private readonly sharedSecret: Uint8Array | null;

  constructor() {
    const baseUrl = process.env.SUPABASE_URL?.replace(/\/+$/, '');
    const secret = process.env.SUPABASE_JWT_SECRET?.trim();

    this.sharedSecret = secret ? new TextEncoder().encode(secret) : null;

    if (!baseUrl) {
      // Supabase is the only identity provider a current client uses, so an
      // unset SUPABASE_URL is not a degraded mode -- it means every
      // authenticated request will fail. Logged at error level because a
      // warning here was easy to miss in a boot log, and the resulting 401s
      // read to users as an expired session rather than a misconfigured server.
      this.logger.error(
        'SUPABASE_URL is not set: no Supabase access token can be verified ' +
          'and every authenticated request will be refused. Set it to the ' +
          'project URL, e.g. https://<project-ref>.supabase.co',
      );
      this.issuer = null;
      this.jwks = null;
      return;
    }

    this.issuer = `${baseUrl}/auth/v1`;
    // createRemoteJWKSet caches the key set and refetches only on an unknown
    // kid, so this is one network call per key rotation rather than per
    // request. It is built even for a project that publishes no keys: fetching
    // is lazy, and building it keeps the migrated case working the moment the
    // project starts publishing.
    this.jwks = createRemoteJWKSet(
      new URL(`${this.issuer}/.well-known/jwks.json`),
    );

    // Stated at boot because a SUPABASE_URL pointing at the wrong project is
    // indistinguishable, from the outside, from one that is not set: both end
    // as a 401 on every authenticated request.
    this.logger.log(
      `Accepting Supabase access tokens from ${this.issuer} ` +
        `(${this.accepts.join(', ')})`,
    );
    if (!this.sharedSecret) {
      // Not an error: a migrated project needs no secret. Worth saying,
      // because a project that has not migrated serves an empty key set and
      // every token then fails with ERR_JWKS_NO_MATCHING_KEY, which reads like
      // a key rotation problem rather than a missing setting.
      this.logger.log(
        "SUPABASE_JWT_SECRET is not set: tokens signed with a project's " +
          'legacy shared secret cannot be verified. Only needed for a project ' +
          'that has not moved to JWT signing keys.',
      );
    }
  }

  get enabled(): boolean {
    return this.issuer !== null;
  }

  /** The issuer tokens must carry, or null when unconfigured. Not a secret. */
  get configuredIssuer(): string | null {
    return this.issuer;
  }

  /** Which signatures this deployment can check. Not a secret. */
  get accepts(): string[] {
    if (!this.issuer) return [];
    return [
      ...ASYMMETRIC_ALGS.map((alg) => `${alg} via JWKS`),
      ...(this.sharedSecret ? SYMMETRIC_ALGS : []),
    ];
  }

  /**
   * The setting this deployment is missing in order to verify [token], or null
   * when the token is not ours to verify or nothing is missing.
   *
   * This separates "the server cannot check this" from "this token is bad",
   * which decides whether a rejection is the caller's problem or ours. Reads
   * unverified header and payload only, so it asserts nothing about
   * authenticity -- it never decides that a token is *good*, only who is at
   * fault when one is refused.
   */
  missingConfigFor(token: string): string | null {
    let alg: string | undefined;
    try {
      alg = decodeProtectedHeader(token).alg;
    } catch {
      return null;
    }
    if (!alg || alg === 'none') return null;

    if (!alg.startsWith('HS')) {
      // Nothing but Supabase mints asymmetric tokens here; the legacy Kyron
      // path is HS256. So an asymmetric token with no issuer configured is
      // unambiguously ours to verify and unambiguously unverifiable.
      return this.issuer ? null : 'SUPABASE_URL';
    }

    // HS256 is ambiguous: it could be a legacy Kyron token, which is none of
    // this service's business. Claim it only when it names our issuer.
    if (!this.issuer || !this.claimsOurIssuer(token)) return null;
    return this.sharedSecret ? null : 'SUPABASE_JWT_SECRET';
  }

  /**
   * Returns the token's claims, or null when it is not a valid Supabase token.
   * Returning null rather than throwing lets the caller fall through to the
   * legacy verifier while both token types are in circulation.
   */
  async verify(token: string): Promise<SupabaseClaims | null> {
    if (!this.issuer) return null;

    let alg: string | undefined;
    try {
      alg = decodeProtectedHeader(token).alg;
    } catch {
      return null;
    }
    if (!alg || alg === 'none') return null;

    // Key material is chosen by algorithm and the accepted algorithms are
    // pinned per path, so a token cannot nominate its own verification: an
    // HS256 token can never be checked against a JWKS public key, which is the
    // shape of the classic algorithm-confusion forgery.
    const symmetric = alg.startsWith('HS');
    const key = symmetric ? this.sharedSecret : this.jwks;
    if (!key) return null;

    try {
      const { payload } = await jwtVerify(token, key, {
        issuer: this.issuer,
        audience: 'authenticated',
        algorithms: symmetric ? SYMMETRIC_ALGS : ASYMMETRIC_ALGS,
      });
      if (typeof payload.sub !== 'string' || payload.sub.length === 0) {
        return null;
      }
      return payload as SupabaseClaims;
    } catch (error) {
      // Swallowing this whole is what made a broken deployment silent: a wrong
      // issuer, an unreachable JWKS endpoint and a forged token all became the
      // same null, and the caller reported all three as an expired session.
      // Only tokens that claim to be Supabase's are logged, so an attacker
      // cannot fill the log by posting arbitrary strings.
      if (!symmetric || this.claimsOurIssuer(token)) {
        const reason =
          error instanceof Error
            ? `${(error as { code?: string }).code ?? error.name}: ${error.message}`
            : String(error);
        this.logger.warn(
          `Rejected a ${alg} access token for ${this.issuer} -- ${reason}`,
        );
      }
      return null;
    }
  }

  /** Unverified `iss` check, used only to decide whether a token is ours. */
  private claimsOurIssuer(token: string): boolean {
    try {
      return decodeJwt(token).iss === this.issuer;
    } catch {
      return false;
    }
  }
}
