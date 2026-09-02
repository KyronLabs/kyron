import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/widgets/inline_video.dart';
import 'package:kyron_app/widgets/media_tray.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(body: SizedBox(height: 200, child: child)),
    );

MediaTray _tray(List<PendingMedia> media) => MediaTray(
      media: media,
      onRemove: (_) {},
      onRetry: (_) {},
      onDescribe: (_) {},
    );

/// The image a widget is drawing, past the resizing wrapper that `cacheWidth`
/// puts around it.
ImageProvider _providerIn(WidgetTester tester) {
  final provider = tester.widget<Image>(find.byType(Image).first).image;
  return provider is ResizeImage ? provider.imageProvider : provider;
}

void main() {
  group('the composer tray', () {
    testWidgets('draws the still pulled out of a clip', (tester) async {
      // The complaint this fixes: attaching a video showed a camcorder glyph
      // on a grey square, so the one place you check what you are about to
      // post told you nothing about it.
      await tester.pumpWidget(_wrap(_tray(const [
        PendingMedia(
          path: '/tmp/clip.mp4',
          kind: MediaKind.video,
          thumbnailPath: '/tmp/clip.jpg',
          url: 'https://example.com/clip.mp4',
        ),
      ])));

      final provider = _providerIn(tester);
      expect(provider, isA<FileImage>());
      expect((provider as FileImage).file.path, '/tmp/clip.jpg');
    });

    testWidgets('draws a picture from the file that was chosen',
        (tester) async {
      await tester.pumpWidget(_wrap(_tray(const [
        PendingMedia(
          path: '/tmp/photo.jpg',
          kind: MediaKind.image,
          url: 'https://example.com/photo.jpg',
        ),
      ])));

      expect((_providerIn(tester) as FileImage).file.path, '/tmp/photo.jpg');
    });

    testWidgets('a clip whose still is not ready yet draws no image',
        (tester) async {
      // Rather than the clip's own path, which is a video file and would fail
      // to decode into a broken-image glyph.
      await tester.pumpWidget(_wrap(_tray(const [
        PendingMedia(path: '/tmp/clip.mp4', kind: MediaKind.video),
      ])));

      expect(find.byType(Image), findsNothing);
    });

    testWidgets('a recording keeps its glyph, having no frame to show',
        (tester) async {
      await tester.pumpWidget(_wrap(_tray(const [
        PendingMedia(
          path: '/tmp/voice.m4a',
          kind: MediaKind.voice,
          url: 'https://example.com/voice.m4a',
        ),
      ])));

      expect(find.byType(Image), findsNothing);
      expect(find.byType(Icon), findsWidgets);
    });
  });

  group('VideoPoster', () {
    testWidgets('draws the still the composer uploaded', (tester) async {
      await tester.pumpWidget(_wrap(const VideoPoster(
        media: PostMedia(
          id: 'm1',
          kind: MediaKind.video,
          url: 'https://example.com/a.mp4',
          thumbnailUrl: 'https://example.com/a.jpg',
        ),
      )));

      final provider = _providerIn(tester);
      expect(provider, isA<NetworkImage>());
      expect((provider as NetworkImage).url, 'https://example.com/a.jpg');
    });

    testWidgets('falls back to a ground for a clip posted before stills',
        (tester) async {
      await tester.pumpWidget(_wrap(const VideoPoster(
        media: PostMedia(
          id: 'm1',
          kind: MediaKind.video,
          url: 'https://example.com/a.mp4',
        ),
      )));

      // No image to draw, and no decoder opened to make one: that is the
      // whole point of the poster.
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('says what it is doing while a decoder is being opened',
        (tester) async {
      await tester.pumpWidget(_wrap(const VideoPoster(
        media: PostMedia(
          id: 'm1',
          kind: MediaKind.video,
          url: 'https://example.com/a.mp4',
          thumbnailUrl: 'https://example.com/a.jpg',
        ),
        badge: VideoPosterBadge.busy,
      )));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Iconsax.play), findsNothing);
    });

    testWidgets('offers a play button when it is waiting to be started',
        (tester) async {
      await tester.pumpWidget(_wrap(const VideoPoster(
        media: PostMedia(
          id: 'm1',
          kind: MediaKind.video,
          url: 'https://example.com/a.mp4',
          thumbnailUrl: 'https://example.com/a.jpg',
        ),
      )));

      expect(find.byIcon(Iconsax.play), findsOneWidget);
    });
  });
}
