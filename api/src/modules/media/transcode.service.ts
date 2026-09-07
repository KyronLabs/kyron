import {
  Inject,
  Injectable,
  Logger,
  OnModuleInit,
  Optional,
} from '@nestjs/common';
import { spawn } from 'node:child_process';
import { mkdtemp, readFile, rm, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';

/** What came back from putting a clip through ffmpeg. */
export interface Transcoded {
  /** The normalised clip, or the original when nothing needed doing. */
  video: Buffer;
  /** A still cut from it, for the poster. Null when one could not be made. */
  poster: Buffer | null;
  width: number | null;
  height: number | null;
  durationMs: number | null;
  /** Whether the bytes actually changed. False means the original is being
   *  kept, which the caller may want to log. */
  reencoded: boolean;
}

/** Runs a command and answers with what it wrote. Injectable, so the rules
 *  around ffmpeg can be tested without ffmpeg. */
export interface CommandRunner {
  run(
    command: string,
    args: string[],
  ): Promise<{ code: number; stdout: string; stderr: string }>;
}

/**
 * The token a test overrides to keep ffmpeg out of it.
 *
 * A default parameter would not do: Nest reads constructor metadata to decide
 * what to inject, sees an interface it cannot resolve, and refuses to build
 * the module -- which is exactly what the module-graph test caught.
 */
export const COMMAND_RUNNER = Symbol('COMMAND_RUNNER');

export class SpawnRunner implements CommandRunner {
  run(
    command: string,
    args: string[],
  ): Promise<{ code: number; stdout: string; stderr: string }> {
    return new Promise((resolve) => {
      const child = spawn(command, args, { stdio: ['ignore', 'pipe', 'pipe'] });
      let stdout = '';
      let stderr = '';
      child.stdout.on('data', (chunk: Buffer) => (stdout += chunk.toString()));
      child.stderr.on('data', (chunk: Buffer) => (stderr += chunk.toString()));
      child.on('error', (error) =>
        resolve({ code: -1, stdout, stderr: String(error) }),
      );
      child.on('close', (code) =>
        resolve({ code: code ?? -1, stdout, stderr }),
      );
    });
  }
}

/** The longest clip that will be kept. Anything past this is refused rather
 *  than silently cut, because a clip that comes back shorter than it went in
 *  is worse than one that was rejected. */
const MAX_DURATION_MS = 5 * 60 * 1000;

/** Above this the clip is re-encoded rather than stored as it arrived. */
const MAX_HEIGHT = 1280;
const MAX_BITRATE = 2_500_000;

/**
 * Normalises an uploaded clip and cuts a poster from it.
 *
 * Everything here is best effort by design. A clip that ffmpeg cannot read, or
 * a server with no ffmpeg on it, means the original bytes are stored exactly
 * as they arrived -- which is what happened to every clip before this existed.
 * What must never happen is a clip going missing because a transcode failed.
 */
@Injectable()
export class TranscodeService implements OnModuleInit {
  private readonly logger = new Logger(TranscodeService.name);

  private available = false;

  private readonly runner: CommandRunner;

  constructor(@Optional() @Inject(COMMAND_RUNNER) runner?: CommandRunner) {
    this.runner = runner ?? new SpawnRunner();
  }

  async onModuleInit(): Promise<void> {
    const { code } = await this.runner.run('ffmpeg', ['-version']);
    this.available = code === 0;
    if (!this.available) {
      this.logger.warn(
        'ffmpeg is not on this server, so clips are stored exactly as they ' +
          'arrive: no normalisation, no bitrate cap, and no poster unless the ' +
          'client uploaded one. Everything still works.',
      );
    }
  }

  get isAvailable(): boolean {
    return this.available;
  }

  /** How long a clip may run. */
  static readonly maxDurationMs = MAX_DURATION_MS;

  /**
   * Reads a clip's shape without decoding it.
   *
   * Null when ffprobe is absent or the file is unreadable -- the caller treats
   * that as "unknown", never as "invalid".
   */
  async probe(video: Buffer): Promise<{
    width: number | null;
    height: number | null;
    durationMs: number | null;
    bitrate: number | null;
  } | null> {
    if (!this.available) return null;

    return this.withTempFile(video, async (path) => {
      const { code, stdout } = await this.runner.run('ffprobe', [
        '-v',
        'error',
        '-select_streams',
        'v:0',
        '-show_entries',
        'stream=width,height,bit_rate:format=duration',
        '-of',
        'json',
        path,
      ]);
      if (code !== 0) return null;
      return TranscodeService.readProbe(stdout);
    });
  }

  /** Parses ffprobe's JSON. Separate and static, so it can be tested on its
   *  own against the shapes ffprobe actually produces. */
  static readProbe(stdout: string): {
    width: number | null;
    height: number | null;
    durationMs: number | null;
    bitrate: number | null;
  } | null {
    try {
      const parsed = JSON.parse(stdout) as {
        streams?: { width?: number; height?: number; bit_rate?: string }[];
        format?: { duration?: string };
      };
      const stream = parsed.streams?.[0];
      if (!stream) return null;

      const seconds = Number(parsed.format?.duration);
      const bitrate = Number(stream.bit_rate);
      return {
        width: stream.width ?? null,
        height: stream.height ?? null,
        // ffprobe answers "N/A" for a stream it cannot measure, which becomes
        // NaN rather than throwing.
        durationMs: Number.isFinite(seconds)
          ? Math.round(seconds * 1000)
          : null,
        bitrate: Number.isFinite(bitrate) ? bitrate : null,
      };
    } catch {
      return null;
    }
  }

  /**
   * Whether a clip of this shape is worth re-encoding.
   *
   * A phone's own recording is usually already H.264 at a sane bitrate, and
   * re-encoding it costs quality and CPU for nothing.
   */
  static shouldReencode(shape: {
    height: number | null;
    bitrate: number | null;
  }): boolean {
    if (shape.height !== null && shape.height > MAX_HEIGHT) return true;
    if (shape.bitrate !== null && shape.bitrate > MAX_BITRATE) return true;
    return false;
  }

  /**
   * Normalises a clip and cuts its poster.
   *
   * Without ffmpeg, or on any failure, the original bytes come back untouched
   * and the poster is null.
   */
  async process(video: Buffer): Promise<Transcoded> {
    const untouched: Transcoded = {
      video,
      poster: null,
      width: null,
      height: null,
      durationMs: null,
      reencoded: false,
    };
    if (!this.available) return untouched;

    try {
      const shape = await this.probe(video);
      if (!shape) return untouched;

      if (
        shape.durationMs !== null &&
        shape.durationMs > TranscodeService.maxDurationMs
      ) {
        // Refused by the caller rather than cut here: a clip that comes back
        // shorter than it went in is worse than one that was rejected.
        return { ...untouched, ...shape, durationMs: shape.durationMs };
      }

      const poster = await this.poster(video);
      if (!TranscodeService.shouldReencode(shape)) {
        return { ...untouched, ...shape, poster };
      }

      const normalised = await this.reencode(video);
      return {
        video: normalised ?? video,
        poster,
        width: shape.width,
        height: shape.height,
        durationMs: shape.durationMs,
        reencoded: normalised !== null,
      };
    } catch (error) {
      this.logger.warn(
        `Keeping a clip as it arrived; ffmpeg failed: ${String(error)}`,
      );
      return untouched;
    }
  }

  /** A still from one second in, or the first frame for a shorter clip. */
  private async poster(video: Buffer): Promise<Buffer | null> {
    return this.withTempFile(video, async (path, dir) => {
      const out = join(dir, 'poster.jpg');
      const { code } = await this.runner.run('ffmpeg', [
        '-v',
        'error',
        // Before -i, so it seeks rather than decoding up to the point.
        '-ss',
        '00:00:01',
        '-i',
        path,
        '-frames:v',
        '1',
        '-q:v',
        '4',
        // A clip shorter than the seek yields nothing at all, so fall back to
        // the very first frame rather than returning no poster.
        '-vf',
        'thumbnail',
        '-y',
        out,
      ]);
      if (code !== 0) return null;
      try {
        return await readFile(out);
      } catch {
        return null;
      }
    });
  }

  /** H.264 at a capped height and bitrate, with the audio left alone. */
  private async reencode(video: Buffer): Promise<Buffer | null> {
    return this.withTempFile(video, async (path, dir) => {
      const out = join(dir, 'out.mp4');
      const { code, stderr } = await this.runner.run('ffmpeg', [
        '-v',
        'error',
        '-i',
        path,
        '-c:v',
        'libx264',
        '-preset',
        'veryfast',
        '-crf',
        '24',
        '-maxrate',
        String(MAX_BITRATE),
        '-bufsize',
        String(MAX_BITRATE * 2),
        // Height capped, width to match, and rounded to an even number
        // because H.264 cannot encode an odd one.
        '-vf',
        `scale=-2:'min(${MAX_HEIGHT},ih)'`,
        '-c:a',
        'aac',
        '-b:a',
        '128k',
        // Puts the index at the front so playback can start before the whole
        // file has arrived.
        '-movflags',
        '+faststart',
        '-y',
        out,
      ]);
      if (code !== 0) {
        this.logger.warn(`Could not re-encode a clip: ${stderr.slice(0, 400)}`);
        return null;
      }
      try {
        return await readFile(out);
      } catch {
        return null;
      }
    });
  }

  /** Writes the buffer somewhere ffmpeg can reach, and always cleans up. */
  private async withTempFile<T>(
    video: Buffer,
    work: (path: string, dir: string) => Promise<T>,
  ): Promise<T> {
    const dir = await mkdtemp(join(tmpdir(), 'kyron-'));
    const path = join(dir, 'in');
    try {
      await writeFile(path, video);
      return await work(path, dir);
    } finally {
      // A transcoder that leaks temporary files fills the disk of a machine
      // that is otherwise healthy, and does it slowly enough to be a mystery.
      await rm(dir, { recursive: true, force: true });
    }
  }
}
