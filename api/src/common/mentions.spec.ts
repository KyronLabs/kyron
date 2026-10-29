import { MAX_MENTIONS, mentionedHandles } from './mentions';

describe('mentionedHandles', () => {
  it('finds each handle once, lower-cased, in order', () => {
    expect(mentionedHandles('@Ada and @bob_1, then @ADA again')).toEqual([
      'ada',
      'bob_1',
    ]);
  });

  it('is not fooled by an email address or a double @', () => {
    // The same rule the app draws mentions with: what it does not show as
    // a link is not a mention.
    expect(mentionedHandles('mail ada@example.com or @@bob')).toEqual([]);
  });

  it('skips what cannot be a handle', () => {
    expect(mentionedHandles('@a is too short')).toEqual([]);
  });

  it(`stops at ${MAX_MENTIONS}`, () => {
    const many = Array.from({ length: 30 }, (_, i) => `@user${i}`).join(' ');
    expect(mentionedHandles(many)).toHaveLength(MAX_MENTIONS);
  });
});
