// lib/services/app_info.dart
import 'package:package_info_plus/package_info_plus.dart';

/// The running build, read from the bundle rather than typed into a string.
///
/// "Kyron v1.0.0" was hard-coded in the drawer, so every build ever shipped
/// claimed to be 1.0.0 and a bug report never said which one it came from.
class AppInfo {
  final String version;
  final String build;
  final String packageName;

  const AppInfo({
    required this.version,
    required this.build,
    required this.packageName,
  });

  /// "1.4.2 (312)", or just the version when the platform has no build number.
  String get display => build.isEmpty ? version : '$version ($build)';

  static AppInfo? _cached;

  /// Cached: the bundle cannot change while the app is running.
  static Future<AppInfo> load() async {
    final cached = _cached;
    if (cached != null) return cached;

    final info = await PackageInfo.fromPlatform();
    return _cached = AppInfo(
      version: info.version,
      build: info.buildNumber,
      packageName: info.packageName,
    );
  }
}
