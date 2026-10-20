import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Inter, which the design system's theme has always asked for and the app
/// never shipped: the pubspec declared it at the top level, outside
/// `flutter:`, where Flutter does not look, and named files that were never
/// added. Every screen fell back to the platform's own font, and nothing said
/// so.
void main() {
  final pubspec = File('pubspec.yaml').readAsStringSync();

  test('the family the theme asks for is the one the app declares', () {
    final family = KyronTheme.lightTheme.textTheme.bodyMedium?.fontFamily;
    expect(family, 'Inter');

    // Under `flutter:`, where Flutter reads it.
    final flutterSection = pubspec.substring(pubspec.indexOf('\nflutter:\n'));
    expect(flutterSection, contains('  fonts:\n    - family: $family\n'));
    // And not left at the top level, where it did nothing.
    expect(RegExp(r'^fonts:', multiLine: true).hasMatch(pubspec), isFalse);
  });

  test('every weight the app uses most is a real TrueType file', () {
    final assets =
        RegExp(r'- asset: (assets/fonts/Inter-\w+\.ttf)\n\s+weight: (\d+)')
            .allMatches(pubspec)
            .map((m) => (path: m.group(1)!, weight: int.parse(m.group(2)!)))
            .toList();

    expect(assets.map((a) => a.weight), [400, 500, 600, 700]);
    for (final asset in assets) {
      final bytes = File(asset.path).readAsBytesSync();
      // The sfnt version every TrueType outline font starts with.
      expect(bytes.sublist(0, 4), [0, 1, 0, 0], reason: asset.path);
    }
  });

  test('is in the bundle the app is built with', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final manifest = jsonDecode(
      await rootBundle.loadString('FontManifest.json'),
    ) as List<dynamic>;
    final inter = manifest.cast<Map<String, dynamic>>().firstWhere(
          (entry) => entry['family'] == 'Inter',
        );
    expect(inter['fonts'] as List<dynamic>, hasLength(4));
  });

  test('travels with its licence', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final licence = await rootBundle.loadString('assets/fonts/Inter-OFL.txt');
    expect(licence, contains('SIL OPEN FONT LICENSE Version 1.1'));
  });
}
