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
      await PushRegistrar(devices, connect: () async => FakeTokens('abc'))
          .start();

      expect(devices.registered, ['abc']);
    });

    test('registers again when the platform rotates the token', () async {
      final devices = FakeDevices();
      final tokens = FakeTokens('first');
      await PushRegistrar(devices, connect: () async => tokens).start();

      tokens.rotate('second');
      await Future<void>.delayed(Duration.zero);

      // A server holding a rotated token pushes into nothing.
      expect(devices.registered, ['first', 'second']);
    });

    test('does not send the same token twice', () async {
      final devices = FakeDevices();
      final tokens = FakeTokens('same');
      await PushRegistrar(devices, connect: () async => tokens).start();

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
        PushRegistrar(devices, connect: () async => FakeTokens('abc')).start(),
        completes,
      );
      expect(devices.registered, isEmpty);
    });

    test('forgets the token on sign-out', () async {
      final devices = FakeDevices();
      final registrar =
          PushRegistrar(devices, connect: () async => FakeTokens('abc'));
      await registrar.start();

      await registrar.stop();

      // Left behind, it would deliver somebody else's messages to whoever
      // holds the handset next.
      expect(devices.forgotten, ['abc']);
    });

    test('asks for a source once, however many times it is started', () async {
      // Both the launch path and the sign-in path lead here, and a returning
      // reader takes both. Asking twice means two permission prompts.
      final devices = FakeDevices();
      var asked = 0;
      final registrar = PushRegistrar(devices, connect: () async {
        asked++;
        return FakeTokens('abc');
      });

      await registrar.start();
      await registrar.start();

      expect(asked, 1);
      expect(devices.registered, ['abc']);
    });

    test('sends nothing when the source comes back empty-handed', () async {
      // Which is what no google-services.json, no Firebase on this platform,
      // and a declined permission all look like from here.
      final devices = FakeDevices();
      final registrar = PushRegistrar(devices, connect: () async => null);

      await registrar.start();

      expect(registrar.isAvailable, isFalse);
      expect(devices.registered, isEmpty);
    });

    test('stops listening for rotations on sign-out', () async {
      // The subscription used to be left running, so a token rotation after
      // sign-out registered the handset against an account nobody was signed
      // in to -- and the next person to hold it got those notifications.
      final devices = FakeDevices();
      final tokens = FakeTokens('first');
      final registrar = PushRegistrar(devices, connect: () async => tokens);
      await registrar.start();
      await registrar.stop();

      tokens.rotate('second');
      await Future<void>.delayed(Duration.zero);

      expect(devices.registered, ['first']);
      expect(devices.forgotten, ['first']);
    });

    test('registers again after signing back in', () async {
      final devices = FakeDevices();
      final registrar = PushRegistrar(
        devices,
        connect: () async => FakeTokens('abc'),
      );

      await registrar.start();
      await registrar.stop();
      await registrar.start();

      expect(devices.registered, ['abc', 'abc']);
      expect(registrar.isAvailable, isTrue);
    });

    test('signing out twice does not unregister twice', () async {
      final devices = FakeDevices();
      final registrar =
          PushRegistrar(devices, connect: () async => FakeTokens('abc'));
      await registrar.start();

      await registrar.stop();
      await registrar.stop();

      expect(devices.forgotten, ['abc']);
    });
  });
}
