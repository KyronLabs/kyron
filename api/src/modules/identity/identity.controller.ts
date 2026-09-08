import { Body, Controller, Get, Put, Req, UseGuards } from '@nestjs/common';
import { IdentityService } from './identity.service';
import { ClaimDidDto } from './dto/claim-did.dto';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';

/**
 * Portable identity.
 *
 * This controller previously exposed `POST /identity/users`, which created a
 * User row, and `GET /identity/users/:id`, which answered with that user's
 * email -- both unauthenticated, on the open internet. Nothing in the app
 * called either: accounts come from Supabase and the auth guard provisions
 * the local row. They are gone rather than guarded, because a way to create
 * accounts outside the identity provider should not exist at all.
 */
@Controller('identity')
@UseGuards(AuthGuard)
export class IdentityController {
  constructor(private readonly svc: IdentityService) {}

  /** What this account's identifier is, if it has made one. */
  @Get('did')
  did(@Req() req: AuthRequest) {
    return this.svc.didFor(req.user.id);
  }

  /** A nonce to sign. Five minutes, one per account. */
  @Get('did/challenge')
  challenge(@Req() req: AuthRequest) {
    return this.svc.issueChallenge(req.user.id);
  }

  /** Records the identifier, once the signature proves it is this account's. */
  @Put('did')
  claim(@Req() req: AuthRequest, @Body() dto: ClaimDidDto) {
    return this.svc.claimDid(req.user.id, dto.did, dto.signature);
  }
}
