import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/profile_model.dart';
import '../repositories/profile_repository.dart';
import '../services/app_log.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';
import 'current_user_provider.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.read(apiClientProvider)),
);

/// One profile, addressed by handle.
///
/// A null username means "mine", which reads the cached /profile/me the drawer
/// and top bar already hold rather than issuing a second request for the same
/// row.
final profileProvider = StateNotifierProvider.family<ProfileNotifier,
    AsyncValue<ProfileModel>, String?>(
  (ref, username) => ProfileNotifier(ref, username),
);

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  final Ref _ref;
  final String? _username;

  /// Guards the follow button against a second tap landing on top of the
  /// first, which would post two follows and leave the count out by one.
  bool _busy = false;

  ProfileNotifier(this._ref, this._username) : super(const AsyncLoading()) {
    load();
  }

  bool get isMine => _username == null;

  Future<void> load({bool force = false}) async {
    // Only a first load empties the screen. A reload used to drop straight
    // back to AsyncLoading, which replaced the whole page with a spinner --
    // tearing down the scroll view, its controller and the chosen tab, and
    // putting the reader back at the top of a page they had scrolled. Pulling
    // to refresh did that every time, which is what made the profile feel as
    // though it would not scroll.
    if (state.value == null) state = const AsyncLoading();

    try {
      if (isMine) {
        final repo = _ref.read(currentUserRepositoryProvider);
        final me = await repo.fetchMe(force: force);
        AppLog.instance.info(
          'profile',
          'Loaded your profile (${me.id.isEmpty ? 'no id' : me.id})',
        );
        state = AsyncData(ProfileModel.fromCurrentUser(me));
      } else {
        final repo = _ref.read(profileRepositoryProvider);
        final profile = await repo.byUsername(_username!);
        AppLog.instance.info('profile', 'Loaded $_username');
        // A profile can be reached by account id as well as by handle, so the
        // one being read may be the reader's own. Without this it would offer
        // to follow you and hide your own Likes tab.
        final me = _ref.read(currentUserProvider).asData?.value;
        state = AsyncData(
          me != null && me.id == profile.id
              ? profile.copyWith(isOwnProfile: true)
              : profile,
        );
      }
    } catch (e, st) {
      // Logged as well as shown: the screen can only display one line, and a
      // blank profile with no explanation is what this is here to prevent.
      AppLog.instance.error(
        'profile',
        'Could not load ${_username == null ? 'your profile' : '@$_username'}: $e',
      );
      state = AsyncError(e, st);
    }
  }

  /// Follows or unfollows, moving the count immediately and putting it back if
  /// the request fails. Returns an error message to show, or null on success.
  Future<String?> toggleFollow() async {
    final current = state.value;
    if (current == null || current.isOwnProfile || _busy) return null;

    _busy = true;
    final wasFollowing = current.isFollowing;
    state = AsyncData(
      current.copyWith(
        isFollowing: !wasFollowing,
        followers: current.followers + (wasFollowing ? -1 : 1),
      ),
    );

    try {
      final repo = _ref.read(profileRepositoryProvider);
      if (wasFollowing) {
        await repo.unfollow(current.id);
      } else {
        await repo.follow(current.id);
      }
      // Your own following count moved too.
      _ref.read(currentUserProvider.notifier).refresh();
      return null;
    } catch (e) {
      state = AsyncData(current);
      return describeApiError(e, sessionIsLive: true);
    } finally {
      _busy = false;
    }
  }
}
