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
  it('keeps the clip exactly as it arrived', async () => {
    const service = new TranscodeService(new ScriptedRunner({}));
    await service.onModuleInit();

    const original = Buffer.from('a clip');
    const result = await service.process(original);

    // A missing binary must never cost somebody their upload.
    expect(service.isAvailable).toBe(false);
    expect(result.video).toBe(original);
    expect(result.poster).toBeNull();
    expect(result.reencoded).toBe(false);
  });
});

describe('TranscodeService with ffmpeg', () => {
  it('reports a clip that runs too long rather than cutting it', async () => {
    const runner = new ScriptedRunner({
      ffmpeg: { code: 0 },
      ffprobe: { code: 0, stdout: probeJson(1920, 1080, 600, 1_000_000) },
    });
    const service = new TranscodeService(runner);
    await service.onModuleInit();

    const result = await service.process(Buffer.from('long'));

    // A clip that comes back shorter than it went in is worse than one that
    // was refused, so the caller decides.
    expect(result.durationMs).toBe(600_000);
    expect(result.durationMs).toBeGreaterThan(TranscodeService.maxDurationMs);
    expect(result.reencoded).toBe(false);
  });

  it('keeps the original when ffmpeg cannot read it', async () => {
    const runner = new ScriptedRunner({
      ffmpeg: { code: 0 },
      ffprobe: { code: 1, stderr: 'moov atom not found' },
    });
    const service = new TranscodeService(runner);
    await service.onModuleInit();

    const original = Buffer.from('broken');
    expect((await service.process(original)).video).toBe(original);
  });
});
