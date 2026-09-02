import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { PreviewLinkDto } from './dto/preview-link.dto';
import { LinksService } from './links.service';

@Controller('links')
@UseGuards(AuthGuard)
export class LinksController {
  constructor(private readonly svc: LinksService) {}

  /**
   * The card for a link, or null if it has none.
   *
   * Behind the auth guard: it makes the server fetch a URL of the caller's
   * choosing, so it is not something to leave open to anyone who finds it.
   */
  @Get('preview')
  async preview(@Query() query: PreviewLinkDto) {
    return { preview: await this.svc.preview(query.url) };
  }
}
