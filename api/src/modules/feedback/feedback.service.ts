import {
  BadRequestException,
  HttpException,
  HttpStatus,
  Injectable,
  Logger,
  ServiceUnavailableException,
} from '@nestjs/common';
import { FeedbackKind, SendFeedbackDto } from './dto/send-feedback.dto';

/** Where a report ends up, once GitHub has taken it. */
export interface FiledReport {
  number: number;
  url: string;
}

/**
 * Turning "this is broken" into an issue on the repository.
 *
 * The screen behind this used to say "Feedback has nowhere to go yet", which
 * was honest and useless: every report had to be relayed by hand.
 *
 * **The token lives here, not on the phone.** A GitHub token shipped inside an
 * installed application is a GitHub token anybody can read out of it, and it
 * would carry write access to the repository. This server holds one and the
 * app holds none.
 *
 * **What is filed is public.** The issue body is somebody's words on a public
 * repository, so nothing is added to it that they did not write: no account
 * id, no handle, no email. What identifies a report is the issue number, which
 * is given back to them.
 */
@Injectable()
export class FeedbackService {
  private readonly log = new Logger(FeedbackService.name);

  /**
   * How many reports one account may file in {@link WINDOW_MS}.
   *
   * The API's own limit is 100 requests a minute, which is the right order for
   * reading a feed and the wrong one for opening issues on a public
   * repository: one signed-in account could fill it faster than anybody could
   * close them. Nobody writes six real reports in an hour.
   *
   * Held in memory, so it is per instance and resets on deploy. That is a
   * weaker guarantee than a stored count and a much better one than none; the
   * point is to bound the damage, not to be exact.
   */
  static readonly PER_ACCOUNT = 5;
  static readonly WINDOW_MS = 60 * 60 * 1000;

  /** When each account filed, most recent last. */
  private readonly recent = new Map<string, number[]>();

  /** `owner/repo`. Without it there is nowhere to file. */
  private get repo(): string | null {
    return process.env.GITHUB_ISSUE_REPO?.trim() || null;
  }

  private get token(): string | null {
    return process.env.GITHUB_ISSUE_TOKEN?.trim() || null;
  }

  /** Whether reports can be filed at all, which the app asks before offering. */
  get isConfigured(): boolean {
    return this.repo !== null && this.token !== null;
  }

  async file(dto: SendFeedbackDto, accountId?: string): Promise<FiledReport> {
    const repo = this.repo;
    const token = this.token;

    // Said, not swallowed. A form that accepts what somebody wrote and drops
    // it is worse than a form that refuses: they think it arrived.
    if (!repo || !token) {
      throw new ServiceUnavailableException(
        'Feedback cannot be filed right now. Nothing you wrote was sent.',
      );
    }

    const title = dto.title.trim();
    const body = dto.body.trim();
    if (!title || !body) {
      throw new BadRequestException('Feedback needs a title and a body.');
    }

    // Checked after the shape of the report and before GitHub sees it, so a
    // malformed request is not counted and a refused one is not filed.
    if (accountId) this.countOrRefuse(accountId);

    const response = await fetch(`https://api.github.com/repos/${repo}/issues`, {
      method: 'POST',
      headers: {
        authorization: `Bearer ${token}`,
        accept: 'application/vnd.github+json',
        'content-type': 'application/json',
        'user-agent': 'kyron-api',
      },
      body: JSON.stringify({
        title,
        body: this.compose(dto, body),
        labels: [
          'from-app',
          dto.kind === FeedbackKind.Bug ? 'bug' : 'enhancement',
        ],
      }),
      signal: AbortSignal.timeout(15000),
    });

    if (!response.ok) {
      // The status, never the token or the response, which can echo the
      // request back.
      this.log.error(`GitHub refused a report: ${response.status}`);
      throw new ServiceUnavailableException(
        'Feedback could not be filed right now. Nothing you wrote was sent.',
      );
    }

    const issue = (await response.json()) as {
      number?: number;
      html_url?: string;
    };
    if (typeof issue.number !== 'number' || !issue.html_url) {
      throw new ServiceUnavailableException(
        'Feedback could not be filed right now. Nothing you wrote was sent.',
      );
    }

    return { number: issue.number, url: issue.html_url };
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

  /**
   * The issue body: what they wrote, then what the build was.
   *
   * Their words are fenced. An issue body is Markdown, and text arriving from
   * a form can otherwise close the section it is in and write headings, task
   * lists, or `@` mentions that notify real people.
   */
  private compose(dto: SendFeedbackDto, body: string): string {
    const fence = this.fenceFor(body);
    const build = [
      dto.appVersion ? `Version: ${dto.appVersion}` : null,
      dto.platform ? `Platform: ${dto.platform}` : null,
    ].filter(Boolean);

    return [
      'Sent from inside the app.',
      '',
      fence,
      body,
      fence,
      ...(build.length ? ['', '---', ...build] : []),
    ].join('\n');
  }

  /**
   * A fence longer than any run of backticks in the text.
   *
   * Three backticks would be closed by three backticks inside the message, and
   * everything after that would be Markdown again.
   */
  private fenceFor(body: string): string {
    const longest = [...body.matchAll(/`+/g)].reduce(
      (most, match) => Math.max(most, match[0].length),
      0,
    );
    return '`'.repeat(Math.max(3, longest + 1));
  }
}
