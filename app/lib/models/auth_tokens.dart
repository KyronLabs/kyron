class AuthTokens {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });
}
