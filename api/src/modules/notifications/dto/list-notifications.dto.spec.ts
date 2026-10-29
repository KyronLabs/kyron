import { plainToInstance } from 'class-transformer';
import { validateSync } from 'class-validator';

import { ListNotificationsDto } from './list-notifications.dto';

/** The query string as the ValidationPipe sees it. */
function parse(query: Record<string, string>) {
  const dto = plainToInstance(ListNotificationsDto, query);
  return { dto, errors: validateSync(dto) };
}

describe('include', () => {
  it('still takes the one value every app in the wild sends', () => {
    const { dto, errors } = parse({ include: 'moderation' });
    expect(errors).toHaveLength(0);
    expect(dto.include).toEqual(['moderation']);
  });

  it('takes several, comma-separated', () => {
    const { dto, errors } = parse({ include: 'moderation, gifts' });
    expect(errors).toHaveLength(0);
    expect(dto.include).toEqual(['moderation', 'gifts']);
  });

  it('refuses anything else', () => {
    expect(parse({ include: 'moderation,everything' }).errors).toHaveLength(1);
  });

  it('is optional', () => {
    expect(parse({}).errors).toHaveLength(0);
  });
});
