import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { UserRole } from '@prisma/client';
import type { AuthRequest } from '../../common/types/auth-request';

/**
 * Financial operations are restricted more tightly than general staff tools:
 * admins only, and an AAL2 session on every request. This is intentionally
 * independent of STAFF_REQUIRE_SECOND_FACTOR; financial access is never
 * allowed on a password-only session.
 */
@Injectable()
export class FinancialOperationsGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest<AuthRequest>();

    // Hide the existence of financial operations from non-admin accounts.
    if (request.user?.role !== UserRole.ADMIN) {
      throw new NotFoundException();
    }

    if (request.aal !== 'aal2') {
      throw new ForbiddenException({
        statusCode: 403,
        code: 'FINANCIAL_OPERATIONS_SECOND_FACTOR_REQUIRED',
        message:
          'A session verified with a second factor is required for financial operations.',
      });
    }

    return true;
  }
}
