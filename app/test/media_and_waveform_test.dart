import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/widgets/media_tile_grid.dart';
import 'package:kyron_app/widgets/voice_waveform.dart';

void main() {
  group('PostMedia.thumbnailUrl', () {
    test('reads the still off the wire', () {
      final media = PostMedia.fromJson({
        'id': 'v1',
        'kind': 'VIDEO',
        'url': 'https://example.com/a.mp4',
        'thumbnailUrl': 'https://example.com/a.jpg',
      });
      expect(media.thumbnailUrl, 'https://example.com/a.jpg');
    });

    test('a blank string is no still', () {
      // The difference matters: an empty URL draws a broken image where the
      // fallback would have drawn something sensible.
      final media = PostMedia.fromJson({
        'id': 'v1',
        'kind': 'VIDEO',
        'url': 'https://example.com/a.mp4',
        'thumbnailUrl': '   ',
      });
      expect(media.thumbnailUrl, isNull);
    });

    test('a clip posted before stills existed has none', () {
      final media = PostMedia.fromJson({
        'id': 'v1',
        'kind': 'VIDEO',
        'url': 'https://example.com/a.mp4',
      });
      expect(media.thumbnailUrl, isNull);
    });
  });

  group('PendingMedia', () {
    test('carries the still through the upload round trip', () {
      const clip = PendingMedia(
        path: '/tmp/a.mp4',
        kind: MediaKind.video,
        thumbnailPath: '/tmp/a.jpg',
        width: 720,
        height: 1280,
      );

      final uploaded = clip.copyWith(
        url: 'https://example.com/a.mp4',
        thumbnailUrl: 'https://example.com/a.jpg',
      );

      expect(uploaded.thumbnailPath, '/tmp/a.jpg');
      expect(uploaded.thumbnailUrl, 'https://example.com/a.jpg');
      expect(uploaded.width, 720);
      expect(uploaded.height, 1280);
    });

    test('sends the still and the clip\'s shape when creating the post', () {
      const clip = PendingMedia(
        path: '/tmp/a.mp4',
        kind: MediaKind.video,
        url: 'https://example.com/a.mp4',
        thumbnailUrl: 'https://example.com/a.jpg',
        width: 720,
        height: 1280,
      );

      expect(clip.toJson(), {
        'url': 'https://example.com/a.mp4',
        'kind': 'VIDEO',
        'width': 720,
        'height': 1280,
        'thumbnailUrl': 'https://example.com/a.jpg',
      });
    });

    test('a clip sends no duration', () {
      // durationMs is the recording field. A clip's length is read off the
      // file by whatever plays it, and the server caps that field at the
      // length of a voice post.
      const clip = PendingMedia(
        path: '/tmp/a.mp4',
        kind: MediaKind.video,
        url: 'https://example.com/a.mp4',
        duration: Duration(minutes: 30),
      );
      expect(clip.toJson().containsKey('durationMs'), isFalse);
    });

    test('a still that failed to upload is simply absent', () {
      const clip = PendingMedia(
        path: '/tmp/a.mp4',
        kind: MediaKind.video,
        url: 'https://example.com/a.mp4',
        thumbnailPath: '/tmp/a.jpg',
      );
      expect(clip.toJson().containsKey('thumbnailUrl'), isFalse);
    });
  });

  group('MediaTileGrid.ratioOf', () {
    test('uses the attachment\'s own shape', () {
      expect(
        MediaTileGrid.ratioOf(
          const PostMedia(
            id: 'm',
            kind: MediaKind.image,
            url: 'u',
            width: 1000,
            height: 1000,
          ),
        ),
        1.0,
      );
    });

    test('assumes portrait when nothing was recorded', () {
      expect(
        MediaTileGrid.ratioOf(
          const PostMedia(id: 'm', kind: MediaKind.video, url: 'u'),
        ),
        0.75,
      );
    });

    test('bounds a shape that would make an unusable tile', () {
      expect(
        MediaTileGrid.ratioOf(
          const PostMedia(
            id: 'm',
            kind: MediaKind.image,
            url: 'u',
            width: 10000,
            height: 1,
          ),
        ),
        MediaTileGrid.maxRatio,
      );
      expect(
        MediaTileGrid.ratioOf(
          const PostMedia(
            id: 'm',
            kind: MediaKind.image,
            url: 'u',
            width: 1,
            height: 10000,
          ),
        ),
        MediaTileGrid.minRatio,
      );
    });
  });

  group('VoiceWaveform.downsample', () {
    test('leaves a short recording alone', () {
      // Fifty readings stretched to two hundred bars would be inventing
      // detail that was never recorded.
      expect(VoiceWaveform.downsample([1, 2, 3], 200), [1, 2, 3]);
    });

    test('keeps the peak of each bucket, not the first reading', () {
      // Taking the first flattens every peak that falls between two bars,
      // which is what turns a waveform into a hedge.
      expect(VoiceWaveform.downsample([0, 90, 0, 0, 80, 0], 2), [90, 80]);
    });

    test('produces exactly the number of bars asked for', () {
      final long = List<int>.generate(6000, (i) => i % 101);
      expect(VoiceWaveform.downsample(long, 200).length, 200);
    });

    test('covers the whole recording, not just its start', () {
      // A ten-minute recording that only drew its first minute was the bug
      // the old halving-in-place approach had.
      final quietThenLoud = [
        ...List<int>.filled(500, 5),
        ...List<int>.filled(500, 95),
      ];
      final bars = VoiceWaveform.downsample(quietThenLoud, 10);
      expect(bars.take(5), everyElement(5));
      expect(bars.skip(5), everyElement(95));
    });

    test('asking for no bars gives none rather than dividing by zero', () {
      expect(VoiceWaveform.downsample([1, 2, 3], 0), isEmpty);
    });
  });
}
