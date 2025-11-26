"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var MediaService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.MediaService = void 0;
const common_1 = require("@nestjs/common");
const child_process_1 = require("child_process");
const util_1 = require("util");
const execAsync = (0, util_1.promisify)(child_process_1.exec);
let MediaService = MediaService_1 = class MediaService {
    constructor() {
        this.logger = new common_1.Logger(MediaService_1.name);
    }
    async transcode(inputPath, outputPath) {
        // placeholder: calls ffmpeg from PATH inside host or container
        const cmd = `ffmpeg -y -i "${inputPath}" -c:v libx264 -preset veryfast "${outputPath}"`;
        this.logger.log(`Transcode command: ${cmd}`);
        const { stdout, stderr } = await execAsync(cmd);
        this.logger.debug(stdout || stderr);
        return { ok: true };
    }
};
exports.MediaService = MediaService;
exports.MediaService = MediaService = MediaService_1 = __decorate([
    (0, common_1.Injectable)()
], MediaService);
//# sourceMappingURL=media.service.js.map