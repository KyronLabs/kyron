import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { PrismaModule } from '../../infrastructure/prisma/prisma.module';

// No controller. UsersController answered GET /users/:id and POST /users with
// no sign-in at all: the first returned the whole account row, email address
// included, for any id -- and every post carries its author's id -- and the
// second created accounts with whatever role the request named, ADMIN
// included. Neither was used by any client. public-routes.spec.ts fails if a
// route without a guard comes back.
@Module({
  imports: [PrismaModule],
  providers: [UsersService],
  exports: [UsersService],
})
export class UsersModule {}
