import { lookup } from 'node:dns/promises';
import { isIP } from 'node:net';

/**
 * Whether an address belongs to a range that must never be fetched on behalf
 * of a user.
 *
 * The endpoint takes a URL from a post and fetches it from inside the
 * deployment's network. Without this it is a request forgery primitive: a post
 * containing http://169.254.169.254/latest/meta-data/iam/security-credentials/
 * would have the API fetch the instance's cloud credentials and hand the
 * result back as a link card. The same applies to anything on the private
 * ranges -- an internal admin panel, the database's own port, another service
 * on the same subnet that trusts its callers.
 */
export function isBlockedAddress(address: string): boolean {
  const version = isIP(address);
  if (version === 4) return isBlockedV4(address);
  if (version === 6) return isBlockedV6(address);
  // Not an address at all: refuse rather than guess.
  return true;
}

function isBlockedV4(address: string): boolean {
  const parts = address.split('.').map(Number);
  if (parts.length !== 4 || parts.some((p) => !Number.isInteger(p))) {
    return true;
  }
  const [a, b] = parts;

  return (
    a === 0 || // "this network"
    a === 10 || // private
    a === 127 || // loopback
    (a === 100 && b >= 64 && b <= 127) || // carrier-grade NAT
    (a === 169 && b === 254) || // link-local, and cloud metadata
    (a === 172 && b >= 16 && b <= 31) || // private
    (a === 192 && b === 0) || // protocol assignments
    (a === 192 && b === 168) || // private
    (a === 198 && b >= 18 && b <= 19) || // benchmarking
    a >= 224 // multicast and reserved
  );
}

function isBlockedV6(address: string): boolean {
  const value = address.toLowerCase().split('%')[0];

  // ::ffff:10.0.0.1 and friends are IPv4 wearing an IPv6 hat, and would
  // otherwise walk straight past the v4 rules above.
  const mapped = /^::ffff:(\d+\.\d+\.\d+\.\d+)$/.exec(value);
  if (mapped) return isBlockedV4(mapped[1]);

  return (
    value === '::' ||
    value === '::1' || // loopback
    value.startsWith('fe8') || // link-local
    value.startsWith('fe9') ||
    value.startsWith('fea') ||
    value.startsWith('feb') ||
    value.startsWith('fc') || // unique local
    value.startsWith('fd') ||
    value.startsWith('ff') // multicast
  );
}

/**
 * Resolves a hostname and refuses it if any address it answers with is
 * blocked.
 *
 * Every address, not just the first: a host that answers with one public and
 * one private address would otherwise be fetchable, and which one the socket
 * picks is not ours to decide.
 */
export async function resolveIfPublic(hostname: string): Promise<string[]> {
  if (isIP(hostname)) {
    if (isBlockedAddress(hostname)) {
      throw new Error(`Refusing to fetch a link pointing at ${hostname}.`);
    }
    return [hostname];
  }

  const records = await lookup(hostname, { all: true, verbatim: true });
  if (!records.length) {
    throw new Error(`${hostname} does not resolve.`);
  }

  for (const record of records) {
    if (isBlockedAddress(record.address)) {
      throw new Error(
        `Refusing to fetch a link pointing at ${hostname}: it resolves to a private address.`,
      );
    }
  }

  return records.map((record) => record.address);
}

/**
 * Parses a user-supplied URL and rejects anything that is not a plain public
 * web address.
 *
 * The returned URL is also the cache key, so the normalisation here decides
 * what counts as the same link: the fragment is dropped because it never
 * reaches the server, and a default port is dropped because :443 and nothing
 * are the same request.
 */
export function normaliseUrl(raw: string): URL {
  let url: URL;
  try {
    url = new URL(raw.trim());
  } catch {
    throw new Error('That is not a web address.');
  }

  if (url.protocol !== 'http:' && url.protocol !== 'https:') {
    throw new Error('Only http and https links can be previewed.');
  }
  if (url.username || url.password) {
    throw new Error('A link carrying credentials will not be fetched.');
  }

  url.hash = '';
  if (
    (url.protocol === 'https:' && url.port === '443') ||
    (url.protocol === 'http:' && url.port === '80')
  ) {
    url.port = '';
  }

  return url;
}
