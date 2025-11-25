/* eslint-disable @typescript-eslint/require-await */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import * as argon2 from 'argon2';

type CreateUserPayload = {
  email: string;
  password: string;
  name?: string;
  role?: string;
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

    // only set role if it's a valid enum member
    const allowedRoles = new Set(['USER', 'ADMIN']);
    if (data.role && allowedRoles.has(data.role)) {
      payload.role = data.role;
    }

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
