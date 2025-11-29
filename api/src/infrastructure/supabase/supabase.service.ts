/* eslint-disable @typescript-eslint/no-unsafe-assignment */
import { createClient, SupabaseClient } from '@supabase/supabase-js';
import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class SupabaseService {
  private readonly logger = new Logger(SupabaseService.name);
  private readonly client: SupabaseClient;
  private readonly bucketName = process.env.SUPABASE_BUCKET_NAME || 'covers';

  constructor() {
    const url = process.env.SUPABASE_URL;
    const key = process.env.SUPABASE_KEY;
    if (!url || !key) {
      this.logger.error('SUPABASE_URL or SUPABASE_KEY missing');
      throw new Error('Supabase config missing');
    }
    this.client = createClient(url, key, { fetch });
  }

  /**
   * Return a public URL (string) for a random file under covers/default_covers.
   * Returns null if no file found.
   */
  async getRandomDefaultCover(): Promise<string | null> {
    const folder = 'default_covers'; // path inside bucket (assuming bucket root covers/)
    try {
      // list files under bucket path
      const { data, error } = await this.client.storage
        .from(this.bucketName)
        .list(folder, { limit: 1000, offset: 0, sortBy: { column: 'name', order: 'asc' } });

      if (error) {
        this.logger.error(`Supabase list error: ${error.message ?? error}`);
        throw error;
      }

      if (!data || data.length === 0) {
        this.logger.warn(`No default covers found in bucket ${this.bucketName}/${folder}`);
        return null;
      }

      // pick random file
      const file = data[Math.floor(Math.random() * data.length)];
      const path = `${folder}/${file.name}`;

      // get public URL
      const { data: urlData } = this.client.storage.from(this.bucketName).getPublicUrl(path);
      // urlData shape: { publicUrl: string }
      if (!urlData || !urlData.publicUrl) {
        this.logger.warn(`getPublicUrl returned no url for ${path}`);
        return null;
      }

      return urlData.publicUrl;
    } catch (err) {
      this.logger.error(`getRandomDefaultCover failed: ${String(err)}`);
      throw err;
    }
  }

  // ------------------------------------------------------------------
  // Optional: keep any legacy helpers you still need elsewhere
  // ------------------------------------------------------------------
  getAvatarFolder(): string {
    return process.env.SUPABASE_AVATAR_BUCKET || 'avatars';
  }

  getCoverFolder(): string {
    return this.bucketName;
  }
}
