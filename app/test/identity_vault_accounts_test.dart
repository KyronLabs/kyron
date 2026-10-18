import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/repositories/identity_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/identity_vault.dart';

/// An identifier that changes whenever somebody signs in identifies nothing.
/// The key behind it was deleted on every sign-out, so it did.
class _Identity extends IdentityRepository {
  _Identity() : super(ApiClient()..dio.interceptors.clear());

  final claimed = <String>[];

  @override
  Future<String?> mine() async => claimed.isEmpty ? null : claimed.last;

  @override
  Future<String> challenge() async => '${IdentityVault.messagePrefix}nonce';

  @override
  Future<void> claim({required String did, required String signature}) async =>
      claimed.add(did);
}

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('signing out and back in keeps the same identifier', () async {
    final server = _Identity();
    final vault = IdentityVault(server);

    final first = await vault.ensure('ada');
    // Bo signs in on the same phone in between.
    final bo = await IdentityVault(_Identity()).ensure('bo');
    final again = await vault.ensure('ada');

    expect(first, isNotNull);
    expect(again, first);
    expect(bo, isNot(first));
    expect(server.claimed, [first], reason: 'claimed once, not per sign-in');
  });

  test('the install key from before becomes the signed-in account\'s',
      () async {
    final before = await IdentityVault(_Identity()).ensure('someone');
    final stored = await const FlutterSecureStorage().readAll();
    FlutterSecureStorage.setMockInitialValues({
      'did_secret_key_v1': stored.values.single,
    });

    expect(await IdentityVault(_Identity()).ensure('ada'), before);
  });

  test('nobody signed in, no identifier', () async {
    expect(await IdentityVault(_Identity()).ensure(), isNull);
    expect(
      await IdentityVault(_Identity(), signedIn: () => 'ada').ensure(),
      startsWith('did:'),
    );
  });
}
