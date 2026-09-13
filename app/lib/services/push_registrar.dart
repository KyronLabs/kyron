// lib/services/push_registrar.dart
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import '../repositories/devices_repository.dart';
import 'app_log.dart';

/// Where a push token comes from.
///
/// Separate from the registrar so the API side could be finished, tested and
/// shipped before the app carried a Firebase dependency at all. The
/// implementation is [FirebasePushTokens]; this interface is what the
/// registrar and its tests see.
abstract class PushTokenSource {
  /// The registration token for this install, or null when there is none.
  Future<String?> token();

  /// Fires when the platform rotates the token, which it does on reinstall,
  /// on restore to a new device, and occasionally for its own reasons.
  Stream<String> get refreshes;
}

/// How a source is obtained, when there is one to obtain.
///
/// A function rather than a source, because obtaining one means starting
/// Firebase and asking the reader whether they want notifications at all --
/// and neither belongs at launch. The question would land before they had
/// seen a single screen, and "no" from a stranger is permanent on both
/// platforms. So it is called once, after sign-in.
///
/// Null from it means no push here, on any of its several honest grounds:
/// the platform has no Firebase, the configuration file was never dropped in,
/// or the reader said no.
typedef PushTokenSourceFactory = Future<PushTokenSource?> Function();

/// Keeps the server's idea of where to reach this install up to date.
///
/// Registered on every launch rather than once: a token can rotate while the
/// app is closed, and a server holding the old one pushes into nothing.
class PushRegistrar {
  final DevicesRepository _devices;
  final PushTokenSourceFactory? _connect;

  PushRegistrar(this._devices, {PushTokenSourceFactory? connect})
      : _connect = connect;

  PushTokenSource? _source;
  String? _registered;
  StreamSubscription<String>? _rotations;

  /// Which platform this install is, as the API records it.
  static String get platform {
    if (kIsWeb) return 'web';
    if (Platform.isIOS) return 'ios';
    return 'android';
  }

  /// Whether a source was found. False until [start] has run, and false after
  /// it has run and come back with nothing.
  bool get isAvailable => _source != null;

  /// Called once somebody is signed in.
  ///
  /// Safe to call again: a second call while a source is held does nothing,
  /// which matters because both the launch path and the sign-in path lead
  /// here and a returning reader takes both.
  Future<void> start() async {
    if (_source != null) return;

    final connect = _connect;
    if (connect == null) {
      // Said once, and only in the log: a reader cannot act on this, but
      // whoever is wondering why nothing is arriving can.
      AppLog.instance.info(
        'push',
        'No push token source is configured, so this install will not be '
            'reachable while the app is closed.',
      );
      return;
    }

    // Whatever went wrong is already in the log, said by whoever knew what it
    // was. Nothing here is worth failing a sign-in over.
    final source = await connect();
    if (source == null) return;

    _source = source;
    await _send(await source.token());
    _rotations = source.refreshes.listen(_send);
  }

  /// Called on sign-out. A token left behind delivers somebody else's
  /// messages to whoever holds the handset next.
  Future<void> stop() async {
    // Cancelled first, and this is not tidying: the subscription used to be
    // left running, so a token rotation after sign-out re-registered the
    // handset against an account nobody was signed in to.
    await _rotations?.cancel();
    _rotations = null;
    _source = null;

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
