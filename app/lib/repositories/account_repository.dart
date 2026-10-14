import '../services/api_client.dart';

/// The account itself, as opposed to the profile it shows.
class AccountRepository {
  final ApiClient _api;

  AccountRepository(this._api);

  /// Deletes the signed-in account and everything in it, sign-in included.
  ///
  /// There is no undo. When this returns the sign-in is gone; the session the
  /// app holds still works for a little while, which is what lets a deletion
  /// that stopped part way be tried again from the same screen.
  Future<void> delete() async {
    await _api.dio.delete<void>('/account');
  }
}
