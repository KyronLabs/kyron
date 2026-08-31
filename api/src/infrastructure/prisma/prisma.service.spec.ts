import { describeDatabaseHost } from './prisma.service';

/**
 * DATABASE_URL holds the database password. The boot failure log names the
 * host because a wrong host is the likelier cause of "cannot reach the
 * database" -- but it must name only the host.
 */
describe('describeDatabaseHost', () => {
  it('returns host and port, and no credentials', () => {
    const described = describeDatabaseHost(
      'postgresql://postgres.abc:s3cr3t-p4ssw0rd@aws-0-us-west-2.pooler.supabase.com:6543/postgres',
    );
    expect(described).toBe('aws-0-us-west-2.pooler.supabase.com:6543');
    expect(described).not.toContain('s3cr3t-p4ssw0rd');
    expect(described).not.toContain('postgres.abc');
  });

  it('keeps query parameters out of it', () => {
    expect(
      describeDatabaseHost(
        'postgresql://u:p@db.example.com:5432/postgres?sslmode=require&pgbouncer=true',
      ),
    ).toBe('db.example.com:5432');
  });

  it('omits the port when the URL does not carry one', () => {
    expect(
      describeDatabaseHost('postgresql://u:p@db.example.com/postgres'),
    ).toBe('db.example.com');
  });

  it('returns null rather than echo a URL it could not parse', () => {
    // Never fall back to printing the input: that string is the credential.
    expect(
      describeDatabaseHost('postgres@@@not a url:with a password'),
    ).toBeNull();
    expect(describeDatabaseHost('')).toBeNull();
    expect(describeDatabaseHost(undefined)).toBeNull();
  });
});
