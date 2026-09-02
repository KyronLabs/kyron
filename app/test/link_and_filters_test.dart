import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/link_preview.dart';
import 'package:kyron_app/providers/search_provider.dart';
import 'package:kyron_app/widgets/create_post/url_preview.dart';
import 'package:kyron_app/widgets/search_filter_sheet.dart';

FeedPost _post(String content) => FeedPost(
      id: 'p1',
      content: content,
      createdAt: DateTime(2026, 1, 1),
      author: const FeedAuthor(id: 'a1'),
    );

void main() {
  group('firstLinkIn', () {
    test('finds a plain https link', () {
      expect(
        firstLinkIn('look at https://example.com/a please'),
        'https://example.com/a',
      );
    });

    test('finds the first of several', () {
      expect(
        firstLinkIn('https://one.example.com and https://two.example.com'),
        'https://one.example.com',
      );
    });

    test('leaves the sentence out of the address', () {
      expect(
        firstLinkIn('see https://example.com/page.'),
        'https://example.com/page',
      );
      expect(
        firstLinkIn('(https://example.com/page)'),
        'https://example.com/page',
      );
    });

    test('finds a bare host and assumes https', () {
      // What someone actually types. Requiring the scheme is requiring them to
      // think about something nobody thinks about.
      expect(firstLinkIn('see m.facebook.com'), 'https://m.facebook.com');
      expect(firstLinkIn('example.com'), 'https://example.com');
      expect(
        firstLinkIn('go to example.co.uk/help now'),
        'https://example.co.uk/help',
      );
    });

    test('does not conjure a link out of ordinary prose', () {
      // Each of these is a full stop between two things that are not a host.
      expect(firstLinkIn('it is 1.5 times bigger'), isNull);
      expect(firstLinkIn('e.g. this one'), isNull);
      expect(firstLinkIn('i.e. that one'), isNull);
      expect(firstLinkIn('and so on, etc. next'), isNull);
      expect(firstLinkIn('at 8.30 tomorrow'), isNull);
      expect(firstLinkIn('version 2.1 shipped'), isNull);
    });

    test('does not treat an email address as a host', () {
      expect(firstLinkIn('write to me@example.com'), isNull);
    });

    test('prefers whichever link comes first in the text', () {
      expect(
        firstLinkIn('example.com then https://other.example.com'),
        'https://example.com',
      );
      expect(
        firstLinkIn('https://other.example.com then example.com'),
        'https://other.example.com',
      );
    });

    test('ignores a scheme the server will not fetch', () {
      // ftp:// has no host the bare matcher can pick up either, because the
      // "//" is not a word boundary it accepts.
      expect(firstLinkIn('file:///etc/passwd'), isNull);
    });

    test('finds nothing in text with no link', () {
      expect(firstLinkIn('just some words'), isNull);
      expect(firstLinkIn(''), isNull);
    });
  });

  group('FeedPost.firstLink', () {
    test('agrees with the composer about what counts as a link', () {
      const text = 'read https://example.com/x, it is good';
      expect(_post(text).firstLink, firstLinkIn(text));
    });

    test('is null for a post with no link', () {
      expect(_post('nothing here').firstLink, isNull);
    });
  });

  group('LinkPreview', () {
    test('prefers the site name over the host', () {
      const preview = LinkPreview(
        url: 'https://www.example.com/a',
        host: 'www.example.com',
        siteName: 'Example',
        title: 'A',
      );
      expect(preview.label, 'Example');
    });

    test('falls back to the host, without www', () {
      const preview = LinkPreview(
        url: 'https://www.example.com/a',
        host: 'www.example.com',
        title: 'A',
      );
      expect(preview.label, 'example.com');
    });

    test('a card with neither a title nor a picture is not worth drawing', () {
      const empty = LinkPreview(url: 'https://e.com', host: 'e.com');
      expect(empty.isRenderable, isFalse);

      const titled =
          LinkPreview(url: 'https://e.com', host: 'e.com', title: 'A');
      expect(titled.isRenderable, isTrue);

      const pictured = LinkPreview(
        url: 'https://e.com',
        host: 'e.com',
        imageUrl: 'https://e.com/i.png',
      );
      expect(pictured.isRenderable, isTrue);
    });

    test('treats a blank string from the server as absent', () {
      final preview = LinkPreview.fromJson({
        'url': 'https://e.com',
        'host': 'e.com',
        'title': '   ',
      });
      expect(preview.title, isNull);
      expect(preview.isRenderable, isFalse);
    });
  });

  group('SearchFilters', () {
    test('a fresh set is empty and counts nothing', () {
      const filters = SearchFilters();
      expect(filters.isEmpty, isTrue);
      expect(filters.count, 0);
      expect(describeFilters(filters), isEmpty);
    });

    test('counts what is actually set', () {
      final filters = SearchFilters(
        from: 'epigone',
        after: DateTime(2026, 3, 4),
        has: 'video',
      );
      expect(filters.count, 3);
      expect(filters.isEmpty, isFalse);
    });

    test('describes each filter the way it reads on a chip', () {
      final filters = SearchFilters(
        from: 'epigone',
        after: DateTime(2026, 3, 4),
        before: DateTime(2026, 12, 25),
        has: 'video',
      );
      expect(describeFilters(filters), [
        'from @epigone',
        'after 4 Mar 2026',
        'before 25 Dec 2026',
        'has video',
      ]);
    });

    test('clears a field rather than treating null as "leave it alone"', () {
      final filters = SearchFilters(from: 'a', after: DateTime(2026, 1, 1));
      expect(filters.copyWith().from, 'a', reason: 'null means unchanged');
      expect(filters.copyWith(clearFrom: true).from, isNull);
      expect(filters.copyWith(clearFrom: true).after, isNotNull);
    });

    test('compares by value, so an unchanged set does not look like a change',
        () {
      expect(
        SearchFilters(from: 'a', after: DateTime(2026, 1, 1)),
        SearchFilters(from: 'a', after: DateTime(2026, 1, 1)),
      );
      expect(
        const SearchFilters(from: 'a'),
        isNot(const SearchFilters(from: 'b')),
      );
    });
  });

  group('SearchState', () {
    test('people search is idle until something is typed', () {
      const state = SearchState();
      expect(state.isIdle, isTrue);

      expect(const SearchState(query: 'a').isTooShort, isTrue);
      expect(const SearchState(query: 'ab').isTooShort, isFalse);
    });

    test('a post search with an account filter runs without words', () {
      // "everything from @epigone in March" is a complete query.
      const state = SearchState(
        mode: SearchMode.posts,
        filters: SearchFilters(from: 'epigone'),
      );
      expect(state.isIdle, isFalse);
      expect(state.isTooShort, isFalse);
    });

    test('a post search with no account filter still needs words', () {
      const state = SearchState(mode: SearchMode.posts, query: 'a');
      expect(state.isTooShort, isTrue);
    });

    test('found-nothing looks at the list the current mode uses', () {
      const people = SearchState(query: 'zz');
      expect(people.foundNothing, isTrue);

      final posts = SearchState(
        mode: SearchMode.posts,
        query: 'zz',
        posts: [_post('hello')],
      );
      expect(posts.foundNothing, isFalse);
    });
  });
}
