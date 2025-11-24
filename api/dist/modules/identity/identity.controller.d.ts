import { IdentityService } from './identity.service';
import { CreateUserDto } from './dto/create-user.dto';
export declare class IdentityController {
    private readonly svc;
    constructor(svc: IdentityService);
    create(dto: CreateUserDto): Promise<import("./identity.service").User>;
    get(id: string): Promise<import("./identity.service").User | null>;
}
