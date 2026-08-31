import type { Request } from 'express';
import type { User } from '@prisma/client';

/**
 * A request that has been through AuthGuard, which sets `user` from the
 * verified token. Declared once here because it was previously redeclared
 * inside each controller that needed it.
 */
export interface AuthRequest extends Request {
  user: User;
}
