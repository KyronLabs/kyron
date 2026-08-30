import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiClient {
  late final Dio dio;

  // 🔥 Routes that should NOT have Authorization header
  static const _publicRoutes = [
    '/auth/login',
    '/auth/register',
    '/auth/refresh',
    '/auth/verify-email',
  ];

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://kyron.fly.dev',
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    )..interceptors.add(
        InterceptorsWrapper(
          onRequest: _onRequest,
          onError: _onError,
        ),
      );
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 🔥 CRITICAL FIX: Skip auth header for public routes
    final isPublicRoute = _publicRoutes.any((route) => options.path.endsWith(route));
    
    if (!isPublicRoute) {
      // Read the token off the live session rather than a stored copy: the
      // Supabase SDK refreshes in the background, so whatever it holds now is
      // current and a cached value could already be stale.
      final token = Supabase.instance.client.auth.currentSession?.accessToken;
      if (token != null && token.isNotEmpty) {
        options.headers.remove('Authorization');
        options.headers['Authorization'] = 'Bearer $token';
      }
    } else {
      print('🌐 Public route: ${options.path} (no auth header)');
    }

    handler.next(options);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final req = err.requestOptions;

    // A 401 means the access token the SDK handed us was rejected. Ask Supabase
    // for a fresh session and replay the request once. Refresh itself is the
    // SDK's job -- this only covers the window where a token expired between
    // being attached and reaching the API.
    if (err.response?.statusCode == 401 && req.extra['retried'] != true) {
      try {
        final refreshed =
            await Supabase.instance.client.auth.refreshSession();
        final token = refreshed.session?.accessToken;
        if (token != null && token.isNotEmpty) {
          req.extra['retried'] = true;
          req.headers['Authorization'] = 'Bearer $token';
          final retryResponse = await dio.fetch(req);
          return handler.resolve(retryResponse);
        }
      } catch (_) {
        // Fall through: the session cannot be renewed, so the caller should see
        // the original 401 and route to sign-in.
      }
    }

    handler.next(err);
  }
}
