import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_log.dart';

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
        baseUrl: 'https://kyron-47r6.onrender.com',
        // Long enough to survive a cold start. The API is on a Render plan
        // that sleeps after a spell of inactivity, and the first request
        // afterwards waits for the container to come up rather than for the
        // server to think. At 20 s that request timed out and the app said it
        // could not reach Kyron, on a service that was merely asleep and
        // about to answer.
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    )..interceptors.add(
        InterceptorsWrapper(
          onRequest: _onRequest,
          onResponse: _onResponse,
          onError: _onError,
        ),
      );
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 🔥 CRITICAL FIX: Skip auth header for public routes
    final isPublicRoute =
        _publicRoutes.any((route) => options.path.endsWith(route));

    if (!isPublicRoute) {
      // Read the token off the live session rather than a stored copy: the
      // Supabase SDK refreshes in the background, so whatever it holds now is
      // current and a cached value could already be stale.
      final token = Supabase.instance.client.auth.currentSession?.accessToken;
      if (token != null && token.isNotEmpty) {
        options.headers.remove('Authorization');
        options.headers['Authorization'] = 'Bearer $token';
      }
    } else {}

    handler.next(options);
  }

  void _onResponse(Response<dynamic> res, ResponseInterceptorHandler handler) {
    // Kept at info, and deliberately without any body: the log can be sent to
    // support, and a profile or a feed page is somebody's content.
    AppLog.instance.info(
      'api',
      '${res.requestOptions.method} ${res.requestOptions.path} '
          '-- ${res.statusCode}',
    );
    handler.next(res);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final req = err.requestOptions;

    // Recorded so About > System log has something to show. It reported
    // "Nothing logged yet" no matter what went wrong, because the only things
    // that ever wrote to it were a failed post and a cache clear -- so the one
    // screen built for diagnosing a problem never saw any of them.
    AppLog.instance.error(
      'api',
      '${req.method} ${req.path} -- '
          '${err.response?.statusCode ?? err.type.name}'
          '${err.message == null ? '' : ': ${err.message}'}',
    );

    // A 401 means the access token the SDK handed us was rejected. Ask Supabase
    // for a fresh session and replay the request once. Refresh itself is the
    // SDK's job -- this only covers the window where a token expired between
    // being attached and reaching the API.
    if (err.response?.statusCode == 401 && req.extra['retried'] != true) {
      try {
        final refreshed = await Supabase.instance.client.auth.refreshSession();
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
