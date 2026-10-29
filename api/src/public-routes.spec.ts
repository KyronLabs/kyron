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
import { OptionalAuthGuard } from './common/guards/optional-auth.guard';
import { RESTRICTED_ACCESS } from './common/guards/standing';
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

/**
 * Everything a banned account can still reach: enough to read why, appeal,
 * hear the answer, contact support, and leave. Nothing that shows it the
 * service or lets it add to it.
 */
const OPEN_TO_BANNED = [
  'GET /moderation/standing',
  'PUT /moderation/standing/seen',
  'POST /moderation/actions/:id/appeal',
  'DELETE /account',
  'PUT /devices',
  'DELETE /devices',
  'DELETE /keys',
  'GET /feedback',
  'POST /feedback',
];

/**
 * What a suspended account can still do beyond reading: protect itself.
 */
const OPEN_TO_SUSPENDED = [
  'POST /reports',
  'PUT /users/:id/block',
  'DELETE /users/:id/block',
  'PUT /users/:id/mute',
  'DELETE /users/:id/mute',
  'PUT /feed/posts/:id/mute',
  'DELETE /feed/posts/:id/mute',
  'POST /mutes/words',
  'DELETE /mutes/words',
  'PUT /feed/posts/:id/hide',
  'DELETE /feed/posts/:id/hide',
];

interface Route {
  route: string;
  guards: string[];
  access: string | undefined;
}

/** "METHOD /path" for every route, with its guards and restricted access. */
async function routes(): Promise<Route[]> {
  const ref = await Test.createTestingModule({
    imports: [AppModule, DiscoveryModule],
  })
    .overrideProvider(PrismaService)
    .useValue({ $connect: jest.fn(), $disconnect: jest.fn() })
    .compile();

  const discovery = ref.get(DiscoveryService);
  const scanner = ref.get(MetadataScanner);
  const found: Route[] = [];

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
        access: (Reflect.getMetadata(RESTRICTED_ACCESS, handler) ??
          Reflect.getMetadata(RESTRICTED_ACCESS, type)) as string | undefined,
      });
    }
  }

  await ref.close();
  return found;
}

describe('which routes answer without a sign-in', () => {
  let all: Route[];

  beforeAll(async () => {
    all = await routes();
  });

  it('is looking at the real API', () => {
    // A scan that finds nothing passes everything below.
    expect(all.length).toBeGreaterThan(100);
    expect(all.map((r) => r.route)).toContain('GET /profile/me');
  });

  it('only the ones listed here, each for a reason', () => {
    // OptionalAuthGuard refuses nobody -- it only reads a session when one
    // is sent -- so a route behind it alone is as open as one with none.
    const refusing = (g: string) => g !== OptionalAuthGuard.name;
    const open = all
      .filter((r) => !r.guards.some(refusing))
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

describe('which routes a restricted account can still reach', () => {
  let all: Route[];

  beforeAll(async () => {
    all = await routes();
  });

  it('a banned one: only these', () => {
    const open = all
      .filter((r) => r.access === 'banned')
      .map((r) => r.route)
      .sort();
    expect(open).toEqual([...OPEN_TO_BANNED].sort());
  });

  it('a suspended one, beyond reading: only these', () => {
    const open = all
      .filter((r) => r.access === 'suspended')
      .map((r) => r.route)
      .sort();
    expect(open).toEqual([...OPEN_TO_SUSPENDED].sort());
  });

  it("the team's routes are not among them", () => {
    const team = all.filter(
      (r) =>
        r.route.startsWith('GET /moderation/reports') ||
        r.route.startsWith('POST /moderation/actions') ||
        r.route.includes('/moderation/appeals'),
    );
    expect(team.length).toBeGreaterThan(0);
    for (const r of team) {
      if (r.route === 'POST /moderation/actions/:id/appeal') continue;
      expect(r.access).toBeUndefined();
    }
  });
});
