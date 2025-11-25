/* eslint-disable @typescript-eslint/await-thenable */
import {
  Injectable,
  OnModuleInit,
  OnModuleDestroy,
  Logger,
} from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  private readonly logger = new Logger(PrismaService.name);
  emailVerification: any;
  refreshToken: any;
  passwordReset: any;

  async onModuleInit() {
    this.logger.log('Connecting to Postgres via Prisma...');
    await this.$connect();
    this.logger.log('Prisma connected.');
  }
  $connect() {
    throw new Error('Method not implemented.');
  }

  async onModuleDestroy() {
    this.logger.log('Disconnecting Prisma...');
    await this.$disconnect();
    this.logger.log('Prisma disconnected.');
  }
  $disconnect() {
    throw new Error('Method not implemented.');
  }
}
