import { Controller, Post, Body } from '@nestjs/common';
import { MediaService } from './media.service';

@Controller('media')
export class MediaController {
  constructor(private readonly svc: MediaService) {}

  @Post('transcode')
  async transcode(@Body() body: { input: string; output: string }) {
    // input/output are host paths for dev. Replace with uploaded blob references in prod.
    return this.svc.transcode(body.input, body.output);
  }
}
