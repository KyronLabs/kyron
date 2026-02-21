import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';
import '../services/secure_storage_service.dart';
import 'current_user_provider.dart';

enum AuthStatus { unknown, unauthenticated, authenticating, authenticated }

class AuthState {
  final AuthStatus status;
  final User? user;
  
  AuthState._({required this.status, this.user});
  
  factory AuthState.unknown() => AuthState._(status: AuthStatus.unknown);
  factory AuthState.unauth() => AuthState._(status: AuthStatus.unauthenticated);
  factory AuthState.authenticating() => AuthState._(status: AuthStatus.authenticating);
  factory AuthState.authenticated(User user) => AuthState._(status: AuthStatus.authenticated, user: user);
}

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repo;

  @override
  AuthState build() {
    _repo = ref.read(authRepositoryProvider);
    return AuthState.unknown();
  }

  /// Called at app startup
  Future<void> bootstrap() async {
    print('🔄 AuthNotifier.bootstrap() called');
    
    // If already authenticated, skip
    if (state.status == AuthStatus.authenticated) {
      print('⚠️ Already authenticated, skipping bootstrap');
      return;
    }
    
    state = AuthState.authenticating();
    
    try {
      // First, try to get user data from storage
      final user = await _repo.getStoredUserData();
      final hasValidToken = await _repo.hasValidAccessToken();
      
      print('🔍 Bootstrap: hasValidToken=$hasValidToken, user=${user?.email}');
      
      // If we have a valid token AND user data, we're authenticated
      if (hasValidToken && user != null) {
        print('✅ Bootstrap: Valid token and user found, setting authenticated');
        state = AuthState.authenticated(user);
        
        // Load full profile data
        ref.read(currentUserProvider.notifier).load();
        return;
      }
      
      // If we have user data but token is expired, try refresh
      final refreshToken = await SecureStorageService().readRefreshToken();
      if (refreshToken != null && user != null) {
        print('🔄 Bootstrap: Token expired/missing, attempting refresh...');
        try {
          final refreshed = await _repo.refresh();
          if (refreshed) {
            final refreshedUser = await _repo.getStoredUserData();
            if (refreshedUser != null) {
              print('✅ Bootstrap: Token refresh successful');
              state = AuthState.authenticated(refreshedUser);
              
              // Load full profile data
              ref.read(currentUserProvider.notifier).load();
              return;
            }
          }
        } catch (e) {
          print('❌ Bootstrap: Refresh failed: $e');
        }
      }
      
      // If we get here, we're not authenticated
      print('🚫 Bootstrap: No valid session found');
      state = AuthState.unauth();
      
    } catch (e) {
      print('❌ Bootstrap error: $e');
      state = AuthState.unauth();
    }
  }

  Future<bool> login(String email, String password) async {
    state = AuthState.authenticating();
    try {
      print('🔐 AuthNotifier.login: Starting for $email');
      
      final resp = await _repo.loginWithUser(email: email, password: password);
      
      print('✅ AuthNotifier.login: Backend responded, user=${resp.user.email}');
      
      state = AuthState.authenticated(resp.user);
      
      // Load full profile data from /profile/me
      print('🔄 AuthNotifier.login: Loading full profile...');
      await ref.read(currentUserProvider.notifier).load();
      
      print('✅ AuthNotifier.login: Complete');
      return true;
    } catch (e) {
      print('❌ Login error: $e');
      state = AuthState.unauth();
      return false;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    
    // Clear profile data
    ref.read(currentUserProvider.notifier).clear();
    
    state = AuthState.unauth();
  }

  Future<bool> refreshTokens() async {
    try {
      final ok = await _repo.refresh();
      if (!ok) {
        state = AuthState.unauth();
        return false;
      }
      
      final user = await _repo.getStoredUserData();
      if (user != null) {
        state = AuthState.authenticated(user);
        
        // Reload profile data
        ref.read(currentUserProvider.notifier).load();
        return true;
      }
      
      state = AuthState.unauth();
      return false;
    } catch (e) {
      print('❌ Refresh tokens error: $e');
      state = AuthState.unauth();
      return false;
    }
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() => AuthNotifier());

// Helper providers
final currentAuthUserProvider = Provider<User?>((ref) {
  final s = ref.watch(authNotifierProvider);
  return s.user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final s = ref.watch(authNotifierProvider);
  return s.status == AuthStatus.authenticated;
});