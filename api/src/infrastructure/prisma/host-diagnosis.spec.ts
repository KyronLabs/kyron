import { diagnoseUnreachableHost, type DnsResolver } from './host-diagnosis';

/** ENOTFOUND is how Node reports "no records of this type", not a failure. */
const notFound = () => Promise.reject(new Error('ENOTFOUND'));

const resolver = (v4: string[] | null, v6: string[] | null): DnsResolver => ({
  resolve4: () => (v4 === null ? notFound() : Promise.resolve(v4)),
  resolve6: () => (v6 === null ? notFound() : Promise.resolve(v6)),
});

describe('diagnoseUnreachableHost', () => {
  it('says nothing when the host has an IPv4 address', async () => {
    // It resolves and is reachable in principle, so the fault is past name
    // resolution. Guessing here would only point somewhere wrong.
    const diagnosis = await diagnoseUnreachableHost(
      'aws-0-us-west-2.pooler.supabase.com',
      resolver(['35.160.209.8'], null),
    );
    expect(diagnosis).toBeNull();
  });

  it('says nothing when a host has both families', async () => {
    expect(
      await diagnoseUnreachableHost(
        'dual.example.com',
        resolver(['1.2.3.4'], ['2600::1']),
      ),
    ).toBeNull();
  });

  it('reports a host that does not resolve at all', async () => {
    // The Supabase pooler host missing its aws-0-/aws-1- cluster segment.
    const diagnosis = await diagnoseUnreachableHost(
      'aws-us-west-2.pooler.supabase.com',
      resolver(null, null),
    );
    expect(diagnosis).toContain('does not resolve to any address');
    expect(diagnosis).toContain('aws-us-west-2.pooler.supabase.com');
    expect(diagnosis).toContain('cluster segment');
  });

  it('reports an IPv6-only host and names the pooler as the IPv4 route', async () => {
    // Supabase's direct connection endpoint. Unreachable from a platform with
    // no outbound IPv6, which looks exactly like a database that is down.
    const diagnosis = await diagnoseUnreachableHost(
      'db.project-ref.supabase.co',
      resolver(null, ['2600:1f14:359d:9301::1']),
    );
    expect(diagnosis).toContain('only to IPv6');
    expect(diagnosis).toContain('2600:1f14:359d:9301::1');
    expect(diagnosis).toContain('pooler');
    // The username changes too; a host-only swap fails with an auth error
    // instead, which sends you looking somewhere else again.
    expect(diagnosis).toContain('postgres.<project-ref>');
  });

  it('treats an empty record set the same as no record', async () => {
    expect(
      await diagnoseUnreachableHost('x.example', resolver([], [])),
    ).toContain('does not resolve');
  });

  it('says nothing about a literal IP address', async () => {
    // Caught by booting against DATABASE_URL=...@127.0.0.1..., which reported
    // "127.0.0.1 does not resolve to any address" -- confidently wrong, and
    // exactly the kind of misdirection this file exists to prevent.
    const never: DnsResolver = {
      resolve4: notFound,
      resolve6: notFound,
    };
    expect(await diagnoseUnreachableHost('127.0.0.1', never)).toBeNull();
    expect(await diagnoseUnreachableHost('::1', never)).toBeNull();
    expect(await diagnoseUnreachableHost('10.0.0.5', never)).toBeNull();
  });

  it('does not hang when a lookup never settles', async () => {
    // A diagnostic must never be slower than the failure it explains.
    const hangs: DnsResolver = {
      resolve4: () => new Promise(() => {}),
      resolve6: () => Promise.resolve(['2600::1']),
    };
    const diagnosis = await diagnoseUnreachableHost('slow.example', hangs);
    expect(diagnosis).toContain('only to IPv6');
  }, 10000);
});
