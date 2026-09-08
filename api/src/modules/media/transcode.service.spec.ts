import { cpus } from 'node:os';
import { TranscodeService, type CommandRunner } from './transcode.service';

/** Answers whatever the test says ffmpeg would. */
class ScriptedRunner implements CommandRunner {
  constructor(
    private readonly script: Record<
      string,
      { code: number; stdout?: string; stderr?: string }
    >,
  ) {}

  readonly calls: { command: string; args: string[] }[] = [];

  run(command: string, args: string[]) {
    this.calls.push({ command, args });
    const reply = this.script[command] ?? { code: -1 };
    return Promise.resolve({
      code: reply.code,
      stdout: reply.stdout ?? '',
      stderr: reply.stderr ?? '',
    });
  }
}

const probeJson = (
  width: number,
  height: number,
  seconds: number,
  bitrate: number,
) =>
  JSON.stringify({
    streams: [{ width, height, bit_rate: String(bitrate) }],
    format: { duration: String(seconds) },
  });

describe('TranscodeService.readProbe', () => {
  it('reads what ffprobe answers', () => {
    expect(
      TranscodeService.readProbe(probeJson(1920, 1080, 12.5, 4_000_000)),
    ).toEqual({
      width: 1920,
      height: 1080,
      durationMs: 12500,
      bitrate: 4_000_000,
    });
  });

  it('takes a value ffprobe could not measure as unknown, not as zero', () => {
    // ffprobe answers "N/A" for a stream it cannot measure. Zero would read as
    // a clip with no duration, which is a very different thing.
    const answer = TranscodeService.readProbe(
      JSON.stringify({
        streams: [{ width: 640, height: 480, bit_rate: 'N/A' }],
        format: { duration: 'N/A' },
      }),
    );

    expect(answer).toEqual({
      width: 640,
      height: 480,
      durationMs: null,
      bitrate: null,
    });
  });

  it('answers nothing for output it cannot read', () => {
    expect(TranscodeService.readProbe('not json')).toBeNull();
    expect(TranscodeService.readProbe('{"streams":[]}')).toBeNull();
  });
});

describe('TranscodeService.shouldReencode', () => {
  it('leaves a clip that is already sensible alone', () => {
    // A phone's own recording is usually H.264 at a sane bitrate, and
    // re-encoding costs quality and CPU for nothing.
    expect(
      TranscodeService.shouldReencode({ height: 1080, bitrate: 2_000_000 }),
    ).toBe(false);
  });

  it('re-encodes something too tall or too fat', () => {
    expect(
      TranscodeService.shouldReencode({ height: 2160, bitrate: 1_000_000 }),
    ).toBe(true);
    expect(
      TranscodeService.shouldReencode({ height: 720, bitrate: 9_000_000 }),
    ).toBe(true);
  });

  it('leaves a clip it could not measure alone', () => {
    // Unknown is not a reason to re-encode: that would put every clip ffprobe
    // stumbled on through a lossy pass for no gain.
    expect(
      TranscodeService.shouldReencode({ height: null, bitrate: null }),
    ).toBe(false);
  });
});

describe('TranscodeService without ffmpeg', () => {
  it('answers "nothing known, nothing needed"', async () => {
    const service = new TranscodeService(new ScriptedRunner({}));
    await service.onModuleInit();

    const prepared = await service.prepare(Buffer.from('a clip'));

    // A missing binary must never cost somebody their upload: the caller
    // stores exactly what arrived.
    expect(service.isAvailable).toBe(false);
    expect(prepared.poster).toBeNull();
    expect(prepared.needsReencode).toBe(false);
    expect(prepared.durationMs).toBeNull();
  });
});

describe('TranscodeService.prepare', () => {
  it('reports a clip that runs too long rather than cutting it', async () => {
    const runner = new ScriptedRunner({
      ffmpeg: { code: 0 },
      ffprobe: { code: 0, stdout: probeJson(1920, 1080, 600, 1_000_000) },
    });
    const service = new TranscodeService(runner);
    await service.onModuleInit();

    const prepared = await service.prepare(Buffer.from('long'));

    // A clip that comes back shorter than it went in is worse than one that
    // was refused, so the caller decides.
    expect(prepared.durationMs).toBe(600_000);
    expect(prepared.durationMs).toBeGreaterThan(TranscodeService.maxDurationMs);
    // And nothing is queued for a clip that is about to be thrown away.
    expect(prepared.needsReencode).toBe(false);
  });

  it('knows nothing about a clip ffmpeg cannot read', async () => {
    const runner = new ScriptedRunner({
      ffmpeg: { code: 0 },
      ffprobe: { code: 1, stderr: 'moov atom not found' },
    });
    const service = new TranscodeService(runner);
    await service.onModuleInit();

    const prepared = await service.prepare(Buffer.from('broken'));

    expect(prepared.width).toBeNull();
    expect(prepared.needsReencode).toBe(false);
  });

  it('asks for a re-encode without doing one', async () => {
    // The whole point of the split: the upload request finds out that a
    // re-encode is needed, and does not pay for it.
    const runner = new ScriptedRunner({
      ffmpeg: { code: 0 },
      ffprobe: { code: 0, stdout: probeJson(3840, 2160, 30, 20_000_000) },
    });
    const service = new TranscodeService(runner);
    await service.onModuleInit();

    const prepared = await service.prepare(Buffer.from('4k'));

    expect(prepared.needsReencode).toBe(true);
    expect(prepared.width).toBe(3840);
    // libx264 is what a re-encode runs. Nothing here should have reached it.
    const encoded = runner.calls.some((call) => call.args.includes('libx264'));
    expect(encoded).toBe(false);
  });
});

describe('TranscodeService poster', () => {
  it('falls back to the first frame when the seek finds nothing', async () => {
    // Checked against ffmpeg 6.1.1: seeking to one second in a half-second
    // clip writes no file *and exits 0*, so a code check alone never notices.
    // Every clip under a second used to end up with no poster at all.
    //
    // The scripted runner writes no file either, which is the same shape: the
    // command succeeds and there is nothing to read.
    const runner = new ScriptedRunner({
      ffmpeg: { code: 0 },
      ffprobe: { code: 0, stdout: probeJson(320, 240, 0.5, 500_000) },
    });
    const service = new TranscodeService(runner);
    await service.onModuleInit();

    const prepared = await service.prepare(Buffer.from('short'));

    const attempts = runner.calls.filter((c) => c.args.includes('-frames:v'));
    expect(attempts).toHaveLength(2);
    expect(attempts[0].args).toContain('-ss');
    expect(attempts[1].args).not.toContain('-ss');
    // Both came back empty here, so there is genuinely no poster -- reported
    // as null rather than as a zero-byte file the app would try to draw.
    expect(prepared.poster).toBeNull();
  });
});

describe('TranscodeService.encoderThreads', () => {
  it('leaves a core for serving requests', () => {
    // The encoder and the API share one machine. libx264 takes every core it
    // can see unless told otherwise, which turns a fast upload into a slow
    // everything-else.
    const threads = TranscodeService.encoderThreads();
    expect(threads).toBeGreaterThanOrEqual(1);
    expect(threads).toBe(Math.max(1, cpus().length - 1));
  });
});
