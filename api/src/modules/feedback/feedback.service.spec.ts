import { HttpStatus, ServiceUnavailableException } from '@nestjs/common';
import { HttpException } from '@nestjs/common';
import { FeedbackService } from './feedback.service';
import { FeedbackKind, SendFeedbackDto } from './dto/send-feedback.dto';

/**
 * Filing a report from inside the app.
 *
 * Two properties are worth more than the happy path: the token never leaves
 * this server, and nothing identifying is added to a body that lands on a
 * public repository.
 */
function report(over: Partial<SendFeedbackDto> = {}): SendFeedbackDto {
  return {
    kind: FeedbackKind.Bug,
    title: 'The composer has no Post button',
    body: 'I open the composer and there is nowhere to press.',
    ...over,
  } as SendFeedbackDto;
}

describe('filing feedback', () => {
  const env = { ...process.env };
  let calls: { url: string; init: RequestInit }[] = [];

  beforeEach(() => {
    calls = [];
    process.env.GITHUB_ISSUE_REPO = 'KyronLabs/kyron';
    process.env.GITHUB_ISSUE_TOKEN = 'a-secret-token';
    global.fetch = jest.fn(async (url: string, init: RequestInit) => {
      calls.push({ url: String(url), init });
      return {
        ok: true,
        status: 201,
        json: async () => ({
          number: 42,
          html_url: 'https://github.com/KyronLabs/kyron/issues/42',
        }),
      };
    }) as unknown as typeof fetch;
  });

  afterEach(() => {
    process.env = { ...env };
  });

  /** The JSON body that went to GitHub. */
  function sent(): { title: string; body: string; labels: string[] } {
    return JSON.parse(String(calls[0].init.body));
  }

  it('answers with where the report went', async () => {
    const filed = await new FeedbackService().file(report());
    expect(filed).toEqual({
      number: 42,
      url: 'https://github.com/KyronLabs/kyron/issues/42',
    });
  });

  it('labels a bug and an idea differently', async () => {
    const service = new FeedbackService();
    await service.file(report());
    expect(sent().labels).toEqual(['from-app', 'bug']);

    calls = [];
    await service.file(report({ kind: FeedbackKind.Idea }));
    expect(sent().labels).toEqual(['from-app', 'enhancement']);
  });

  it('puts nothing in the issue that identifies who sent it', async () => {
    // The body lands on a public repository. Only the words they wrote go in
    // it -- no account id, no handle, no email. The issue number is what ties
    // a report back to its sender, and it is given to them rather than posted.
    await new FeedbackService().file(
      report({ appVersion: '1.4.0', platform: 'android' }),
    );
    const body = sent().body;

    expect(body).toContain('nowhere to press');
    expect(body).toContain('1.4.0');
    expect(body).not.toMatch(/userId|@|email|token/i);
  });

  it('never sends the token anywhere but GitHub', async () => {
    await new FeedbackService().file(report());

    expect(calls[0].url).toBe('https://api.github.com/repos/KyronLabs/kyron/issues');
    expect(sent().body).not.toContain('a-secret-token');
    expect(sent().title).not.toContain('a-secret-token');
  });

  it('fences the words so they cannot write Markdown of their own', async () => {
    // An issue body is Markdown. Without a fence, text from a form can write
    // headings, task lists, or an `@` mention that notifies a real person.
    await new FeedbackService().file(
      report({ body: '# Not a heading\n@someone\n- [ ] not a task' }),
    );
    const body = sent().body;

    expect(body).toMatch(/```[\s\S]*# Not a heading[\s\S]*```/);
  });

  it('uses a longer fence when the words contain one', async () => {
    // Three backticks would be closed by three backticks inside the message,
    // and everything after that would be Markdown again.
    await new FeedbackService().file(
      report({ body: 'look:\n```\n@someone\n```\nthat' }),
    );
    const body = sent().body;

    expect(body).toContain('````');
    // The closing fence is the long one, so nothing escapes the block.
    expect(body.trimEnd().endsWith('````')).toBe(true);
  });

  it('refuses rather than pretending, when there is nowhere to file', async () => {
    // A form that accepts what somebody wrote and drops it is worse than one
    // that refuses: they think it arrived.
    delete process.env.GITHUB_ISSUE_TOKEN;
    const service = new FeedbackService();

    expect(service.isConfigured).toBe(false);
    await expect(service.file(report())).rejects.toBeInstanceOf(
      ServiceUnavailableException,
    );
    expect(calls).toHaveLength(0);
  });

  it('says nothing was sent when GitHub refuses', async () => {
    global.fetch = jest.fn(async () => ({
      ok: false,
      status: 403,
      json: async () => ({}),
    })) as unknown as typeof fetch;

    await expect(new FeedbackService().file(report())).rejects.toThrow(
      /Nothing you wrote was sent/,
    );
  });

  describe('how many one account may file', () => {
    // The API's own limit is 100 requests a minute, which is right for
    // reading a feed and wrong for opening issues on a public repository.
    const cap = FeedbackService.PER_ACCOUNT;

    it('takes what somebody could plausibly write', async () => {
      const service = new FeedbackService();
      for (let i = 0; i < cap; i++) {
        await service.file(report({ title: `Report ${i}` }), 'ada');
      }
      expect(calls).toHaveLength(cap);
    });

    it('refuses the next one, and does not file it', async () => {
      const service = new FeedbackService();
      for (let i = 0; i < cap; i++) {
        await service.file(report(), 'ada');
      }

      await expect(service.file(report(), 'ada')).rejects.toMatchObject({
        status: HttpStatus.TOO_MANY_REQUESTS,
      });
      // The refusal has to stop it reaching GitHub, not just colour the reply.
      expect(calls).toHaveLength(cap);
    });

    it('says it is the limit, not a failure', async () => {
      // Somebody who hits it has done nothing wrong, and a message that reads
      // as "we lost it" gets the same report written again immediately.
      const service = new FeedbackService();
      for (let i = 0; i < cap; i++) await service.file(report(), 'ada');

      await expect(service.file(report(), 'ada')).rejects.toThrow(
        /as many as we take/,
      );
    });

    it('counts each account separately', async () => {
      const service = new FeedbackService();
      for (let i = 0; i < cap; i++) await service.file(report(), 'ada');

      // Grace has filed nothing. One noisy account must not silence everyone.
      await expect(
        service.file(report(), 'grace'),
      ).resolves.toMatchObject({ number: 42 });
    });

    it('lets an account file again once the window has passed', async () => {
      const service = new FeedbackService();
      const start = Date.now();
      jest.spyOn(Date, 'now').mockReturnValue(start);
      for (let i = 0; i < cap; i++) await service.file(report(), 'ada');
      await expect(service.file(report(), 'ada')).rejects.toBeInstanceOf(
        HttpException,
      );

      jest
        .spyOn(Date, 'now')
        .mockReturnValue(start + FeedbackService.WINDOW_MS + 1);
      await expect(service.file(report(), 'ada')).resolves.toMatchObject({
        number: 42,
      });
      jest.spyOn(Date, 'now').mockRestore();
    });

    it('is not counted against when there was nowhere to file', async () => {
      // A report refused because the server is unconfigured was never filed,
      // so it must not use up one of the five.
      delete process.env.GITHUB_ISSUE_TOKEN;
      const service = new FeedbackService();
      await expect(service.file(report(), 'ada')).rejects.toBeInstanceOf(
        ServiceUnavailableException,
      );

      process.env.GITHUB_ISSUE_TOKEN = 'a-secret-token';
      for (let i = 0; i < cap; i++) {
        await expect(service.file(report(), 'ada')).resolves.toBeDefined();
      }
    });
  });
});
