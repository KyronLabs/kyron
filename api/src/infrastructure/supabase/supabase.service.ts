/* eslint-disable @typescript-eslint/no-unsafe-assignment */
import { createClient, SupabaseClient } from '@supabase/supabase-js';
import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class SupabaseService {
  private readonly logger = new Logger(SupabaseService.name);
  private readonly client: SupabaseClient;

  // Bucket name is EXACTLY "kyron-media"
  private readonly bucket = process.env.SUPABASE_BUCKET_NAME || 'kyron-media';

  constructor() {
    const url = process.env.SUPABASE_URL;
    const key = process.env.SUPABASE_KEY;

    if (!url || !key) {
      this.logger.error('Supabase config missing: SUPABASE_URL or SUPABASE_KEY');
      throw new Error('Supabase config missing');
    }

    this.client = createClient(url, key);
  }

  // -----------------------------------------------------
  // Upload a file
  // -----------------------------------------------------
  async uploadFile(
    folder: string,
    fileName: string,
    buffer: Buffer,
    mimeType: string,
  ) {
    const fullPath = `${folder}/${fileName}`;

    const { error } = await this.client.storage
      .from(this.bucket)
      .upload(fullPath, buffer, {
        contentType: mimeType,
        upsert: true,
      });

    if (error) {
      this.logger.error(`Upload failed for ${fullPath}`, error);
      throw error;
    }

    const { data } = this.client.storage.from(this.bucket).getPublicUrl(fullPath);
    return { publicUrl: data.publicUrl };
  }

  // -----------------------------------------------------
  // Default cover folder
  // -----------------------------------------------------
  getCoverFolder() {
    // actual path inside bucket
    return 'covers';
  }

  async getRandomDefaultCover(): Promise<string | null> {
    const folder = 'covers/default_covers';

    const { data, error } = await this.client.storage
      .from(this.bucket)
      .list(folder, {
        limit: 1000,
      });

    if (error) {
      this.logger.error(`Error listing default covers`, error);
      throw error;
    }

    if (!data?.length) {
      this.logger.warn(`No default covers found in ${folder}`);
      return null;
    }

    const file = data[Math.floor(Math.random() * data.length)];
    const path = `${folder}/${file.name}`;

    const { data: urlData } = this.client.storage.from(this.bucket).getPublicUrl(path);
    return urlData.publicUrl;
  }

  // -----------------------------------------------------
  // Avatar folder
  // -----------------------------------------------------
  getAvatarFolder() {
    // if you created: kyron-media/avatars/
    return process.env.SUPABASE_AVATAR_BUCKET || 'avatars';
  }
}
