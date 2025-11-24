import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { IdentityService } from './identity.service';
import { CreateUserDto } from './dto/create-user.dto';

@Controller('identity')
export class IdentityController {
  constructor(private readonly svc: IdentityService) {}

  @Post('users')
  async create(@Body() dto: CreateUserDto) {
    return this.svc.createUser(dto);
  }

  @Get('users/:id')
  async get(@Param('id') id: string) {
    return this.svc.findById(id);
  }
}
