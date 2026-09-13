import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The iOS deployment target, checked from Linux.
///
/// Nothing in CI builds iOS -- there is no runner for it and no signing
/// identity to build with -- so the only thing standing between a wrong
/// deployment target and a developer discovering it at `pod install` is this.
/// It found the problem it was written for: adding `firebase_messaging` for
/// push raised the floor to iOS 15, the project was on 13, and CocoaPods
/// refuses that combination before a line is compiled.
///
/// It reads the same two sources Xcode and CocoaPods do, so it cannot be
/// satisfied by a number written down somewhere convenient.
void main() {
  group('the iOS deployment target', () {
    test('is one number, in every build configuration', () {
      final targets = _projectTargets();

      expect(targets, isNotEmpty, reason: 'the Xcode project declares none');
      // Debug, Release and Profile. One of them left behind builds fine and
      // then fails on exactly one configuration, usually the release.
      expect(targets.toSet(), hasLength(1), reason: 'configurations disagree');
    });

    test('matches what the framework says its minimum is', () {
      // Xcode builds against IPHONEOS_DEPLOYMENT_TARGET; the App Store reads
      // MinimumOSVersion out of the built framework. Different numbers mean
      // an app that compiles and is then rejected, or offered to handsets it
      // cannot run on.
      expect(_frameworkMinimum(), _projectTargets().first);
    });

    test('is at least what every plugin requires', () {
      final required = _pluginRequirements();
      expect(required, isNotEmpty, reason: 'no podspecs were found to check');

      final highest = required.values.reduce(
        (a, b) => _isAtLeast(a, b) ? a : b,
      );
      final highestNames = required.entries
          .where((e) => e.value == highest)
          .map((e) => e.key)
          .toList()
        ..sort();

      expect(
        _isAtLeast(_projectTargets().first, highest),
        isTrue,
        reason: 'the project is on ${_projectTargets().first} and '
            '${highestNames.join(', ')} require $highest. CocoaPods refuses '
            'this before anything is compiled.',
      );
    });
  });
}

/// Every `IPHONEOS_DEPLOYMENT_TARGET` in the Xcode project.
List<String> _projectTargets() {
  final project = File('ios/Runner.xcodeproj/project.pbxproj');
  expect(project.existsSync(), isTrue,
      reason: 'no Xcode project at ${project.path}');

  return RegExp(r'IPHONEOS_DEPLOYMENT_TARGET\s*=\s*([0-9.]+)\s*;')
      .allMatches(project.readAsStringSync())
      .map((m) => m.group(1)!)
      .toList();
}

/// `MinimumOSVersion` from the Flutter framework's Info.plist.
String _frameworkMinimum() {
  final plist = File('ios/Flutter/AppFrameworkInfo.plist');
  expect(plist.existsSync(), isTrue, reason: 'no plist at ${plist.path}');

  final match = RegExp(
    r'<key>MinimumOSVersion</key>\s*<string>([0-9.]+)</string>',
    multiLine: true,
  ).firstMatch(plist.readAsStringSync());

  expect(match, isNotNull, reason: 'no MinimumOSVersion in ${plist.path}');
  return match!.group(1)!;
}

/// What each resolved plugin's podspec asks for, by package name.
///
/// Read out of the packages this app actually resolved rather than a list
/// kept by hand, so a plugin that raises its floor in a routine upgrade shows
/// up here rather than at somebody's next `pod install`.
Map<String, String> _pluginRequirements() {
  final config = File('.dart_tool/package_config.json');
  expect(config.existsSync(), isTrue,
      reason: 'run flutter pub get before this test');

  final packages = (jsonDecode(config.readAsStringSync())
      as Map<String, dynamic>)['packages'] as List<dynamic>;

  final found = <String, String>{};
  for (final entry in packages.cast<Map<String, dynamic>>()) {
    final root = _resolve(entry['rootUri'] as String, config.parent.path);
    // `ios/` is the long-standing layout; `darwin/` is what plugins sharing
    // one podspec between iOS and macOS use.
    for (final folder in const ['ios', 'darwin']) {
      final dir = Directory('$root/$folder');
      if (!dir.existsSync()) continue;
      for (final file in dir.listSync().whereType<File>()) {
        if (!file.path.endsWith('.podspec')) continue;
        final version = _declaredTarget(file.readAsStringSync());
        if (version != null) found[entry['name'] as String] = version;
      }
    }
  }
  return found;
}

/// Both spellings a podspec uses to say the same thing.
String? _declaredTarget(String podspec) {
  final explicit = RegExp(r"""ios\.deployment_target\s*=\s*['"]([0-9.]+)['"]""")
      .firstMatch(podspec);
  if (explicit != null) return explicit.group(1);

  final platform = RegExp(r"""platform\s*=\s*:ios\s*,\s*['"]([0-9.]+)['"]""")
      .firstMatch(podspec);
  return platform?.group(1);
}

String _resolve(String rootUri, String from) {
  if (rootUri.startsWith('file://')) return Uri.parse(rootUri).toFilePath();
  // Relative to the directory package_config.json is in.
  return File('$from/$rootUri').absolute.path;
}

/// Version comparison on the dotted numbers a podspec uses. `9.0` is not
/// "greater than" `15.0`, which is what comparing the strings would say.
bool _isAtLeast(String version, String minimum) {
  final a = version.split('.').map(int.parse).toList();
  final b = minimum.split('.').map(int.parse).toList();
  for (var i = 0; i < a.length || i < b.length; i++) {
    final left = i < a.length ? a[i] : 0;
    final right = i < b.length ? b[i] : 0;
    if (left != right) return left > right;
  }
  return true;
}
