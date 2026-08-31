// lib/services/device_cache.dart
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// The app's on-device cache: how big it is, and getting rid of it.
///
/// The settings screen used to report `DateTime.now().millisecondsSinceEpoch %
/// 40 + 10` megabytes and "clear" it by setting that number to zero. Nothing
/// was ever measured and nothing was ever deleted.
class DeviceCache {
  const DeviceCache();

  /// Total bytes across the platform cache directories, or null when the
  /// platform does not expose one.
  Future<int?> size() async {
    final directories = await _directories();
    if (directories.isEmpty) return null;

    var total = 0;
    for (final directory in directories) {
      total += await _sizeOf(directory);
    }
    return total;
  }

  /// Deletes the contents of the cache directories, leaving the directories
  /// themselves. Returns how many bytes went.
  Future<int> clear() async {
    final before = await size() ?? 0;

    for (final directory in await _directories()) {
      try {
        await for (final entity in directory.list()) {
          try {
            await entity.delete(recursive: true);
          } catch (_) {
            // A file in use stays. Skipping it beats failing the whole sweep.
          }
        }
      } catch (_) {
        // The directory vanished underneath us; nothing to do.
      }
    }

    final after = await size() ?? 0;
    return (before - after).clamp(0, before);
  }

  Future<List<Directory>> _directories() async {
    final found = <Directory>[];
    try {
      found.add(await getTemporaryDirectory());
    } catch (_) {
      // Not every platform has one.
    }
    try {
      final support = await getApplicationCacheDirectory();
      if (!found.any((d) => d.path == support.path)) found.add(support);
    } catch (_) {
      // Likewise.
    }
    return found.where((d) => d.existsSync()).toList();
  }

  Future<int> _sizeOf(Directory directory) async {
    var total = 0;
    try {
      await for (final entity in directory.list(recursive: true)) {
        if (entity is! File) continue;
        try {
          total += await entity.length();
        } catch (_) {
          // Deleted mid-walk.
        }
      }
    } catch (_) {
      // Unreadable directory; report what we got.
    }
    return total;
  }
}

/// Bytes as a person reads them.
String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  const units = ['KB', 'MB', 'GB'];
  var value = bytes / 1024;
  var unit = 0;
  while (value >= 1024 && unit < units.length - 1) {
    value /= 1024;
    unit++;
  }
  return '${value.toStringAsFixed(value >= 10 ? 0 : 1)} ${units[unit]}';
}
