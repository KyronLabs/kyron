import {
  ExecutionContext,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { AccountStatus, UserRole } from '@prisma/client';
import type { AuthRequest } from '../../common/types/auth-request';
import { FinancialOperationsGuard } from './financial-operations.guard';

function contextFor(request: Partial<AuthRequest>): ExecutionContext {
  return {
    switchToHttp: () => ({
      getRequest: () => request,
    }),
  } as unknown as ExecutionContext;
}

describe('FinancialOperationsGuard', () => {
  const guard = new FinancialOperationsGuard();

  it('hides financial operations from ordinary users', () => {
    const request = {
      user: { id: 'user-1', role: UserRole.USER },
      aal: 'aal2',
    } as AuthRequest;

    expect(() => guard.canActivate(contextFor(request))).toThrow(
      NotFoundException,
    );
  });

  it('hides financial operations from moderators', () => {
    const request = {
      user: { id: 'moderator-1', role: UserRole.MODERATOR },
      aal: 'aal2',
    } as AuthRequest;

    expect(() => guard.canActivate(contextFor(request))).toThrow(
      NotFoundException,
    );
  });

  it('rejects suspended admins even when their session is AAL2', () => {
    const request = {
      user: {
        id: 'admin-1',
        role: UserRole.ADMIN,
        status: AccountStatus.SUSPENDED,
      },
      aal: 'aal2',
    } as AuthRequest;

    expect(() => guard.canActivate(contextFor(request))).toThrow(
      NotFoundException,
    );
  });

  it('requires AAL2 independently of staff policy', () => {
    const request = {
      user: {
        id: 'admin-1',
        role: UserRole.ADMIN,
        status: AccountStatus.ACTIVE,
      },
      aal: 'aal1',
    } as AuthRequest;

    try {
      guard.canActivate(contextFor(request));
      throw new Error('Expected the guard to reject an AAL1 session.');
    } catch (error) {
      expect(error).toBeInstanceOf(ForbiddenException);
      expect((error as ForbiddenException).getResponse()).toMatchObject({
        code: 'FINANCIAL_OPERATIONS_SECOND_FACTOR_REQUIRED',
      });
    }
  });

  it('allows only an admin session verified with a second factor', () => {
    const request = {
      user: {
        id: 'admin-1',
        role: UserRole.ADMIN,
        status: AccountStatus.ACTIVE,
      },
      aal: 'aal2',
    } as AuthRequest;

    expect(guard.canActivate(contextFor(request))).toBe(true);
  });
});
