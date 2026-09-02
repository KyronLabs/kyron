import { IsUUID } from 'class-validator';

export class VotePollDto {
  /**
   * The answer being voted for. Checked against the poll's own options in the
   * service, so an id belonging to a different poll cannot be voted into this
   * one just by being a valid uuid.
   */
  @IsUUID('4', { message: 'optionId must be one of the poll answers.' })
  optionId!: string;
}
