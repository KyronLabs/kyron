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
import type { AuthRequest } from '../../common/types/auth-request';
import { ModerationService } from './moderation.service';
import {
  CreateReportDto,
  InterestDto,
  MutePhraseDto,
} from './dto/moderation.dto';

@Controller()
@UseGuards(AuthGuard)
export class ModerationController {
  constructor(private readonly svc: ModerationService) {}

  // ---- Blocking -----------------------------------------------------------

  @Put('users/:id/block')
  block(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setBlocked(req.user.id, id, true);
  }

  @Delete('users/:id/block')
  unblock(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setBlocked(req.user.id, id, false);
  }

  @Get('blocks')
  blocked(@Req() req: AuthRequest) {
    return this.svc.listBlockedUsers(req.user.id);
  }

  // ---- Muting -------------------------------------------------------------

  @Put('users/:id/mute')
  muteUser(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.muteUser(req.user.id, id, true);
  }

  @Delete('users/:id/mute')
  unmuteUser(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.muteUser(req.user.id, id, false);
  }

  @Get('mutes/users')
  mutedUsers(@Req() req: AuthRequest) {
    return this.svc.listMutedUsers(req.user.id);
  }

  @Put('feed/posts/:id/mute')
  muteThread(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.muteThread(req.user.id, id, true);
  }

  @Delete('feed/posts/:id/mute')
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
  muteWord(@Req() req: AuthRequest, @Body() dto: MutePhraseDto) {
    return this.svc.mutePhrase(req.user.id, dto.phrase, true);
  }

  // A query parameter rather than a path segment: a muted phrase can contain
  // slashes, spaces and '#', none of which survive a path intact.
  @Delete('mutes/words')
  unmuteWord(@Req() req: AuthRequest, @Query('phrase') phrase: string) {
    return this.svc.mutePhrase(req.user.id, phrase ?? '', false);
  }

  // ---- Feed control -------------------------------------------------------

  @Put('feed/posts/:id/hide')
  hide(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setHidden(req.user.id, id, true);
  }

  @Delete('feed/posts/:id/hide')
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
