// lib/services/share_inbox.dart
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'app_log.dart';

/// What another app handed Kyron from its share sheet: some text -- often a
/// link -- and any pictures, already copied to files this app owns.
class SharedContent {
  final String? text;
  final List<String> files;

  const SharedContent({this.text, this.files = const []});

  /// Read from what MainActivity passes over. Anything malformed is dropped
  /// rather than trusted: this arrives from whichever app did the sharing.
  static SharedContent? fromChannel(Object? value) {
    if (value is! Map) return null;
    final text = value['text'];
    final files = value['files'];
    final content = SharedContent(
      text: text is String && text.trim().isNotEmpty ? text.trim() : null,
      files: files is List ? files.whereType<String>().toList() : const [],
    );
    return content.isEmpty ? null : content;
  }

  bool get isEmpty => text == null && files.isEmpty;
}

/// Listens for shares from other apps.
///
/// Android only for now. The share sheet on iOS takes a separate share
/// extension target in the Xcode project, with its own app group to hand
/// things across; until that exists, this answers nothing there.
class ShareInbox {
  static const _channel = MethodChannel('so.kyron.app/share');

  final _incoming = StreamController<SharedContent>.broadcast();

  ShareInbox() {
    _channel.setMethodCallHandler((call) async {
      if (call.method != 'shared') return;
      final content = SharedContent.fromChannel(call.arguments);
      if (content != null) _incoming.add(content);
    });
  }

  /// Shares that arrive while the app is open.
  Stream<SharedContent> get incoming => _incoming.stream;

  /// The share that opened the app, if one did. Taken once.
  Future<SharedContent?> take() async {
    try {
      return SharedContent.fromChannel(
        await _channel.invokeMethod<Object?>('take'),
      );
    } on MissingPluginException {
      return null;
    } catch (error) {
      AppLog.instance.error('share', 'Could not read the share: $error');
      return null;
    }
  }
}

final shareInboxProvider = Provider<ShareInbox>((ref) => ShareInbox());

/// A share waiting to be offered, until somebody signed in is in the app to
/// see it. Held here rather than shown when it arrives: a share that opens
/// the app lands before the session is restored, and a sheet opened then
/// would be swept away by the move from the splash screen to the feed.
final pendingShareProvider = StateProvider<SharedContent?>((ref) => null);
