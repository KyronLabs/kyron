export type Post = {
    id: string;
    authorId: string;
    content: string;
    createdAt: number;
};
export declare class FeedService {
    private readonly logger;
    private posts;
    createPost(p: Partial<Post>): Promise<Post>;
    listRecent(limit?: number): Promise<Post[]>;
}
