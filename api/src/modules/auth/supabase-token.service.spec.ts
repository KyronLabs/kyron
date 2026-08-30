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

  describe('a project still on its legacy shared secret', () => {
    // Such a project serves an empty JWKS and signs HS256, so a verifier that
    // only reads JWKS refuses every token it issues with
    // ERR_JWKS_NO_MATCHING_KEY -- which reads like a key rotation problem
    // rather than a project that was never migrated.
    const SECRET = 'legacy-project-shared-secret-at-least-32-bytes';

    const signHs = (
      claims: Record<string, unknown>,
      secret = SECRET,
      iss: string | null = issuer,
      aud: string | null = 'authenticated',
    ) => {
      let jwt = new SignJWT(claims)
        .setProtectedHeader({ alg: 'HS256' })
        .setIssuedAt()
        .setExpirationTime('1h');
      if (iss !== null) jwt = jwt.setIssuer(iss);
      if (aud !== null) jwt = jwt.setAudience(aud);
      return jwt.sign(new TextEncoder().encode(secret));
    };

    const withSecret = () => {
      process.env.SUPABASE_URL = jwks.url;
      process.env.SUPABASE_JWT_SECRET = SECRET;
      return new SupabaseTokenService();
    };

    afterEach(() => {
      delete process.env.SUPABASE_JWT_SECRET;
    });

    it('accepts an HS256 token signed with the shared secret', async () => {
      const claims = await withSecret().verify(
        await signHs({ sub: 'user-9', email: 'c@d.co' }),
      );
      expect(claims?.sub).toBe('user-9');
      expect(claims?.email).toBe('c@d.co');
    });

    it('rejects one signed with a different secret', async () => {
      const forged = await signHs({ sub: 'attacker' }, 'not-the-secret-at-all');
      expect(await withSecret().verify(forged)).toBeNull();
    });

    it('still pins issuer and audience on the symmetric path', async () => {
      const wrongIssuer = await signHs(
        { sub: 'x' },
        SECRET,
        'https://evil.example/auth/v1',
      );
      const wrongAudience = await signHs({ sub: 'x' }, SECRET, issuer, 'anon');
      expect(await withSecret().verify(wrongIssuer)).toBeNull();
      expect(await withSecret().verify(wrongAudience)).toBeNull();
    });

    it('does not verify an HS256 token when only JWKS is configured', async () => {
      // The two paths must not cross: choosing key material by algorithm is
      // what stops a token nominating its own verification, which is the shape
      // of the classic algorithm-confusion forgery.
      expect(await service().verify(await signHs({ sub: 'x' }))).toBeNull();
    });

    it('leaves a legacy Kyron token alone', async () => {
      // Those carry sub and role, no issuer and no audience, and belong to the
      // guard's own HS256 verifier rather than to this service.
      // auth.service signs exactly { sub, role } plus an expiry: no issuer,
      // no audience.
      const legacy = await signHs(
        { sub: 'x', role: 'USER' },
        SECRET,
        null,
        null,
      );
      expect(await withSecret().verify(legacy)).toBeNull();
    });
  });

  describe('missingConfigFor', () => {
    // Separates "this server cannot check the token" from "this token is bad",
    // which is what lets the guard answer 503 naming the setting instead of a
    // 401 the user reads as an expired session.
    const SECRET = 'legacy-project-shared-secret-at-least-32-bytes';

    const signHs = (iss: string | null) => {
      let jwt = new SignJWT({ sub: 'x' })
        .setProtectedHeader({ alg: 'HS256' })
        .setAudience('authenticated')
        .setIssuedAt()
        .setExpirationTime('1h');
      if (iss !== null) jwt = jwt.setIssuer(iss);
      return jwt.sign(new TextEncoder().encode(SECRET));
    };

    afterEach(() => {
      delete process.env.SUPABASE_JWT_SECRET;
    });

    it('names SUPABASE_URL for an asymmetric token with nothing configured', async () => {
      const token = await sign({ sub: 'x' });
      delete process.env.SUPABASE_URL;
      expect(new SupabaseTokenService().missingConfigFor(token)).toBe(
        'SUPABASE_URL',
      );
    });

    it('names nothing for an asymmetric token once configured', async () => {
      expect(service().missingConfigFor(await sign({ sub: 'x' }))).toBeNull();
    });

    it('names SUPABASE_JWT_SECRET for an HS256 token carrying our issuer', async () => {
      expect(service().missingConfigFor(await signHs(issuer))).toBe(
        'SUPABASE_JWT_SECRET',
      );
    });

    it('names nothing once the shared secret is set', async () => {
      const token = await signHs(issuer);
      process.env.SUPABASE_URL = jwks.url;
      process.env.SUPABASE_JWT_SECRET = SECRET;
      expect(new SupabaseTokenService().missingConfigFor(token)).toBeNull();
    });

    it('does not claim a legacy Kyron token', async () => {
      // No issuer, so not ours -- blaming the server for one of these would
      // turn a genuinely bad token into a 503.
      expect(service().missingConfigFor(await signHs(null))).toBeNull();
    });

    it('does not claim an HS256 token from another issuer', async () => {
      const other = await signHs('https://someone-else.supabase.co/auth/v1');
      expect(service().missingConfigFor(other)).toBeNull();
    });

    it('does not claim an unsigned token or a non-token', () => {
      const unsecured = `${Buffer.from(
        JSON.stringify({ alg: 'none', typ: 'JWT' }),
      ).toString('base64url')}.${Buffer.from(
        JSON.stringify({ sub: 'x' }),
      ).toString('base64url')}.`;
      expect(service().missingConfigFor(unsecured)).toBeNull();
      expect(service().missingConfigFor('not-a-token')).toBeNull();
      expect(service().missingConfigFor('')).toBeNull();
    });
  });
});
