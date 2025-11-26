/* eslint-disable @typescript-eslint/no-unsafe-assignment */
// src/infrastructure/supabase/supabase.service.ts
// src/infrastructure/supabase/supabase.service.ts
import {
  Injectable,
  Logger,
  InternalServerErrorException,
} from '@nestjs/common';
import { createClient, SupabaseClient } from '@supabase/supabase-js';

@Injectable()
export class SupabaseService {
  private readonly logger = new Logger(SupabaseService.name);
  private client: SupabaseClient;

  constructor() {
    const url = process.env.SUPABASE_URL;
    const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!url || !key) {
      throw new Error('Supabase environment variables missing');
    }

    this.client = createClient(url, key, {
      auth: {
        persistSession: false,
      },
    });
  }

  // -----------------------------------------------------------------------
  // FOLDER HELPERS (required by ProfileService)
  // -----------------------------------------------------------------------
  getAvatarFolder() {
    return 'avatars';
  }

  getCoverFolder() {
    return 'covers';
  }

  // -----------------------------------------------------------------------
  // UNIVERSAL UPLOAD (returns { publicUrl })
  // -----------------------------------------------------------------------
  async uploadFile(
    bucket: string,
    path: string,
    buffer: Buffer,
    mime: string,
  ): Promise<{ publicUrl: string }> {
    const { error: uploadErr } = await this.client.storage
      .from(bucket)
      .upload(path, buffer, {
        upsert: true,
        contentType: mime,
      });

    if (uploadErr) {
      this.logger.error(uploadErr);
      throw new InternalServerErrorException(uploadErr.message);
    }

    // get public URL (Supabase returns: { data: { publicUrl } })
    const { data } = this.client.storage.from(bucket).getPublicUrl(path);
    const publicUrl = data.publicUrl;

    if (!publicUrl) {
      throw new InternalServerErrorException('Failed to generate public URL');
    }

    return { publicUrl };
  }

  // -----------------------------------------------------------------------
  // Signed URL
  // -----------------------------------------------------------------------
  async createSignedUrl(bucket: string, path: string): Promise<string> {
    const { data, error } = await this.client.storage
      .from(bucket)
      .createSignedUrl(path, 60 * 60);

    if (error) {
      throw new InternalServerErrorException(error.message);
    }

    return data.signedUrl;
  }

  // -----------------------------------------------------------------------
  // DELETE FILE
  // -----------------------------------------------------------------------
  async deleteFile(bucket: string, path: string): Promise<void> {
    const { error } = await this.client.storage.from(bucket).remove([path]);

    if (error) {
      throw new InternalServerErrorException(error.message);
    }
  }
}
