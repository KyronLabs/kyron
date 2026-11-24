import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { IsString, Matches, MaxLength, MinLength } from 'class-validator';

import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { GooglePlayPurchasesService } from './google-play-purchases.service';

export class VerifyGooglePlayPurchaseDto {
  @IsString()
  @Matches(/^[A-Za-z0-9._-]{1,160}$/)
  productId!: string;

  @IsString()
  @MinLength(20)
  @MaxLength(4096)
  purchaseToken!: string;
}

@Controller('purchases/google-play')
@UseGuards(AuthGuard)
export class GooglePlayPurchasesController {
  constructor(private readonly purchases: GooglePlayPurchasesService) {}

  /**
   * Server-owned package catalogue and account-binding value. The client must
   * pass accountObfuscationId to Google Play as its obfuscated account ID.
   */
  @Get('catalogue')
  catalogue(@Req() request: AuthRequest) {
    return this.purchases.catalogue(request.user.id);
  }

  /** Verifies, credits once, and consumes a completed Play one-time purchase. */
  @Post('verify')
  verify(
    @Req() request: AuthRequest,
    @Body() dto: VerifyGooglePlayPurchaseDto,
  ) {
    return this.purchases.verify(
      request.user.id,
      dto.productId,
      dto.purchaseToken,
    );
  }
}
