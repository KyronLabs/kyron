import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import * as argon2 from 'argon2';

@Injectable()
export class AuthService {
  constructor(private users: UsersService, private jwt: JwtService) {}

  async validatePassword(email: string, pass: string) {
    const user = await this.users.findByEmail(email);
    if (!user) return null;
    const ok = await argon2.verify(user.password, pass);
    if (!ok) return null;
    return user;
  }

  async login(user: any) {
    const payload = { sub: user.id, role: user.role };
    return {
      access_token: this.jwt.sign(payload),
      token_type: 'Bearer',
      expires_in: Number(process.env.JWT_EXPIRES_SECONDS || 900),
    };
  }
}
