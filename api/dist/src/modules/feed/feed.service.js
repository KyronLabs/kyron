"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var FeedService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.FeedService = void 0;
const common_1 = require("@nestjs/common");
let FeedService = FeedService_1 = class FeedService {
    constructor() {
        this.logger = new common_1.Logger(FeedService_1.name);
        this.posts = [];
    }
    async createPost(p) {
        const post = {
            id: (Math.random() * 1e9).toFixed(0),
            authorId: p.authorId || 'anon',
            content: p.content || '',
            createdAt: Date.now(),
        };
        this.posts.unshift(post);
        this.logger.log(`post created ${post.id}`);
        return post;
    }
    async listRecent(limit = 20) {
        return this.posts.slice(0, limit);
    }
};
exports.FeedService = FeedService;
exports.FeedService = FeedService = FeedService_1 = __decorate([
    (0, common_1.Injectable)()
], FeedService);
//# sourceMappingURL=feed.service.js.map