import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The app's Android manifest has to merge with every plugin's.
///
/// The merger refuses a permission declared twice with different
/// `maxSdkVersion` values, and only an Android build runs it -- which pull
/// requests do not. The app declared WRITE_EXTERNAL_STORAGE up to 29 for
/// saving photos while camera_android_camerax declared it up to 28; tests
/// and analysis passed and the release APK failed after merging. This reads
/// the same manifests the merger would and holds them to the same rule.
Map<String, String> _maxSdkByPermission(String manifest) => {
      for (final match in RegExp(r'<uses-permission\b[^>]*>').allMatches(
        manifest,
      ))
        if (RegExp(r'android:name="([^"]+)"').firstMatch(match[0]!)
            case final name?)
          if (RegExp(r'android:maxSdkVersion="(\d+)"').firstMatch(match[0]!)
              case final max?)
            name[1]!: max[1]!,
    };

void main() {
  test('no permission is capped at a different SDK than a plugin caps it', () {
    final app = _maxSdkByPermission(
      File('android/app/src/main/AndroidManifest.xml').readAsStringSync(),
    );
    final config = jsonDecode(
      File('.dart_tool/package_config.json').readAsStringSync(),
    ) as Map<String, dynamic>;

    final conflicts = <String>[];
    var plugins = 0;
    for (final package in (config['packages'] as List).cast<Map>()) {
      final root = Uri.parse(package['rootUri'] as String);
      final dir = root.hasScheme
          ? Directory.fromUri(root)
          : Directory('.dart_tool/${root.path}');
      final manifest = File('${dir.path}/android/src/main/AndroidManifest.xml');
      if (!manifest.existsSync()) continue;
      plugins++;
      _maxSdkByPermission(manifest.readAsStringSync()).forEach((name, max) {
        final ours = app[name];
        if (ours != null && ours != max) {
          conflicts.add(
            '$name: the app caps it at $ours, ${package['name']} at $max',
          );
        }
      });
    }

    // A path that matched nothing would pass every time.
    expect(plugins, greaterThan(5));
    expect(conflicts, isEmpty, reason: conflicts.join('\n'));
  });
}
