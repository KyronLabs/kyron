import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/widgets/post_actions_row.dart';

FeedPost _post(String id) => FeedPost(
      id: id,
      content: 'post $id',
      createdAt: DateTime(2026, 1, 1),
      author: const FeedAuthor(id: 'a1'),
    );

void main() {
  group('countLabel', () {
    test('says one of a thing without an s', () {
      // "1 likes" is the kind of thing that makes an app look unfinished.
      expect(countLabel(1, 'like'), '1 like');
      expect(countLabel(1, 'repost'), '1 repost');
    });

    test('pluralises everything else', () {
      expect(countLabel(0, 'like'), '0 likes');
      expect(countLabel(2, 'like'), '2 likes');
      expect(countLabel(12, 'repost'), '12 reposts');
    });

    test('takes an irregular plural', () {
      expect(countLabel(1, 'reply', plural: 'replies'), '1 reply');
      expect(countLabel(4, 'reply', plural: 'replies'), '4 replies');
    });

    test('shortens a big number but keeps the word', () {
      expect(countLabel(1200, 'like'), '1.2K likes');
      expect(countLabel(2000000, 'reply', plural: 'replies'), '2M replies');
    });
  });

  group('dedupePosts', () {
    test('leaves a list with no repeats alone', () {
      final posts = [_post('a'), _post('b'), _post('c')];
      expect(dedupePosts(posts).map((p) => p.id), ['a', 'b', 'c']);
    });

    test('keeps the first of a repeat', () {
      // A post written here is put at the top of the list, and a refresh that
      // lands afterwards returns it again. Two cards for one post is wrong on
      // its own, and two widgets sharing a key is a list that will not build.
      final first = _post('a');
      final again = FeedPost(
        id: 'a',
        content: 'the same post, fetched again',
        createdAt: DateTime(2026, 1, 1),
        author: const FeedAuthor(id: 'a1'),
      );

      final out = dedupePosts([first, _post('b'), again]);
      expect(out.map((p) => p.id), ['a', 'b']);
      expect(out.first.content, 'post a');
    });

    test('handles an empty list', () {
      expect(dedupePosts(const []), isEmpty);
    });

    test('every id in the result is unique', () {
      final posts = [
        for (var i = 0; i < 40; i++) _post('p${i % 7}'),
      ];
      final ids = dedupePosts(posts).map((p) => p.id).toList();
      expect(ids.toSet().length, ids.length);
      expect(ids.length, 7);
    });
  });
}
