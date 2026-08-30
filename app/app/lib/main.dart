import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/draft_service.dart';
import 'theme/app_theme.dart';
import 'routes.dart';
import 'providers/auth_provider.dart';
import 'screens/root_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  runApp(
    const ProviderScope(
      child: KyronApp(),
    ),
  );
}

class KyronApp extends ConsumerStatefulWidget {
  const KyronApp({super.key});

  @override
  ConsumerState<KyronApp> createState() => _KyronAppState();
}

class _KyronAppState extends ConsumerState<KyronApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(milliseconds: 100));

    ref.read(authNotifierProvider.notifier).bootstrap();

    if (!kIsWeb) {
      await DraftService().database;
    }

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: AppTheme.lightBackground,
          body: Center(
            child: CircularProgressIndicator(
              color: AppTheme.accent,
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Kyron',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const RootScreen(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
