import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/user.dart';
import 'package:kyron_app/providers/auth_provider.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/identity_provider.dart';
import 'package:kyron_app/providers/keys_provider.dart';
import 'package:kyron_app/providers/push_provider.dart';
import 'package:kyron_app/repositories/auth_repository.dart';
import 'package:kyron_app/repositories/devices_repository.dart';
import 'package:kyron_app/repositories/identity_repository.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/identity_vault.dart';
import 'package:kyron_app/services/message_vault.dart';
import 'package:kyron_app/services/push_registrar.dart';

/// Every way into a signed-in app starts the same things: the message key,
/// the identifier, and the push token.
///
/// A launch whose access token had expired -- any launch more than an hour
/// after the last, which is what an update is -- was refreshed and marked
/// signed in without any of them. The message key was never read, so every
/// sealed message showed "cannot be read" and every new one went out in the
/// clear.
class _Auth extends AuthRepository {
  _Auth({required this.tokenValid, this.refreshes = true});

  final bool tokenValid;
  final bool refreshes;

  @override
  Future<User?> getStoredUserData() async =>
      User(id: 'u1', email: 'ada@example.com');

  @override
  Future<bool> hasValidAccessToken() async => tokenValid;

  @override
  bool get hasPersistedSession => true;

  @override
  Future<bool> refresh() async => refreshes;
}

class _Vault extends MessageVault {
  _Vault() : super(KeysRepository(ApiClient()));
  int unlocks = 0;

  @override
  Future<void> unlock() async => unlocks++;
}

class _Identity extends IdentityVault {
  _Identity() : super(IdentityRepository(ApiClient()));
  int ensures = 0;

  @override
  Future<String?> ensure() async {
    ensures++;
    return null;
  }
}

class _Push extends PushRegistrar {
  _Push() : super(DevicesRepository(ApiClient()));
  int starts = 0;

  @override
  Future<void> start() async => starts++;
}

class _Me extends CurrentUserNotifier {
  _Me(super.ref);

  @override
  Future<void> load({bool force = false}) async {
    state = const AsyncData(
      CurrentUser(id: 'u1', name: 'Ada', followers: 0, following: 0, posts: 0),
    );
  }
}

Future<(_Vault, _Identity, _Push, AuthState)> _launch(_Auth auth) async {
  final vault = _Vault();
  final identity = _Identity();
  final push = _Push();
  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(auth),
      messageVaultProvider.overrideWithValue(vault),
      identityVaultProvider.overrideWithValue(identity),
      pushRegistrarProvider.overrideWithValue(push),
      currentUserProvider.overrideWith((ref) => _Me(ref)),
    ],
  );
  addTearDown(container.dispose);
  await container.read(authNotifierProvider.notifier).bootstrap();
  return (vault, identity, push, container.read(authNotifierProvider));
}

void main() {
  test('a launch with a live token starts the session', () async {
    final (vault, identity, push, state) = await _launch(
      _Auth(tokenValid: true),
    );

    expect(state.status, AuthStatus.authenticated);
    expect(vault.unlocks, 1);
    expect(identity.ensures, 1);
    expect(push.starts, 1);
  });

  test('a launch whose token had expired starts it too', () async {
    final (vault, identity, push, state) = await _launch(
      _Auth(tokenValid: false),
    );

    expect(state.status, AuthStatus.authenticated);
    expect(vault.unlocks, 1, reason: 'the message key was never read');
    expect(identity.ensures, 1);
    expect(push.starts, 1, reason: 'the push token was never refreshed');
  });

  test('and a launch that cannot be refreshed starts nothing', () async {
    final (vault, identity, push, state) = await _launch(
      _Auth(tokenValid: false, refreshes: false),
    );

    expect(state.status, AuthStatus.unauthenticated);
    expect(vault.unlocks, 0);
    expect(push.starts, 0);
  });
}
