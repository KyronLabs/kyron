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

    this.client = createClient(url, key); // FIXED — no { fetch }
  }

  async uploadFile(
    folder: string,
    filename: string,
    buffer: Buffer,
    mimeType: string,
  ): Promise<{ publicUrl: string }> {
    const path = `${folder}/${filename}`;

    const { error: uploadError } = await this.client.storage
      .from(this.bucketName)
      .upload(path, buffer, {
        contentType: mimeType,
        upsert: true,
      });

    if (uploadError) {
      this.logger.error(`Supabase upload error: ${uploadError.message}`);
      throw uploadError;
    }

    const { data } = this.client.storage
      .from(this.bucketName)
      .getPublicUrl(path);

    if (!data?.publicUrl) {
      throw new Error(`Failed to get public URL for ${path}`);
    }

    return { publicUrl: data.publicUrl };
  }

  async getRandomDefaultCover(): Promise<string | null> {
    const folder = 'default_covers';

    const { data, error } = await this.client.storage
      .from(this.bucketName)
      .list(folder);

    if (error) {
      this.logger.error(`Supabase list error: ${error.message}`);
      throw error;
    }

    if (!data || data.length === 0) {
      this.logger.warn(`No default covers in ${this.bucketName}/${folder}`);
      return null;
    }

    const file = data[Math.floor(Math.random() * data.length)];
    const path = `${folder}/${file.name}`;

    const { data: urlData } = this.client.storage
      .from(this.bucketName)
      .getPublicUrl(path);

    return urlData?.publicUrl ?? null;
  }

  getAvatarFolder() {
    return process.env.SUPABASE_AVATAR_BUCKET || 'avatars';
  }

  getCoverFolder() {
    return this.bucketName;
  }
}
