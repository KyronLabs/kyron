import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import { UpdateProfileDto } from './update-profile.dto';

describe('UpdateProfileDto country', () => {
  const errors = async (country: unknown) =>
    (await validate(plainToInstance(UpdateProfileDto, { country }))).length;

  it('takes a code from the list', async () => {
    expect(await errors('NG')).toBe(0);
    expect(await errors('XK')).toBe(0);
  });

  it('takes null, which clears it', async () => {
    expect(await errors(null)).toBe(0);
  });

  it('refuses anything typed', async () => {
    expect(await errors('Nigeria')).toBe(1);
    expect(await errors('ng')).toBe(1);
    expect(await errors('EU')).toBe(1);
  });
});
