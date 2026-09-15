import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { AuthRequest } from '../../common/types/auth-request';
import { SendFeedbackDto } from './dto/send-feedback.dto';
import { FeedbackService } from './feedback.service';

@Controller('feedback')
@UseGuards(AuthGuard)
export class FeedbackController {
  constructor(private readonly svc: FeedbackService) {}

  /**
   * Whether reports can be filed, so the app can say why not *before*
   * somebody writes one rather than after.
   */
  @Get()
  status() {
    return { available: this.svc.isConfigured };
  }

  /**
   * Files a bug or an idea as an issue, and answers with where it went.
   *
   * Behind the auth guard: an open endpoint that opens issues on a public
   * repository is a spam pipe with a nice interface.
   */
  @Post()
  async send(@Req() req: AuthRequest, @Body() dto: SendFeedbackDto) {
    // The account is used to count reports and for nothing else: it is not
    // put in the issue, which is public.
    const filed = await this.svc.file(dto, req.user?.id);
    return { number: filed.number, url: filed.url };
  }
}
