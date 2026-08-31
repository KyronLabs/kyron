// lib/services/app_log.dart
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LogLevel { info, warning, error }

class LogEntry {
  final DateTime at;
  final LogLevel level;

  /// Where it came from: 'api', 'auth', 'feed'. Short, for filtering by eye.
  final String source;
  final String message;

  const LogEntry({
    required this.at,
    required this.level,
    required this.source,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'at': at.toIso8601String(),
        'level': level.name,
        'source': source,
        'message': message,
      };

  static LogEntry? fromJson(Object? value) {
    if (value is! Map) return null;
    final at = DateTime.tryParse(value['at'] as String? ?? '');
    if (at == null) return null;
    return LogEntry(
      at: at,
      level: LogLevel.values.firstWhere(
        (l) => l.name == value['level'],
        orElse: () => LogLevel.info,
      ),
      source: value['source'] as String? ?? 'app',
      message: value['message'] as String? ?? '',
    );
  }

  /// One line, as it appears in the system log and in an error report.
  @override
  String toString() =>
      '${at.toIso8601String()}  ${level.name.toUpperCase().padRight(7)} '
      '[$source] $message';
}

/// What the app has been doing, kept so a person can see it and send it.
///
/// The About screen offers a system log and an error report. Without somewhere
/// to record what happened, both would have had to show something made up.
/// This is deliberately small: a bounded ring buffer, written to disk so it
/// survives the crash or the force-quit you would want to report.
class AppLog {
  AppLog._();

  static final AppLog instance = AppLog._();

  /// Bounded so the log cannot grow without limit on a long-lived install.
  static const maxEntries = 200;

  static const _storageKey = 'kyron.system_log.v1';

  final ListQueue<LogEntry> _entries = ListQueue<LogEntry>();

  /// Bumped on every change, so a screen can rebuild without polling.
  final ValueNotifier<int> revision = ValueNotifier<int>(0);

  SharedPreferences? _prefs;
  bool _loaded = false;

  List<LogEntry> get entries => List.unmodifiable(_entries);

  /// Reads whatever the last run left behind. Safe to call more than once.
  Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    try {
      _prefs = await SharedPreferences.getInstance();
      final raw = _prefs?.getString(_storageKey);
      if (raw == null) return;
      final decoded = jsonDecode(raw);
      if (decoded is! List) return;
      for (final item in decoded) {
        final entry = LogEntry.fromJson(item);
        if (entry != null) _entries.add(entry);
      }
      revision.value++;
    } catch (_) {
      // A log that cannot be read is not worth failing a launch over.
    }
  }

  void info(String source, String message) =>
      add(LogLevel.info, source, message);

  void warn(String source, String message) =>
      add(LogLevel.warning, source, message);

  void error(String source, String message) =>
      add(LogLevel.error, source, message);

  void add(LogLevel level, String source, String message) {
    _entries.addLast(LogEntry(
      at: DateTime.now(),
      level: level,
      source: source,
      message: message,
    ));
    while (_entries.length > maxEntries) {
      _entries.removeFirst();
    }
    revision.value++;
    unawaited(_persist());
  }

  Future<void> clear() async {
    _entries.clear();
    revision.value++;
    await _persist();
  }

  /// The log as text, newest last -- the order it reads in.
  String asText() => _entries.map((e) => e.toString()).join('\n');

  Future<void> _persist() async {
    try {
      final prefs = _prefs ??= await SharedPreferences.getInstance();
      await prefs.setString(
        _storageKey,
        jsonEncode(_entries.map((e) => e.toJson()).toList()),
      );
    } catch (_) {
      // Losing a persisted copy is survivable; the in-memory log still works.
    }
  }
}

/// Fire-and-forget, without the analyzer warning about a dropped future.
void unawaited(Future<void> future) {
  future.then((_) {}, onError: (_) {});
}
