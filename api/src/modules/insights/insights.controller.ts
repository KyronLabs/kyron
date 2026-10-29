import { Controller, Get, Query, Req, UseGuards } from '@nestjs/common';

import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { InsightsQueryDto } from './dto/insights-query.dto';
import { InsightsService } from './insights.service';

/**
 * Your own account's insights. There is no way to ask for anybody else's:
 * the account is the signed-in one, never a parameter.
 */
@Controller('insights')
@UseGuards(AuthGuard)
export class InsightsController {
  constructor(private readonly insights: InsightsService) {}

  @Get()
  report(@Req() req: AuthRequest, @Query() query: InsightsQueryDto) {
    return this.insights.report(req.user.id, query.days, query.tzOffset);
  }
}
