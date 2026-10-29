// lib/providers/follow_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/api_error_message.dart';
import 'auth_provider.dart';
import 'current_user_provider.dart';
import 'profile_provider.dart';

/// Follows made or undone in this session, by account id.
///
/// A post carries whether you follow its author as the server knew it when
/// the list was read. Follow somebody from one of their posts and the other
/// nine of theirs on screen still say you do not -- until this, which every
/// card reads before its own answer. Kept per account: signing in as somebody
/// else starts it empty.
class FollowOverrides extends Notifier<Map<String, bool>> {
  @override
  Map<String, bool> build() {
    ref.watch(currentAuthUserProvider.select((user) => user?.id));
    return const {};
  }

  /// Records an answer the server has already given.
  void record(String userId, bool following) {
    if (state[userId] == following) return;
    state = {...state, userId: following};
  }

  /// Follows them, showing it straight away and taking it back if the request
  /// fails. Answers an error to show, or null.
  Future<String?> follow(String userId) async {
    if (state[userId] == true) return null;
    final before = state;
    state = {...state, userId: true};
    try {
      await ref.read(profileRepositoryProvider).follow(userId);
      // Your own following count moved.
      ref.read(currentUserProvider.notifier).refresh();
      return null;
    } catch (e) {
      state = before;
      return describeApiError(e, sessionIsLive: true);
    }
  }
}

final followOverridesProvider =
    NotifierProvider<FollowOverrides, Map<String, bool>>(FollowOverrides.new);
