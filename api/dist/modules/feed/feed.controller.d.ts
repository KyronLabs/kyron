import { FeedService } from './feed.service';
import { CreatePostDto } from './dto/create-post.dto';
export declare class FeedController {
    private readonly svc;
    constructor(svc: FeedService);
    create(dto: CreatePostDto): Promise<import("./feed.service").Post>;
    recent(limit?: string): Promise<import("./feed.service").Post[]>;
}
