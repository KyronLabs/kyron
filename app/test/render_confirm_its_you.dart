import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/account_provider.dart';
import 'package:kyron_app/providers/auth_provider.dart';
import 'package:kyron_app/repositories/account_repository.dart';
import 'package:kyron_app/repositories/auth_repository.dart';
import 'package:kyron_app/screens/delete_account_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

const out =
    '/tmp/claude-0/-home-user/12d35714-7d93-5c89-a11a-4fab0fe9bb15/scratchpad/renders';

class _Account extends AccountRepository {
  _Account() : super(ApiClient()..dio.interceptors.clear());
  @override
  Future<void> delete() async {
    final request = RequestOptions(path: '/account');
    throw DioException(
      requestOptions: request,
      response: Response<Object>(
        requestOptions: request,
        statusCode: 403,
        data: {'code': 'RECENT_SIGN_IN_REQUIRED'},
      ),
    );
  }
}

class _Repo extends AuthRepository {
  _Repo(this.password);
  final bool password;
  @override
  bool get hasPassword => password;
}

class _Auth extends AuthNotifier {
  @override
  AuthState build() => AuthState.unauth();
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
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.reset);

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

    for (final password in [true, false]) {
      for (final dark in [false, true]) {
        await tester.pumpWidget(
          RepaintBoundary(
            child: ProviderScope(
              overrides: [
                accountRepositoryProvider.overrideWithValue(_Account()),
                authRepositoryProvider.overrideWithValue(_Repo(password)),
                authNotifierProvider.overrideWith(_Auth.new),
              ],
              child: MaterialApp(
                key: ValueKey('$dark$password'),
                debugShowCheckedModeBanner: false,
                theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
                home: const DeleteAccountScreen(),
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.byKey(const ValueKey('delete-account-confirm')));
        for (var i = 0; i < 40; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }
        await tester.tap(find.byKey(const ValueKey('delete-account-final')));
        for (var i = 0; i < 40; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }
        expect(find.text("Confirm it's you"), findsOneWidget);
        await shoot(
            'confirm-${password ? 'password' : 'google'}-${dark ? 'dark' : 'light'}');
      }
    }
    exit(0);
  });
}
