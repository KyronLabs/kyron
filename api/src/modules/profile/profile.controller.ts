/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */

// src/modules/profile/profile.controller.ts
import {
  Controller,
  Get,
  Post,
  Patch,
  UploadedFile,
  UseInterceptors,
  UseGuards,
  Body,
  Req,
  Logger,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ProfileService } from './profile.service';
import { AuthGuard } from '../../common/guards/auth.guard'; // your existing auth guard
import { Request } from 'express';

@Controller('profile')
export class ProfileController {
  private readonly logger = new Logger(ProfileController.name);
  constructor(private readonly svc: ProfileService) {}

  // get my profile
  @UseGuards(AuthGuard)
  @Get('me')
  async me(@Req() req: Request) {
    // assume your AuthGuard attaches userId to req.user?.id
    const userId = (req as any).user?.id;
    return await this.svc.getProfile(userId);
  }

  // update profile body fields
  @UseGuards(AuthGuard)
  @Patch()
  async update(@Req() req: Request, @Body() body: any) {
    const userId = (req as any).user?.id;
    return await this.svc.updateProfile(userId, body);
  }

  // upload avatar (multipart form-data with file field 'file')
  @UseGuards(AuthGuard)
  @Post('avatar')
  @UseInterceptors(FileInterceptor('file'))
  async uploadAvatar(@Req() req: Request, @UploadedFile() file: Express.Multer.File) {
    const userId = (req as any).user?.id;
    if (!file) throw new Error('no file uploaded');
    const url = await this.svc.uploadAvatar(userId, file.buffer, file.originalname, file.mimetype);
    return { url };
  }

  // upload cover
  @UseGuards(AuthGuard)
  @Post('cover')
  @UseInterceptors(FileInterceptor('file'))
  async uploadCover(@Req() req: Request, @UploadedFile() file: Express.Multer.File) {
    const userId = (req as any).user?.id;
    if (!file) throw new Error('no file uploaded');
    const url = await this.svc.uploadCover(userId, file.buffer, file.originalname, file.mimetype);
    return { url };
  }

  @UseGuards(AuthGuard)
  @Get('default-cover/random')
  async randomDefaultCover() {
    const url = await this.svc.getRandomDefaultCover();
    return { url };
  }

  @Get('interests')
  async interests() {
    const rows = await this.svc.listInterests();
    return { data: rows };
  }
}