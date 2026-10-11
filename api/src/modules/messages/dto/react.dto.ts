import { IsString, MaxLength } from 'class-validator';

export class ReactDto {
  /**
   * The emoji. That it is exactly one emoji is the service's check, not a
   * decorator's -- counting what a reader sees as one character takes
   * grapheme segmentation, and the rule should live in one place.
   */
  @IsString()
  @MaxLength(32)
  emoji!: string;
}
