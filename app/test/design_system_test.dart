import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Two rules the design system states plainly, checked against the source
/// rather than against a rendered frame.
///
/// Both were swept to zero in one go, and both are the kind of thing that
/// creeps back one widget at a time -- a 14 here, a Material icon there --
/// because nothing fails when it does. A design system that is only ever
/// audited is a design system that drifts between audits.
///
/// There is no allow-list. If a rule needs an exception, the rule is wrong
/// and belongs in the design system's own repository, not in a list here.
void main() {
  final dart =
      Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  /// Every line matching [pattern], as `path:line  text`.
  List<String> offences(RegExp pattern) => [
    for (final file in dart)
      ...() {
        final lines = file.readAsLinesSync();
        return [
          for (var i = 0; i < lines.length; i++)
            if (pattern.hasMatch(lines[i]))
              '${file.path}:${i + 1}  ${lines[i].trim()}',
        ];
      }(),
  ];

  test('there is a file to read', () {
    // A glob that matches nothing passes every test below it.
    expect(dart.length, greaterThan(100));
  });

  test('type is set from the scale, never a number', () {
    // TypographyTokens is a 1.125 modular scale from a 15px base: 9.4, 11.3,
    // 13.1, 15, 16.9, 18.8, 20.6, 24.3, 30, 37.5. Half the sizes written by
    // hand here were not on it -- 10, 12, 14, 17, 18, 22 -- so text a point
    // or two off matched nothing else on the screen. There were 175.
    final found = offences(RegExp(r'fontSize:\s*\d'));
    expect(
      found,
      isEmpty,
      reason:
          'a font size is set from a number rather than '
          'TypographyTokens:\n${found.join('\n')}',
    );
  });

  test('the browser draws outlines', () {
    // Iconsax ships every glyph twice, and the `_copy` suffix is the outline.
    // A filled glyph in Kyron means a state -- a liked post, a saved one, the
    // selected tab, a playing video -- so this is not a rule the whole app can
    // follow. The browser has no such states: every one of its eleven icons
    // was the filled variant, next to an interface drawn entirely in outlines.
    final filled = [
      for (final file in dart)
        if (file.path.contains('screens/browser'))
          ...() {
            final lines = file.readAsLinesSync();
            return [
              for (var i = 0; i < lines.length; i++)
                if (RegExp(r'Iconsax\.[a-z0-9_]+')
                    .allMatches(lines[i])
                    .any((m) => !m.group(0)!.endsWith('_copy')))
                  '${file.path}:${i + 1}  ${lines[i].trim()}',
            ];
          }(),
    ];
    expect(
      filled,
      isEmpty,
      reason:
          'a filled Iconsax glyph is back in the browser:\n'
          '${filled.join('\n')}',
    );
  });

  test('top bars go through KyronAppBar', () {
    // A bare Material AppBar turns faintly blue the moment a list scrolls
    // under it: Material 3 raises it to `scrolledUnderElevation` and washes
    // it in `surfaceTint`. The themes turn that off and KyronAppBar draws a
    // hairline in its place, but only for the bars that go through it -- and
    // a new screen reaching for AppBar directly is how the tint comes back
    // one screen at a time.
    //
    // `SimpleAppBar` and `TopEdge` are not Material app bars at all; they are
    // Containers, and never had the tint.
    final found = offences(RegExp(r'appBar:\s*(const\s+)?AppBar\('));
    expect(
      found,
      isEmpty,
      reason:
          'a screen builds a Material AppBar directly instead of '
          'KyronAppBar:\n${found.join('\n')}',
    );
  });

  test('icons come from Iconsax, not Material', () {
    // "Don't use Material Icons (use Iconsax)" -- philosophy.md. A Material
    // glyph next to an Iconsax one is the most visible kind of drift: two
    // different drawing styles in the same row.
    final found = offences(RegExp(r'\bIcons\.[a-z_0-9]+'));
    expect(
      found,
      isEmpty,
      reason: 'a Material icon is still in use:\n${found.join('\n')}',
    );
  });
}
