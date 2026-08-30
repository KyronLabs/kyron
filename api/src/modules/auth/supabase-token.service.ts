import { Injectable, Logger } from '@nestjs/common';
import { createRemoteJWKSet, jwtVerify, type JWTPayload } from 'jose';

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
      this.logger.warn(
        'SUPABASE_URL is not set; Supabase access tokens cannot be verified.',
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
  }

  get enabled(): boolean {
    return this.jwks !== null;
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
    } catch {
      return null;
    }
  }
}
