/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import {
  Controller,
  Post,
  UseGuards,
  UploadedFile,
  UseInterceptors,
  Req,
  Put,
  Body,
  Get,
  BadRequestException,
  Param,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ProfileService } from './profile.service';
import { AuthGuard } from '../../common/guards/auth.guard';

@Controller('profile')
export class ProfileController {
  constructor(private readonly profile: ProfileService) {}

  @UseGuards(AuthGuard)
  @Post('avatar')
  @UseInterceptors(FileInterceptor('file'))
  async uploadAvatar(@Req() req: any, @UploadedFile() file: Express.Multer.File) {
    if (!file) throw new BadRequestException('No file provided');

    return this.profile.uploadAvatar(
      req.user.id,
      file.buffer,
      file.originalname,
      file.mimetype,
    );
  }

  @UseGuards(AuthGuard)
  @Post('cover')
  @UseInterceptors(FileInterceptor('file'))
  async uploadCover(@Req() req: any, @UploadedFile() file: Express.Multer.File) {
    if (!file) throw new BadRequestException('No file provided');

    return this.profile.uploadCover(
      req.user.id,
      file.buffer,
      file.originalname,
      file.mimetype,
    );
  }

  @UseGuards(AuthGuard)
  @Put()
  async updateProfile(@Req() req: any, @Body() body: any) {
    return this.profile.updateProfile(req.user.id, body);
  }

  @UseGuards(AuthGuard)
  @Get('me')
  async getMe(@Req() req: any) {
    return this.profile.getProfile(req.user.id);
  }

  @Get(':id')
  async getProfile(@Param('id') id: string) {
    return this.profile.getProfile(id);
  }
}
