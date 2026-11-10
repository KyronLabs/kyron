import {
  ArrayMaxSize,
  IsArray,
  IsIn,
  IsOptional,
  IsString,
  Matches,
  MaxLength,
} from 'class-validator';

import { COUNTRY_CODES } from '../../../common/countries';
import { IsStoredMediaUrl } from '../../../common/stored-media-url';

/**
 * What Edit profile may send. The lengths are the ones that screen enforces
 * (50, 300, 200), so nothing it can type is refused here; this is for whoever
 * is not using the screen.
 */
export class UpdateProfileDto {
  @IsOptional()
  @IsString()
  @MaxLength(50)
  name?: string;

  @IsOptional()
  @IsString()
  @MaxLength(300)
  bio?: string;

  /**
   * Free text, from app versions before the country picker. Still accepted so
   * they can save, and still stored, but no longer shown anywhere.
   */
  @IsOptional()
  @IsString()
  @MaxLength(100)
  location?: string;

  /**
   * Where they are, as a code from the list, or null to say nothing. A list
   * rather than text so it can be counted: "Lagos", "lagos nigeria" and "9ja"
   * are one place and three strings.
   */
  @IsOptional()
  @IsIn(COUNTRY_CODES)
  country?: string | null;

  /**
   * A web address, with or without `https://`, or empty to clear it.
   *
   * It becomes a link on the profile, so the one thing it must never be is
   * another scheme: `javascript:`, `intent:` and the rest stop at the colon.
   */
  @IsOptional()
  @IsString()
  @MaxLength(200)
  @Matches(/^$|^(https?:\/\/)?[^\s:@/?#]+(:\d{1,5})?([/?#]\S*)?$/i, {
    message: 'website must be a web address.',
  })
  website?: string;

  // A cover chosen from the default set. Uploads go through POST /profile/cover
  // instead; this is for selecting one that already exists in storage.
  @IsOptional()
  @IsStoredMediaUrl()
  coverUrl?: string;

  /** Interest ids. */
  @IsOptional()
  @IsArray()
  @ArrayMaxSize(50)
  @IsString({ each: true })
  @MaxLength(64, { each: true })
  interests?: string[];
}
