import { parseCard } from './open-graph';

const base = new URL('https://example.com/article');

describe('parseCard', () => {
  it('reads Open Graph tags', () => {
    const card = parseCard(
      `<html><head>
         <meta property="og:title" content="A title">
         <meta property="og:description" content="A description">
         <meta property="og:image" content="https://cdn.example.com/a.png">
         <meta property="og:site_name" content="Example">
       </head><body></body></html>`,
      base,
    );

    expect(card).toEqual({
      title: 'A title',
      description: 'A description',
      imageUrl: 'https://cdn.example.com/a.png',
      siteName: 'Example',
    });
  });

  it('prefers Open Graph over the plain title tag', () => {
    const card = parseCard(
      `<head><title>Tab title</title>
       <meta property="og:title" content="Card title"></head>`,
      base,
    );
    expect(card.title).toBe('Card title');
  });

  it('falls back to the title tag and meta description', () => {
    const card = parseCard(
      `<head><title>Tab title</title>
       <meta name="description" content="Plain description"></head>`,
      base,
    );
    expect(card.title).toBe('Tab title');
    expect(card.description).toBe('Plain description');
  });

  it('falls back to twitter tags', () => {
    const card = parseCard(
      `<head><meta name="twitter:title" content="T"><
       meta name="twitter:image" content="/i.png"></head>`,
      base,
    );
    expect(card.title).toBe('T');
  });

  it('resolves a relative image against the page', () => {
    const card = parseCard(
      '<head><meta property="og:image" content="/img/a.png"></head>',
      base,
    );
    expect(card.imageUrl).toBe('https://example.com/img/a.png');
  });

  it('drops an image that is not http(s)', () => {
    const card = parseCard(
      '<head><meta property="og:image" content="data:image/png;base64,AAA"></head>',
      base,
    );
    expect(card.imageUrl).toBeNull();
  });

  it('decodes entities and collapses whitespace', () => {
    const card = parseCard(
      `<head><title>  Ben &amp;   Jerry&#39;s\n  shop </title></head>`,
      base,
    );
    expect(card.title).toBe("Ben & Jerry's shop");
  });

  it('survives a numeric entity that is out of range', () => {
    const card = parseCard(
      '<head><title>a &#99999999999; b</title></head>',
      base,
    );
    expect(card.title).toContain('a');
  });

  it('handles single-quoted and unquoted attributes', () => {
    const card = parseCard(
      `<head><meta property='og:title' content='Single'></head>`,
      base,
    );
    expect(card.title).toBe('Single');
  });

  it('returns nulls for a page with no metadata at all', () => {
    const card = parseCard('<html><body>hello</body></html>', base);
    expect(card).toEqual({
      title: null,
      description: null,
      imageUrl: null,
      siteName: null,
    });
  });

  it('ignores tags below the head', () => {
    const card = parseCard(
      `<head><title>Real</title></head>
       <body><meta property="og:title" content="Injected"></body>`,
      base,
    );
    expect(card.title).toBe('Real');
  });

  it('truncates a very long title rather than storing it whole', () => {
    const card = parseCard(
      `<head><title>${'a'.repeat(500)}</title></head>`,
      base,
    );
    expect(card.title!.length).toBe(300);
    expect(card.title!.endsWith('…')).toBe(true);
  });
});
