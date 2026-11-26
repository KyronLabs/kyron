import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/action_button.dart';
import 'package:kyron_app/widgets/app_sheet.dart';
import 'package:kyron_app/widgets/hairline.dart';
import 'package:kyron_app/widgets/play_coin_purchase_panel.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

void main() {
  testWidgets('coin pack art, localized prices and selection on a phone',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 750));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final capturePreview = Platform.environment['KYRON_COIN_PREVIEW'] == '1';
    if (capturePreview) {
      await tester.runAsync(() async {
        final manifest = jsonDecode(
          await rootBundle.loadString('FontManifest.json'),
        ) as List<dynamic>;
        for (final entry in manifest.cast<Map<String, dynamic>>()) {
          final loader = FontLoader(entry['family'] as String);
          for (final font in (entry['fonts'] as List<dynamic>)
              .cast<Map<String, dynamic>>()) {
            loader.addFont(rootBundle.load(font['asset'] as String));
          }
          await loader.load();
        }
      });
    }
    final capture = GlobalKey();
    var selected = 100;
    const packs = {
      100: ('100 coins', 'GH₵5.00'),
      500: ('500 coins', 'GH₵25.00'),
      1000: ('1,000 coins', 'GH₵50.00'),
    };

    await tester.pumpWidget(
      RepaintBoundary(
        key: capture,
        child: MaterialApp(
          theme: KyronTheme.darkTheme,
          home: Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Wallet')),
              body: Center(
                child: ActionButton(
                  label: 'Open coin shop',
                  onPressed: () => showAppSheet<void>(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    builder: (_) => CoinPurchaseSheet(
                      child: StatefulBuilder(
                        builder: (context, update) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'Prices and availability come from your Google Play storefront.',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            for (final entry in packs.entries) ...[
                              const Hairline(),
                              CoinPackOption(
                                coins: entry.key,
                                label: entry.value.$1,
                                price: entry.value.$2,
                                selected: selected == entry.key,
                                onTap: () => update(() => selected = entry.key),
                              ),
                            ],
                            const Hairline(),
                            const SizedBox(height: 16),
                            ActionButton(
                              label: 'Recharge',
                              expand: true,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open coin shop'));
    await tester.pumpAndSettle();

    expect(find.byType(CoinPackOption), findsNWidgets(3));
    expect(find.byType(Image), findsNWidgets(3));
    await tester.tap(find.text('500 coins'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<CoinPackOption>(find.byType(CoinPackOption).at(1)).selected,
      isTrue,
    );

    if (capturePreview) {
      await tester.runAsync(() async {
        final boundary = capture.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
        final frame = await boundary.toImage(pixelRatio: 2);
        try {
          final png = await frame.toByteData(format: ui.ImageByteFormat.png);
          await File('coin-shop-preview.png')
              .writeAsBytes(png!.buffer.asUint8List());
        } finally {
          frame.dispose();
        }
      });
    }
    expect(tester.takeException(), isNull);
  });
}
