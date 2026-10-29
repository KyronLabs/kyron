// src/modules/profile/dto/update-profile.dto.ts
import { IsOptional, IsString, IsArray, IsIn } from 'class-validator';
import { COUNTRY_CODES } from '../../../common/countries';

export class UpdateProfileDto {
  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  @IsString()
  bio?: string;

  /**
   * Free text, from app versions before the country picker. Still accepted so
   * they can save, and still stored, but no longer shown anywhere.
   */
  @IsOptional()
  @IsString()
  location?: string;

  /**
   * Where they are, as a code from the list, or null to say nothing. A list
   * rather than text so it can be counted: "Lagos", "lagos nigeria" and "9ja"
   * are one place and three strings.
   */
  @IsOptional()
  @IsIn(COUNTRY_CODES)
  country?: string | null;

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
