/**
 * Environment defaults for the test run.
 *
 * Several services read their configuration at module scope and throw when it
 * is missing -- deliberately, so a misconfigured deployment fails at boot
 * rather than at the first request. That means a spec cannot set them in
 * `beforeAll`: by then the import has already run. jest's `setupFiles` execute
 * before the test file is imported, which is early enough.
 *
 * Only ever fills a gap. A value already in the environment wins, so this
 * cannot quietly override real configuration.
 *
 * Two related notes on the jest config in package.json, which has nowhere to
 * put a comment jest does not warn about:
 *
 *   moduleNameMapper       tsconfig maps @/* to src/*; jest resolves modules
 *                          itself and has to be told separately, or any spec
 *                          reaching code that uses the alias fails to run.
 *   transformIgnorePatterns  jose ships ESM only. Node 22 can require() it,
 *                          which is why the built app works, but jest uses its
 *                          own registry and needs it transformed.
 */
const DEFAULTS: Record<string, string> = {
  SUPABASE_URL: 'https://example.supabase.co',
  SUPABASE_SERVICE_ROLE_KEY: 'test-service-role-key',
  SUPABASE_ANON_KEY: 'test-anon-key',
  DATABASE_URL: 'postgresql://user:pass@127.0.0.1:5432/postgres',
  JWT_SECRET: 'test-jwt-secret-used-only-for-module-compilation',
  SENDGRID_API_KEY: 'SG.test',
  EMAIL_FROM: 'noreply@example.test',
};

for (const [key, value] of Object.entries(DEFAULTS)) {
  process.env[key] ??= value;
}
