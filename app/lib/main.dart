import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Add this import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/app_log.dart';
import 'services/draft_service.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'routes.dart';
import 'providers/auth_provider.dart';
import 'providers/preferences_provider.dart';
import 'screens/root_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy(); // Removes # from URLs on web

  // A screen that fails to build renders a bare grey rectangle in a release
  // build -- which is what a blank page in this app has meant, with nothing
  // on screen or in the log to say which screen or why. This says both, and
  // records it so About > System log still has it after the screen is closed.
  ErrorWidget.builder = _describeBuildFailure;

  // Fails here, with the name of the missing value, rather than as an opaque
  // authorization error on the first request.
  SupabaseConfig.assertConfigured();

  // Supabase is the identity provider. Initialising here means the SDK has
  // restored any persisted session before the first widget builds, so the app
  // does not flash the login screen for an already-signed-in user.
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(
    const ProviderScope(
      child: KyronApp(),
    ),
  );
}

/// What to draw in place of a widget whose build threw.
Widget _describeBuildFailure(FlutterErrorDetails details) {
  AppLog.instance.error(
    'ui',
    '${details.exceptionAsString()} (${details.context ?? 'while building'})',
  );

  return Builder(
    builder: (context) {
      // Read defensively: this can be reached above MaterialApp, where there
      // is no theme to ask.
      final scheme =
          context.findAncestorWidgetOfExactType<MaterialApp>() == null
              ? null
              : Theme.of(context).colorScheme;
      return Material(
        color: scheme?.surface ?? const Color(0xFF141414),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 40, color: scheme?.error ?? const Color(0xFFE5484D)),
              const SizedBox(height: 12),
              Text(
                'This screen could not be drawn.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: scheme?.onSurface ?? const Color(0xFFE5EBF5),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                details.exceptionAsString(),
                textAlign: TextAlign.center,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: (scheme?.onSurface ?? const Color(0xFFE5EBF5))
                      .withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'It is in About \u203a System log.',
                style: TextStyle(
                  fontSize: 12,
                  color: (scheme?.onSurface ?? const Color(0xFFE5EBF5))
                      .withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class KyronApp extends ConsumerStatefulWidget {
  const KyronApp({super.key, this.enableLocalDatabase = true});

  /// Allows tests and unsupported platforms to skip native database startup.
  final bool enableLocalDatabase;

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
    // Wait a bit for everything to initialize
    await Future.delayed(const Duration(milliseconds: 100));

    // Whatever the last run recorded, so a crash report opened now still has
    // the events that led to it.
    await AppLog.instance.load();

    // Run bootstrap
    ref.read(authNotifierProvider.notifier).bootstrap();

    // Pre-warm composer - ONLY on non-web platforms
    if (!kIsWeb && widget.enableLocalDatabase) {
      await DraftService().database; // Initialize DB in background
    }

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: KyronTheme.darkBackground,
          body: Center(
            child: CircularProgressIndicator(
              color: KyronTheme.accent,
            ),
          ),
        ),
      );
    }

    // The chosen scale is applied here so it reaches every screen, rather
    // than only the one that sets it. Clamped to exactly the chosen value:
    // compounding it with the platform's own accessibility scale would take
    // the largest setting somewhere no layout has been checked against.
    final textScale = ref.watch(preferencesProvider).textScale;

    return MaterialApp(
      title: 'Kyron',
      debugShowCheckedModeBanner: false,
      theme: KyronTheme.lightTheme,
      darkTheme: KyronTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const RootScreen(),
      onGenerateRoute: Routes.onGenerateRoute,
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: textScale,
        maxScaleFactor: textScale,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
