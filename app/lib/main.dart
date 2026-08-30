import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Add this import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/draft_service.dart';
import 'theme/app_theme.dart';
import 'routes.dart';
import 'providers/auth_provider.dart';
import 'screens/root_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy(); // Removes # from URLs on web

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
          backgroundColor: AppTheme.background,
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
