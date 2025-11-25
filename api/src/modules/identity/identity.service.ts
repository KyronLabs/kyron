/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

export type UserDto = {
  id: string;
  email?: string;
  displayName?: string | null;
  createdAt?: Date;
  updatedAt?: Date;
};

@Injectable()
export class IdentityService {
  private readonly logger = new Logger(IdentityService.name);

  constructor(private readonly prisma: PrismaService) {}

  async createUser(data: {
    email?: string;
    displayName?: string;
  }): Promise<UserDto> {
    const payload: any = {};

    if (data.email) payload.email = data.email;
    if (data.displayName) payload.displayName = data.displayName;

    const user = await this.prisma.user.create({
      data: payload,
    });

    // ✔ Correct template string
    this.logger.log(`User created: ${user.id}`);

    return this.toDto(user)!;
  }

  async findById(id: string): Promise<UserDto | null> {
    const user = await this.prisma.user.findUnique({ where: { id } });
    if (!user) return null;
    return this.toDto(user);
  }

  async findByEmail(email: string): Promise<UserDto | null> {
    const user = await this.prisma.user.findUnique({ where: { email } });
    if (!user) return null;
    return this.toDto(user);
  }

  private toDto(user: any): UserDto | null {
    if (!user) return null;

    return {
      id: user.id,
      email: user.email ?? undefined,
      displayName: user.displayName ?? undefined,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    };
  }
}
