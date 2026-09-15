import {
  IsEnum,
  IsOptional,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';

/** What somebody is telling us. Two kinds, because they are two labels. */
export enum FeedbackKind {
  Bug = 'BUG',
  Idea = 'IDEA',
}

export class SendFeedbackDto {
  @IsEnum(FeedbackKind, {
    message: 'Feedback is either a BUG or an IDEA.',
  })
  kind!: FeedbackKind;

  @IsString()
  @MinLength(3, { message: 'Give it a title.' })
  @MaxLength(120, { message: 'A title cannot exceed 120 characters.' })
  title!: string;

  @IsString()
  @MinLength(10, {
    message: 'Say a little more -- at least ten characters.',
  })
  @MaxLength(4000, { message: 'Feedback cannot exceed 4000 characters.' })
  body!: string;

  /**
   * The build it came from, so a report can be tied to a version without
   * asking the reader what they are running.
   */
  @IsOptional()
  @IsString()
  @MaxLength(40)
  appVersion?: string;

  @IsOptional()
  @IsString()
  @MaxLength(40)
  platform?: string;
}
