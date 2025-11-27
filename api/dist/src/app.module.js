"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const gateway_module_1 = require("./modules/gateway/gateway.module");
const feed_module_1 = require("./modules/feed/feed.module");
const media_module_1 = require("./modules/media/media.module");
const identity_module_1 = require("./modules/identity/identity.module");
const common_module_1 = require("./modules/common/common.module");
const prisma_module_1 = require("./infrastructure/prisma/prisma.module");
const config_module_1 = require("./config/config.module");
const users_module_1 = require("./modules/users/users.module");
const auth_module_1 = require("./modules/auth/auth.module");
let AppModule = class AppModule {
};
exports.AppModule = AppModule;
exports.AppModule = AppModule = __decorate([
    (0, common_1.Module)({
        imports: [
            config_module_1.AppConfigModule,
            prisma_module_1.PrismaModule,
            common_module_1.CommonModule,
            identity_module_1.IdentityModule,
            media_module_1.MediaModule,
            feed_module_1.FeedModule,
            gateway_module_1.GatewayModule,
            users_module_1.UsersModule,
            auth_module_1.AuthModule,
        ],
        controllers: [],
        providers: [],
    })
], AppModule);
//# sourceMappingURL=app.module.js.map