import { createServer, type Server } from 'http';
import type { AddressInfo } from 'net';
import {
  SignJWT,
  exportJWK,
  generateKeyPair,
  type CryptoKey,
  type JWK,
} from 'jose';
import { SupabaseTokenService } from './supabase-token.service';

/**
 * Serves a JWKS the way Supabase does, so the service exercises its real
 * remote-key path instead of a stub.
 */
async function startJwksServer(
  jwk: JWK,
): Promise<{ url: string; close(): Promise<void> }> {
  const server: Server = createServer((req, res) => {
    if (req.url === '/auth/v1/.well-known/jwks.json') {
      res.writeHead(200, { 'content-type': 'application/json' });
      res.end(JSON.stringify({ keys: [jwk] }));
      return;
    }
    res.writeHead(404).end();
  });
  await new Promise<void>((resolve) => server.listen(0, '127.0.0.1', resolve));
  const { port } = server.address() as AddressInfo;
  return {
    url: `http://127.0.0.1:${port}`,
    close: () => new Promise<void>((resolve) => server.close(() => resolve())),
  };
}

describe('SupabaseTokenService', () => {
  const originalUrl = process.env.SUPABASE_URL;
  let jwks: Awaited<ReturnType<typeof startJwksServer>>;
  let signingKey: CryptoKey;
  let issuer: string;

  beforeAll(async () => {
    const { privateKey, publicKey } = await generateKeyPair('ES256', {
      extractable: true,
    });
    signingKey = privateKey;
    const jwk = await exportJWK(publicKey);
    jwks = await startJwksServer({ ...jwk, alg: 'ES256', kid: 'test-key' });
    issuer = `${jwks.url}/auth/v1`;
  });

  afterAll(async () => {
    await jwks.close();
    process.env.SUPABASE_URL = originalUrl;
  });

  const sign = (
    claims: Record<string, unknown>,
    aud = 'authenticated',
    iss = issuer,
  ) =>
    new SignJWT(claims)
      .setProtectedHeader({ alg: 'ES256', kid: 'test-key' })
      .setIssuer(iss)
      .setAudience(aud)
      .setIssuedAt()
      .setExpirationTime('1h')
      .sign(signingKey);

  const service = () => {
    process.env.SUPABASE_URL = jwks.url;
    return new SupabaseTokenService();
  };

  it('accepts a correctly signed token and returns its claims', async () => {
    const token = await sign({ sub: 'user-123', email: 'a@b.co' });
    const claims = await service().verify(token);
    expect(claims?.sub).toBe('user-123');
    expect(claims?.email).toBe('a@b.co');
  });

  it('rejects a token signed by a different key', async () => {
    const { privateKey } = await generateKeyPair('ES256', {
      extractable: true,
    });
    const forged = await new SignJWT({ sub: 'attacker' })
      .setProtectedHeader({ alg: 'ES256', kid: 'test-key' })
      .setIssuer(issuer)
      .setAudience('authenticated')
      .setIssuedAt()
      .setExpirationTime('1h')
      .sign(privateKey);
    expect(await service().verify(forged)).toBeNull();
  });

  it('rejects a token from another issuer', async () => {
    const token = await sign(
      { sub: 'x' },
      'authenticated',
      'https://evil.example/auth/v1',
    );
    expect(await service().verify(token)).toBeNull();
  });

  it('rejects a token for another audience', async () => {
    const token = await sign({ sub: 'x' }, 'not-authenticated');
    expect(await service().verify(token)).toBeNull();
  });

  it('rejects an expired token', async () => {
    const expired = await new SignJWT({ sub: 'x' })
      .setProtectedHeader({ alg: 'ES256', kid: 'test-key' })
      .setIssuer(issuer)
      .setAudience('authenticated')
      .setIssuedAt(Math.floor(Date.now() / 1000) - 7200)
      .setExpirationTime(Math.floor(Date.now() / 1000) - 3600)
      .sign(signingKey);
    expect(await service().verify(expired)).toBeNull();
  });

  it('rejects a token with no subject', async () => {
    const token = await sign({ email: 'nobody@b.co' });
    expect(await service().verify(token)).toBeNull();
  });

  it('is disabled, and verifies nothing, when SUPABASE_URL is unset', async () => {
    delete process.env.SUPABASE_URL;
    const svc = new SupabaseTokenService();
    expect(svc.enabled).toBe(false);
    expect(await svc.verify(await sign({ sub: 'x' }))).toBeNull();
  });

  describe('isAsymmetric', () => {
    // Tells "not mine to verify" apart from "invalid", which is what lets the
    // guard answer a Supabase token with a 503 naming the misconfiguration
    // rather than a 401 the user reads as an expired session.
    it('recognises a Supabase ES256 token even with the verifier disabled', async () => {
      const token = await sign({ sub: 'x' });
      delete process.env.SUPABASE_URL;
      const svc = new SupabaseTokenService();
      expect(svc.enabled).toBe(false);
      expect(svc.isAsymmetric(token)).toBe(true);
    });

    it('does not claim a legacy HS256 token', async () => {
      const legacy = await new SignJWT({ sub: 'x' })
        .setProtectedHeader({ alg: 'HS256' })
        .setIssuedAt()
        .setExpirationTime('1h')
        .sign(new TextEncoder().encode('a'.repeat(32)));
      expect(service().isAsymmetric(legacy)).toBe(false);
    });

    it('does not claim an unsigned token', () => {
      const unsecured = `${Buffer.from(
        JSON.stringify({ alg: 'none', typ: 'JWT' }),
      ).toString('base64url')}.${Buffer.from(
        JSON.stringify({ sub: 'x' }),
      ).toString('base64url')}.`;
      expect(service().isAsymmetric(unsecured)).toBe(false);
    });

    it('does not throw on a value that is not a JWT', () => {
      expect(service().isAsymmetric('not-a-token')).toBe(false);
      expect(service().isAsymmetric('')).toBe(false);
    });
  });
});
