"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var PrismaService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.PrismaService = void 0;
const common_1 = require("@nestjs/common");
const client_1 = require("@prisma/client");
let PrismaService = PrismaService_1 = class PrismaService extends client_1.PrismaClient {
    constructor() {
        super(...arguments);
        this.logger = new common_1.Logger(PrismaService_1.name);
    }
    async onModuleInit() {
        let attempts = 0;
        while (attempts < 5) {
            try {
                this.logger.log('Connecting to Postgres via Prisma...');
                await this.$connect();
                this.logger.log('Prisma connected.');
                return;
            }
            catch (err) {
                attempts++;
                this.logger.warn(`DB connect attempt ${attempts} failed, retrying in 2 s…`);
                await new Promise(res => setTimeout(res, 2000));
            }
        }
        throw new Error('Could not connect to Postgres after 5 attempts');
    }
    async onModuleDestroy() {
        this.logger.log('Disconnecting Prisma...');
        await this.$disconnect();
        this.logger.log('Prisma disconnected.');
    }
};
exports.PrismaService = PrismaService;
exports.PrismaService = PrismaService = PrismaService_1 = __decorate([
    (0, common_1.Injectable)()
], PrismaService);
//# sourceMappingURL=prisma.service.js.map