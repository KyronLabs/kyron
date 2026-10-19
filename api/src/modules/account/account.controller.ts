import { Controller, Delete, Req, UseGuards } from '@nestjs/common';
import { Request } from 'express';
import { AuthGuard } from '../../common/guards/auth.guard';
import { AllowRestricted } from '../../common/guards/standing';
import { AccountService } from './account.service';

interface AuthRequest extends Request {
  user: { id: string };
}

@Controller('account')
@UseGuards(AuthGuard)
export class AccountController {
  constructor(private readonly svc: AccountService) {}

  /**
   * Deletes the signed-in account and everything in it. There is no undo:
   * the app asks first, and the sign-in itself is gone when this answers.
   */
  // Open to a banned account. Leaving is always allowed; the address is
  // kept, hashed, so leaving does not also wipe the ban (BannedIdentity).
  @Delete()
  @AllowRestricted()
  delete(@Req() req: AuthRequest) {
    return this.svc.deleteAccount(req.user.id);
  }
}
