import { IsString, Matches, MaxLength } from 'class-validator';

export class ClaimDidDto {
  /**
   * The identifier being claimed.
   *
   * Shape-checked here and meaning-checked in the service, which decodes it
   * and verifies a signature against the key inside. This only keeps
   * obviously-wrong input out of that.
   */
  @IsString()
  @MaxLength(200)
  @Matches(/^did:key:z[1-9A-HJ-NP-Za-km-z]+$/, {
    message: 'did must be a did:key identifier.',
  })
  did!: string;

  /** Ed25519 signature over the challenge, base64url. 64 bytes is 86 chars. */
  @IsString()
  @MaxLength(200)
  @Matches(/^[A-Za-z0-9_-]+$/, {
    message: 'signature must be base64url.',
  })
  signature!: string;
}
