import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Put,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { IsString, Matches, MaxLength, MinLength } from 'class-validator';

import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { KeysService, type PublishedKey } from './keys.service';

export class PublishKeyDto {
  /** X25519 raw bytes, base64url. */
  @IsString()
  @Matches(/^[A-Za-z0-9_-]{43}=?$/, {
    message: 'That is not an X25519 public key.',
  })
  publicKey!: string;

  /** Which install this is. Opaque to the server. */
  @IsString()
  @MinLength(8)
  @MaxLength(128)
  deviceId!: string;
}

/** The public halves that make a private message possible. */
@Controller('keys')
@UseGuards(AuthGuard)
export class KeysController {
  constructor(private readonly keys: KeysService) {}

  /** Publishes this install's key. Called once per install, and on rotation. */
  @Put()
  publish(
    @Req() req: AuthRequest,
    @Body() dto: PublishKeyDto,
  ): Promise<PublishedKey> {
    return this.keys.publish(req.user.id, dto.deviceId, dto.publicKey);
  }

  /** Withdraws it, on sign-out. */
  @Delete()
  async withdraw(
    @Req() req: AuthRequest,
    @Query('deviceId') deviceId: string,
  ): Promise<{ withdrawn: boolean }> {
    await this.keys.withdraw(req.user.id, deviceId);
    return { withdrawn: true };
  }

  /** Everybody's keys in one conversation, so a message can be sealed. */
  @Get('conversation/:id')
  forConversation(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<PublishedKey[]> {
    return this.keys.forConversation(req.user.id, id);
  }

  /** One person's keys, for a conversation that does not exist yet. */
  @Get(':userId')
  forUser(
    @Param('userId', ParseUUIDPipe) userId: string,
  ): Promise<PublishedKey[]> {
    return this.keys.forUser(userId);
  }
}
