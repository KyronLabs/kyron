import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/providers/current_user_provider.dart';

/// The signed-in account, without asking the API for /profile/me.
///
/// A screen that reads the current user would otherwise send a real request
/// from the test, and its timeout outlives the test.
Override signedInAs({String role = 'USER'}) =>
    currentUserProvider.overrideWith((ref) => _Me(ref, role));

class _Me extends CurrentUserNotifier {
  _Me(super.ref, this.role);
  final String role;

  @override
  Future<void> load({bool force = false}) async {
    state = AsyncData(
      CurrentUser(
        id: 'me',
        name: 'Me',
        username: 'me',
        followers: 0,
        following: 0,
        posts: 0,
        role: role,
      ),
    );
  }
}
