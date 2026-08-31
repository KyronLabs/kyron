import { Test } from '@nestjs/testing';
import { HealthController } from './health.controller';
import { SupabaseTokenService } from '../auth/supabase-token.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';

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

  const controller = async (
    databaseReachable = true,
    diagnosis: string | null = null,
    mirrorTables: boolean | 'throws' = true,
  ) => {
    const moduleRef = await Test.createTestingModule({
      controllers: [HealthController],
      providers: [
        SupabaseTokenService,
        {
          provide: PrismaService,
          useValue: {
            isReachable: () => Promise.resolve(databaseReachable),
            diagnoseHost: () => Promise.resolve(diagnosis),
          },
        },
        {
          provide: SupabaseService,
          useValue: {
            mirrorTablesPresent: () =>
              mirrorTables === 'throws'
                ? Promise.reject(new Error('network'))
                : Promise.resolve(mirrorTables),
          },
        },
      ],
    }).compile();
    return moduleRef.get(HealthController);
  };

  it('stays ok and names the issuer when Supabase is configured', async () => {
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    delete process.env.SUPABASE_JWT_SECRET;
    const body = await (await controller()).health();

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
    const body = await (await controller()).health();

    expect(body.auth.accepts).toContain('HS256');
  });

  it('trims a trailing slash rather than doubling it into the issuer', async () => {
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co/';
    const body = await (await controller()).health();

    expect(body.auth.issuer).toBe('https://project-ref.supabase.co/auth/v1');
  });

  it('reports the database as reachable when it answers', async () => {
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    const body = await (await controller(true)).health();

    expect(body.status).toBe('ok');
    expect(body.database).toBe('reachable');
  });

  it('reports degraded, not unhealthy, when the database is unreachable', async () => {
    // Deliberately still 'degraded' rather than a failure: the process is
    // serving, and reporting unhealthy takes the machine out of rotation and
    // hides the one piece of information this endpoint exists to give. The
    // API used to refuse to boot in this situation, and a machine that exits
    // at boot is not restarted -- so a ten-second database outage took it
    // down until someone deployed again by hand.
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    const body = await (await controller(false)).health();

    expect(body.status).toBe('degraded');
    expect(body.database).toBe('unreachable');
    // Auth config is still reported: whichever half is broken, the other one
    // should still be answerable in the same request.
    expect(body.auth.issuer).toBe('https://project-ref.supabase.co/auth/v1');
  });

  it('carries the DNS diagnosis when there is one', async () => {
    // "unreachable" has meant three different faults: a hostname that does not
    // exist, an IPv6-only host on a platform without IPv6, and a database that
    // is genuinely down. This endpoint is the view from outside the machine,
    // so the distinction belongs here and not only in the log.
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    const body = await (
      await controller(false, 'db.x.supabase.co resolves only to IPv6')
    ).health();

    expect(body.database).toBe('unreachable');
    expect(body.databaseDetail).toContain('only to IPv6');
  });

  it('omits the detail when DNS has nothing to add', async () => {
    // The host resolves to IPv4, so the fault is past name resolution. An
    // empty or speculative field would send someone the wrong way.
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    const body = await (await controller(false, null)).health();

    expect(body.database).toBe('unreachable');
    expect(body).not.toHaveProperty('databaseDetail');
  });

  it('never carries a detail while the database is reachable', async () => {
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    const body = await (await controller(true, 'stale explanation')).health();

    expect(body.database).toBe('reachable');
    expect(body).not.toHaveProperty('databaseDetail');
  });

  it('reports the mirror tables as missing when they are', async () => {
    // The fault this exists for: user_profiles, interests and user_interests
    // did not exist in the project the API writes to, so every profile save
    // answered 500. "database: reachable" said nothing about it -- the
    // database was reachable, it simply did not hold these tables.
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    const body = await (await controller(true, null, false)).health();

    expect(body.database).toBe('reachable');
    expect(body.mirrorTables).toBe('missing');
  });

  it('reports them present when they are', async () => {
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    const body = await (await controller(true, null, true)).health();

    expect(body.mirrorTables).toBe('present');
  });

  it('says unknown rather than missing when the check itself fails', async () => {
    // A transport or permission failure is not evidence the tables are gone,
    // and reporting "missing" would send someone to re-run a migration that
    // was never the problem.
    process.env.SUPABASE_URL = 'https://project-ref.supabase.co';
    const body = await (await controller(true, null, 'throws')).health();

    expect(body.mirrorTables).toBe('unknown');
    expect(body.status).toBe('ok');
  });

  it('says so, and stays ok, when Supabase is not configured', async () => {
    delete process.env.SUPABASE_URL;
    const body = await (await controller()).health();

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
