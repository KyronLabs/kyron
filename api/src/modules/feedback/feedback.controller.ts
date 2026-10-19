import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { AllowRestricted } from '../../common/guards/standing';
import { AuthRequest } from '../../common/types/auth-request';
import { SendFeedbackDto } from './dto/send-feedback.dto';
import { FeedbackService } from './feedback.service';

@Controller('feedback')
@UseGuards(AuthGuard)
export class FeedbackController {
  constructor(private readonly svc: FeedbackService) {}

  /**
   * Whether reports can be sent. Always, now that they are kept here; still
   * answered, because installed apps ask before offering the form.
   */
  @Get()
  @AllowRestricted()
  status() {
    return { available: this.svc.isConfigured };
  }

  /**
   * Keeps a bug, an idea or an error report for the team, and answers with
   * the number to quote.
   *
   * Behind the auth guard: the report is tied to the account that sent it,
   * so the team can follow up, and an open endpoint into an inbox people
   * read by hand would be a spam pipe.
   */
  // Open to a restricted account: somebody locked out of everything else
  // may need to tell the team their account was taken over, and an appeal
  // only answers a decision.
  @Post()
  @AllowRestricted()
  async send(@Req() req: AuthRequest, @Body() dto: SendFeedbackDto) {
    const filed = await this.svc.file(dto, req.user.id);
    // `url` stays, empty, for installed apps that read it: there is no
    // public page for a private report.
    return { number: filed.number, url: '' };
  }
}
