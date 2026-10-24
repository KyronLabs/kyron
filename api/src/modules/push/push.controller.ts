import {
  Body,
  Controller,
  Delete,
  HttpCode,
  Post,
  Put,
  Req,
  UseGuards,
} from '@nestjs/common';
import {
  IsIn,
  IsOptional,
  IsString,
  Matches,
  MaxLength,
  MinLength,
} from 'class-validator';

import { AuthGuard } from '../../common/guards/auth.guard';
import { AllowRestricted } from '../../common/guards/standing';
import type { AuthRequest } from '../../common/types/auth-request';
import { PushService, PushTestResult } from './push.service';

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

/** Where to reach somebody when the app is closed. */
@Controller('devices')
@UseGuards(AuthGuard)
export class PushController {
  constructor(private readonly push: PushService) {}

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
