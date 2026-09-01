import { BadRequestException, Injectable, Logger } from '@nestjs/common';
import { MediaKind } from '@prisma/client';
import { randomUUID } from 'node:crypto';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';

/** What an upload answers with, ready to attach to a post or a comment. */
export interface UploadedMedia {
  url: string;
  kind: MediaKind;
  width: number | null;
  height: number | null;
}

/** The types accepted, and how each maps to a MediaKind. */
const ACCEPTED: Record<string, MediaKind> = {
  'image/jpeg': MediaKind.IMAGE,
  'image/png': MediaKind.IMAGE,
  'image/webp': MediaKind.IMAGE,
  'image/heic': MediaKind.IMAGE,
  'image/gif': MediaKind.GIF,
  'video/mp4': MediaKind.VIDEO,
  'video/quicktime': MediaKind.VIDEO,
  'video/webm': MediaKind.VIDEO,
};

const EXTENSIONS: Record<string, string> = {
  'image/jpeg': 'jpg',
  'image/png': 'png',
  'image/webp': 'webp',
  'image/heic': 'heic',
  'image/gif': 'gif',
  'video/mp4': 'mp4',
  'video/quicktime': 'mov',
  'video/webm': 'webm',
};

@Injectable()
export class MediaService {
  private readonly logger = new Logger(MediaService.name);

  constructor(private readonly supabase: SupabaseService) {}

  /** 25 MB. Large enough for a short clip, small enough to survive a phone's data plan. */
  static readonly maxBytes = 25 * 1024 * 1024;

  static readonly folder = 'post-media';

  async upload(
    userId: string,
    buffer: Buffer,
    mimeType: string | undefined,
    dimensions: { width?: number; height?: number } = {},
  ): Promise<UploadedMedia> {
    if (!buffer || buffer.length === 0) {
      throw new BadRequestException('That file is empty.');
    }
    if (buffer.length > MediaService.maxBytes) {
      throw new BadRequestException('That file is larger than 25 MB.');
    }

    // Determined from the bytes, not from the declared type: a client can
    // claim any content type, and the bucket serves what it is given.
    const sniffed = MediaService.sniff(buffer) ?? mimeType;
    const kind = sniffed ? ACCEPTED[sniffed] : undefined;
    if (!sniffed || !kind) {
      throw new BadRequestException(
        'Only JPEG, PNG, WebP, HEIC, GIF, MP4, MOV and WebM files can be attached.',
      );
    }

    // The name never comes from the client. An uploaded filename is attacker
    // input, and it ends up in a URL other people load.
    const filename = `${userId}_${Date.now()}_${randomUUID()}.${EXTENSIONS[sniffed]}`;

    const { publicUrl } = await this.supabase.uploadFile(
      MediaService.folder,
      filename,
      buffer,
      sniffed,
    );

    if (!publicUrl) {
      throw new BadRequestException('That upload could not be stored.');
    }

    this.logger.log(`media ${filename} uploaded by ${userId} (${kind})`);
    return {
      url: publicUrl,
      kind,
      width: dimensions.width ?? null,
      height: dimensions.height ?? null,
    };
  }

  /**
   * The content type, read from the file's own leading bytes.
   *
   * Returns undefined for anything not recognised, which the caller rejects.
   */
  static sniff(buffer: Buffer): string | undefined {
    const startsWith = (...bytes: number[]) =>
      bytes.every((byte, index) => buffer[index] === byte);

    if (startsWith(0xff, 0xd8, 0xff)) return 'image/jpeg';
    if (startsWith(0x89, 0x50, 0x4e, 0x47)) return 'image/png';
    if (startsWith(0x47, 0x49, 0x46, 0x38)) return 'image/gif';

    // RIFF....WEBP
    if (
      startsWith(0x52, 0x49, 0x46, 0x46) &&
      buffer.toString('ascii', 8, 12) === 'WEBP'
    ) {
      return 'image/webp';
    }

    // ISO base media: ....ftyp<brand>
    if (buffer.toString('ascii', 4, 8) === 'ftyp') {
      const brand = buffer.toString('ascii', 8, 12);
      if (brand.startsWith('qt')) return 'video/quicktime';
      if (brand.startsWith('hei') || brand.startsWith('mif'))
        return 'image/heic';
      return 'video/mp4';
    }

    // EBML, used by WebM and Matroska.
    if (startsWith(0x1a, 0x45, 0xdf, 0xa3)) return 'video/webm';

    return undefined;
  }
}
