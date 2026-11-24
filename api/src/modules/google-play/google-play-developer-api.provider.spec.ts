import { GooglePlayDeveloperApiProvider } from './google-play-developer-api.provider';

describe('GooglePlayDeveloperApiProvider configuration', () => {
  const originalEnv = { ...process.env };
  let provider: GooglePlayDeveloperApiProvider;

  beforeEach(() => {
    process.env.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON = JSON.stringify({
      client_email: 'kyron-test@project.iam.gserviceaccount.com',
      private_key:
        '-----BEGIN PRIVATE KEY-----\\ntest\\n-----END PRIVATE KEY-----',
    });
    process.env.GOOGLE_PLAY_PACKAGE_NAME = 'so.kyron.app';
    provider = new GooglePlayDeveloperApiProvider();
  });

  afterEach(() => {
    process.env = { ...originalEnv };
  });

  it('accepts a configured dotted Android package identifier', () => {
    expect(provider.isConfigured()).toBe(true);
  });

  it('fails closed for an invalid Android package identifier', () => {
    process.env.GOOGLE_PLAY_PACKAGE_NAME = 'so/kyron/app';

    expect(provider.isConfigured()).toBe(false);
  });

  it('fails closed when the service account is missing', () => {
    delete process.env.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON;

    expect(provider.isConfigured()).toBe(false);
  });
});
