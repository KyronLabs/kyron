/* eslint-disable @typescript-eslint/no-unsafe-assignment */

import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import * as argon2 from 'argon2';

// No role. Who is staff is decided in the database by the people who run
// Kyron, never by a request: this used to accept ADMIN from its caller.
type CreateUserPayload = {
  email: string;
  password: string;
  name?: string;
};

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async create(data: CreateUserPayload) {
    const hash = await argon2.hash(data.password);

    const payload: any = {
      email: data.email,
      password: hash,
      name: data.name ?? null,
    };

    const user = await this.prisma.user.create({
      data: payload,
    });
    return user;
  }

  async findById(id: string) {
    const u = await this.prisma.user.findUnique({ where: { id } });
    if (!u) throw new NotFoundException('User not found');
    return u;
  }

  async findByEmail(email: string) {
    return this.prisma.user.findUnique({ where: { email } });
  }
}
