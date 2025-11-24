export type User = {
    id: string;
    email?: string;
    displayName?: string;
};
export declare class IdentityService {
    private readonly logger;
    private users;
    createUser(u: Partial<User>): Promise<User>;
    findById(id: string): Promise<User | null>;
}
