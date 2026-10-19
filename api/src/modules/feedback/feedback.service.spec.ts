import { HttpException, HttpStatus } from '@nestjs/common';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { FeedbackService } from './feedback.service';
import { FeedbackKind, SendFeedbackDto } from './dto/send-feedback.dto';

/**
 * Keeping a report from inside the app, for the team.
 *
 * It used to be filed as an issue on the public repository, and never was:
 * the token it needed was not set, so every account was told feedback could
 * not be sent. It is a private row now, which needs nothing set up.
 */
function report(over: Partial<SendFeedbackDto> = {}): SendFeedbackDto {
  return {
    kind: FeedbackKind.Bug,
    title: 'The composer has no Post button',
    body: 'I open the composer and there is nowhere to press.',
    ...over,
  } as SendFeedbackDto;
}

/** The Feedback table, in memory. */
function store() {
  const rows: Record<string, unknown>[] = [];
  const prisma = {
    feedback: {
      create: jest.fn(({ data }: { data: Record<string, unknown> }) => {
        const row = { ...data, number: rows.length + 1 };
        rows.push(row);
        return Promise.resolve({ number: row.number });
      }),
    },
  };
  const service = new FeedbackService(prisma as unknown as PrismaService);
  return { service, rows };
}

describe('keeping feedback', () => {
  it('is always available: there is nothing to configure', () => {
    expect(store().service.isConfigured).toBe(true);
  });

  it('keeps the report, tied to the account that sent it', async () => {
    const { service, rows } = store();

    await expect(
      service.file(
        report({ appVersion: '0.1.5 (665)', platform: 'android' }),
        'ada',
      ),
    ).resolves.toEqual({ number: 1 });

    expect(rows).toEqual([
      {
        userId: 'ada',
        kind: FeedbackKind.Bug,
        title: 'The composer has no Post button',
        body: 'I open the composer and there is nowhere to press.',
        log: null,
        appVersion: '0.1.5 (665)',
        platform: 'android',
        number: 1,
      },
    ]);
  });

  it('keeps an error report with its log', async () => {
    const { service, rows } = store();
    await service.file(
      report({
        kind: FeedbackKind.Report,
        title: 'Error report',
        body: 'It crashed opening a chat.',
        log: '  12:00 e2ee Could not fetch keys  \n',
      }),
      'ada',
    );
    expect(rows[0]).toMatchObject({
      kind: FeedbackKind.Report,
      log: '12:00 e2ee Could not fetch keys',
    });
  });

  it('keeps the words as written, trimmed', async () => {
    const { service, rows } = store();
    await service.file(
      report({ title: '  Spaces  ', body: '\n  around the words  \n' }),
      'ada',
    );
    expect(rows[0]).toMatchObject({
      title: 'Spaces',
      body: 'around the words',
    });
  });

  it('numbers reports so the sender has something to quote', async () => {
    const { service } = store();
    await service.file(report(), 'ada');
    await expect(service.file(report(), 'grace')).resolves.toEqual({
      number: 2,
    });
  });

  describe('how many one account may send', () => {
    // The API's own limit is 100 requests a minute, which is right for
    // reading a feed and wrong for an inbox people read by hand.
    const cap = FeedbackService.PER_ACCOUNT;

    afterEach(() => jest.restoreAllMocks());

    it('takes what somebody could plausibly write', async () => {
      const { service, rows } = store();
      for (let i = 0; i < cap; i++) {
        await service.file(report({ title: `Report ${i}` }), 'ada');
      }
      expect(rows).toHaveLength(cap);
    });

    it('refuses the next one, and does not keep it', async () => {
      const { service, rows } = store();
      for (let i = 0; i < cap; i++) await service.file(report(), 'ada');

      await expect(service.file(report(), 'ada')).rejects.toMatchObject({
        status: HttpStatus.TOO_MANY_REQUESTS,
      });
      expect(rows).toHaveLength(cap);
    });

    it('says it is the limit, not a failure', async () => {
      // Somebody who hits it has done nothing wrong, and a message that reads
      // as "we lost it" gets the same report written again immediately.
      const { service } = store();
      for (let i = 0; i < cap; i++) await service.file(report(), 'ada');

      await expect(service.file(report(), 'ada')).rejects.toThrow(
        /as many as we take/,
      );
    });

    it('counts each account separately', async () => {
      const { service } = store();
      for (let i = 0; i < cap; i++) await service.file(report(), 'ada');

      // Grace has sent nothing. One noisy account must not silence everyone.
      await expect(service.file(report(), 'grace')).resolves.toBeDefined();
    });

    it('lets an account send again once the window has passed', async () => {
      const { service } = store();
      const start = Date.now();
      jest.spyOn(Date, 'now').mockReturnValue(start);
      for (let i = 0; i < cap; i++) await service.file(report(), 'ada');
      await expect(service.file(report(), 'ada')).rejects.toBeInstanceOf(
        HttpException,
      );

      jest
        .spyOn(Date, 'now')
        .mockReturnValue(start + FeedbackService.WINDOW_MS + 1);
      await expect(service.file(report(), 'ada')).resolves.toBeDefined();
    });
  });
});
