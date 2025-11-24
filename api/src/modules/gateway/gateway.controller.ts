import { Controller, Get } from '@nestjs/common';

@Controller()
export class GatewayController {
  @Get()
  root() {
    return { service: 'kyron-api', version: '0.1.0' };
  }
}
