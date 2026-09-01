import { Test } from '@nestjs/testing';
import { AppModule } from './app.module';
import { PrismaService } from './infrastructure/prisma/prisma.service';

/**
 * Compiles the whole dependency graph.
 *
 * `nest build` is `tsc`: it type-checks, and knows nothing about whether a
 * provider is reachable from the module that injects it. Every unit spec here
 * builds a testing module with its dependencies mocked, so none of them see
 * the real wiring either.
 *
 * That gap put a deploy in a crash loop. MediaService injects SupabaseService,
 * SupabaseModule is not global, and MediaModule did not import it -- which
 * type-checks, builds, and passes every unit test, then fails at boot with
 *
 *   Nest can't resolve dependencies of the MediaService (?).
 *
 * This compiles AppModule exactly as main.ts does. A module that forgets an
 * import fails here instead of on Render.
 *
 * The configuration these services demand at import time comes from
 * src/test-env.ts, which jest runs before this file is loaded.
 */
describe('AppModule', () => {
  it('resolves every provider in every module', async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppModule],
    })
      // Overridden so compiling the graph does not open a connection. The
      // wiring is what is under test, not the database.
      .overrideProvider(PrismaService)
      .useValue({ $connect: jest.fn(), $disconnect: jest.fn() })
      .compile();

    expect(moduleRef).toBeDefined();
    await moduleRef.close();
  });
});
