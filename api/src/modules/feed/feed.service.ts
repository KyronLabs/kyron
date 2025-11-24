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

  async createPost(p: Partial<Post>) {
    const post: Post = {
      id: (Math.random() * 1e9).toFixed(0),
      authorId: p.authorId || 'anon',
      content: p.content || '',
      createdAt: Date.now(),
    };
    this.posts.unshift(post);
    this.logger.log(`post created ${post.id}`);
    return post;
  }

  async listRecent(limit = 20) {
    return this.posts.slice(0, limit);
  }
}
