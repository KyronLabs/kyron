import 'reflect-metadata';
import { NestFactory } from '@nestjs/core';
import { WsAdapter } from '@nestjs/platform-ws';
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
import { readRateLimit } from './config/rate-limit';
import { randomUUID } from 'node:crypto';
import { MetricsService } from './infrastructure/observability/metrics.service';
import { installRequestLogging } from './infrastructure/observability/request-log';
import { RealtimeService } from './modules/realtime/realtime.service';

async function bootstrap() {
  const logger = new Logger('Bootstrap');
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter({
      logger: false,
      // One id per request, echoed back on the response and carried on every
      // log line it produces. A caller that already has one -- a proxy, the
      // app, another service -- keeps it, so a single id spans the hop.
      genReqId: (request: {
        headers: Record<string, string | string[] | undefined>;
      }) => {
        const carried = request.headers['x-request-id'];
        const given = Array.isArray(carried) ? carried[0] : carried;
        // Bounded and stripped: this goes into a log line and a response
        // header, and a client must not be able to write either.
        if (typeof given === 'string') {
          const clean = given.replace(/[^\w.:-]/g, '').slice(0, 64);
          if (clean.length > 0) return clean;
        }
        return randomUUID();
      },
    }),
    // Not buffering. Provider initialisation -- notably PrismaService's connect
    // retry loop -- runs inside create(), and a failure there rejects before
    // useLogger() is ever reached, so buffered records are dropped and the boot
    // fails in total silence. Unbuffered costs some log ordering at startup and
    // buys knowing why the process died.
    { bufferLogs: false },
  );

  app.useLogger(['error', 'warn', 'log', 'debug', 'verbose']);

  const config = app.get(ConfigService);

  // Before the route plugins, so the hook is in place for the first request
  // the process ever serves rather than from whenever registration finishes.
  const metrics = app.get(MetricsService);
  installRequestLogging(app.getHttpAdapter().getInstance(), metrics);
  metrics.gauge(
    'kyron_realtime_readers',
    'Readers with at least one open socket on this instance.',
    () => app.get(RealtimeService).connectedReaders,
  );
  metrics.gauge(
    'process_resident_memory_bytes',
    'Resident set size of this process.',
    () => process.memoryUsage().rss,
  );

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
    // Read and validated in one place. Passing `config.get<number>(...)`
    // straight through handed the plugin a string, which it ignored in favour
    // of its own default of 1000 -- see src/config/rate-limit.ts.
    max: readRateLimit(),
    timeWindow: 60 * 1000,
    // Per account when there is one, per address otherwise.
    //
    // Keyed on the address alone, one limit covers everybody behind it: an
    // office, a school, or a mobile carrier's NAT, where thousands of phones
    // share a handful of addresses. The first few people through would spend
    // the budget for everyone else on the network, which reads as the app
    // being broken. The token is read here, not verified -- the guard does
    // that -- so the worst a forged one buys is a private bucket of the same
    // size, while anonymous traffic stays limited by address as before.
    keyGenerator: (request: {
      headers: Record<string, string | string[] | undefined>;
      ip: string;
    }) => {
      const header = request.headers.authorization;
      const bearer =
        typeof header === 'string' && header.startsWith('Bearer ')
          ? header.slice(7)
          : null;
      const subject = bearer ? subjectOf(bearer) : null;
      return subject ? `user:${subject}` : `ip:${request.ip}`;
    },
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

  // The realtime gateway rides the same port and the same process. Registered
  // before listen(), because the adapter has to be in place when the HTTP
  // server that carries the upgrade is created.
  app.useWebSocketAdapter(new WsAdapter(app));

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

/**
 * The `sub` claim of a token, without verifying it.
 *
 * Only ever used to choose a rate-limit bucket, never to decide who somebody
 * is -- AuthGuard does that, against a signature. A forged token therefore
 * buys nothing but its own bucket of the same size as everyone else's.
 */
function subjectOf(token: string): string | null {
  const body = token.split('.')[1];
  if (!body) return null;
  try {
    const claims: unknown = JSON.parse(
      Buffer.from(body, 'base64url').toString('utf8'),
    );
    const sub = (claims as { sub?: unknown })?.sub;
    return typeof sub === 'string' && sub.length > 0 && sub.length <= 128
      ? sub
      : null;
  } catch {
    return null;
  }
}
