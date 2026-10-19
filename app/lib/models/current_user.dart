// lib/models/current_user.dart

/// The signed-in account, exactly as GET /profile/me returns it.
///
/// Every field here is one the API actually sends. The follower count used to
/// be the only stat this kept, so the drawer and the profile screen could show
/// followers and nothing else -- `following` and the post count arrived in the
/// same response and were dropped on the floor.
class CurrentUser {
  final String id;
  final String? name;
  final String? username;
  final String? did;
  final String? avatarUrl;
  final String? coverUrl;
  final String? bio;
  final String? location;
  final String? website;
  final int followers;
  final int following;
  final int posts;

  /// USER, MODERATOR or ADMIN. Only ever this account's own: what decides
  /// whether the moderation queue is offered. The server checks again.
  final String role;

  /// Somebody on the Kyron team checked it is who it says it is.
  final bool verified;

  const CurrentUser({
    required this.id,
    this.name,
    this.username,
    this.did,
    this.avatarUrl,
    this.coverUrl,
    this.bio,
    this.location,
    this.website,
    required this.followers,
    required this.following,
    required this.posts,
    this.role = 'USER',
    this.verified = false,
  });

  /// On the moderation team.
  bool get isStaff => role == 'ADMIN' || role == 'MODERATOR';

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    final user = _map(json['user']);
    final profile = _map(json['profile']);
    final stats = _map(json['stats']);

    return CurrentUser(
      id: user['id'] as String? ?? '',
      name: user['name'] as String?,
      username: user['username'] as String?,
      did: user['did'] as String?,
      avatarUrl: profile['avatarUrl'] as String?,
      coverUrl: profile['coverUrl'] as String?,
      bio: profile['bio'] as String?,
      location: profile['location'] as String?,
      website: profile['website'] as String?,
      followers: _int(stats['followers']),
      following: _int(stats['following']),
      posts: _int(stats['posts']),
      role: user['role'] as String? ?? 'USER',
      verified: user['verified'] == true,
    );
  }

  /// What to put above a profile. Falls back through name, then handle -- never
  /// to a placeholder, which is what made a real account look like filler.
  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final u = username?.trim();
    if (u != null && u.isNotEmpty) return u;
    return 'Your account';
  }

  /// The @handle, or null when the account has not set one yet.
  String? get handle {
    final u = username?.trim();
    return (u == null || u.isEmpty) ? null : '@$u';
  }

  static Map<String, dynamic> _map(Object? value) =>
      value is Map<String, dynamic> ? value : const <String, dynamic>{};

  static int _int(Object? value) => value is num ? value.toInt() : 0;

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'name': name,
        'username': username,
        'did': did,
        'role': role,
        'verified': verified,
      },
      'profile': {
        'avatarUrl': avatarUrl,
        'coverUrl': coverUrl,
        'bio': bio,
        'location': location,
        'website': website,
      },
      'stats': {'followers': followers, 'following': following, 'posts': posts},
    };
  }
}
