// lib/services/push_registrar.dart
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import '../repositories/devices_repository.dart';
import 'app_log.dart';

/// Where a push token comes from.
///
/// Separate from the registrar so the API side can be finished, tested and
/// shipped without the app carrying a Firebase dependency it cannot yet be
/// built against. Supply one of these and push works end to end; supply none
/// and the app says so in its log rather than behaving as though it were
/// registered.
abstract class PushTokenSource {
  /// The registration token for this install, or null when there is none.
  Future<String?> token();

  /// Fires when the platform rotates the token, which it does on reinstall,
  /// on restore to a new device, and occasionally for its own reasons.
  Stream<String> get refreshes;
}

/// Keeps the server's idea of where to reach this install up to date.
///
/// Registered on every launch rather than once: a token can rotate while the
/// app is closed, and a server holding the old one pushes into nothing.
class PushRegistrar {
  final DevicesRepository _devices;
  final PushTokenSource? _source;

  PushRegistrar(this._devices, {PushTokenSource? source}) : _source = source;

  String? _registered;

  /// Which platform this install is, as the API records it.
  static String get platform {
    if (kIsWeb) return 'web';
    if (Platform.isIOS) return 'ios';
    return 'android';
  }

  bool get isAvailable => _source != null;

  /// Called once somebody is signed in.
  Future<void> start() async {
    final source = _source;
    if (source == null) {
      // Said once, and only in the log: a reader cannot act on this, but
      // whoever is wondering why nothing is arriving can.
      AppLog.instance.info(
        'push',
        'No push token source is configured, so this install will not be '
            'reachable while the app is closed.',
      );
      return;
    }

    await _send(await source.token());
    source.refreshes.listen(_send);
  }

  /// Called on sign-out. A token left behind delivers somebody else's
  /// messages to whoever holds the handset next.
  Future<void> stop() async {
    final token = _registered;
    _registered = null;
    if (token == null) return;
    try {
      await _devices.forget(token);
    } catch (error) {
      AppLog.instance.error('push', 'Could not unregister the device: $error');
    }
  }

  Future<void> _send(String? token) async {
    if (token == null || token.isEmpty || token == _registered) return;
    try {
      await _devices.register(token, platform);
      _registered = token;
    } catch (error) {
      // Not fatal and not retried here: the next launch registers again, and
      // a failure to register costs push, not the session.
      AppLog.instance.error('push', 'Could not register the device: $error');
    }
  }
}
