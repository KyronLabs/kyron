import { readdirSync, readFileSync, statSync } from 'fs';
import { join } from 'path';

/** The fields push needs from a Firebase service account key. */
export interface ServiceAccount {
  project_id: string;
  client_email: string;
  private_key: string;
}

/** A key, and where it was found -- or what is wrong, in plain words. */
export type ServiceAccountReading =
  | { account: ServiceAccount; source: string }
  | { problem: string };

/** A file Render mounts for a service that was given a secret file. */
export interface SecretFile {
  name: string;
  content: string;
}

export const SERVICE_ACCOUNT_VAR = 'FCM_SERVICE_ACCOUNT_JSON';

const HOW_TO_GET_ONE =
  'Firebase console, Project settings, Service accounts, Generate new ' +
  'private key, and paste that whole file.';

/** Names that look like somebody meant them for this key. */
const LOOKS_MEANT = /fcm|firebase|adminsdk|service.?account/i;

/**
 * Reads the Firebase service account key from wherever it was put, or says
 * what is wrong with it.
 *
 * "Push is off" was all anybody could learn before, and every way of getting
 * the key wrong looked the same from outside: not set, set on a different
 * name, cut off at its first line, the app's google-services.json pasted in
 * its place. Each now has its own sentence.
 *
 * The sentences go to /health, which anybody can read, so they say what is
 * wrong and never repeat any part of the value.
 */
export function readServiceAccount(
  env: NodeJS.ProcessEnv,
  secretFiles: readonly SecretFile[] = [],
): ServiceAccountReading {
  const raw = env[SERVICE_ACCOUNT_VAR]?.trim();
  if (raw) return parseKey(raw, SERVICE_ACCOUNT_VAR);

  // A Render secret file, for whoever chose that over a variable.
  const fileProblems: string[] = [];
  for (const file of secretFiles) {
    const reading = parseKey(
      file.content.trim(),
      `The secret file ${file.name}`,
    );
    if ('account' in reading) return reading;
    if (LOOKS_MEANT.test(file.name)) fileProblems.push(reading.problem);
  }

  const nearMisses = Object.keys(env).filter(
    (name) => name !== SERVICE_ACCOUNT_VAR && LOOKS_MEANT.test(name),
  );
  return {
    problem: [
      `${SERVICE_ACCOUNT_VAR} is not set on this service, or it was set ` +
        'without redeploying.',
      ...(nearMisses.length > 0
        ? [
            `${nearMisses.join(', ')} ${
              nearMisses.length === 1 ? 'is' : 'are'
            } set, but the name has to be exactly ${SERVICE_ACCOUNT_VAR}.`,
          ]
        : []),
      ...fileProblems,
    ].join(' '),
  };
}

/**
 * The secret files Render mounted, small enough to be a key.
 *
 * `/etc/secrets` is where Render puts them for every kind of service. Absent
 * everywhere else, which reads as no files.
 */
export function readSecretFiles(dir = '/etc/secrets'): SecretFile[] {
  try {
    return readdirSync(dir).flatMap((name) => {
      const path = join(dir, name);
      const stat = statSync(path);
      if (!stat.isFile() || stat.size > 64 * 1024) return [];
      return [{ name, content: readFileSync(path, 'utf8') }];
    });
  } catch {
    return [];
  }
}

function parseKey(raw: string, where: string): ServiceAccountReading {
  const text = unwrap(raw);

  let parsed: unknown;
  try {
    parsed = JSON.parse(text);
  } catch {
    if (!text.startsWith('{')) {
      return {
        problem:
          `${where} is set (${raw.length} characters) but is not the key ` +
          `file, which starts with {. ${HOW_TO_GET_ONE}`,
      };
    }
    if (!text.endsWith('}')) {
      return {
        problem:
          `${where} starts like the key file but stops after ${raw.length} ` +
          'characters, so it was cut off. Paste the whole file into the ' +
          "value box: a .env import keeps only a value's first line.",
      };
    }
    return {
      problem:
        `${where} looks like the key file but is not valid JSON, so it was ` +
        `changed on the way in. ${HOW_TO_GET_ONE}`,
    };
  }

  if (!parsed || typeof parsed !== 'object' || Array.isArray(parsed)) {
    return { problem: `${where} is not the key file. ${HOW_TO_GET_ONE}` };
  }
  const key = parsed as Record<string, unknown>;

  if ('project_info' in key || 'client' in key) {
    return {
      problem:
        `${where} holds google-services.json, which is the app's Firebase ` +
        `config. The server needs a service account key instead: ${HOW_TO_GET_ONE}`,
    };
  }
  if ('web' in key || 'installed' in key) {
    return {
      problem:
        `${where} holds an OAuth client, which is what Google sign-in uses. ` +
        `The server needs a service account key instead: ${HOW_TO_GET_ONE}`,
    };
  }

  const missing = ['project_id', 'client_email', 'private_key'].filter(
    (field) => {
      const value = key[field];
      return typeof value !== 'string' || !value.trim();
    },
  );
  if (missing.length > 0) {
    return {
      problem:
        `${where} is JSON but not a service account key: it has no ` +
        `${missing.join(', ')}. ${HOW_TO_GET_ONE}`,
    };
  }

  // Escaped newlines, as a key set through a shell or a .env file has them.
  const privateKey = (key.private_key as string).replace(/\\n/g, '\n');
  if (!privateKey.includes('PRIVATE KEY')) {
    return {
      problem: `${where} has a private_key that is not a key. ${HOW_TO_GET_ONE}`,
    };
  }

  return {
    account: {
      project_id: key.project_id as string,
      client_email: key.client_email as string,
      private_key: privateKey,
    },
    source: where,
  };
}

/** The key's JSON from the shapes a pasted value arrives in. */
function unwrap(raw: string): string {
  let text = raw.trim();

  // Still in the quotes it was written between on a command line.
  if (
    text.length >= 2 &&
    ((text.startsWith("'") && text.endsWith("'")) ||
      (text.startsWith('"') && text.endsWith('"')))
  ) {
    try {
      // A JSON string holding the JSON, as some secret stores hand it over.
      const inner: unknown = JSON.parse(text);
      text = typeof inner === 'string' ? inner.trim() : text.slice(1, -1);
    } catch {
      text = text.slice(1, -1).trim();
    }
  }

  // Base64, which some dashboards suggest for a value that spans lines.
  if (!text.startsWith('{') && /^[A-Za-z0-9+/=_\-\s]+$/.test(text)) {
    const decoded = Buffer.from(text, 'base64').toString('utf8').trim();
    if (decoded.startsWith('{')) text = decoded;
  }

  return text;
}
