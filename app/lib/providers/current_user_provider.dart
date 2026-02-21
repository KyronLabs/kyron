import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repositories/current_user_repository.dart';
import '../models/current_user.dart';
import 'api_client_provider.dart';

final currentUserRepositoryProvider = Provider<CurrentUserRepository>((ref) {
  final api = ref.read(apiClientProvider);
  return CurrentUserRepository(api);
});

final currentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, AsyncValue<CurrentUser>>(
  (ref) => CurrentUserNotifier(ref),
);

class CurrentUserNotifier extends StateNotifier<AsyncValue<CurrentUser>> {
  final Ref ref;

  CurrentUserNotifier(this.ref) : super(const AsyncLoading()) {
    load();
  }

  Future<void> load({bool force = false}) async {
    try {
      final repo = ref.read(currentUserRepositoryProvider);
      final user = await repo.fetchMe(force: force);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void refresh() => load(force: true);

  void clear() {
    ref.read(currentUserRepositoryProvider).clear();
    state = const AsyncLoading();
  }
}