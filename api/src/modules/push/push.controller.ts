import { timingSafeEqual } from 'node:crypto';

import {
  Body,
  Controller,
  Delete,
  Get,
  Headers,
  HttpCode,
  NotFoundException,
  Patch,
  Post,
  Put,
  Req,
  UseGuards,
} from '@nestjs/common';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Matches,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

import { AuthGuard } from '../../common/guards/auth.guard';
import { AllowRestricted } from '../../common/guards/standing';
import type { AuthRequest } from '../../common/types/auth-request';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { PushService, PushTestResult } from './push.service';
import { ScheduledPushService } from './scheduled-push.service';

export class RegisterDeviceDto {
  /** The registration token the platform issued. Long, and opaque to us. */
  @IsString()
  @MinLength(10)
  @MaxLength(4096)
  token!: string;

  @IsIn(['ios', 'android', 'web'])
  platform!: string;

  /** The language the app is in -- `fr`, `pt-BR` -- so pushes are said in
   * it. Optional: an app from before this sends none, and gets English. */
  @IsOptional()
  @IsString()
  @Matches(/^[A-Za-z]{2,3}(?:[-_][A-Za-z0-9]{2,8})*$/)
  @MaxLength(35)
  locale?: string;
}

export class ForgetDeviceDto {
  @IsString()
  @MinLength(10)
  @MaxLength(4096)
  token!: string;
}

export class ActiveDto {
  /** The phone's offset from UTC, in minutes: +60 in Lagos, -300 in New
   * York. Where in the day the person is, for when a reminder may arrive. */
  @IsOptional()
  @IsInt()
  @Min(-720)
  @Max(840)
  utcOffsetMinutes?: number;
}

export class RemindersDto {
  @IsBoolean()
  reminders!: boolean;
}

/** Where to reach somebody when the app is closed. */
@Controller('devices')
@UseGuards(AuthGuard)
export class PushController {
  constructor(
    private readonly push: PushService,
    private readonly prisma: PrismaService,
  ) {}

  /**
   * The app is open: called on launch and whenever it comes back to the
   * front. Who has been away, and where in their day they are, is read
   * from this by the scheduled pushes.
   */
  @Post('active')
  @HttpCode(204)
  async active(@Req() req: AuthRequest, @Body() dto: ActiveDto): Promise<void> {
    await this.prisma.user.update({
      where: { id: req.user.id },
      data: {
        lastActiveAt: new Date(),
        ...(dto.utcOffsetMinutes === undefined
          ? {}
          : { utcOffsetMinutes: dto.utcOffsetMinutes }),
      },
    });
  }

  /** Whether "while you were away" and "your coins are back" are sent. */
  @Get('reminders')
  async reminders(@Req() req: AuthRequest): Promise<{ reminders: boolean }> {
    const me = await this.prisma.user.findUnique({
      where: { id: req.user.id },
      select: { reminderPushes: true },
    });
    return { reminders: me?.reminderPushes ?? true };
  }

  @Patch('reminders')
  async setReminders(
    @Req() req: AuthRequest,
    @Body() dto: RemindersDto,
  ): Promise<{ reminders: boolean }> {
    await this.prisma.user.update({
      where: { id: req.user.id },
      data: { reminderPushes: dto.reminders },
    });
    return { reminders: dto.reminders };
  }

  /**
   * Called on every launch, so a token that rotated is picked up. Open to a
   * banned account: the answer to its appeal arrives as a notification.
   */
  @Put()
  @AllowRestricted()
  async register(
    @Req() req: AuthRequest,
    @Body() dto: RegisterDeviceDto,
  ): Promise<{ registered: boolean }> {
    await this.push.register(req.user.id, dto.token, dto.platform, dto.locale);
    return { registered: true };
  }

  /**
   * Sends the reader a notification, and says which part of push is not
   * working if it does not arrive. Only ever to the reader's own phones.
   */
  @Post('test')
  @HttpCode(200)
  test(@Req() req: AuthRequest): Promise<PushTestResult> {
    return this.push.test(req.user.id);
  }

  /** Called on sign-out. A token left behind delivers to the wrong person. */
  @Delete()
  @AllowRestricted()
  async forget(@Body() dto: ForgetDeviceDto): Promise<{ forgotten: boolean }> {
    await this.push.forget(dto.token);
    return { forgotten: true };
  }
}

/**
 * The outside clock for the scheduled pushes: called every hour by
 * .github/workflows/scheduled-pushes.yml, which also wakes a server that
 * has gone to sleep. Not signed in as anybody -- it carries CRON_KEY
 * instead -- and absent, a plain 404, on a server that has no key set.
 */
@Controller('internal/scheduled-pushes')
export class ScheduledPushController {
  constructor(private readonly scheduled: ScheduledPushService) {}

  @Post()
  @HttpCode(200)
  run(
    @Headers('x-cron-key') key: string | undefined,
  ): Promise<{ away: number; coins: number }> {
    const expected = process.env.CRON_KEY ?? '';
    if (!expected || !key || !ScheduledPushController.same(key, expected)) {
      throw new NotFoundException();
    }
    return this.scheduled.runDue();
  }

  private static same(a: string, b: string): boolean {
    const x = Buffer.from(a);
    const y = Buffer.from(b);
    return x.length === y.length && timingSafeEqual(x, y);
  }
}
