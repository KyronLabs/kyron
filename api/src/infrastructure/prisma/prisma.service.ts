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

  async onModuleInit(): Promise<void> {
    let attempts = 0;
    while (attempts < 5) {
      try {
        this.logger.log('Connecting to Postgres via Prisma...');
        await this.$connect();
        this.logger.log('Prisma connected.');
        return;
      } catch (err) {
        attempts++;
        this.logger.warn(`DB connect attempt ${attempts} failed, retrying in 2 s…`);
        await new Promise(res => setTimeout(res, 2000));
      }
    }
    throw new Error('Could not connect to Postgres after 5 attempts');
  }

  async onModuleDestroy(): Promise<void> {
    this.logger.log('Disconnecting Prisma...');
    await this.$disconnect();
    this.logger.log('Prisma disconnected.');
  }
}
