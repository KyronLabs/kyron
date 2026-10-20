import { IsString, MaxLength } from 'class-validator';

/**
 * A handle, as typed. The format is checked by the service against the one
 * rule in common/handles.ts, so the reason given is the same wherever a
 * handle comes from; this only keeps an absurd body from reaching it.
 */
export class ChooseHandleDto {
  @IsString()
  @MaxLength(64)
  handle!: string;
}
