import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/post_detail_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/post_detail_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

/// A tool, not a test: draws a post's own page -- the header, the counts and
/// actions, and a deep thread with a folded branch and the author's like --
/// light and dark, at the top and scrolled, to PNGs.
///
///     flutter test test/render_post_page.dart --dart-define=shots=/tmp/x
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

Map<String, dynamic> _who(String id, String name) =>
    {'id': id, 'username': name.toLowerCase(), 'name': name};

Map<String, dynamic> _c(
  String id,
  String text, {
  String? parent,
  String who = 'tester',
  String name = 'Tester',
  int replies = 0,
  int likes = 0,
  bool liked = false,
  bool byAuthor = false,
  bool authorLike = false,
  List<Map<String, dynamic>> faces = const [],
  List<String> gifted = const [],
  bool saved = false,
}) =>
    {
      'id': id,
      'content': text,
      'createdAt': DateTime.now()
          .subtract(const Duration(days: 6))
          .toUtc()
          .toIso8601String(),
      'author': _who(who, name),
      'parentId': parent,
      'replies': replies,
      'likes': likes,
      'liked': liked,
      'byAuthor': byAuthor,
      if (authorLike) 'authorLike': _who('weaver', 'Weaver'),
      'replyFaces': faces,
      'gifts': gifted.length,
      'topGifts': gifted,
      'saved': saved,
    };

class _Repo extends FeedRepository {
  _Repo() : super(ApiClient());

  @override
  Future<FeedPost> byId(String postId) async => FeedPost(
        id: 'p1',
        content: 'Good shot of our lovely kudu that hung around the lodge 🔥 '
            '#andbeyondtravel #kudu #animals #travelphotography',
        createdAt: DateTime(2026, 11, 2, 20, 53),
        author: FeedAuthor.fromJson(_who('weaver', 'Weaver')),
        likes: 6,
        comments: 7,
        reposts: 2,
        gifts: 6,
        topGifts: const ['rocket', 'gem', 'rose'],
      );

  @override
  Future<CommentPage> comments(String postId,
          {String? cursor, int limit = 20}) async =>
      CommentPage(items: [
        PostComment.fromJson(_c('c1', 'Great shot!',
            replies: 1,
            likes: 3,
            liked: true,
            authorLike: true,
            saved: true,
            gifted: ['crown', 'rose'])),
        PostComment.fromJson(_c('c7', 'nice shot man',
            who: 'reacce',
            name: 'Reacce',
            replies: 2,
            faces: [
              _who('yun', 'Yunnieee'),
              _who('ada', 'Ada'),
            ])),
        PostComment.fromJson(
            _c('c8', 'incredible', who: 'yun', name: 'Yunnieee')),
      ]);

  static final _replies = {
    'c1': [
      _c('c2', 'Thank you! Took ages to get the light right.',
          parent: 'c1',
          who: 'weaver',
          name: 'Weaver',
          byAuthor: true,
          replies: 1,
          likes: 1)
    ],
    'c2': [_c('c3', 'worth it', parent: 'c2', replies: 1)],
    'c3': [_c('c4', 'which lens?', parent: 'c3', replies: 2, likes: 12)],
    'c4': [
      _c('c5', 'a 400mm, handheld',
          parent: 'c4', who: 'weaver', name: 'Weaver', byAuthor: true),
      _c('c6', 'no way, handheld?',
          parent: 'c4', replies: 1, faces: [_who('weaver', 'Weaver')]),
    ],
  };

  @override
  Future<CommentPage> replies(String commentId,
          {String? cursor, int limit = 20}) async =>
      CommentPage(items: [
        for (final r in _replies[commentId] ?? const [])
          PostComment.fromJson(r),
      ]);

  @override
  Future<void> recordView(String postId, {int? dwellMs}) async {}

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async =>
      const FeedPage(items: []);
}

void main() {
  testWidgets('render', (tester) async {
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
    tester.view.physicalSize = const Size(360, 1400);
    addTearDown(tester.view.reset);

    Future<void> shoot(String name) async {
      await tester.pump(const Duration(milliseconds: 400));
      await tester.runAsync(() async {
        for (final element in find.byType(Image).evaluate()) {
          await precacheImage((element.widget as Image).image, element);
        }
      });
      await tester.pump(const Duration(milliseconds: 400));
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
      final container = ProviderContainer(overrides: [
        signedInAs(),
        feedRepositoryProvider.overrideWithValue(_Repo()),
      ]);
      await tester.pumpWidget(
        RepaintBoundary(
          key: const ValueKey('shot'),
          child: UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              key: ValueKey(dark),
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: const PostDetailScreen(postId: 'p1'),
            ),
          ),
        ),
      );
      for (var i = 0; i < 4; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      final notifier = container.read(postDetailProvider('p1').notifier);
      for (final id in ['c1', 'c2', 'c3', 'c4']) {
        await notifier.toggleReplies(id);
        await tester.pump(const Duration(milliseconds: 50));
      }
      await shoot('post-${dark ? 'dark' : 'light'}');
      if (!dark) {
        tester.view.physicalSize = const Size(360, 720);
        await tester.pump();
        await tester.drag(find.byType(ListView), const Offset(0, -160));
        await shoot('post-scrolled');
        tester.view.physicalSize = const Size(360, 1400);
      }
      container.dispose();
    }
    exit(0);
  });
}
