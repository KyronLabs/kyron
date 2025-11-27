"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var IdentityService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.IdentityService = void 0;
/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../../infrastructure/prisma/prisma.service");
let IdentityService = IdentityService_1 = class IdentityService {
    constructor(prisma) {
        this.prisma = prisma;
        this.logger = new common_1.Logger(IdentityService_1.name);
    }
    async createUser(data) {
        const payload = {};
        if (data.email)
            payload.email = data.email;
        if (data.displayName)
            payload.displayName = data.displayName;
        const user = await this.prisma.user.create({
            data: payload,
        });
        // ✔ Correct template string
        this.logger.log(`User created: ${user.id}`);
        return this.toDto(user);
    }
    async findById(id) {
        const user = await this.prisma.user.findUnique({ where: { id } });
        if (!user)
            return null;
        return this.toDto(user);
    }
    async findByEmail(email) {
        const user = await this.prisma.user.findUnique({ where: { email } });
        if (!user)
            return null;
        return this.toDto(user);
    }
    toDto(user) {
        if (!user)
            return null;
        return {
            id: user.id,
            email: user.email ?? undefined,
            displayName: user.displayName ?? undefined,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt,
        };
    }
};
exports.IdentityService = IdentityService;
exports.IdentityService = IdentityService = IdentityService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], IdentityService);
//# sourceMappingURL=identity.service.js.map