import { BadRequestException, Injectable, Logger } from '@nestjs/common';
import { MediaKind } from '@prisma/client';
import { randomUUID } from 'node:crypto';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { MediaQueue } from './media-queue.service';
import { TranscodeService } from './transcode.service';

/** What an upload answers with, ready to attach to a post or a comment. */
export interface UploadedMedia {
  url: string;
  kind: MediaKind;
  width: number | null;
  height: number | null;
  /** A still cut from a clip, so every list drawing the post has something to
   *  show before anybody presses play. Null for anything but video, and for a
   *  clip no poster could be made from. */
  thumbnailUrl?: string | null;
  /** How long a clip runs. Null when it could not be measured. */
  durationMs?: number | null;
}

/** A file in the private bucket: a reference to it, never an address. */
export interface PrivateUpload {
  ref: string;
  kind: MediaKind;
  width: number | null;
  height: number | null;
  durationMs: number | null;
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

  constructor(
    private readonly supabase: SupabaseService,
    private readonly transcode: TranscodeService,
    private readonly jobs: MediaQueue,
  ) {}

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

  /** The private bucket's folder for view-once attachments. */
  static readonly onceFolder = 'once';

  /** The private bucket's folder for what is sent in community chats. */
  static readonly chatFolder = 'chat';

  /**
   * Uploads a view-once attachment to the private bucket.
   *
   * The same checks as [upload], and less after them: no poster, which would
   * be a public frame of a private clip, and no re-encode, which would write
   * a public copy. What comes back is a reference only this API can turn
   * into a link, and only for the people it was sent to. See
   * docs/MESSAGING.md.
   */
  async uploadOnce(
    userId: string,
    buffer: Buffer,
    mimeType: string | undefined,
    dimensions: { width?: number; height?: number } = {},
  ): Promise<PrivateUpload> {
    return this.uploadPrivately(
      MediaService.onceFolder,
      userId,
      buffer,
      mimeType,
      {
        dimensions,
        allowGif: false,
      },
    );
  }

  /**
   * Uploads a photo, clip or voice note for a community chat.
   *
   * Into the private bucket, like a view-once attachment, and answered with a
   * reference: the message it goes in hands out links that last an hour, to
   * people who can read the chat, so a message taken down takes its picture
   * with it rather than leaving a public address behind.
   */
  async uploadChat(
    userId: string,
    buffer: Buffer,
    mimeType: string | undefined,
    dimensions: { width?: number; height?: number } = {},
  ): Promise<PrivateUpload> {
    return this.uploadPrivately(
      MediaService.chatFolder,
      userId,
      buffer,
      mimeType,
      {
        dimensions,
        allowGif: true,
      },
    );
  }

  /**
   * A reference [userId] uploaded into [folder], and nobody else's: the name
   * starts with the uploader's id, and holds nothing that could walk out of
   * the folder.
   */
  static isOwnPrivateRef(folder: string, ref: string, userId: string): boolean {
    const prefix = `${folder}/${userId}_`;
    return (
      ref.startsWith(prefix) &&
      /^[A-Za-z0-9_.-]+$/.test(ref.slice(prefix.length))
    );
  }

  private async uploadPrivately(
    folder: string,
    userId: string,
    buffer: Buffer,
    mimeType: string | undefined,
    {
      dimensions,
      allowGif,
    }: { dimensions: { width?: number; height?: number }; allowGif: boolean },
  ): Promise<PrivateUpload> {
    const { sniffed, kind, measured } = this.check(buffer, mimeType);
    if (kind === MediaKind.GIF && !allowGif) {
      throw new BadRequestException(
        'A GIF cannot be sent view once. Send it as it is.',
      );
    }

    let durationMs: number | null = null;
    if (kind === MediaKind.VIDEO) {
      // Read, not prepared: preparing cuts a poster, and a poster would need
      // a public home this file must not have.
      const shape = (await this.transcode.probe(buffer)) ?? {
        width: null,
        height: null,
        durationMs: null,
      };
      if (
        shape.durationMs !== null &&
        shape.durationMs > TranscodeService.maxDurationMs
      ) {
        const minutes = Math.round(TranscodeService.maxDurationMs / 60000);
        throw new BadRequestException(
          `A clip cannot run longer than ${minutes} minutes.`,
        );
      }
      durationMs = shape.durationMs;
      if (shape.width) dimensions = { ...dimensions, width: shape.width };
      if (shape.height) dimensions = { ...dimensions, height: shape.height };
    }

    const ref = `${folder}/${userId}_${Date.now()}_${randomUUID()}.${EXTENSIONS[sniffed]}`;
    await this.supabase.uploadPrivate(ref, buffer, sniffed);
    this.logger.log(
      `private media uploaded by ${userId} into ${folder} (${kind})`,
    );
    return {
      ref,
      kind,
      width: measured?.width ?? dimensions.width ?? null,
      height: measured?.height ?? dimensions.height ?? null,
      durationMs,
    };
  }

  /**
   * What every upload is held to: not empty, a kind this app takes, under
   * its kind's ceiling, and an image that will decode.
   */
  private check(
    buffer: Buffer,
    mimeType: string | undefined,
  ): {
    sniffed: string;
    kind: MediaKind;
    measured: { width: number; height: number } | undefined;
  } {
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
    return { sniffed, kind, measured };
  }

  async upload(
    userId: string,
    buffer: Buffer,
    mimeType: string | undefined,
    dimensions: { width?: number; height?: number } = {},
  ): Promise<UploadedMedia> {
    const { sniffed, kind, measured } = this.check(buffer, mimeType);

    // A clip gets probed and a poster cut from it, both of which are quick.
    // Re-encoding is not, so it is queued rather than waited for -- see
    // docs/MEDIA_JOBS.md. Without ffmpeg on the server none of it happens and
    // the clip is stored exactly as it arrived.
    let poster: Buffer | null = null;
    let durationMs: number | null = null;
    let reencodeLater = false;

    if (kind === MediaKind.VIDEO) {
      const prepared = await this.transcode.prepare(buffer);
      if (
        prepared.durationMs !== null &&
        prepared.durationMs > TranscodeService.maxDurationMs
      ) {
        const minutes = Math.round(TranscodeService.maxDurationMs / 60000);
        throw new BadRequestException(
          `A clip cannot run longer than ${minutes} minutes.`,
        );
      }
      poster = prepared.poster;
      durationMs = prepared.durationMs;
      reencodeLater = prepared.needsReencode;
      if (prepared.width) dimensions = { ...dimensions, width: prepared.width };
      if (prepared.height) {
        dimensions = { ...dimensions, height: prepared.height };
      }
    }

    // The name never comes from the client. An uploaded filename is attacker
    // input, and it ends up in a URL other people load.
    const filename = `${userId}_${Date.now()}_${randomUUID()}.${EXTENSIONS[sniffed]}`;

    // The bytes exactly as they arrived. A queued re-encode writes a smaller
    // version back over this same path later, which is why the URL can be
    // handed out now.
    const { publicUrl, path } = await this.supabase.uploadFile(
      MediaService.folder,
      filename,
      buffer,
      sniffed,
    );

    if (!publicUrl) {
      throw new BadRequestException('That upload could not be stored.');
    }

    if (reencodeLater) {
      await this.jobs.enqueue({ path, userId, bytesIn: buffer.length });
    }

    // Best effort, and deliberately not fatal: a clip whose poster would not
    // store is still a clip worth posting.
    let thumbnailUrl: string | null = null;
    if (poster) {
      try {
        const still = await this.supabase.uploadFile(
          MediaService.folder,
          `${filename}.poster.jpg`,
          poster,
          'image/jpeg',
        );
        thumbnailUrl = still.publicUrl ?? null;
      } catch (error) {
        this.logger.warn(`A clip went up without its poster: ${String(error)}`);
      }
    }

    this.logger.log(`media ${filename} uploaded by ${userId} (${kind})`);
    return {
      url: publicUrl,
      kind,
      // What the bytes say, falling back to what the client said for the
      // formats this does not parse -- video, and HEIC.
      width: measured?.width ?? dimensions.width ?? null,
      height: measured?.height ?? dimensions.height ?? null,
      thumbnailUrl,
      durationMs,
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
