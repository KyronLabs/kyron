import { Body, Controller, Delete, Put, Req, UseGuards } from '@nestjs/common';
import { IsIn, IsString, MaxLength, MinLength } from 'class-validator';

import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { PushService } from './push.service';

export class RegisterDeviceDto {
  /** The registration token the platform issued. Long, and opaque to us. */
  @IsString()
  @MinLength(10)
  @MaxLength(4096)
  token!: string;

  @IsIn(['ios', 'android', 'web'])
  platform!: string;
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

  /** Called on every launch, so a token that rotated is picked up. */
  @Put()
  async register(
    @Req() req: AuthRequest,
    @Body() dto: RegisterDeviceDto,
  ): Promise<{ registered: boolean }> {
    await this.push.register(req.user.id, dto.token, dto.platform);
    return { registered: true };
  }

  /** Called on sign-out. A token left behind delivers to the wrong person. */
  @Delete()
  async forget(@Body() dto: ForgetDeviceDto): Promise<{ forgotten: boolean }> {
    await this.push.forget(dto.token);
    return { forgotten: true };
  }
}
