import {
  IsEnum,
  IsOptional,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';

/** What somebody is telling us. */
export enum FeedbackKind {
  Bug = 'BUG',
  Idea = 'IDEA',
  /** Somebody asking for help: Contact support writes one of these. */
  Question = 'QUESTION',
  /** An error report from About, usually carrying the app's log. */
  Report = 'REPORT',
}

export class SendFeedbackDto {
  @IsEnum(FeedbackKind, {
    message: 'Feedback is a BUG, an IDEA, a QUESTION or a REPORT.',
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

  /**
   * The app's own log, attached to an error report when its sender chose
   * to. The app trims it to its tail before sending.
   */
  @IsOptional()
  @IsString()
  @MaxLength(20000, { message: 'The attached log is too long.' })
  log?: string;
}
