import 'package:flutter/material.dart' show ThemeData, ThemeMode;
import 'package:kyron_design_system/kyron_design_system.dart';

/// Which of Kyron's palettes the app paints itself in.
///
/// The settings screen used to carry a "Dark Mode" switch next to a
/// `// TODO: Apply theme change immediately`, while `main.dart` passed a
/// hard-coded `ThemeMode.system`. The switch moved, remembered nothing and
/// changed nothing.
///
/// Four choices rather than a switch, because a switch cannot say "whatever
/// the phone is set to" -- and because the design system defines three
/// palettes, not two: [dim] is a softer dark, blue-grey rather than black,
/// for reading at night on an LCD where true black smears.
enum AppTheme {
  system('system', 'System'),
  light('light', 'Light'),
  dark('dark', 'Dark'),
  dim('dim', 'Dim');

  const AppTheme(this.code, this.label);

  /// What is persisted.
  final String code;

  /// What the picker shows.
  final String label;

  /// A line under the label saying what the choice actually does.
  String get detail => switch (this) {
        AppTheme.system => 'Follow the phone’s own light or dark setting',
        AppTheme.light => 'Always light',
        AppTheme.dark => 'Always dark',
        AppTheme.dim => 'A softer dark, blue-grey rather than black',
      };

  /// Falls back to [system] rather than throwing, so a code written by a build
  /// that offered a palette this one does not cannot stop start-up.
  static AppTheme fromCode(String? code) {
    for (final theme in AppTheme.values) {
      if (theme.code == code) return theme;
    }
    return AppTheme.system;
  }
}

/// How a choice reaches [MaterialApp].
///
/// Stated here rather than inline in `main.dart` so that the mapping can be
/// checked without booting the app, and so there is one place that knows dim
/// is a palette rather than a fourth mode.
extension AppThemePalette on AppTheme {
  /// What [MaterialApp.themeMode] is given.
  ThemeMode get mode => switch (this) {
        AppTheme.system => ThemeMode.system,
        AppTheme.light => ThemeMode.light,
        // Dim is dark, painted differently. Asking for it must not leave the
        // app following the phone.
        AppTheme.dark || AppTheme.dim => ThemeMode.dark,
      };

  /// What [MaterialApp.darkTheme] is given.
  ///
  /// Every choice answers, including [light]: `darkTheme` is still consulted
  /// by anything that asks for a dark palette directly, and leaving it stale
  /// would mean the wrong dark showing through.
  ThemeData get darkPalette =>
      this == AppTheme.dim ? KyronTheme.dimTheme : KyronTheme.darkTheme;
}
