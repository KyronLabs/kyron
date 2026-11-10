import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Put,
  Req,
  UseGuards,
} from '@nestjs/common';

import { staffFrom } from '../moderation/staff-session';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import {
  ApplyDto,
  DecideVerificationDto,
  SetVerifiedDto,
} from './dto/verification.dto';
import { VerificationService } from './verification.service';

/**
 * /verification is any account's own: where it stands and its request.
 * /moderation/... is the team's, and answers 404 to anybody else.
 */
@Controller()
@UseGuards(AuthGuard)
export class VerificationController {
  constructor(private readonly svc: VerificationService) {}

  @Get('verification')
  status(@Req() req: AuthRequest) {
    return this.svc.status(req.user.id);
  }

  @Post('verification')
  apply(@Req() req: AuthRequest, @Body() dto: ApplyDto) {
    return this.svc.apply(req.user.id, dto);
  }

  @Delete('verification')
  withdraw(@Req() req: AuthRequest) {
    return this.svc.withdraw(req.user.id);
  }

  @Get('moderation/verifications')
  queue(@Req() req: AuthRequest) {
    return this.svc.queue(staffFrom(req));
  }

  @Post('moderation/verifications/:id/decide')
  decide(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: DecideVerificationDto,
  ) {
    return this.svc.decide(staffFrom(req), id, dto.approve, dto.response);
  }

  @Put('moderation/accounts/:id/verified')
  setVerified(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: SetVerifiedDto,
  ) {
    return this.svc.setVerified(staffFrom(req), id, dto.verified, dto.reason);
  }
}
