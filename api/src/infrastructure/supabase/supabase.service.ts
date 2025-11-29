/* eslint-disable @typescript-eslint/no-unsafe-assignment */
// src/infrastructure/supabase/supabase.service.ts
// src/infrastructure/supabase/supabase.service.ts
// src/infrastructure/supabase/supabase.service.ts
import { Injectable, Logger } from '@nestjs/common';
import { createClient, SupabaseClient } from '@supabase/supabase-js';

@Injectable()
export class SupabaseService {
  private readonly logger = new Logger(SupabaseService.name);
  private readonly client: SupabaseClient;

  // Buckets / folders from env
  private readonly avatarBucket = process.env.SUPABASE_AVATAR_BUCKET || 'avatars';
  private readonly coverBucket = process.env.SUPABASE_COVER_BUCKET || 'covers';
  private readonly defaultCoversFolder =
    process.env.SUPABASE_DEFAULT_COVERS_FOLDER || 'default_covers';
  private readonly signedUrlExpiry =
    Number(process.env.SUPABASE_URL_EXPIRY_SECONDS) || 3600; // seconds

  constructor() {
    const url = process.env.SUPABASE_URL;
    const key = process.env.SUPABASE_KEY;

    if (!url || !key) {
      this.logger.error('Supabase URL/KEY not found in environment variables');
      // continue, but calls will fail — better than crashing at import time
    }

    this.client = createClient(url ?? '', key ?? '', {
      // optional settings
    });
    this.logger.log('Supabase client initialized');
  }

  // Return the bucket name for avatars (so existing calls like getAvatarFolder() keep working)
  getAvatarFolder(): string {
    return this.avatarBucket;
  }

  // Return the bucket name for covers
  getCoverFolder(): string {
    return this.coverBucket;
  }

  // Upload a Buffer to a bucket. `path` may include subfolders (e.g. "avatars/uid_avatar.png")
  // Returns { publicUrl }.
  async uploadFile(
    bucket: string,
    path: string,
    buffer: Buffer,
    mimeType?: string,
  ): Promise<{ publicUrl: string }> {
    // path must not have a leading slash
    const cleanedPath = path.replace(/^\/+/, '');
    const options = mimeType ? { contentType: mimeType, upsert: true } : { upsert: true };

    const { error: uploadError } = await this.client.storage
      .from(bucket)
      .upload(cleanedPath, buffer, options);

    if (uploadError) {
      this.logger.error('Supabase upload error', uploadError);
      throw uploadError;
    }

    const { data: urlData } = this.client.storage.from(bucket).getPublicUrl(cleanedPath);
    // urlData.publicUrl exists per supabase API
    return { publicUrl: urlData.publicUrl };
  }

  // Create a signed URL (expiresIn seconds) — useful if you don't want public access.
  async createSignedUrl(bucket: string, path: string, expiresInSeconds?: number) {
    const cleanedPath = path.replace(/^\/+/, '');
    const expiry = expiresInSeconds ?? this.signedUrlExpiry;

    const { data, error } = await this.client.storage
      .from(bucket)
      .createSignedUrl(cleanedPath, expiry);

    if (error) {
      this.logger.error('Supabase createSignedUrl error', error);
      throw error;
    }

    // data.signedUrl
    return { signedUrl: data.signedUrl, expiresAtSeconds: expiry };
  }

  // List objects inside a folder (returns array of public URLs)
  async listPublicFiles(bucket: string, folder = '', limit = 200) {
    const prefix = folder.replace(/^\/+|\/+$/g, ''); // remove leading/trailing slashes
    const { data, error } = await this.client.storage.from(bucket).list(prefix || '', {
      limit,
      offset: 0,
      sortBy: { column: 'name', order: 'asc' },
    });

    if (error) {
      this.logger.error('Supabase list error', error);
      throw error;
    }

    const urls = (data || []).map((item) => {
      const filePath = prefix ? `${prefix}/${item.name}` : item.name;
      const { data: urlData } = this.client.storage.from(bucket).getPublicUrl(filePath);
      return urlData.publicUrl;
    });

    return urls;
  }

  // Return a random default cover public URL (or throw if none)
  async getRandomDefaultCover(): Promise<string> {
    const urls = await this.listPublicFiles(this.coverBucket, this.defaultCoversFolder, 1000);
    if (!urls || urls.length === 0) {
      throw new Error('No default covers available');
    }
    const idx = Math.floor(Math.random() * urls.length);
    return urls[idx];
  }
}

