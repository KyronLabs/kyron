import type { SupabaseService } from './supabase.service';

/**
 * The private bucket, as a spec needs it: links that name the path they are
 * for, and a record of what was removed. No network.
 */
export class RecordingPrivateStorage {
  readonly removed: string[] = [];
  readonly signed: string[] = [];

  signPrivateMany(
    paths: readonly string[],
    seconds: number,
  ): Promise<Map<string, string>> {
    this.signed.push(...paths);
    return Promise.resolve(
      new Map(paths.map((p) => [p, `https://signed.test/${p}?s=${seconds}`])),
    );
  }

  removePrivate(paths: readonly string[]): Promise<void> {
    this.removed.push(...paths);
    return Promise.resolve();
  }

  /** As the service takes it. */
  get asService(): SupabaseService {
    return this as unknown as SupabaseService;
  }
}
