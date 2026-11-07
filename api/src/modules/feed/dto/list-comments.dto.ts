import { Transform } from 'class-transformer';
import { IsIn, IsInt, IsOptional, Matches, Max, Min } from 'class-validator';

/** How a post's comments are ordered. */
export const COMMENT_SORTS = ['top', 'recent'] as const;
export type CommentSort = (typeof COMMENT_SORTS)[number];

/**
 * A page of a post's comments, in the order the reader chose.
 *
 * Recent pages by the last comment's id, as every time-ordered list does.
 * Top cannot: its order moves as people like things, so an id names a
 * place that may have moved by the next page. Its cursor is a position --
 * `t<offset>` -- and a like landing between two pages can at worst show one
 * comment twice or skip one, which is what every ranked list accepts.
 */
export class ListCommentsDto {
  @IsOptional()
  @Matches(
    /^(?:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|t\d{1,7})$/i,
    { message: 'cursor must come from a previous page.' },
  )
  cursor?: string;

  @IsOptional()
  @Transform(({ value }) => Number(value))
  @IsInt({ message: 'limit must be a whole number.' })
  @Min(1)
  @Max(50)
  limit?: number;

  /** Top unless asked otherwise: the comments people found worth liking. */
  @IsOptional()
  @IsIn(COMMENT_SORTS, { message: 'sort must be top or recent.' })
  sort?: CommentSort;
}
