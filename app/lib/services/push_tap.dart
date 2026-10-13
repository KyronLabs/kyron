// lib/services/push_tap.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../routes.dart';
import '../screens/thread_screen.dart' show ThreadArgs;

/// A notification that was tapped and has not been opened yet.
///
/// Filled at the top of the app, the moment the tap is known, and emptied by
/// the signed-in screen once it has opened it. The tap used to be listened
/// for by that screen itself, which meant a tap that arrived before it was
/// built -- a cold start, behind the splash and the onboarding check -- or
/// while it was being rebuilt had nobody to hear it, and the app opened on
/// the feed.
final pendingPushTapProvider =
    StateProvider<Map<String, dynamic>?>((ref) => null);

/// Where a tapped notification goes: a route and what to hand it.
typedef PushDestination = ({String route, Object? arguments});

/// Where the notification carrying [data] is about, or null for one that
/// is not about anything that can be opened.
///
/// What the server sends (`api/src/modules/push`):
///
///   message        conversationId                 -> that conversation
///   notification   postId (like, reply, repost)   -> that post
///   notification   actorId (follow)               -> their profile
///   notification   anything else                  -> the notifications page
///
/// A like used to carry only its kind, so every activity notification
/// opened the notifications page and left the reader to find the post.
PushDestination? pushDestination(Map<String, dynamic> data) {
  String? text(String key) {
    final value = data[key];
    return value is String && value.trim().isNotEmpty ? value.trim() : null;
  }

  switch (text('type')) {
    case 'message':
      final conversation = text('conversationId');
      if (conversation == null) return null;
      return (
        route: Routes.thread,
        arguments: ThreadArgs(conversationId: conversation),
      );
    case 'notification':
      final post = text('postId');
      if (post != null) return (route: Routes.postDetail, arguments: post);
      final actor = text('actorId');
      if (text('kind') == 'follow' && actor != null) {
        return (route: Routes.profile, arguments: actor);
      }
      return (route: Routes.notifications, arguments: null);
    default:
      // The test notification, and anything a newer server sends that this
      // build does not know: opening the app is all it can mean.
      return null;
  }
}

/// Opens a tapped notification's destination over [child], once [child] is
/// on screen, and forgets the tap so it is opened only once.
///
/// Wrapped round the signed-in app (MainContainer), so a tap waits for it:
/// one that lands while the splash or onboarding is showing opens as soon as
/// the app is there, over the tab it starts on, and back from it is back
/// into the app rather than out of it.
class PushTapOpener extends ConsumerStatefulWidget {
  final Widget child;

  const PushTapOpener({super.key, required this.child});

  @override
  ConsumerState<PushTapOpener> createState() => _PushTapOpenerState();
}

class _PushTapOpenerState extends ConsumerState<PushTapOpener> {
  @override
  void initState() {
    super.initState();
    ref.listenManual<Map<String, dynamic>?>(
      pendingPushTapProvider,
      (_, data) => _open(data),
      fireImmediately: true,
    );
  }

  void _open(Map<String, dynamic>? data) {
    if (data == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!identical(ref.read(pendingPushTapProvider), data)) return;
      ref.read(pendingPushTapProvider.notifier).state = null;
      final where = pushDestination(data);
      if (where == null) return;
      Navigator.of(context).pushNamed(where.route, arguments: where.arguments);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
