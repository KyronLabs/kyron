/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
// src/modules/profile/profile.controller.ts
import {
  Controller,
  Post,
  UseGuards,
  UploadedFile,
  UseInterceptors,
  Req,
  Body,
  Put,
  Get,
  Param,
  BadRequestException,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ProfileService } from './profile.service';
import { AuthGuard } from '../../common/guards/auth.guard'; // adjust path if different

@Controller('profile')
export class ProfileController {
  constructor(private readonly profileService: ProfileService) {}

  // Upload avatar (multipart/form-data: file)
  @UseGuards(AuthGuard)
  @Post('avatar')
  @UseInterceptors(FileInterceptor('file'))
  async uploadAvatar(@Req() req: any, @UploadedFile() file: Express.Multer.File) {
    if (!file) throw new BadRequestException('No file uploaded');
    // req.user.id assumed
    const userId = req.user?.id;
    return this.profileService.uploadAvatar(userId, file.buffer, file.originalname, file.mimetype);
  }

  // Upload cover
  @UseGuards(AuthGuard)
  @Post('cover')
  @UseInterceptors(FileInterceptor('file'))
  async uploadCover(@Req() req: any, @UploadedFile() file: Express.Multer.File) {
    if (!file) throw new BadRequestException('No file uploaded');
    const userId = req.user?.id;
    return this.profileService.uploadCover(userId, file.buffer, file.originalname, file.mimetype);
  }

  // Update profile (name/bio/location/website/interests)
  @UseGuards(AuthGuard)
  @Put()
  async updateProfile(@Req() req: any, @Body() body: any) {
    const userId = req.user?.id;
    return this.profileService.updateProfile(userId, body);
  }

  // Get own profile
  @UseGuards(AuthGuard)
  @Get('me')
  async getMyProfile(@Req() req: any) {
    const userId = req.user?.id;
    return this.profileService.getProfile(userId);
  }

  // Get someone else's profile by id (public)
  @Get(':id')
  async getProfile(@Param('id') id: string) {
    return this.profileService.getProfile(id);
  }
}
