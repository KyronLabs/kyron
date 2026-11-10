import { readRateLimit } from './rate-limit';

export default () => ({
  port: Number(process.env.PORT) || 3000,
  databaseUrl: process.env.DATABASE_URL,
  redis: {
    host: process.env.REDIS_HOST || 'localhost',
    port: Number(process.env.REDIS_PORT) || 6379,
  },
  rateLimit: {
    // Through the shared reader, so the value here and the one the plugin is
    // given cannot disagree -- and so an unparseable one is refused rather
    // than turned into 100 by a `||`.
    max: readRateLimit(),
  },
});
