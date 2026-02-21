// lib/models/current_user.dart

class CurrentUser {
  final String id;
  final String? username;
  final String? did;
  final int kyronPoints;
  final String? avatarUrl;
  final String? coverUrl;
  final int followers;

  CurrentUser({
    required this.id,
    this.username,
    this.did,
    required this.kyronPoints,
    this.avatarUrl,
    this.coverUrl,
    required this.followers,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    final profile = json['profile'] ?? {};
    final stats = json['stats'] ?? {};

    return CurrentUser(
      id: user['id'],
      username: user['username'],
      did: user['did'],
      kyronPoints: user['kyronPoints'] ?? 0,
      // Use camelCase keys (not snake_case)
      avatarUrl: profile['avatarUrl'],
      coverUrl: profile['coverUrl'],
      followers: stats['followers'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'username': username,
        'did': did,
        'kyronPoints': kyronPoints,
      },
      'profile': {
        'avatarUrl': avatarUrl,
        'coverUrl': coverUrl,
      },
      'stats': {
        'followers': followers,
      },
    };
  }
}