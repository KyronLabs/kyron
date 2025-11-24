import 'reflect-metadata';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import helmet from '@fastify/helmet';
import rateLimit from '@fastify/rate-limit';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from './infrastructure/prisma/prisma.service';

async function bootstrap() {
  const logger = new Logger('Bootstrap');
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter({ logger: false }),
    { bufferLogs: true },
  );

  const config = app.get(ConfigService);
  await app.register(helmet);

  await app.register(rateLimit, {
    max: config.get<number>('RATE_LIMIT_MAX') ?? 100,
    timeWindow: 60 * 1000, // ms instead of human string
  });

  app.useLogger(logger);
  app.enableCors({
    origin: config.get('CORS_ORIGIN') || true,
    credentials: true,
  });

  const port = config.get<number>('PORT', 3000);

  // Graceful shutdown: ensure Prisma disconnects cleanly
  const prismaService = app.get(PrismaService);
  await app.listen(port, '0.0.0.0');
  logger.log(`🚀 Kyron API (Fastify) running on http://localhost:${port}`);

  const shutdown = async () => {
    logger.log('SIGINT/SIGTERM received: closing Nest app...');
    await app.close();
    process.exit(0);
  };
  process.on('SIGINT', shutdown);
  process.on('SIGTERM', shutdown);
}
bootstrap();
