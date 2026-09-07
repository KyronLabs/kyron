import { MediaKind } from '@prisma/client';

import { MediaService } from './media.service';

/** A PNG header: signature, IHDR length and tag, then width and height. */
const png = (width: number, height: number): Buffer => {
  const buffer = Buffer.alloc(24);
  Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]).copy(buffer);
  buffer.write('IHDR', 12, 'ascii');
  buffer.writeUInt32BE(width, 16);
  buffer.writeUInt32BE(height, 20);
  return buffer;
};

/** A GIF header: signature then the logical screen descriptor. */
const gif = (width: number, height: number): Buffer => {
  const buffer = Buffer.alloc(10);
  buffer.write('GIF89a', 0, 'ascii');
  buffer.writeUInt16LE(width, 6);
  buffer.writeUInt16LE(height, 8);
  return buffer;
};

/** A JPEG with one filler segment before the frame header. */
const jpeg = (width: number, height: number): Buffer => {
  const buffer = Buffer.alloc(32);
  let at = 0;
  buffer.writeUInt16BE(0xffd8, at); // SOI
  at += 2;
  buffer.writeUInt16BE(0xffe0, at); // APP0, skipped
  buffer.writeUInt16BE(4, at + 2); // its length, covering itself
  at += 6;
  buffer.writeUInt16BE(0xffc0, at); // SOF0
  buffer.writeUInt16BE(11, at + 2);
  buffer.writeUInt8(8, at + 4); // precision
  buffer.writeUInt16BE(height, at + 5);
  buffer.writeUInt16BE(width, at + 7);
  return buffer;
};

describe('MediaService.measure', () => {
  it('reads a PNG', () => {
    expect(MediaService.measure(png(1920, 1080), 'image/png')).toEqual({
      width: 1920,
      height: 1080,
    });
  });

  it('reads a GIF', () => {
    expect(MediaService.measure(gif(320, 240), 'image/gif')).toEqual({
      width: 320,
      height: 240,
    });
  });

  it('walks past a segment it does not care about to reach a JPEG frame', () => {
    expect(MediaService.measure(jpeg(800, 600), 'image/jpeg')).toEqual({
      width: 800,
      height: 600,
    });
  });

  it('says nothing about a format it does not parse', () => {
    // Video and HEIC fall back to what the client sent rather than failing.
    expect(MediaService.measure(png(1, 1), 'video/mp4')).toBeUndefined();
  });

  it('says nothing about a truncated header rather than throwing', () => {
    // A malformed file is still a file; the client's own numbers stand in.
    expect(MediaService.measure(Buffer.alloc(4), 'image/png')).toBeUndefined();
    expect(MediaService.measure(Buffer.alloc(3), 'image/jpeg')).toBeUndefined();
    expect(MediaService.measure(Buffer.alloc(8), 'image/webp')).toBeUndefined();
  });
});

describe('MediaService.maxBytesFor', () => {
  it('gives a clip the room a photograph does not need', () => {
    // One ceiling for everything let a still be 25 MB, which every reader of
    // that post then downloads.
    expect(MediaService.maxBytesFor(MediaKind.VIDEO)).toBe(
      MediaService.maxBytes,
    );
    expect(MediaService.maxBytesFor(MediaKind.IMAGE)).toBeLessThan(
      MediaService.maxBytesFor(MediaKind.VIDEO),
    );
  });

  it('never exceeds the outer ceiling the parser enforces', () => {
    for (const kind of Object.values(MediaKind)) {
      expect(MediaService.maxBytesFor(kind)).toBeLessThanOrEqual(
        MediaService.maxBytes,
      );
    }
  });
});
