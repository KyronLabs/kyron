import {
  Body,
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';

import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { staffFrom } from '../moderation/staff-session';
import {
  CreateRewardProgramDto,
  DecidePostRewardNominationDto,
  NominatePostDto,
  UpdateRewardProgramDto,
} from './dto/rewards.dto';
import { RewardsService } from './rewards.service';

@Controller()
@UseGuards(AuthGuard)
export class RewardsController {
  constructor(private readonly rewards: RewardsService) {}

  /** Active programmes users can nominate posts into. */
  @Get('rewards/programs')
  programs() {
    return this.rewards.availablePrograms();
  }

  /** A nomination is a request for review, never an award. */
  @Post('rewards/programs/:programId/nominations')
  nominate(
    @Req() req: AuthRequest,
    @Param('programId', ParseUUIDPipe) programId: string,
    @Body() body: NominatePostDto,
  ) {
    return this.rewards.nominate(req.user.id, programId, body);
  }

  /** A user's own nomination and reward history. */
  @Get('rewards/me')
  mine(@Req() req: AuthRequest) {
    return this.rewards.myRewards(req.user.id);
  }

  // The routes below are staff-only. staffFrom enforces AAL2 whenever
  // STAFF_REQUIRE_SECOND_FACTOR is enabled; the service checks the role.

  @Get('moderation/rewards/programs')
  staffPrograms(@Req() req: AuthRequest) {
    return this.rewards.staffPrograms(staffFrom(req));
  }

  @Post('moderation/rewards/programs')
  createProgram(@Req() req: AuthRequest, @Body() body: CreateRewardProgramDto) {
    return this.rewards.createProgram(staffFrom(req), body);
  }

  @Patch('moderation/rewards/programs/:id')
  updateProgram(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() body: UpdateRewardProgramDto,
  ) {
    return this.rewards.updateProgram(staffFrom(req), id, body);
  }

  @Get('moderation/rewards/nominations')
  nominationQueue(
    @Req() req: AuthRequest,
    @Query('programId') programId?: string,
  ) {
    return this.rewards.nominationQueue(staffFrom(req), programId);
  }

  @Post('moderation/rewards/nominations/:id/decision')
  decide(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() body: DecidePostRewardNominationDto,
  ) {
    return this.rewards.decide(staffFrom(req), id, body.decision, body.note);
  }
}
