import { RequestMethod } from '@nestjs/common';
import {
  GUARDS_METADATA,
  METHOD_METADATA,
  PATH_METADATA,
} from '@nestjs/common/constants';
import { Test } from '@nestjs/testing';
import {
  DiscoveryModule,
  DiscoveryService,
  MetadataScanner,
} from '@nestjs/core';

import { AppModule } from './app.module';
import { PrismaService } from './infrastructure/prisma/prisma.service';

/**
 * Every route answers only to a signed-in account, except these.
 *
 * GET /users/:id was live with no guard for as long as the API had been up,
 * and returned the whole account row -- email address included -- for any id,
 * while every post carries its author's id. POST /users beside it created
 * accounts with any role the request named. Nothing noticed, because nothing
 * looked at the routes as a set. This does: a route without a guard has to be
 * added here, on purpose, with a reason.
 */
const PUBLIC = new Map<string, string>([
  ['GET /', 'says the API is up'],
  ['GET /health', 'the status page and the deploy health check'],
  ['GET /health/history', 'the status page'],
  ['GET /metrics', 'checks METRICS_TOKEN itself'],
  [
    'GET /profile/:username',
    'public profiles; returns no email, and reads a session if one is sent',
  ],
  // The pre-Supabase sign-in. Nothing it issues is accepted by AuthGuard any
  // more, but the routes still answer.
  ['POST /auth/register', 'legacy sign-up'],
  ['POST /auth/verify-email', 'legacy sign-up'],
  ['POST /auth/login', 'legacy sign-in'],
  ['POST /auth/refresh', 'legacy sign-in'],
  ['POST /auth/logout', 'legacy sign-in'],
]);

/** "METHOD /path" for every route, with the names of its guards. */
async function routes(): Promise<{ route: string; guards: string[] }[]> {
  const ref = await Test.createTestingModule({
    imports: [AppModule, DiscoveryModule],
  })
    .overrideProvider(PrismaService)
    .useValue({ $connect: jest.fn(), $disconnect: jest.fn() })
    .compile();

  const discovery = ref.get(DiscoveryService);
  const scanner = ref.get(MetadataScanner);
  const found: { route: string; guards: string[] }[] = [];

  for (const controller of discovery.getControllers()) {
    const type = controller.metatype as object;
    const base = (Reflect.getMetadata(PATH_METADATA, type) as string) ?? '';
    const onClass = (Reflect.getMetadata(GUARDS_METADATA, type) ?? []) as {
      name: string;
    }[];
    const proto = Object.getPrototypeOf(controller.instance) as Record<
      string,
      object
    >;

    for (const name of scanner.getAllMethodNames(proto)) {
      const handler = proto[name];
      const path = Reflect.getMetadata(PATH_METADATA, handler) as
        | string
        | undefined;
      if (path === undefined) continue;
      const method =
        RequestMethod[Reflect.getMetadata(METHOD_METADATA, handler) as number];
      const onHandler = (Reflect.getMetadata(GUARDS_METADATA, handler) ??
        []) as { name: string }[];
      // "GET /health/" and "GET /health" are the same route; "GET /" stays.
      const route = `${method} /${base}/${path}`
        .replace(/\/+/g, '/')
        .replace(/(\/[^ ]+)\/$/, '$1');
      found.push({
        route,
        guards: [...onClass, ...onHandler].map((g) => g.name),
      });
    }
  }

  await ref.close();
  return found;
}

describe('which routes answer without a sign-in', () => {
  let all: { route: string; guards: string[] }[];

  beforeAll(async () => {
    all = await routes();
  });

  it('is looking at the real API', () => {
    // A scan that finds nothing passes everything below.
    expect(all.length).toBeGreaterThan(100);
    expect(all.map((r) => r.route)).toContain('GET /profile/me');
  });

  it('only the ones listed here, each for a reason', () => {
    const open = all
      .filter((r) => r.guards.length === 0)
      .map((r) => r.route)
      .sort();
    expect(open).toEqual([...PUBLIC.keys()].sort());
  });

  it('no longer includes reading or creating accounts by id', () => {
    const routes = all.map((r) => r.route);
    expect(routes).not.toContain('GET /users/:id');
    expect(routes).not.toContain('POST /users');
  });
});
