import { IsBoolean } from 'class-validator';

import { IsEmail } from 'class-validator';

import { IsOptional } from 'class-validator';

import { IsString } from 'class-validator';

export class RegisterDto {
  @IsString()
  username?: string;

  @IsEmail()
  email!: string;

  @IsString()
  password!: string;

  @IsBoolean()
  @IsOptional()
  marketing?: boolean;
}
