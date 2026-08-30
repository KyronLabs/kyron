import { Injectable, Logger } from '@nestjs/common';
import {
  createRemoteJWKSet,
  decodeProtectedHeader,
  jwtVerify,
  type JWTPayload,
} from 'jose';

/**
 * Claims we rely on from a Supabase access token. Supabase signs these with
 * ES256 and publishes the public half at /auth/v1/.well-known/jwks.json, so
 * verification is local -- no per-request round-trip to Supabase, and no shared
 * secret to distribute.
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

@Injectable()
export class SupabaseTokenService {
  private readonly logger = new Logger(SupabaseTokenService.name);
  private readonly issuer: string | null;
  private readonly jwks: ReturnType<typeof createRemoteJWKSet> | null;

  constructor() {
    const baseUrl = process.env.SUPABASE_URL?.replace(/\/+$/, '');
    if (!baseUrl) {
      // Supabase is the only identity provider a current client uses, so an
      // unset SUPABASE_URL is not a degraded mode -- it means every
      // authenticated request will fail. Logged at error level because a
      // warning here was easy to miss in a boot log, and the resulting 401s
      // read to users as an expired session rather than a misconfigured server.
      this.logger.error(
        'SUPABASE_URL is not set: no JWKS can be fetched, so no Supabase ' +
          'access token can be verified and every authenticated request will ' +
          'be refused. Set it to the project URL, e.g. ' +
          'https://<project-ref>.supabase.co',
      );
      this.issuer = null;
      this.jwks = null;
      return;
    }
    this.issuer = `${baseUrl}/auth/v1`;
    // createRemoteJWKSet caches the key set and refetches only on an unknown
    // kid, so this is one network call per key rotation rather than per request.
    this.jwks = createRemoteJWKSet(
      new URL(`${this.issuer}/.well-known/jwks.json`),
    );
    // Stated at boot because a SUPABASE_URL pointing at the wrong project is
    // indistinguishable, from the outside, from one that is not set: both end
    // as a 401 on every authenticated request.
    this.logger.log(`Accepting Supabase access tokens from ${this.issuer}`);
  }

  get enabled(): boolean {
    return this.jwks !== null;
  }

  /** The issuer tokens must carry, or null when unconfigured. Not a secret. */
  get configuredIssuer(): string | null {
    return this.issuer;
  }

  /**
   * Whether the token was issued by an asymmetric provider -- Supabase signs
   * ES256 -- as opposed to the legacy HS256 tokens this API used to mint.
   * Reads the unverified header only, so it says nothing about authenticity;
   * it exists to tell "this token is not mine to verify" apart from
   * "this token is invalid", which decides whether a rejection is the caller's
   * problem or the server's.
   */
  isAsymmetric(token: string): boolean {
    try {
      const { alg } = decodeProtectedHeader(token);
      return typeof alg === 'string' && alg !== 'none' && !alg.startsWith('HS');
    } catch {
      return false;
    }
  }

  /**
   * Returns the token's claims, or null when it is not a valid Supabase token.
   * Returning null rather than throwing lets the caller fall through to the
   * legacy verifier while both token types are in circulation.
   */
  async verify(token: string): Promise<SupabaseClaims | null> {
    if (!this.jwks || !this.issuer) return null;
    try {
      const { payload } = await jwtVerify(token, this.jwks, {
        issuer: this.issuer,
        audience: 'authenticated',
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
      if (this.isAsymmetric(token)) {
        const reason =
          error instanceof Error
            ? `${(error as { code?: string }).code ?? error.name}: ${error.message}`
            : String(error);
        this.logger.warn(
          `Rejected an access token issued for ${this.issuer ?? 'nothing'} -- ${reason}`,
        );
      }
      return null;
    }
  }
}
