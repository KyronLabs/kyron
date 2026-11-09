import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/home_prompts.dart';
import 'package:kyron_app/widgets/check_in_sheet.dart';
import 'package:kyron_app/widgets/whats_new_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A tool, not a test: the "What's new" card, from the notes the build
/// carries, and the day-3 check-in, light and dark.
///
///     flutter test test/render_home_prompts.dart --dart-define=shots=/tmp/x
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family);
      for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
        loader.addFont(rootBundle.load('assets/fonts/Inter-$weight.ttf'));
      }
      await loader.load();
    }
    final icons = FontLoader('packages/iconsax_flutter/FlutterIconsax');
    icons.addFont(
      rootBundle.load('packages/iconsax_flutter/fonts/FlutterIconsax.ttf'),
    );
    await icons.load();
    // Colour emoji for the check-in's faces, as a phone has them.
    final emoji = FontLoader('NotoColorEmoji');
    final emojiFile = File('/usr/share/fonts/truetype/noto/NotoColorEmoji.ttf');
    if (emojiFile.existsSync()) {
      emoji.addFont(
        Future.value(ByteData.sublistView(emojiFile.readAsBytesSync())),
      );
      await emoji.load();
    }

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 760);
    addTearDown(tester.view.reset);

    final notes = await HomePrompts.bundledNotes();

    Future<void> shoot(String name) async {
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 32));
      }
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byType(RepaintBoundary).first,
      );
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 2);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        return data!.buffer.asUint8List();
      });
      File('$out/$name.png').writeAsBytesSync(bytes!);
    }

    for (final dark in [false, true]) {
      for (final (name, show)
          in <(String, Future<void> Function(BuildContext))>[
        ('whats-new', (c) => WhatsNewSheet.show(c, notes.take(1).toList())),
        ('check-in', (c) => CheckInSheet.show(c, day: 3)),
      ]) {
        await tester.pumpWidget(
          RepaintBoundary(
            child: ProviderScope(
              child: MaterialApp(
                key: ValueKey('$name$dark'),
                debugShowCheckedModeBanner: false,
                theme: _withEmoji(
                  dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
                ),
                home: Builder(
                  builder: (context) => Scaffold(
                    body: Center(
                      child: TextButton(
                        onPressed: () => show(context),
                        child: const Text('open'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('open'));
        if (name == 'check-in') {
          await shoot('$name-${dark ? 'dark' : 'light'}');
          await tester.tap(find.byKey(const ValueKey('check-in-face-4')));
          await shoot('$name-picked-${dark ? 'dark' : 'light'}');
        } else {
          await shoot('$name-${dark ? 'dark' : 'light'}');
        }
      }
    }
    exit(0);
  });
}

ThemeData _withEmoji(ThemeData theme) => theme.copyWith(
      textTheme: theme.textTheme.apply(fontFamilyFallback: ['NotoColorEmoji']),
    );
