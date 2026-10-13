import { Transform } from 'class-transformer';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
} from 'class-validator';

/** Which of the reader's communities to list. */
export type CommunityFilter = 'all' | 'unread' | 'running';

export class ListCommunitiesDto {
  @IsOptional()
  @IsUUID('4', { message: 'cursor must come from a previous page.' })
  cursor?: string;

  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(50)
  limit?: number;

  /**
   * All of them; only those with posts the reader has not seen; or only
   * those they own or moderate.
   */
  @IsOptional()
  @IsIn(['all', 'unread', 'running'])
  filter?: CommunityFilter;
}

/** The reader's settings for communities. */
export class CommunitySettingsDto {
  @IsBoolean()
  postsInHome!: boolean;
}

export class DiscoverCommunitiesDto {
  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(50)
  limit?: number;

  /** Narrows Discover to a search. Optional: with none it is the whole shelf. */
  @IsOptional()
  @IsString()
  @MaxLength(80)
  q?: string;
}

export class CreateCommunityDto {
  // The slug is derived from this rather than supplied: two fields that have
  // to agree is one more thing to get out of step.
  @IsString()
  @MaxLength(60, { message: 'A name cannot exceed 60 characters.' })
  name!: string;

  @IsOptional()
  @IsString()
  @MaxLength(400, { message: 'A description cannot exceed 400 characters.' })
  description?: string;
}

/** What an owner may change about a community. */
export class UpdateCommunityDto {
  @IsOptional()
  @IsString()
  @MaxLength(60, { message: 'A name cannot exceed 60 characters.' })
  name?: string;

  @IsOptional()
  @IsString()
  @MaxLength(400, { message: 'A description cannot exceed 400 characters.' })
  description?: string;

  @IsOptional()
  @IsString()
  @MaxLength(2048)
  avatarUrl?: string;

  @IsOptional()
  @IsString()
  @MaxLength(2048)
  bannerUrl?: string;
}

/** Promoting or demoting somebody. OWNER is refused by the service. */
export class SetRoleDto {
  @IsIn(['MODERATOR', 'MEMBER'], {
    message: 'role must be MODERATOR or MEMBER.',
  })
  role!: 'MODERATOR' | 'MEMBER';
}

/** Removing somebody, with an optional note for the moderation log. */
export class RemoveMemberDto {
  @IsOptional()
  @IsString()
  @MaxLength(280)
  reason?: string;
}
