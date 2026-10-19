import { HttpException, HttpStatus, Injectable, Logger } from '@nestjs/common';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SendFeedbackDto } from './dto/send-feedback.dto';

/** What the sender is told: the number to quote if they write again. */
export interface FiledReport {
  number: number;
}

/**
 * What somebody tells the team from inside the app, kept for the team.
 *
 * It used to be filed as an issue on the public repository. That needed a
 * GitHub token on the server, which was never set, so the screen said
 * "Feedback cannot be sent right now" to everybody; and had it worked, it
 * would have published whatever people wrote -- an email address pasted
 * into a bug report included -- with no way to answer anybody privately.
 *
 * Now it is a row in the Feedback table, read by the team and nobody else,
 * tied to the account that sent it so somebody can follow up, and deleted
 * with that account. It needs no configuration, so it is always available.
 */
@Injectable()
export class FeedbackService {
  private readonly log = new Logger(FeedbackService.name);

  constructor(private readonly prisma: PrismaService) {}

  /**
   * How many reports one account may file in {@link WINDOW_MS}.
   *
   * The API's own limit is 100 requests a minute, which is the right order for
   * reading a feed and the wrong one for an inbox people read by hand: one
   * signed-in account could bury it. Nobody writes six real reports in an
   * hour.
   *
   * Held in memory, so it is per instance and resets on deploy. That is a
   * weaker guarantee than a stored count and a much better one than none; the
   * point is to bound the damage, not to be exact.
   */
  static readonly PER_ACCOUNT = 5;
  static readonly WINDOW_MS = 60 * 60 * 1000;

  /** When each account filed, most recent last. */
  private readonly recent = new Map<string, number[]>();

  /** Kept for the app, which still asks before offering the form. */
  get isConfigured(): boolean {
    return true;
  }

  async file(dto: SendFeedbackDto, accountId: string): Promise<FiledReport> {
    // Checked before anything is stored, so a refused report is not kept
    // and a malformed one -- refused by validation -- is never counted.
    this.countOrRefuse(accountId);

    const row = await this.prisma.feedback.create({
      data: {
        userId: accountId,
        kind: dto.kind,
        title: dto.title.trim(),
        body: dto.body.trim(),
        log: dto.log?.trim() || null,
        appVersion: dto.appVersion ?? null,
        platform: dto.platform ?? null,
      },
      select: { number: true },
    });
    this.log.log(`feedback #${row.number} (${dto.kind}) received`);
    return { number: row.number };
  }

  /**
   * Counts this report against the account, or refuses it.
   *
   * Says plainly that the limit is the reason, rather than reporting a
   * failure: somebody who has hit it has not done anything wrong, and a
   * report that reads as "we lost it" gets written again immediately.
   */
  private countOrRefuse(accountId: string): void {
    const now = Date.now();
    const since = now - FeedbackService.WINDOW_MS;
    const kept = (this.recent.get(accountId) ?? []).filter((at) => at > since);

    if (kept.length >= FeedbackService.PER_ACCOUNT) {
      // Keep the trimmed list: otherwise a caller hammering the endpoint
      // grows an array that is never swept.
      this.recent.set(accountId, kept);
      throw new HttpException(
        `You have filed ${FeedbackService.PER_ACCOUNT} reports in the last ` +
          `hour, which is as many as we take. Nothing you wrote was sent -- ` +
          `keep it and send it later.`,
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }

    kept.push(now);
    this.recent.set(accountId, kept);
  }
}
