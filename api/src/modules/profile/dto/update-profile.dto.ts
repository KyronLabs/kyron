// src/modules/profile/dto/update-profile.dto.ts
import { IsOptional, IsString, IsArray } from 'class-validator';

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

  // A cover chosen from the default set. Uploads go through POST /profile/cover
  // instead; this is for selecting one that already exists in storage, which
  // previously had no way to be saved at all -- GET default-cover/random only
  // ever returned a URL and persisted nothing.
  @IsOptional()
  @IsString()
  coverUrl?: string;

  @IsOptional()
  @IsArray()
  interests?: string[]; // array of interest IDs (prisma UUIDs)
}
