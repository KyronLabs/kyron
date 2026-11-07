import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/services/kyron_links.dart';
import 'package:kyron_app/widgets/comment_tile.dart';

/// A shared comment opens the comment, not a community.
///
/// Comments were shared as https://kyron.so/c/<id>. /c/ is the community
/// path, so tapping one opened the community screen with a comment's id, and
/// it found nothing. Comments now have /comment/<id>, and the old links --
/// already sent, in chats nobody can edit -- still open the comment.
void main() {
  const id = 'c2d8de0f-a029-4c69-8844-71d9f70962ca';

  test('a comment is shared at /comment/, not at the community path', () {
    final comment = PostComment(
      id: id,
      content: 'Lovely',
      createdAt: DateTime(2026, 11, 7),
      author: const FeedAuthor(id: 'ada', username: 'ada', name: 'Ada'),
    );
    expect(CommentTile.linkTo(comment), 'https://kyron.so/comment/$id');
  });

  test('a /comment/ link is read as the comment', () {
    final link = KyronLinks.parse(Uri.parse(KyronLinks.comment(id)));
    expect(link?.kind, KyronLinkKind.comment);
    expect(link?.value, id);
  });

  test('an old /c/<id> link is still read as the comment', () {
    final link = KyronLinks.parse(Uri.parse('https://kyron.so/c/$id'));
    expect(link?.kind, KyronLinkKind.comment);
    expect(link?.value, id);
    // Upper case too: the id is the same id.
    expect(
      KyronLinks.parse(Uri.parse('https://kyron.so/c/${id.toUpperCase()}'))
          ?.kind,
      KyronLinkKind.comment,
    );
  });

  test('a community slug at /c/ is still a community', () {
    for (final slug in ['runners', 'oh', 'mushroomsss', 'a-b-c', '2026']) {
      final link = KyronLinks.parse(Uri.parse(KyronLinks.community(slug)));
      expect(link?.kind, KyronLinkKind.community, reason: slug);
      expect(link?.value, slug);
    }
  });

  test('profiles are shared by handle, or by id without one', () {
    expect(KyronLinks.profile(handle: 'ada', id: 'x'), 'https://kyron.so/@ada');
    expect(KyronLinks.profile(handle: null, id: 'x'), 'https://kyron.so/u/x');
    expect(KyronLinks.profile(handle: '', id: 'x'), 'https://kyron.so/u/x');
  });

  testWidgets('opening one goes to the comment screen', (tester) async {
    final routes = <RouteSettings>[];
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: (settings) {
          routes.add(settings);
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (c) {
              context = c;
              return const SizedBox();
            },
          );
        },
      ),
    );

    for (final url in [
      'https://kyron.so/comment/$id',
      'https://kyron.so/c/$id',
    ]) {
      routes.clear();
      expect(KyronLinks.open(context, Uri.parse(url)), isTrue);
      await tester.pumpAndSettle();
      expect(routes.single.name, Routes.comment, reason: url);
      expect(routes.single.arguments, id);
    }
  });
}
