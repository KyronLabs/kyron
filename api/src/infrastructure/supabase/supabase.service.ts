/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
// src/infrastructure/supabase/supabase.service.ts
import { Injectable, Logger } from '@nestjs/common';
import { createClient, SupabaseClient } from '@supabase/supabase-js';

@Injectable()
export class SupabaseService {
  private readonly logger = new Logger(SupabaseService.name);
  private readonly supabase: SupabaseClient;
  private readonly bucket: string;
  private readonly avatarFolder: string;
  private readonly coverFolder: string;

  constructor() {
    const url = process.env.SUPABASE_URL;
    const key = process.env.SUPABASE_SERVICE_KEY;
    if (!url || !key) {
      this.logger.error('SUPABASE_URL or SUPABASE_SERVICE_KEY is not set');
      throw new Error('Supabase config missing');
    }

    this.supabase = createClient(url, key, {
      auth: { persistSession: false },
    });

    this.bucket = process.env.SUPABASE_BUCKET || 'kyron-media';
    this.avatarFolder = process.env.AVATAR_FOLDER || 'avatars';
    this.coverFolder = process.env.COVER_FOLDER || 'covers';
  }

  /**
   * Upload a file buffer to a given folder and return public URL
   * - path should be unique (we generate unique names for you in ProfileService)
   */
  async uploadFile(
    folder: string,
    path: string,
    fileBuffer: Buffer,
    contentType: string,
  ): Promise<{ publicUrl: string }> {
    const key = `${folder}/${path}`;

    // upsert true makes subsequent uploads replace
    const resp = await this.supabase.storage
      .from(this.bucket)
      .upload(key, fileBuffer, {
        contentType,
        upsert: true,
      });

    if (resp.error) {
      this.logger.error('Supabase upload error', resp.error);
      throw resp.error;
    }

    // get public URL (if bucket public). If bucket is private, you can create signed URL.
    const { publicURL, error } = this.supabase.storage
      .from(this.bucket)
      .getPublicUrl(key);

    if (error) {
      this.logger.error('Supabase getPublicUrl error', error);
      throw error;
    }

    return { publicUrl: publicURL! };
  }

  async createSignedUrl(path: string, expiresInSeconds = 60 * 60) {
    const resp = await this.supabase.storage
      .from(this.bucket)
      .createSignedUrl(path, expiresInSeconds);
    if (resp.error) throw resp.error;
    return resp.signedUrl!;
  }

  // convenience helpers
  getAvatarFolder() {
    return this.avatarFolder;
  }
  getCoverFolder() {
    return this.coverFolder;
  }
  getBucket() {
    return this.bucket;
  }
}
