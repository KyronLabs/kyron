import {
  chmodSync,
  existsSync,
  mkdtempSync,
  mkdirSync,
  rmSync,
  writeFileSync,
} from 'fs';
import { tmpdir } from 'os';
import { join, resolve } from 'path';
import { spawnSync } from 'child_process';

describe('API container startup script', () => {
  let root: string;
  let bin: string;
  let prisma: string;
  let marker: string;
  const script = resolve(process.cwd(), 'scripts/start.sh');

  beforeEach(() => {
    root = mkdtempSync(join(tmpdir(), 'kyron-start-'));
    bin = join(root, 'bin');
    mkdirSync(bin);
    prisma = join(root, 'fake-prisma');
    marker = join(root, 'api-started');
    writeFileSync(
      prisma,
      '#!/bin/sh\nif [ -n "${FAKE_PRISMA_SLEEP:-}" ]; then sleep "$FAKE_PRISMA_SLEEP"; fi\nexit "${FAKE_PRISMA_EXIT:-0}"\n',
    );
    chmodSync(prisma, 0o755);
    writeFileSync(
      join(bin, 'node'),
      '#!/bin/sh\nprintf "%s\\n" "$*" > "$START_MARKER"\nexit 0\n',
    );
    chmodSync(join(bin, 'node'), 0o755);
  });

  afterEach(() => {
    rmSync(root, { recursive: true, force: true });
  });

  function run(extra: Record<string, string> = {}) {
    return spawnSync('sh', [script], {
      cwd: process.cwd(),
      encoding: 'utf8',
      env: {
        ...process.env,
        PATH: bin + ':' + (process.env.PATH || ''),
        PRISMA_BIN: prisma,
        START_MARKER: marker,
        ...extra,
      },
    });
  }

  it('starts the API only after migrations succeed', () => {
    const result = run();
    expect(result.status).toBe(0);
    expect(result.stdout).toContain('database migrations are up to date');
    expect(existsSync(marker)).toBe(true);
  });

  it('does not start the API or auto-baseline after migration failure', () => {
    const result = run({ FAKE_PRISMA_EXIT: '23' });
    expect(result.status).toBe(23);
    expect(result.stderr).toContain('refusing to start the API');
    expect(result.stdout).not.toContain('baselin');
    expect(existsSync(marker)).toBe(false);
  });

  it('does not start the API when the migration command times out', () => {
    const result = run({ MIGRATE_TIMEOUT: '1', FAKE_PRISMA_SLEEP: '3' });
    expect(result.status).toBe(124);
    expect(result.stderr).toContain('exceeded 1s');
    expect(existsSync(marker)).toBe(false);
  });

  it('rejects an invalid migration timeout before running Prisma', () => {
    const result = run({ MIGRATE_TIMEOUT: '0' });
    expect(result.status).toBe(2);
    expect(result.stderr).toContain('MIGRATE_TIMEOUT');
    expect(existsSync(marker)).toBe(false);
  });
});
