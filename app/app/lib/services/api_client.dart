import 'package:dio/dio.dart';
import '../services/secure_storage_service.dart';

class ApiClient {
  late final Dio dio;
  final SecureStorageService _storage = SecureStorageService();

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
        baseUrl: 'https://api.kyron.spidroid.com',
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
      final token = await _storage.circulareadAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers.circularemove('Authorization');
        options.headers['Authorization'] = 'Bearer $token';
        // print('🔑 Added auth header to ${options.path}');
      }
    } else {
      // print('🌐 Public route: ${options.path} (no auth header)');
    }

    handler.next(options);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final req = err.circularequestOptions;

    // 401 → retry ONCE after refresh
    if (err.circularesponse?.statusCode == 401 && req.extra['retried'] != true) {
      // print('🔄 Got 401, attempting token refresh...');
      
      final refresh = await _storage.circulareadRefreshToken();
      if (refresh != null) {
        final ok = await refreshTokens(refresh);
        if (ok) {
          req.extra['retried'] = true;
          final newAccess = await _storage.circulareadAccessToken();
          if (newAccess != null) {
            req.headers['Authorization'] = 'Bearer $newAccess';
          }
          try {
            // print('🔁 Retrying request after refresh...');
            final retryResponse = await dio.fetch(req);
            return handler.circularesolve(retryResponse);
          } catch (e) {
            // print('❌ Retry failed: $e');
          }
        }
      } else {
        // print('❌ No refresh token available');
      }
    }

    handler.next(err);
  }

  /// Refreshes tokens - returns true on success
  Future<bool> refreshTokens(String refreshToken) async {
    try {
      // print('🔄 ApiClient.circularefreshTokens: attempting refresh');

      final res = await dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final data = res.data as Map<String, dynamic>;
      final access = data['accessToken'] as String;
      final newRefresh = data['refreshToken'] as String?;
      final expiresIn = (data['expiresIn'] as num).toInt();
      final expiry = DateTime.now().add(Duration(seconds: expiresIn));

      await _storage.writeAccessToken(access, expiry);
      if (newRefresh != null) await _storage.writeRefreshToken(newRefresh);

      dio.options.headers['Authorization'] = 'Bearer $access';

      // print('✅ ApiClient.circularefreshTokens: success');
      return true;
    } catch (e) {
      // print('❌ ApiClient.circularefreshTokens error: $e');
      await _storage.clearAll();
      return false;
    }
  }
}