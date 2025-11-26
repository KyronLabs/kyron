/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
// src/modules/profile/profile.controller.ts
import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFile,
  Req,
  BadRequestException,
  Body,
  Patch,
  Get,
  Param,
  UseGuards,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ProfileService } from './profile.service';
import { Request } from 'express';
import { UpdateProfileDto } from './dto/update-profile.dto';
import { UploadResponseDto } from './dto/upload-response.dto';
import { AuthGuard } from '../../common/guards/auth.guard'; // assume you have a guard

@Controller('profile')
export class ProfileController {
  constructor(private readonly svc: ProfileService) {}

  // Avatar upload (multipart/form-data -> file)
  @Post('avatar')
  @UseGuards(AuthGuard)
  @UseInterceptors(FileInterceptor('file'))
  async uploadAvatar(
    @UploadedFile() file: Express.Multer.File,
    @Req() req: Request,
  ): Promise<UploadResponseDto> {
    const userId = (req.user as any)?.sub;
    if (!userId) throw new BadRequestException('No user');

    if (!file) throw new BadRequestException('File required');
    const url = await this.svc.uploadAvatar(
      userId,
      file.buffer,
      file.originalname,
      file.mimetype,
    );
    return { url };
  }

  @Post('cover')
  @UseGuards(AuthGuard)
  @UseInterceptors(FileInterceptor('file'))
  async uploadCover(
    @UploadedFile() file: Express.Multer.File,
    @Req() req: Request,
  ): Promise<UploadResponseDto> {
    const userId = (req.user as any)?.sub;
    if (!userId) throw new BadRequestException('No user');

    if (!file) throw new BadRequestException('File required');
    const url = await this.svc.uploadCover(
      userId,
      file.buffer,
      file.originalname,
      file.mimetype,
    );
    return { url };
  }

  // update profile metadata & interests
  @Patch()
  @UseGuards(AuthGuard)
  async updateProfile(@Body() body: UpdateProfileDto, @Req() req: Request) {
    const userId = (req.user as any)?.sub;
    return await this.svc.updateProfile(userId, body as any);
  }

  @Get(':id')
  async getProfile(@Param('id') id: string) {
    return await this.svc.getProfile(id);
  }
}
