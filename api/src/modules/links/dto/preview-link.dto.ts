import { IsString, MaxLength, MinLength } from 'class-validator';

export class PreviewLinkDto {
  /**
   * Bounded before it is parsed. A URL is validated properly in the service,
   * which is where the SSRF rules live; this only stops an unbounded string
   * reaching it.
   */
  @IsString()
  @MinLength(4)
  @MaxLength(2048)
  url!: string;
}
