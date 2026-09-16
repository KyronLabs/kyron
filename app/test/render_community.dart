import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/communities_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/communities_repository.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/community_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Not a test -- a tool, like render_desktop.dart:
///
///     flutter test test/render_community.dart --dart-define=shots=/tmp/shots
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

const _community = Community(
  id: 'c1',
  slug: 'gardeners',
  name: 'Gardeners',
  description: 'Tomatoes, mostly. Occasionally a marrow somebody is proud of.',
  members: 1240,
  posts: 318,
  joined: true,
  role: CommunityRole.member,
);

class _Repo extends CommunitiesRepository {
  _Repo() : super(ApiClient());
  @override
  Future<Community> bySlug(String slug) async => _community;
}

class _Feed extends FeedRepository {
  _Feed() : super(ApiClient());
  @override
  Future<FeedPage> byCommunity(
    String slug, {
    String? cursor,
    int limit = 20,
  }) async =>
      const FeedPage(items: [], nextCursor: null);
}

void main() {
  testWidgets('render', (tester) async {
    SharedPreferences.setMockInitialValues({});
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family)
        ..addFont(
          Future.value(
            File('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf')
                .readAsBytesSync()
                .buffer
                .asByteData(),
          ),
        );
      await loader.load();
    }

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    tester.view.padding = const FakeViewPadding(top: 47, bottom: 34);

    Future<void> shoot(String name) async {
      await tester.pumpAndSettle();
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byType(RepaintBoundary).first,
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
          child: ProviderScope(
            overrides: [
              communitiesRepositoryProvider.overrideWithValue(_Repo()),
              feedRepositoryProvider.overrideWithValue(_Feed()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: const CommunityScreen(slug: 'gardeners'),
            ),
          ),
        ),
      );
      await shoot('community-${dark ? 'dark' : 'light'}');
    }

    exit(0);
  });
}
