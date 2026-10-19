import {
  Body,
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Put,
  Req,
  UseGuards,
} from '@nestjs/common';

import { AuthGuard } from '../../common/guards/auth.guard';
import { AllowRestricted } from '../../common/guards/standing';
import type { AuthRequest } from '../../common/types/auth-request';
import {
  ActDto,
  AppealDto,
  DecideAppealDto,
  DismissDto,
  ReasonDto,
} from './dto/enforcement.dto';
import { EnforcementService, type Staff } from './enforcement.service';

/**
 * Two audiences. /moderation/standing and appeals are any account's own,
 * and answer a banned one: they are how it learns why and answers back.
 * Everything else is the team's, and answers 404 to anybody else.
 */
@Controller('moderation')
@UseGuards(AuthGuard)
export class EnforcementController {
  constructor(private readonly svc: EnforcementService) {}

  // ---- The account's own ---------------------------------------------------

  @Get('standing')
  @AllowRestricted()
  standing(@Req() req: AuthRequest) {
    return this.svc.standing(req.user.id);
  }

  @Put('standing/seen')
  @AllowRestricted()
  seen(@Req() req: AuthRequest) {
    return this.svc.markSeen(req.user.id);
  }

  @Post('actions/:id/appeal')
  @AllowRestricted()
  appeal(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: AppealDto,
  ) {
    return this.svc.appeal(req.user.id, id, dto.statement);
  }

  // ---- The team's ------------------------------------------------------------

  @Get('reports')
  reports(@Req() req: AuthRequest) {
    return this.svc.reportQueue(staff(req));
  }

  @Post('reports/dismiss')
  dismiss(@Req() req: AuthRequest, @Body() dto: DismissDto) {
    return this.svc.dismiss(staff(req), dto.target, dto.targetId);
  }

  @Get('accounts/:id')
  account(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.account(staff(req), id);
  }

  @Post('actions')
  act(@Req() req: AuthRequest, @Body() dto: ActDto) {
    return this.svc.act(staff(req), dto);
  }

  @Post('actions/:id/reverse')
  reverse(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: ReasonDto,
  ) {
    return this.svc.reverse(staff(req), id, dto.reason);
  }

  @Get('appeals')
  appeals(@Req() req: AuthRequest) {
    return this.svc.appealQueue(staff(req));
  }

  @Post('appeals/:id/decide')
  decide(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: DecideAppealDto,
  ) {
    return this.svc.decide(staff(req), id, dto.overturn, dto.response);
  }
}

/** The caller, as the service checks them: id and role, from the guard. */
function staff(req: AuthRequest): Staff {
  return { id: req.user.id, role: req.user.role };
}
