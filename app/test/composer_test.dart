import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/composer_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/services/device_cache.dart';

ComposerState state(String content, {bool isPosting = false}) => ComposerState(
      content: content,
      isPosting: isPosting,
      placeholderText: '',
    );

void main() {
  group('ComposerState', () {
    test('nothing to post until something is typed', () {
      expect(state('').canPost, isFalse);
      expect(state('   ').canPost, isFalse);
      expect(state('hello').canPost, isTrue);
    });

    test('cannot post twice over the top of one send', () {
      expect(state('hello', isPosting: true).canPost, isFalse);
    });

    test('refuses a post past the server limit', () {
      final long = 'x' * (ComposerState.maxCharacters + 1);

      expect(state(long).isOverLimit, isTrue);
      // The old screen let this through and the request came back 400.
      expect(state(long).canPost, isFalse);
    });

    test('counts characters, not code units', () {
      // An emoji is one character to a person and two code units to Dart, so
      // a length-based count charged double for it.
      expect(state('👋').charCount, 1);
      expect(state('héllo').charCount, 5);
    });

    test('progress is clamped at full', () {
      expect(state('x' * (ComposerState.maxCharacters * 2)).charProgress, 1.0);
      expect(state('').charProgress, 0.0);
    });

    test('copyWith can clear the error, and carries it otherwise', () {
      final failed = state('hi').copyWith(error: 'nope');

      expect(failed.error, 'nope');
      expect(failed.copyWith(content: 'hi there').error, 'nope');
      expect(failed.copyWith(clearError: true).error, isNull);
    });
  });

  group('PostListSource', () {
    test('two sources for the same author are the same provider key', () {
      // Riverpod families key on equality; without it every rebuild would
      // create a fresh, empty provider for the same profile.
      expect(
        PostListSource.author('u1'),
        equals(PostListSource.author('u1')),
      );
      expect(
        PostListSource.author('u1').hashCode,
        PostListSource.author('u1').hashCode,
      );
    });

    test('different authors and different lists stay apart', () {
      expect(
          PostListSource.author('u1') == PostListSource.author('u2'), isFalse);
      expect(PostListSource.liked == PostListSource.saved, isFalse);
      expect(PostListSource.recent == PostListSource.liked, isFalse);
    });
  });

  group('FeedPost', () {
    test("reads the viewer's own like and save state", () {
      final post = FeedPost.fromJson(const {
        'id': 'p1',
        'content': 'hi',
        'createdAt': '2026-01-01T00:00:00.000Z',
        'author': {'id': 'u1'},
        'likes': 3,
        'likedByViewer': true,
        'savedByViewer': false,
      });

      expect(post.likes, 3);
      expect(post.liked, isTrue);
      expect(post.saved, isFalse);
    });

    test('defaults to unliked and unsaved when the server omits them', () {
      final post = FeedPost.fromJson(const {
        'id': 'p1',
        'content': 'hi',
        'author': {'id': 'u1'},
      });

      expect(post.likes, 0);
      expect(post.liked, isFalse);
      expect(post.saved, isFalse);
    });

    test('copyWith changes only what it is given', () {
      final post = FeedPost.fromJson(const {
        'id': 'p1',
        'content': 'hi',
        'author': {'id': 'u1', 'username': 'ada'},
        'likes': 2,
      });

      final liked = post.copyWith(liked: true, likes: 3);

      expect(liked.likes, 3);
      expect(liked.liked, isTrue);
      expect(liked.saved, isFalse);
      expect(liked.content, 'hi');
      expect(liked.author.username, 'ada');
    });
  });

  group('formatBytes', () {
    test('reports bytes below a kilobyte', () {
      expect(formatBytes(0), '0 B');
      expect(formatBytes(512), '512 B');
    });

    test('steps up through the units', () {
      expect(formatBytes(2048), '2.0 KB');
      expect(formatBytes(5 * 1024 * 1024), '5.0 MB');
      expect(formatBytes(3 * 1024 * 1024 * 1024), '3.0 GB');
    });

    test('drops the decimal once it stops being informative', () {
      expect(formatBytes(64 * 1024 * 1024), '64 MB');
    });
  });
}
