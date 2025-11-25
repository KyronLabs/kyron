import { IsBoolean, IsEmail, IsOptional, IsString } from 'class-validator';

export class RegisterDto {
  @IsString()
  @IsOptional()
  username?: string;

  @IsEmail()
  email!: string;

  @IsString()
  password!: string;

  @IsBoolean()
  @IsOptional()
  marketing?: boolean;
}
