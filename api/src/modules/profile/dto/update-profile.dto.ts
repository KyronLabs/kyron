// src/modules/profile/dto/update-profile.dto.ts
import { IsOptional, IsString, IsArray, ArrayUnique } from 'class-validator';

export class UpdateProfileDto {
  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  @IsString()
  bio?: string;

  @IsOptional()
  @IsString()
  location?: string;

  @IsOptional()
  @IsString()
  website?: string;

  // interest ids (prisma uuid strings)
  @IsOptional()
  @IsArray()
  @ArrayUnique()
  interests?: string[];
}
