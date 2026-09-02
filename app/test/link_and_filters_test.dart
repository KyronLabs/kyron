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

    test('does not invent a link from a bare domain', () {
      // The old detector guessed at these, so "e.g." and "1.5" conjured cards
      // for sites nobody meant to link.
      expect(firstLinkIn('e.g. this is 1.5 times example.com'), isNull);
    });

    test('ignores a scheme the server will not fetch', () {
      expect(firstLinkIn('ftp://example.com/a'), isNull);
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
