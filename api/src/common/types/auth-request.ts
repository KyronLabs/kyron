import type { Request } from 'express';
import type { User } from '@prisma/client';

/**
 * A request that has been through AuthGuard, which sets `user` from the
 * verified token. Declared once here because it was previously redeclared
 * inside each controller that needed it.
 */
export interface AuthRequest extends Request {
  user: User;
  /** How the session was proven: 'aal2' after a second factor, else 'aal1'.
   * Set by AuthGuard from the token's own `aal` claim. */
  aal?: 'aal1' | 'aal2';
}
