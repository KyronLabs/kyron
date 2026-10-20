import { ArrayMaxSize, ArrayMinSize, IsArray, IsUUID } from 'class-validator';

export class RecordImpressionsDto {
  /**
   * Posts that have just been on the reader's screen in a feed, long enough
   * to count as shown. Sent in batches as the reader scrolls; a page is
   * twenty, so fifty is room for a fast scroll without letting one request
   * write an unbounded number of rows.
   */
  @IsArray()
  @ArrayMinSize(1)
  @ArrayMaxSize(50)
  @IsUUID('all', { each: true, message: 'Every post id must be a UUID.' })
  postIds!: string[];
}
