import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/screens/second_factor_screen.dart';
import 'package:kyron_app/services/second_factor.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const out =
    '/tmp/claude-0/-home-user/12d35714-7d93-5c89-a11a-4fab0fe9bb15/scratchpad/renders';

/// A QR-like pattern: three finder squares and a fixed scatter of modules.
final String qr = () {
  const n = 25;
  final cells = StringBuffer();
  for (var y = 0; y < n; y++) {
    for (var x = 0; x < n; x++) {
      var on = (x * 7 + y * 13 + x * y) % 3 == 0;
      for (final (x0, y0) in [(0, 0), (18, 0), (0, 18)]) {
        final fx = x - x0, fy = y - y0;
        if (fx >= 0 && fx < 7 && fy >= 0 && fy < 7) {
          on = fx == 0 ||
              fx == 6 ||
              fy == 0 ||
              fy == 6 ||
              (fx >= 2 && fx <= 4 && fy >= 2 && fy <= 4);
        }
      }
      if (on) cells.write('<rect x="$x" y="$y" width="1" height="1"/>');
    }
  }
  return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 $n $n">$cells</svg>';
}();

class _Fake extends SecondFactor {
  _Fake(this.enrolled) : super(auth: Supabase.instance.client.auth);
  final bool enrolled;
  @override
  Future<Factor?> verifiedFactor() async => enrolled
      ? Factor(
          id: 'f1',
          friendlyName: 'Authenticator',
          factorType: FactorType.totp,
          status: FactorStatus.verified,
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026),
        )
      : null;
  @override
  bool get sessionPassed => false;
  @override
  Future<({String factorId, String qrSvg, String secret})> start() async =>
      (factorId: 'f1', qrSvg: qr, secret: 'JBSWY3DPEHPK3PXPJBSWY3DPEHPK3PXP');
  @override
  Future<void> verify(String factorId, String code) async =>
      throw const AuthException('Invalid TOTP code');
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await Supabase.initialize(
      url: 'http://localhost:54321',
      anonKey: 'test-anon-key',
      debug: false,
    );
  });

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
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 720);
    addTearDown(tester.view.reset);

    Future<void> settle() async {
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 32));
      }
    }

    Future<void> shoot(String name) async {
      await settle();
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
      final mode = dark ? 'dark' : 'light';
      for (final enrolled in [false, true]) {
        await tester.pumpWidget(
          RepaintBoundary(
            child: MaterialApp(
              key: ValueKey('$dark$enrolled'),
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: SecondFactorScreen(service: _Fake(enrolled)),
            ),
          ),
        );
        if (!enrolled) {
          await shoot('2fa-intro-$mode');
          await tester.tap(find.byKey(const ValueKey('2fa-start')));
          await shoot('2fa-setup-$mode');
        } else {
          await shoot('2fa-on-$mode');
          await tester.tap(find.byKey(const ValueKey('2fa-remove')));
          await settle();
          await tester.enterText(
              find.byKey(const ValueKey('2fa-code')), '123456');
          await tester.tap(find.byKey(const ValueKey('2fa-verify')));
          await shoot('2fa-sheet-$mode');
        }
      }
    }
    exit(0);
  });
}
