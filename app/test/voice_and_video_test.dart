import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/widgets/inline_video.dart';

PostMedia _media({
  MediaKind kind = MediaKind.video,
  int? width,
  int? height,
}) =>
    PostMedia(
      id: 'm1',
      kind: kind,
      url: 'https://example.com/a',
      width: width,
      height: height,
    );

void main() {
  group('SizedInlineVideo.ratioFor', () {
    test('uses the clip\'s own shape', () {
      // A 9:16 phone recording stays portrait rather than being poured into a
      // landscape box and letterboxed, which is what it used to do.
      expect(
        SizedInlineVideo.ratioFor(_media(width: 1080, height: 1920)),
        closeTo(0.5625, 0.0001),
      );
      expect(
        SizedInlineVideo.ratioFor(_media(width: 1920, height: 1080)),
        closeTo(1.7778, 0.0001),
      );
      expect(
        SizedInlineVideo.ratioFor(_media(width: 1000, height: 1000)),
        1.0,
      );
    });

    test('assumes portrait when the upload recorded no dimensions', () {
      expect(SizedInlineVideo.ratioFor(_media()), 0.75);
      expect(SizedInlineVideo.ratioFor(_media(width: 100)), 0.75);
      expect(SizedInlineVideo.ratioFor(_media(height: 100)), 0.75);
    });

    test('ignores dimensions that cannot be real', () {
      expect(SizedInlineVideo.ratioFor(_media(width: 0, height: 100)), 0.75);
      expect(SizedInlineVideo.ratioFor(_media(width: -5, height: 100)), 0.75);
    });

    test('bounds an absurd shape rather than drawing it', () {
      // Without the clamp these are a post one pixel tall and a post three
      // screens high.
      expect(
        SizedInlineVideo.ratioFor(_media(width: 10000, height: 1)),
        SizedInlineVideo.maxRatio,
      );
      expect(
        SizedInlineVideo.ratioFor(_media(width: 1, height: 10000)),
        SizedInlineVideo.minRatio,
      );
    });
  });

  group('PostMedia', () {
    test('reads a voice recording off the wire', () {
      final media = PostMedia.fromJson({
        'id': 'v1',
        'kind': 'VOICE',
        'url': 'https://example.com/a.m4a',
        'durationMs': 65000,
        'waveform': [0, 50, 100],
      });

      expect(media.kind, MediaKind.voice);
      expect(media.isVoice, isTrue);
      expect(media.isVisual, isFalse);
      expect(media.duration, const Duration(seconds: 65));
      expect(media.waveform, [0, 50, 100]);
    });

    test('clamps waveform values into the range a bar can be drawn at', () {
      final media = PostMedia.fromJson({
        'id': 'v1',
        'kind': 'VOICE',
        'url': 'https://example.com/a.m4a',
        'waveform': [-20, 40, 300],
      });
      expect(media.waveform, [0, 40, 100]);
    });

    test('a post without a recording has no duration or waveform', () {
      final media = PostMedia.fromJson({
        'id': 'i1',
        'kind': 'IMAGE',
        'url': 'https://example.com/a.png',
      });
      expect(media.duration, isNull);
      expect(media.waveform, isEmpty);
      expect(media.isVoice, isFalse);
      expect(media.isVisual, isTrue);
    });

    test('everything but a recording counts as visual', () {
      for (final kind in [MediaKind.image, MediaKind.video, MediaKind.gif]) {
        expect(_media(kind: kind).isVisual, isTrue, reason: '$kind');
      }
      expect(_media(kind: MediaKind.voice).isVisual, isFalse);
    });
  });

  group('PendingMedia', () {
    test('carries the recording through the upload round trip', () {
      const recording = PendingMedia(
        path: '/tmp/a.m4a',
        kind: MediaKind.voice,
        duration: Duration(seconds: 12),
        waveform: [10, 20, 30],
      );

      // copyWith is what the upload calls when it comes back with a URL. If it
      // dropped these the post would carry a recording with no waveform.
      final uploaded = recording.copyWith(url: 'https://example.com/a.m4a');
      expect(uploaded.duration, const Duration(seconds: 12));
      expect(uploaded.waveform, [10, 20, 30]);
      expect(uploaded.isVoice, isTrue);
      expect(uploaded.isReady, isTrue);
    });

    test('sends the duration and waveform when creating the post', () {
      const recording = PendingMedia(
        path: '/tmp/a.m4a',
        kind: MediaKind.voice,
        url: 'https://example.com/a.m4a',
        duration: Duration(seconds: 12),
        waveform: [10, 20],
      );

      expect(recording.toJson(), {
        'url': 'https://example.com/a.m4a',
        'kind': 'VOICE',
        'durationMs': 12000,
        'waveform': [10, 20],
      });
    });

    test('a picture sends neither', () {
      const picture = PendingMedia(
        path: '/tmp/a.png',
        kind: MediaKind.image,
        url: 'https://example.com/a.png',
        width: 100,
        height: 200,
      );

      final json = picture.toJson();
      expect(json.containsKey('durationMs'), isFalse);
      expect(json.containsKey('waveform'), isFalse);
    });
  });
}
