import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  IsString,
  IsUUID,
  MaxLength,
  MinLength,
  ValidateNested,
} from 'class-validator';

/** A device asking for the keys of messages it was not sealed for. */
export class RequestKeysDto {
  /** Which of the reader's installs is asking: its key is what the answers
   * are sealed for. */
  @IsString()
  @MinLength(8)
  @MaxLength(128)
  deviceId!: string;

  @IsArray()
  @ArrayMinSize(1)
  @ArrayMaxSize(100)
  @IsUUID('all', { each: true })
  messageIds!: string[];
}

export class KeyShareDto {
  /** The request being answered. */
  @IsUUID()
  id!: string;

  /** `<answering key>.<nonce>.<sealed key>.<mac>`, base64url. The service
   * checks the shape. */
  @IsString()
  @MaxLength(512)
  sealed!: string;
}

/** A device answering requests it can open the messages of. */
export class ShareKeysDto {
  @IsArray()
  @ArrayMinSize(1)
  @ArrayMaxSize(100)
  @ValidateNested({ each: true })
  @Type(() => KeyShareDto)
  shares!: KeyShareDto[];
}
