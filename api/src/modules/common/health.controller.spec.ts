import { Test } from '@nestjs/testing';
import { HealthController } from './health.controller';
import { SupabaseTokenService } from '../auth/supabase-token.service';

/**
 * /health is the only way to see, from outside the machine, which identity
 * provider a deployment will accept tokens from. A wrong SUPABASE_URL fails
 * every authenticated request with a 401 that looks exactly like a bad
 * password, so the endpoint reporting the issuer is the difference between
 * diagnosing that in one request and guessing at it.
 */
describe('HealthController', () => {
  const originalUrl = process.env.SUPABASE_URL;

  const originalSecret = process.env.SUPABASE_JWT_SECRET;

  afterEach(() => {
    if (originalUrl === undefined) delete process.env.SUPABASE_URL;
    else process.env.SUPABASE_URL = originalUrl;
    if (originalSecret === undefined) delete process.env.SUPABASE_JWT_SECRET;
    else process.env.SUPABASE_JWT_SECRET = originalSecret;
  });

  const controller = async () => {
    const moduleRef = await Test.createTestingModule({
      controllers: [HealthController],
      providers: [SupabaseTokenService],
    }).compile();
    return moduleRef.get(HealthController);
  };

  it('stays ok and names the issuer when Supabase is configured', async () => {
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    delete process.env.SUPABASE_JWT_SECRET;
    const body = (await controller()).health();

    expect(body.status).toBe('ok');
    expect(body.auth).toEqual({
      supabase: 'configured',
      issuer: 'https://project-ref.supabase.co/auth/v1',
      accepts: ['ES256 via JWKS', 'RS256 via JWKS'],
    });
  });

  it('reports HS256 once a shared secret is configured', async () => {
    // A project that has not moved to JWT signing keys serves an empty key
    // set, so "configured" alone does not say whether its tokens can be
    // checked. The algorithm list is the half that does.
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    process.env.SUPABASE_JWT_SECRET = 'a-legacy-project-shared-secret';
    const body = (await controller()).health();

    expect(body.auth.accepts).toContain('HS256');
  });

  it('trims a trailing slash rather than doubling it into the issuer', async () => {
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co/';
    const body = (await controller()).health();

    expect(body.auth.issuer).toBe('https://project-ref.supabase.co/auth/v1');
  });

  it('says so, and stays ok, when Supabase is not configured', async () => {
    delete process.env.SUPABASE_URL;
    const body = (await controller()).health();

    // Still ok: the process is healthy, it just cannot authenticate anyone.
    // Reporting unhealthy here would take the machine out of the load
    // balancer and hide the very information this endpoint exists to give.
    expect(body.status).toBe('ok');
    expect(body.auth).toEqual({
      supabase: 'not configured',
      issuer: null,
      accepts: [],
    });
  });
});
