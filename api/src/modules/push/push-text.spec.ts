import { CATALOGS } from './copy';
import { en } from './copy/en';
import { catalogFor, render, say } from './push-text';

/**
 * Kyron's own words in a push, in the language of the phone it goes to.
 */
describe('saying a push', () => {
  it("says people's own words as they wrote them", () => {
    expect(render('Gardeners · Lagos', 'fr')).toBe('Gardeners · Lagos');
  });

  it("says Kyron's words in the phone's language", () => {
    expect(render(say('followed'), 'fr')).toBe('Vous suit');
    expect(render(say('followed'), 'de')).toBe('Folgt dir jetzt');
    expect(render(say('followed'), 'en')).toBe('Followed you');
  });

  it('fills in what was said, in the same language all the way down', () => {
    expect(
      render(say('named_line', { name: 'Ada', text: say('chat_photo') }), 'es'),
    ).toBe('Ada: Foto');
    expect(
      render(say('liked_quote', { snippet: 'Kingfisher at dawn' }), 'fr'),
    ).toBe('A aimé votre publication : « Kingfisher at dawn »');
  });

  it('says sentences one after another, without empty ones', () => {
    expect(render([say('mod_removed_post'), '', say('mod_warned')], 'en')).toBe(
      'Your post was removed. Your account has a warning.',
    );
    // Chinese and Japanese put no space between sentences.
    expect(render([say('mod_removed_post'), say('mod_warned')], 'zh')).toBe(
      '你的帖子已被移除。你的账号收到了一次警告。',
    );
  });

  it('writes a date and a count the way the language does', () => {
    const at = new Date('2026-10-26T23:30:00Z');
    expect(render(say('mod_suspended_until', { date: at }), 'en')).toBe(
      'Your account is suspended until Oct 26, 2026.',
    );
    expect(render(say('mod_suspended_until', { date: at }), 'de')).toBe(
      'Dein Konto ist bis 26.10.2026 gesperrt.',
    );
    expect(render(say('and_others', { name: 'Ada', count: 1200 }), 'en')).toBe(
      'Ada and 1,200 others',
    );
  });
});

describe('which language', () => {
  it.each([
    ['fr', 'fr'],
    ['pt-BR', 'pt'],
    ['zh_Hant', 'zh'],
    ['EN-gb', 'en'],
    ['iw', 'he'],
    ['nn', 'nb'],
    ['fil', 'tl'],
  ])('%s is %s', (locale, tag) => {
    expect(catalogFor(locale).tag).toBe(tag);
  });

  it.each([null, undefined, '', 'xx', 'klingon'])(
    'anything else (%s) is English',
    (locale) => {
      expect(catalogFor(locale).tag).toBe('en');
    },
  );
});

describe('every catalog', () => {
  const placeholders = (text: string) =>
    [...text.matchAll(/\{(\w+)\}/g)].map((m) => m[1]).sort();

  it('is every language the app is in', () => {
    // The app's 69 catalogs, English among them.
    expect(Object.keys(CATALOGS)).toHaveLength(69);
  });

  it.each(Object.entries(CATALOGS))(
    '%s keeps every placeholder English has, and leaves nothing empty',
    (_, copy) => {
      for (const key of Object.keys(en) as (keyof typeof en)[]) {
        expect([key, placeholders(copy[key])]).toEqual([
          key,
          placeholders(en[key]),
        ]);
        expect(copy[key].trim()).not.toBe('');
      }
    },
  );
});
