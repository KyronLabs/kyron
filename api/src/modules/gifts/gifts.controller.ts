import {
  Body,
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';

import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { SendGiftDto } from './dto/send-gift.dto';
import { GiftsService } from './gifts.service';

@Controller()
@UseGuards(AuthGuard)
export class GiftsController {
  constructor(private readonly svc: GiftsService) {}

  /** The gift sheet in one call: what can be sent, and what is in hand. */
  @Get('gifts')
  async sheet(@Req() req: AuthRequest) {
    return {
      catalogue: this.svc.catalogue(),
      wallet: await this.svc.wallet(req.user.id),
    };
  }

  @Get('feed/posts/:id/gifts')
  summary(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.summary(id, req.user.id);
  }

  @Post('feed/posts/:id/gifts')
  send(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() body: SendGiftDto,
  ) {
    return this.svc.send(req.user.id, id, body);
  }
}
