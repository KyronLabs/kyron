"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("reflect-metadata");
const core_1 = require("@nestjs/core");
const app_module_1 = require("./app.module");
const platform_fastify_1 = require("@nestjs/platform-fastify");
const helmet_1 = __importDefault(require("@fastify/helmet"));
const rate_limit_1 = __importDefault(require("@fastify/rate-limit"));
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
const prisma_service_1 = require("./infrastructure/prisma/prisma.service");
async function bootstrap() {
    const logger = new common_1.Logger('Bootstrap');
    const app = await core_1.NestFactory.create(app_module_1.AppModule, new platform_fastify_1.FastifyAdapter({ logger: false }), { bufferLogs: true });
    // 🔊  FORCE  ALL  LOG  LEVELS  (error / warn / log / debug / verbose)
    app.useLogger(['error', 'warn', 'log', 'debug', 'verbose']);
    const config = app.get(config_1.ConfigService);
    await app.register(helmet_1.default);
    await app.register(rate_limit_1.default, {
        max: config.get('RATE_LIMIT_MAX') ?? 100,
        timeWindow: 60 * 1000,
    });
    app.enableCors({
        origin: config.get('CORS_ORIGIN') || true,
        credentials: true,
    });
    const port = config.get('PORT', 3000);
    // Graceful shutdown: ensure Prisma disconnects cleanly
    const prismaService = app.get(prisma_service_1.PrismaService);
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
//# sourceMappingURL=main.js.map