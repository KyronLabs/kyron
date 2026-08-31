/**
 * Why a database host could not be reached, when DNS can tell us.
 *
 * Three different faults have produced the identical "Can't reach database
 * server" from Prisma, and the difference between them is the whole fix:
 *
 *   - a hostname that does not exist (a typo, or a Supabase pooler host
 *     missing its aws-0-/aws-1- cluster segment)
 *   - a host that resolves only to IPv6, on a platform with no outbound IPv6
 *     route -- which is every managed container host this runs on, and which
 *     Supabase's direct connection endpoints have been for some time
 *   - a database that is actually unreachable or down
 *
 * Only the third is a database problem. The first two are configuration, and
 * both look exactly like an outage until someone resolves the host by hand.
 */

/** The DNS surface used here, injected so this is testable without a network. */
export interface DnsResolver {
  resolve4(host: string): Promise<string[]>;
  resolve6(host: string): Promise<string[]>;
}

/** Caps the lookup: a diagnostic must never be slower than the thing it explains. */
const LOOKUP_TIMEOUT_MS = 3000;

async function addressesOf(
  lookup: (host: string) => Promise<string[]>,
  host: string,
): Promise<string[]> {
  try {
    const addresses = await Promise.race([
      lookup(host),
      new Promise<string[]>((resolve) =>
        setTimeout(() => resolve([]), LOOKUP_TIMEOUT_MS),
      ),
    ]);
    return Array.isArray(addresses) ? addresses : [];
  } catch {
    // ENOTFOUND and ENODATA both mean "no records of this type", which is the
    // answer, not an error.
    return [];
  }
}

/**
 * A sentence explaining an unreachable [host], or null when DNS has nothing to
 * add -- the host resolves to IPv4, so the fault is beyond name resolution and
 * a guess here would only mislead.
 */
export async function diagnoseUnreachableHost(
  host: string,
  dns: DnsResolver,
): Promise<string | null> {
  const [v4, v6] = await Promise.all([
    addressesOf((h) => dns.resolve4(h), host),
    addressesOf((h) => dns.resolve6(h), host),
  ]);

  if (v4.length > 0) return null;

  if (v6.length === 0) {
    return (
      `${host} does not resolve to any address -- no A and no AAAA record. ` +
      'A hostname that does not exist is indistinguishable from a database ' +
      'that is down. Check DATABASE_URL for a typo; a Supabase pooler host ' +
      'needs its cluster segment, as in aws-0-<region>.pooler.supabase.com.'
    );
  }

  return (
    `${host} resolves only to IPv6 (${v6[0]}) and has no IPv4 address. ` +
    'It is unreachable from a host with no outbound IPv6 route, which is the ' +
    'usual case on managed container platforms. Supabase serves IPv4 through ' +
    'the connection pooler instead -- note the pooler expects the username ' +
    'postgres.<project-ref> rather than postgres, so the host is not the only ' +
    'part of DATABASE_URL that changes.'
  );
}
