import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Stands in for Android's Credential Manager, so the paths that never reach
/// Supabase can be exercised without one.
class FakeGooglePlatform extends GoogleSignInPlatform
    with MockPlatformInterfaceMixin {
  FakeGooglePlatform({
    this.supports = true,
    this.result,
    this.throws,
    this.initThrows,
  });

  final bool supports;
  final AuthenticationResults? result;
  final Object? throws;
  final Object? initThrows;

  InitParameters? initialisedWith;

  @override
  Future<void> init(InitParameters params) async {
    initialisedWith = params;
    if (initThrows != null) throw initThrows!;
  }

  @override
  bool supportsAuthenticate() => supports;

  @override
  Future<AuthenticationResults> authenticate(AuthenticateParameters params) {
    if (throws != null) return Future<AuthenticationResults>.error(throws!);
    return Future<AuthenticationResults>.value(result!);
  }

  // The rest of the interface. Kyron asks for authentication only -- no
  // scopes, no silent sign-in, no token refresh -- so anything reaching these
  // is a change in behaviour the tests should notice rather than absorb.
  @override
  Future<AuthenticationResults?>? attemptLightweightAuthentication(
    AttemptLightweightAuthenticationParameters params,
  ) => throw UnimplementedError('Kyron does not sign in silently');

  @override
  bool authorizationRequiresUserInteraction() =>
      throw UnimplementedError('Kyron asks for no scopes');

  @override
  Future<ClientAuthorizationTokenData?> clientAuthorizationTokensForScopes(
    ClientAuthorizationTokensForScopesParameters params,
  ) => throw UnimplementedError('Kyron asks for no scopes');

  @override
  Future<ServerAuthorizationTokenData?> serverAuthorizationTokensForScopes(
    ServerAuthorizationTokensForScopesParameters params,
  ) => throw UnimplementedError('Kyron asks for no scopes');

  @override
  Future<void> disconnect(DisconnectParams params) =>
      throw UnimplementedError('Kyron signs out through Supabase');

  @override
  Future<void> signOut(SignOutParams params) =>
      throw UnimplementedError('Kyron signs out through Supabase');
}

AuthenticationResults googleResults({String? idToken}) => AuthenticationResults(
  user: const GoogleSignInUserData(id: 'g1', email: 'a@b.c'),
  authenticationTokens: AuthenticationTokenData(idToken: idToken),
);
