import { mkdirSync, mkdtempSync, rmSync, writeFileSync } from 'fs';
import { tmpdir } from 'os';
import { join } from 'path';

import { readSecretFiles, readServiceAccount } from './service-account';

/**
 * Reading the Firebase key, and saying what is wrong with it in words that
 * can go on /health.
 *
 * Every case here is a way the key really arrives broken from a dashboard,
 * and each used to read as the same bare "off".
 */
const PEM =
  '-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASC\n' +
  '-----END PRIVATE KEY-----\n';

const key = {
  type: 'service_account',
  project_id: 'kyron-push',
  private_key_id: 'abc',
  private_key: PEM,
  client_email: 'firebase-adminsdk@kyron-push.iam.gserviceaccount.com',
};

const compact = JSON.stringify(key);

function accountFrom(value: string) {
  const reading = readServiceAccount({ FCM_SERVICE_ACCOUNT_JSON: value });
  if (!('account' in reading)) throw new Error(reading.problem);
  return reading.account;
}

function problemFrom(env: NodeJS.ProcessEnv, files = []) {
  const reading = readServiceAccount(env, files);
  if ('account' in reading) throw new Error('read a key that is not one');
  // Never any of the value, whatever went wrong: this goes on /health.
  expect(reading.problem).not.toContain('MIIEvQ');
  expect(reading.problem).not.toContain('iam.gserviceaccount.com');
  return reading.problem;
}

describe('a key pasted the way the docs say', () => {
  it('reads as one line', () => {
    expect(accountFrom(compact)).toEqual({
      project_id: 'kyron-push',
      client_email: key.client_email,
      private_key: PEM,
    });
  });

  it('reads as the file itself, across many lines', () => {
    expect(accountFrom(JSON.stringify(key, null, 2)).project_id).toBe(
      'kyron-push',
    );
  });
});

describe('a key pasted some other way that is still the key', () => {
  it('in the quotes from a command line', () => {
    expect(accountFrom(`'${compact}'`).project_id).toBe('kyron-push');
    expect(accountFrom(`"${compact}"`).project_id).toBe('kyron-push');
  });

  it('as a JSON string of the JSON', () => {
    expect(accountFrom(JSON.stringify(compact)).project_id).toBe('kyron-push');
  });

  it('in base64', () => {
    expect(
      accountFrom(Buffer.from(compact).toString('base64')).project_id,
    ).toBe('kyron-push');
  });

  it('with its newlines escaped twice', () => {
    const doubled = compact.replace(/\\n/g, '\\\\n');
    expect(accountFrom(doubled).private_key).toBe(PEM);
  });

  it('from a Render secret file, when there is no variable', () => {
    const reading = readServiceAccount({}, [
      { name: 'kyron-push-firebase-adminsdk.json', content: compact },
    ]);
    expect(reading).toMatchObject({
      account: { project_id: 'kyron-push' },
      source: 'The secret file kyron-push-firebase-adminsdk.json',
    });
  });

  it('the variable wins over a secret file', () => {
    const other = JSON.stringify({ ...key, project_id: 'other' });
    const reading = readServiceAccount({ FCM_SERVICE_ACCOUNT_JSON: compact }, [
      { name: 'service-account.json', content: other },
    ]);
    expect(reading).toMatchObject({ account: { project_id: 'kyron-push' } });
  });
});

describe('what is wrong, when it is wrong', () => {
  it('not set at all', () => {
    expect(problemFrom({})).toMatch(
      /^FCM_SERVICE_ACCOUNT_JSON is not set on this service/,
    );
  });

  it('set under a name that is nearly right, naming it but not its value', () => {
    const problem = problemFrom({
      FIREBASE_SERVICE_ACCOUNT: compact,
      PATH: '/usr/bin',
    });
    expect(problem).toMatch(/FIREBASE_SERVICE_ACCOUNT is set/);
    expect(problem).not.toMatch(/PATH/);
  });

  it('cut off at its first line', () => {
    expect(problemFrom({ FCM_SERVICE_ACCOUNT_JSON: '{' })).toMatch(/cut off/);
  });

  it('not JSON at all', () => {
    expect(
      problemFrom({ FCM_SERVICE_ACCOUNT_JSON: '/etc/secrets/key.json' }),
    ).toMatch(/is not the key file/);
  });

  it("the app's google-services.json in its place", () => {
    const googleServices = JSON.stringify({
      project_info: { project_id: 'kyron-push' },
      client: [{ api_key: [{ current_key: 'AIza' }] }],
    });
    expect(problemFrom({ FCM_SERVICE_ACCOUNT_JSON: googleServices })).toMatch(
      /holds google-services.json/,
    );
  });

  it('the OAuth client from Google sign-in in its place', () => {
    const client = JSON.stringify({
      web: { client_id: 'x', client_secret: 'y' },
    });
    expect(problemFrom({ FCM_SERVICE_ACCOUNT_JSON: client })).toMatch(
      /OAuth client/,
    );
  });

  it('JSON missing the parts a key has', () => {
    const partial = JSON.stringify({ project_id: 'kyron-push' });
    expect(problemFrom({ FCM_SERVICE_ACCOUNT_JSON: partial })).toMatch(
      /no client_email, private_key/,
    );
  });

  it('a secret file that is meant to be the key and is not', () => {
    const problem = problemFrom({}, [
      { name: 'firebase-key.json', content: '{"project_id":"x"' },
    ] as never);
    expect(problem).toMatch(/The secret file firebase-key.json/);
  });

  it('says nothing of secret files that are about something else', () => {
    const problem = problemFrom({}, [
      { name: 'certificate.pem', content: 'not a key' },
    ] as never);
    expect(problem).not.toMatch(/certificate/);
  });
});

describe('the secret files Render mounts', () => {
  it('reads small files, and nothing when the folder is not there', () => {
    const dir = mkdtempSync(join(tmpdir(), 'secrets-'));
    try {
      writeFileSync(join(dir, 'key.json'), compact);
      mkdirSync(join(dir, 'nested'));
      expect(readSecretFiles(dir)).toEqual([
        { name: 'key.json', content: compact },
      ]);
    } finally {
      rmSync(dir, { recursive: true, force: true });
    }
    expect(readSecretFiles(join(dir, 'gone'))).toEqual([]);
  });
});
