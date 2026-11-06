import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/models/profile_model.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/profile_provider.dart';
import 'package:kyron_app/screens/profile_screen.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

/// A tool, not a test: a profile's tabs and posts -- words, emoji alone, a
/// photograph on its own, a pair -- and the text menu, light and dark.
///
/// Pictures come from a local server: start one in a folder holding
/// quote.png, land.png and land2.png, and pass its address.
///
///     flutter test test/render_feed_profile.dart \\
///       --dart-define=shots=/tmp/x --dart-define=media=http://127.0.0.1:8765
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');
const media = String.fromEnvironment('media', defaultValue: '');

const _me = ProfileModel(
  id: 'u1',
  name: 'Reacce',
  username: 'rheacee',
  bio: 'Quotes, mostly.',
  followers: 128,
  following: 41,
  posts: 4,
  isOwnProfile: true,
);

class _Profile extends ProfileNotifier {
  _Profile(super.ref, super.username) {
    state = const AsyncData(_me);
  }
  @override
  Future<void> load({bool force = false}) async {}
}

class _Posts extends PostListNotifier {
  _Posts(super.ref, super.source, this._seed);
  final FeedState _seed;
  @override
  Future<void> refresh() async => state = _seed;
}

FeedPost _post(String id, String text, {List<PostMedia> media = const []}) =>
    FeedPost(
      id: id,
      content: text,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      author: const FeedAuthor(id: 'u1', name: 'Reacce', username: 'rheacee'),
      likes: 4,
      media: media,
    );

void main() {
  testWidgets('render', (tester) async {
    HttpOverrides.global = null;
    SharedPreferences.setMockInitialValues({});
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family);
      for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
        loader.addFont(rootBundle.load('assets/fonts/Inter-$weight.ttf'));
      }
      await loader.load();
    }
    final icons = FontLoader('packages/iconsax_flutter/FlutterIconsax');
    icons.addFont(
      rootBundle.load('packages/iconsax_flutter/fonts/FlutterIconsax.ttf'),
    );
    await icons.load();

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 1700);
    addTearDown(tester.view.reset);

    final posts = FeedState(
      posts: [
        _post(
          'p1',
          'Solitude is not loneliness; it is a sacred space. Your peace is '
              'not too much to ask for.',
          media: [
            // No recorded size: the case that was cut to 4:3.
            const PostMedia(
                id: 'm1', kind: MediaKind.image, url: '$media/quote.png'),
          ],
        ),
        _post('p2', '🤣🤣'),
        _post('p3', 'Joy has a habit of returning #mornings'),
        _post('p4', 'Two from the walk', media: [
          const PostMedia(
              id: 'm2', kind: MediaKind.image, url: '$media/land.png'),
          const PostMedia(
              id: 'm3', kind: MediaKind.image, url: '$media/land2.png'),
        ]),
      ],
    );

    Future<void> shoot(String name) async {
      for (var i = 0; i < 8; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 150)),
        );
        await tester.pump(const Duration(milliseconds: 50));
      }
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byKey(const ValueKey('shot')),
      );
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 2);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        return data!.buffer.asUint8List();
      });
      File('$out/$name.png').writeAsBytesSync(bytes!);
    }

    for (final dark in [false, true]) {
      await tester.pumpWidget(
        RepaintBoundary(
          key: const ValueKey('shot'),
          child: ProviderScope(
            key: ValueKey(dark),
            overrides: [
              signedInAs(),
              profileProvider.overrideWith((ref, u) => _Profile(ref, u)),
              postListProvider.overrideWith(
                (ref, source) => _Posts(ref, source, posts),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: const ProfileScreen(),
            ),
          ),
        ),
      );
      await shoot('profile-${dark ? 'dark' : 'light'}');

      // The text menu, over a long-pressed post.
      await tester.longPress(find.textContaining('Joy has a habit'));
      await tester.pump(const Duration(milliseconds: 300));
      await shoot('select-${dark ? 'dark' : 'light'}');
    }
    exit(0);
  });
}
