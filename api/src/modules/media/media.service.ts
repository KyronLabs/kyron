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
  // What the composer's voice recorder produces: AAC in an m4a container.
  'audio/mp4': MediaKind.VOICE,
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
  'audio/mp4': 'm4a',
};

@Injectable()
export class MediaService {
  private readonly logger = new Logger(MediaService.name);

  constructor(private readonly supabase: SupabaseService) {}

  /**
   * The outer ceiling, and what the multipart parser is configured with. A
   * clip may reach it; nothing else should, which is what [maxBytesFor] is
   * for.
   */
  static readonly maxBytes = 25 * 1024 * 1024;

  /**
   * What each kind may weigh.
   *
   * One ceiling for everything meant a photograph could be twenty-five
   * megabytes -- which no camera produces by accident, and which every reader
   * of that post then downloads. A clip legitimately needs the room; a still
   * does not.
   */
  static maxBytesFor(kind: MediaKind): number {
    switch (kind) {
      case MediaKind.VIDEO:
        return MediaService.maxBytes;
      case MediaKind.GIF:
        return 12 * 1024 * 1024;
      case MediaKind.VOICE:
        return 12 * 1024 * 1024;
      default:
        return 8 * 1024 * 1024;
    }
  }

  /**
   * The most pixels an image may decode to, whatever it weighs on disk.
   *
   * A highly compressible picture -- a single flat colour, say -- can be a few
   * kilobytes and still decode to hundreds of megabytes in memory. Every
   * client that renders the post pays that, so it is refused here rather than
   * on the weakest phone that opens the feed.
   */
  static readonly maxPixels = 50_000_000;

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

    const ceiling = MediaService.maxBytesFor(kind);
    if (buffer.length > ceiling) {
      const mb = Math.round(ceiling / (1024 * 1024));
      throw new BadRequestException(
        kind === MediaKind.IMAGE
          ? `A picture cannot exceed ${mb} MB.`
          : `That file is larger than ${mb} MB.`,
      );
    }

    // Read from the file itself. The client sends these too, and the feed lays
    // a post out from them before the image has loaded -- so a wrong pair,
    // whether from a bug or from a client that lied, is a feed that jumps.
    const measured = MediaService.measure(buffer, sniffed);
    if (measured && measured.width * measured.height > MediaService.maxPixels) {
      throw new BadRequestException(
        'That picture is too large to display. Try one under 50 megapixels.',
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
      // What the bytes say, falling back to what the client said for the
      // formats this does not parse -- video, and HEIC.
      width: measured?.width ?? dimensions.width ?? null,
      height: measured?.height ?? dimensions.height ?? null,
    };
  }

  /**
   * An image's real dimensions, from its header.
   *
   * Undefined for anything not parsed here, which the caller takes as "trust
   * what the client said". Deliberately header-only: decoding the image to
   * measure it is exactly the work the pixel ceiling exists to avoid.
   */
  static measure(
    buffer: Buffer,
    mimeType: string,
  ): { width: number; height: number } | undefined {
    try {
      switch (mimeType) {
        case 'image/png':
          // IHDR is always the first chunk: 8 bytes of signature, 8 of chunk
          // header, then width and height as big-endian 32-bit.
          if (buffer.length < 24) return undefined;
          return {
            width: buffer.readUInt32BE(16),
            height: buffer.readUInt32BE(20),
          };

        case 'image/gif':
          // The logical screen descriptor, little-endian, right after the
          // six-byte signature.
          if (buffer.length < 10) return undefined;
          return {
            width: buffer.readUInt16LE(6),
            height: buffer.readUInt16LE(8),
          };

        case 'image/jpeg':
          return MediaService.measureJpeg(buffer);

        case 'image/webp':
          return MediaService.measureWebp(buffer);

        default:
          return undefined;
      }
    } catch {
      // A truncated or malformed header is not worth an exception: the upload
      // is still a file, and the client's own numbers stand in.
      return undefined;
    }
  }

  /** Walks JPEG segments to the frame header, which carries the size. */
  private static measureJpeg(
    buffer: Buffer,
  ): { width: number; height: number } | undefined {
    let offset = 2; // past SOI
    while (offset + 9 < buffer.length) {
      if (buffer[offset] !== 0xff) return undefined;
      const marker = buffer[offset + 1];
      const length = buffer.readUInt16BE(offset + 2);

      // SOF0 through SOF15, skipping the four that are not frame headers.
      const isFrame =
        marker >= 0xc0 &&
        marker <= 0xcf &&
        marker !== 0xc4 &&
        marker !== 0xc8 &&
        marker !== 0xcc;
      if (isFrame) {
        return {
          height: buffer.readUInt16BE(offset + 5),
          width: buffer.readUInt16BE(offset + 7),
        };
      }
      offset += 2 + length;
    }
    return undefined;
  }

  /** The three WebP flavours each keep the size somewhere different. */
  private static measureWebp(
    buffer: Buffer,
  ): { width: number; height: number } | undefined {
    if (buffer.length < 30) return undefined;
    const format = buffer.toString('ascii', 12, 16);

    if (format === 'VP8 ') {
      // Lossy: 14 bytes in, then two 14-bit values.
      return {
        width: buffer.readUInt16LE(26) & 0x3fff,
        height: buffer.readUInt16LE(28) & 0x3fff,
      };
    }
    if (format === 'VP8L') {
      // Lossless: 14 bits each, packed across four bytes after the signature.
      const bits = buffer.readUInt32LE(21);
      return {
        width: (bits & 0x3fff) + 1,
        height: ((bits >> 14) & 0x3fff) + 1,
      };
    }
    if (format === 'VP8X') {
      // Extended: 24-bit values, minus one, little-endian.
      return {
        width: buffer.readUIntLE(24, 3) + 1,
        height: buffer.readUIntLE(27, 3) + 1,
      };
    }
    return undefined;
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
      // M4A and M4B are the same container as MP4 with an audio-only brand.
      // Without this a voice recording is stored as a video and the client
      // hands it to a video player that has nothing to draw.
      if (brand.startsWith('M4A') || brand.startsWith('M4B'))
        return 'audio/mp4';
      return 'video/mp4';
    }

    // EBML, used by WebM and Matroska.
    if (startsWith(0x1a, 0x45, 0xdf, 0xa3)) return 'video/webm';

    return undefined;
  }
}
