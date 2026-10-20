// lib/services/secure_screen.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Keeps what is on screen out of screenshots and recordings, on Android.
///
/// For a view-once message, while it is open. Android can refuse a
/// screenshot outright (FLAG_SECURE, set in MainActivity). iOS cannot: it
/// only says one was taken, after the fact. And no phone can stop another
/// camera. docs/MESSAGING.md says so, and so does the viewer.
class SecureScreen {
  SecureScreen._();

  static const _channel = MethodChannel('so.kyron.app/secure');

  /// How many screens have asked, so one closing does not lift it under
  /// another that is still open.
  static int _holds = 0;

  static Future<void> hold() async {
    _holds++;
    if (_holds == 1) await _set(true);
  }

  static Future<void> release() async {
    if (_holds == 0) return;
    _holds--;
    if (_holds == 0) await _set(false);
  }

  static Future<void> _set(bool on) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    try {
      await _channel.invokeMethod<void>('secure', on);
    } on MissingPluginException {
      // A test, or an embedding without the activity's channel.
    } on PlatformException {
      // The window refused. Nothing to do from here.
    }
  }
}
