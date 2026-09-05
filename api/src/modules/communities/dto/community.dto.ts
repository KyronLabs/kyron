import { Transform } from 'class-transformer';
import {
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
} from 'class-validator';

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
