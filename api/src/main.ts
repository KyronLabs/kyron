import 'reflect-metadata';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import helmet from '@fastify/helmet';
import rateLimit from '@fastify/rate-limit';
import multipart from '@fastify/multipart';
import { MediaService } from './modules/media/media.service';
import { Logger, ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

async function bootstrap() {
  const logger = new Logger('Bootstrap');
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter({ logger: false }),
    // Not buffering. Provider initialisation -- notably PrismaService's connect
    // retry loop -- runs inside create(), and a failure there rejects before
    // useLogger() is ever reached, so buffered records are dropped and the boot
    // fails in total silence. Unbuffered costs some log ordering at startup and
    // buys knowing why the process died.
    { bufferLogs: false },
  );

  app.useLogger(['error', 'warn', 'log', 'debug', 'verbose']);

  const config = app.get(ConfigService);
  await app.register(helmet);

  // The plugin enforces this before a handler sees the request, so a limit
  // here that is lower than the one MediaService advertises makes that check
  // unreachable: it was 5 MB against a stated 25, and every video upload came
  // back 413 with no message anyone could act on. Named once, in the service
  // that owns the rule.
  await app.register(multipart, {
    limits: {
      fieldNameSize: 100,
      fieldSize: 1_000_000,
      fields: 10,
      fileSize: MediaService.maxBytes,
      files: 1,
    },
  });

  await app.register(rateLimit, {
    max: config.get<number>('RATE_LIMIT_MAX') ?? 100,
    timeWindow: 60 * 1000,
  });

  // CORS_ORIGIN is a comma-separated allow-list. Unset, we reflect whatever
  // Origin the request carries -- which together with credentials:true lets any
  // site issue authenticated cross-origin requests. That is fine locally and
  // wrong in production, so warn loudly rather than throw: this check must not
  // be able to take down a running deployment on its own.
  const allowedOrigins = config
    .get<string>('CORS_ORIGIN')
    ?.split(',')
    .map((origin) => origin.trim())
    .filter(Boolean);

  if (!allowedOrigins?.length) {
    logger.warn(
      'CORS_ORIGIN is not set: reflecting any origin with credentials enabled. ' +
        'Set it to a comma-separated allow-list before exposing this publicly.',
    );
  }

  app.enableCors({
    origin: allowedOrigins?.length ? allowedOrigins : true,
    credentials: true,
  });

  // Nothing validated DTOs before this. Every class-validator decorator in the
  // codebase was inert, which is why POST /auth/login with an empty body
  // answered 500 rather than 400: the handler ran with undefined fields and
  // threw somewhere further in.
  //
  // whitelist strips properties the DTO does not declare, rather than
  // rejecting them, so a client sending an extra field keeps working. That
  // stripping is also a control in its own right: it is what stops a body
  // smuggling in a field a handler was not meant to accept.
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
      transformOptions: { enableImplicitConversion: false },
    }),
  );

  const port = config.get<number>('PORT', 3000);

  await app.listen(port, '0.0.0.0');
  // Report the address actually bound. This previously said "localhost", which
  // reads as a loopback-only bind and is the first thing anyone checks when a
  // platform reports the app is not reachable on 0.0.0.0.
  logger.log(`🚀 Kyron API (Fastify) listening on 0.0.0.0:${port}`);

  const shutdown = async () => {
    logger.log('SIGINT/SIGTERM received: closing Nest app...');
    await app.close();
    process.exit(0);
  };
  process.on('SIGINT', () => void shutdown());
  process.on('SIGTERM', () => void shutdown());
}
void bootstrap().catch((error) => {
  new Logger('Bootstrap').error(
    'Failed to start Kyron API',
    error instanceof Error ? error.stack : String(error),
  );
  // Set the code and let the event loop drain rather than exiting immediately;
  // the unref'd timer only fires if something is still holding the process
  // open, so a failed boot reports its reason and still cannot hang the machine.
  process.exitCode = 1;
  setTimeout(() => process.exit(1), 250).unref();
});
