// lib/screens/browser/browser_palette.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// The browser's own colours.
///
/// Taken from Kyron's tokens rather than from `Theme.of(context).colorScheme`,
/// because several of the roles the chrome would want are not distinct in this
/// theme and reading them gives an invisible interface: `surfaceContainerHighest`
/// is the same colour as `surface`, so a pill filled with it disappears into
/// the bar behind it; `onSurfaceVariant` is the same as `onSurface`, so a
/// second line meant to sit quietly under the first shouts as loudly; and
/// `outlineVariant` is pure black in the light theme and pure white in the
/// dark one, so a hairline drawn with it is a rule.
///
/// Every value here is a real token or derived from one.
class BrowserPalette {
  /// Behind the bar. Deeper than the page so the two are told apart even when
  /// the page is white.
  final Color chrome;

  /// The address pill, and the tab being read.
  final Color pill;
  final Color pillEdge;

  /// Behind a page that has not painted, and behind a failure.
  final Color paper;

  final Color ink;

  /// A second line, a host, a disabled arrow.
  final Color quiet;

  /// Hairlines and the grab rail.
  final Color rule;
  final Color rail;

  /// Progress, and the tab being read in the tab sheet.
  final Color accent;

  /// The one string in the app that has to be read correctly: an insecure
  /// origin. Kyron's error pink is too pale on a light chrome to carry it, so
  /// the light theme takes a darker red of the same family.
  final Color alarm;

  const BrowserPalette({
    required this.chrome,
    required this.pill,
    required this.pillEdge,
    required this.paper,
    required this.ink,
    required this.quiet,
    required this.rule,
    required this.rail,
    required this.accent,
    required this.alarm,
  });

  static const _light = BrowserPalette(
    chrome: Color(0xFFEDF1F6),
    pill: Color(0xFFFFFFFF),
    pillEdge: Color(0x141A202C),
    paper: Color(0xFFFFFFFF),
    ink: KyronTheme.lightTextPrimary,
    quiet: KyronTheme.lightTextSecondary,
    rule: Color(0x1F1A202C),
    rail: Color(0x331A202C),
    accent: KyronTheme.accent,
    alarm: Color(0xFFC0334D),
  );

  static const _dark = BrowserPalette(
    chrome: Color(0xFF17171B),
    pill: Color(0xFF26262D),
    pillEdge: Color(0x1FFFFFFF),
    paper: KyronTheme.darkBackground,
    ink: KyronTheme.darkTextPrimary,
    quiet: KyronTheme.darkTextSecondary,
    rule: Color(0x24FFFFFF),
    rail: Color(0x40FFFFFF),
    accent: KyronTheme.accent,
    alarm: KyronTheme.errorPink,
  );

  static BrowserPalette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _dark : _light;
}
