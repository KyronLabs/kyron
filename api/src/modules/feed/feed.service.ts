import { Injectable, Logger } from '@nestjs/common';

export type Post = {
  id: string;
  authorId: string;
  content: string;
  createdAt: number;
};

@Injectable()
export class FeedService {
  private readonly logger = new Logger(FeedService.name);
  private posts: Post[] = [];

  createPost(p: Partial<Post>): Promise<Post> {
    const post: Post = {
      id: (Math.random() * 1e9).toFixed(0),
      authorId: p.authorId || 'anon',
      content: p.content || '',
      createdAt: Date.now(),
    };
    this.posts.unshift(post);
    this.logger.log(`post created ${post.id}`);
    return Promise.resolve(post);
  }

  listRecent(limit = 20): Promise<Post[]> {
    return Promise.resolve(this.posts.slice(0, limit));
  }
}
