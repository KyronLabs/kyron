import { isBlockedAddress, normaliseUrl } from './link-safety';

describe('isBlockedAddress', () => {
  // The endpoint fetches a URL taken from a post, from inside the deployment's
  // network. Each of these is a place a post must not be able to point it.
  const blocked = [
    ['loopback', '127.0.0.1'],
    ['loopback, elsewhere in the /8', '127.99.1.5'],
    ['cloud metadata', '169.254.169.254'],
    ['link-local', '169.254.0.1'],
    ['private 10/8', '10.0.0.1'],
    ['private 172.16/12', '172.20.10.1'],
    ['private 172.31/12', '172.31.255.254'],
    ['private 192.168/16', '192.168.1.1'],
    ['carrier-grade NAT', '100.100.0.1'],
    ['this network', '0.0.0.0'],
    ['multicast', '224.0.0.1'],
    ['IPv6 loopback', '::1'],
    ['IPv6 unspecified', '::'],
    ['IPv6 link-local', 'fe80::1'],
    ['IPv6 unique local', 'fd00::1'],
    // The one that walks past a v4-only check.
    ['IPv4-mapped private address', '::ffff:10.0.0.1'],
    ['IPv4-mapped metadata address', '::ffff:169.254.169.254'],
    ['not an address at all', 'not-an-address'],
  ] as const;

  for (const [name, address] of blocked) {
    it(`refuses ${name} (${address})`, () => {
      expect(isBlockedAddress(address)).toBe(true);
    });
  }

  const allowed = [
    ['a public v4 address', '93.184.216.34'],
    ['another public v4 address', '8.8.8.8'],
    ['just outside 172.16/12', '172.32.0.1'],
    ['just below 172.16/12', '172.15.255.255'],
    ['a public v6 address', '2606:2800:220:1:248:1893:25c8:1946'],
  ] as const;

  for (const [name, address] of allowed) {
    it(`allows ${name} (${address})`, () => {
      expect(isBlockedAddress(address)).toBe(false);
    });
  }
});

describe('normaliseUrl', () => {
  it('refuses a scheme that is not the web', () => {
    expect(() => normaliseUrl('file:///etc/passwd')).toThrow();
    expect(() => normaliseUrl('gopher://example.com')).toThrow();
    expect(() => normaliseUrl('javascript:alert(1)')).toThrow();
  });

  it('refuses a URL carrying credentials', () => {
    expect(() => normaliseUrl('https://user:pass@example.com')).toThrow();
  });

  it('refuses something that is not a URL', () => {
    expect(() => normaliseUrl('hello')).toThrow();
  });

  it('drops the fragment, which never reaches the server', () => {
    expect(normaliseUrl('https://example.com/a#b').toString()).toBe(
      'https://example.com/a',
    );
  });

  it('drops a default port so it caches as the same link', () => {
    expect(normaliseUrl('https://example.com:443/a').toString()).toBe(
      'https://example.com/a',
    );
    expect(normaliseUrl('http://example.com:80/a').toString()).toBe(
      'http://example.com/a',
    );
  });

  it('keeps a non-default port', () => {
    expect(normaliseUrl('https://example.com:8443/a').toString()).toBe(
      'https://example.com:8443/a',
    );
  });

  it('keeps the query, which changes what is served', () => {
    expect(normaliseUrl('https://example.com/a?b=1').toString()).toBe(
      'https://example.com/a?b=1',
    );
  });
});
