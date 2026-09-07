import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/repositories/devices_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/push_registrar.dart';

class FakeDevices extends DevicesRepository {
  FakeDevices() : super(ApiClient());

  final List<String> registered = [];
  final List<String> forgotten = [];
  bool fails = false;

  @override
  Future<void> register(String token, String platform) async {
    if (fails) throw Exception('offline');
    registered.add(token);
  }

  @override
  Future<void> forget(String token) async {
    forgotten.add(token);
  }
}

class FakeTokens implements PushTokenSource {
  FakeTokens(this.first);

  final String? first;
  final _rotations = StreamController<String>.broadcast();

  @override
  Future<String?> token() async => first;

  @override
  Stream<String> get refreshes => _rotations.stream;

  void rotate(String token) => _rotations.add(token);
}

void main() {
  group('PushRegistrar', () {
    test('registers the token it is given', () async {
      final devices = FakeDevices();
      await PushRegistrar(devices, source: FakeTokens('abc')).start();

      expect(devices.registered, ['abc']);
    });

    test('registers again when the platform rotates the token', () async {
      final devices = FakeDevices();
      final tokens = FakeTokens('first');
      await PushRegistrar(devices, source: tokens).start();

      tokens.rotate('second');
      await Future<void>.delayed(Duration.zero);

      // A server holding a rotated token pushes into nothing.
      expect(devices.registered, ['first', 'second']);
    });

    test('does not send the same token twice', () async {
      final devices = FakeDevices();
      final tokens = FakeTokens('same');
      await PushRegistrar(devices, source: tokens).start();

      tokens.rotate('same');
      await Future<void>.delayed(Duration.zero);

      expect(devices.registered, ['same']);
    });

    test('sends nothing when there is no source', () async {
      final devices = FakeDevices();
      final registrar = PushRegistrar(devices);

      await registrar.start();

      expect(registrar.isAvailable, isFalse);
      expect(devices.registered, isEmpty);
    });

    test('a failed registration costs push, not the session', () async {
      final devices = FakeDevices()..fails = true;

      await expectLater(
        PushRegistrar(devices, source: FakeTokens('abc')).start(),
        completes,
      );
      expect(devices.registered, isEmpty);
    });

    test('forgets the token on sign-out', () async {
      final devices = FakeDevices();
      final registrar = PushRegistrar(devices, source: FakeTokens('abc'));
      await registrar.start();

      await registrar.stop();

      // Left behind, it would deliver somebody else's messages to whoever
      // holds the handset next.
      expect(devices.forgotten, ['abc']);
    });

    test('signing out twice does not unregister twice', () async {
      final devices = FakeDevices();
      final registrar = PushRegistrar(devices, source: FakeTokens('abc'));
      await registrar.start();

      await registrar.stop();
      await registrar.stop();

      expect(devices.forgotten, ['abc']);
    });
  });
}
