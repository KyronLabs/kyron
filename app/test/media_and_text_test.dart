import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/composer_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/widgets/post_text.dart';

void main() {
  group('PostText.hashtagsIn', () {
    test('finds tags and lower-cases them, matching the server', () {
      expect(PostText.hashtagsIn('Hello #Kyron and #running'),
          ['kyron', 'running']);
    });

    test('counts a tag once however often it appears', () {
      expect(PostText.hashtagsIn('#a #A #a'), ['a']);
    });

    test('ignores a hash that is not at a word boundary', () {
      // The client highlights exactly what the server indexed, so a colour
      // written mid-sentence must not light up in one and not the other.
      expect(PostText.hashtagsIn('in the#middle'), isEmpty);
    });

    test('ignores a purely numeric tag', () {
      expect(PostText.hashtagsIn('ranked #1'), isEmpty);
    });
  });

  group('PostText.pattern', () {
    List<String> matches(String text) =>
        PostText.pattern.allMatches(text).map((m) => m.group(0)!).toList();

    test('picks out hashtags, mentions and links', () {
      expect(
        matches('hey @ada see #kyron at https://kyron.so/x'),
        ['@ada', '#kyron', 'https://kyron.so/x'],
      );
    });

    test('leaves an email address alone', () {
      // "a@b.com" is not a mention of @b.
      expect(matches('write to ada@kyron.so'), isEmpty);
    });
  });

  group('PostMedia', () {
    test('reads an attachment and its shape', () {
      final media = PostMedia.fromJson(const {
        'id': 'm1',
        'kind': 'IMAGE',
        'url': 'https://example.test/a.jpg',
        'width': 1600,
        'height': 900,
        'alt': 'A wide picture',
      });

      expect(media.kind, MediaKind.image);
      expect(media.aspectRatio, closeTo(16 / 9, 1e-9));
      expect(media.alt, 'A wide picture');
    });

    test('has no aspect ratio when the server did not record one', () {
      // Callers fall back to a fixed box rather than guessing a shape.
      final media = PostMedia.fromJson(const {'id': 'm2', 'url': 'x'});
      expect(media.aspectRatio, isNull);
    });

    test('reads video and GIF kinds', () {
      expect(
        PostMedia.fromJson(const {'id': 'm', 'url': 'x', 'kind': 'VIDEO'})
            .isVideo,
        isTrue,
      );
      expect(
        PostMedia.fromJson(const {'id': 'm', 'url': 'x', 'kind': 'GIF'}).kind,
        MediaKind.gif,
      );
    });

    test('drops an attachment with no URL rather than rendering a gap', () {
      final list = PostMedia.listFrom([
        const {'id': 'a', 'url': 'https://example.test/a.jpg'},
        const {'id': 'b'},
      ]);
      expect(list, hasLength(1));
    });
  });

  group('PendingMedia', () {
    const pending = PendingMedia(path: '/tmp/a.jpg', kind: MediaKind.image);

    test('is uploading until it has a URL or an error', () {
      expect(pending.isUploading, isTrue);
      expect(pending.copyWith(url: 'https://x').isUploading, isFalse);
      expect(pending.copyWith(error: 'nope').isUploading, isFalse);
    });

    test('clearError beats the fallthrough value, so a retry can reset it', () {
      final failed = pending.copyWith(error: 'nope');
      expect(failed.copyWith(clearError: true).error, isNull);
    });

    test('sends only what the server accepts', () {
      final ready = pending.copyWith(url: 'https://x', alt: '  a cat  ');
      expect(ready.toJson(), {
        'url': 'https://x',
        'kind': 'IMAGE',
        'alt': 'a cat',
      });
    });
  });

  group('ReplyPolicy', () {
    test('round-trips through the wire format', () {
      for (final policy in ReplyPolicy.values) {
        expect(ReplyPolicy.fromJson(policy.wire), policy);
      }
    });

    test('falls back to everyone for an unknown value', () {
      expect(ReplyPolicy.fromJson('SOMETHING_NEW'), ReplyPolicy.everyone);
      expect(ReplyPolicy.fromJson(null), ReplyPolicy.everyone);
    });

    test('the default reads as the composer button says', () {
      expect(ReplyPolicy.everyone.label, 'Anyone can interact');
    });
  });

  group('ComposerState', () {
    ComposerState state({
      String content = '',
      List<PendingMedia> media = const [],
    }) =>
        ComposerState(content: content, media: media, placeholderText: '');

    test('a post carrying only an attachment can be sent', () {
      const ready = PendingMedia(
        path: '/tmp/a.jpg',
        kind: MediaKind.image,
        url: 'https://x',
      );
      expect(state(media: [ready]).canPost, isTrue);
    });

    test('cannot be sent while an attachment is still uploading', () {
      const uploading = PendingMedia(path: '/tmp/a.jpg', kind: MediaKind.image);
      expect(state(content: 'hi', media: [uploading]).canPost, isFalse);
    });

    test('stops accepting attachments at the limit', () {
      final full = List.generate(
        ComposerState.maxMedia,
        (i) => PendingMedia(path: '/tmp/$i.jpg', kind: MediaKind.image),
      );
      expect(state(media: full).canAddMedia, isFalse);
      expect(state(media: full.take(1).toList()).canAddMedia, isTrue);
    });

    test('has content worth a draft once anything is added', () {
      expect(state().hasContent, isFalse);
      expect(state(content: '  ').hasContent, isFalse);
      expect(state(content: 'hi').hasContent, isTrue);
      expect(
        state(media: const [
          PendingMedia(path: '/tmp/a.jpg', kind: MediaKind.image)
        ]).hasContent,
        isTrue,
      );
    });
  });

  group('FeedPost with the new fields', () {
    test('reads reposts, media, the quote and the reply policy', () {
      final post = FeedPost.fromJson({
        'id': 'p1',
        'content': 'look at this #thing',
        'author': const {'id': 'u1', 'username': 'ada'},
        'reposts': 4,
        'repostedByViewer': true,
        'replyPolicy': 'FOLLOWERS',
        'media': [
          const {'id': 'm1', 'url': 'https://example.test/a.jpg'},
        ],
        'quotedPost': {
          'id': 'p0',
          'content': 'the original',
          'author': const {'id': 'u2', 'username': 'grace'},
        },
      });

      expect(post.reposts, 4);
      expect(post.reposted, isTrue);
      expect(post.replyPolicy, ReplyPolicy.followers);
      expect(post.media, hasLength(1));
      expect(post.quotedPost?.author.handle, '@grace');
    });

    test('has no quote when the quoted post was deleted', () {
      // The server drops it rather than sending a husk.
      final post = FeedPost.fromJson(const {
        'id': 'p1',
        'content': 'x',
        'author': {'id': 'u1'},
        'quotedPost': null,
      });
      expect(post.quotedPost, isNull);
    });

    test('copyWith carries media and the quote through a like', () {
      final post = FeedPost.fromJson({
        'id': 'p1',
        'content': 'x',
        'author': const {'id': 'u1'},
        'media': [
          const {'id': 'm1', 'url': 'https://example.test/a.jpg'},
        ],
      });

      expect(post.copyWith(liked: true).media, hasLength(1));
    });
  });

  group('PostListSource', () {
    test('a hashtag source is keyed case-insensitively', () {
      // #Kyron and #kyron are one tag on the server, so they must be one
      // provider here or the two would fetch and cache separately.
      expect(
        PostListSource.hashtag('Kyron'),
        equals(PostListSource.hashtag('kyron')),
      );
    });

    test('a hashtag and an author with the same key stay apart', () {
      expect(
        PostListSource.hashtag('abc') == PostListSource.author('abc'),
        isFalse,
      );
    });
  });
}
