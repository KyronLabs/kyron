import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Put,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { AllowRestricted } from '../../common/guards/standing';
import type { AuthRequest } from '../../common/types/auth-request';
import { ModerationService } from './moderation.service';
import {
  CreateReportDto,
  InterestDto,
  MutePhraseDto,
} from './dto/moderation.dto';

// Blocking, muting, hiding and reporting stay open to a suspended account:
// they protect somebody rather than add to the service, and an account that
// is suspended can still be harassed.
@Controller()
@UseGuards(AuthGuard)
export class ModerationController {
  constructor(private readonly svc: ModerationService) {}

  // ---- Blocking -----------------------------------------------------------

  @Put('users/:id/block')
  @AllowRestricted('suspended')
  block(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setBlocked(req.user.id, id, true);
  }

  @Delete('users/:id/block')
  @AllowRestricted('suspended')
  unblock(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setBlocked(req.user.id, id, false);
  }

  @Get('blocks')
  blocked(@Req() req: AuthRequest) {
    return this.svc.listBlockedUsers(req.user.id);
  }

  // ---- Muting -------------------------------------------------------------

  @Put('users/:id/mute')
  @AllowRestricted('suspended')
  muteUser(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.muteUser(req.user.id, id, true);
  }

  @Delete('users/:id/mute')
  @AllowRestricted('suspended')
  unmuteUser(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.muteUser(req.user.id, id, false);
  }

  @Get('mutes/users')
  mutedUsers(@Req() req: AuthRequest) {
    return this.svc.listMutedUsers(req.user.id);
  }

  @Put('feed/posts/:id/mute')
  @AllowRestricted('suspended')
  muteThread(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.muteThread(req.user.id, id, true);
  }

  @Delete('feed/posts/:id/mute')
  @AllowRestricted('suspended')
  unmuteThread(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
  ) {
    return this.svc.muteThread(req.user.id, id, false);
  }

  @Get('mutes/words')
  mutedWords(@Req() req: AuthRequest) {
    return this.svc.listMutedPhrases(req.user.id);
  }

  @Post('mutes/words')
  @AllowRestricted('suspended')
  muteWord(@Req() req: AuthRequest, @Body() dto: MutePhraseDto) {
    return this.svc.mutePhrase(req.user.id, dto.phrase, true);
  }

  // A query parameter rather than a path segment: a muted phrase can contain
  // slashes, spaces and '#', none of which survive a path intact.
  @Delete('mutes/words')
  @AllowRestricted('suspended')
  unmuteWord(@Req() req: AuthRequest, @Query('phrase') phrase: string) {
    return this.svc.mutePhrase(req.user.id, phrase ?? '', false);
  }

  // ---- Feed control -------------------------------------------------------

  @Put('feed/posts/:id/hide')
  @AllowRestricted('suspended')
  hide(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setHidden(req.user.id, id, true);
  }

  @Delete('feed/posts/:id/hide')
  @AllowRestricted('suspended')
  unhide(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setHidden(req.user.id, id, false);
  }

  @Put('feed/posts/:id/interest')
  interest(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: InterestDto,
  ) {
    return this.svc.setInterest(req.user.id, id, dto.kind);
  }

  // ---- Reporting ----------------------------------------------------------

  @Post('reports')
  @AllowRestricted('suspended')
  report(@Req() req: AuthRequest, @Body() dto: CreateReportDto) {
    return this.svc.report(
      req.user.id,
      dto.target,
      dto.targetId,
      dto.reason,
      dto.detail,
    );
  }
}
