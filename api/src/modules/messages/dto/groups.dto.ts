import { Transform } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  IsEnum,
  IsIn,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import { MemberRole } from '@prisma/client';

const trim = ({ value }: { value: unknown }): unknown =>
  typeof value === 'string' ? value.trim() : value;

/** Starts a group. The service holds the rules; these keep a body sane. */
export class CreateGroupDto {
  @IsString()
  @Transform(trim)
  @MaxLength(80, { message: "A group's name can be at most 80 characters." })
  title!: string;

  @IsArray()
  @ArrayMinSize(1, { message: 'Add at least one person to the group.' })
  @ArrayMaxSize(31, { message: 'A group can have at most 32 people.' })
  @IsUUID('all', { each: true })
  userIds!: string[];

  /** What people added later start as. */
  @IsOptional()
  @IsIn([MemberRole.MEMBER, MemberRole.SPECTATOR])
  joinRole?: MemberRole;
}

/** Renames a group, or changes what people added to it start as. */
export class UpdateGroupDto {
  @IsOptional()
  @IsString()
  @Transform(trim)
  @MaxLength(80, { message: "A group's name can be at most 80 characters." })
  title?: string;

  @IsOptional()
  @IsIn([MemberRole.MEMBER, MemberRole.SPECTATOR])
  joinRole?: MemberRole;
}

export class AddMembersDto {
  @IsArray()
  @ArrayMinSize(1)
  @ArrayMaxSize(31)
  @IsUUID('all', { each: true })
  userIds!: string[];
}

export class SetRoleDto {
  @IsEnum(MemberRole)
  role!: MemberRole;
}
