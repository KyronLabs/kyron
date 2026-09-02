// lib/models/profile_model.dart

import 'current_user.dart';

/// A profile, as GET /profile/me and GET /profile/:username return it.
///
/// The old shape carried badges, verification, a socials list and separate
/// reply, media and like counts. The API knows none of those, so every one of
/// them had to be invented -- and it was: `ProfileModel.mock()` and a
/// `_fetchProfileByDid` that derived follower counts from `did.hashCode`. A
/// field only exists here once the server can answer for it.
class ProfileModel {
  final String id;
  final String? name;
  final String? username;
  final String? did;
  final int kyronPoints;
  final String? avatarUrl;
  final String? coverUrl;
  final String? bio;
  final String? location;
  final String? website;
  final int followers;
  final int following;
  final int posts;

  /// Whether the viewer follows this account. Always false on your own.
  final bool isFollowing;

  final bool isOwnProfile;

  const ProfileModel({
    required this.id,
    this.name,
    this.username,
    this.did,
    required this.kyronPoints,
    this.avatarUrl,
    this.coverUrl,
    this.bio,
    this.location,
    this.website,
    required this.followers,
    required this.following,
    required this.posts,
    this.isFollowing = false,
    this.isOwnProfile = false,
  });

  factory ProfileModel.fromJson(
    Map<String, dynamic> json, {
    bool isOwnProfile = false,
  }) {
    final user = _map(json['user']);
    final profile = _map(json['profile']);
    final stats = _map(json['stats']);

    return ProfileModel(
      id: user['id'] as String? ?? '',
      name: user['name'] as String?,
      username: user['username'] as String?,
      did: user['did'] as String?,
      kyronPoints: _int(user['kyronPoints']),
      avatarUrl: profile['avatarUrl'] as String?,
      coverUrl: profile['coverUrl'] as String?,
      bio: profile['bio'] as String?,
      location: profile['location'] as String?,
      website: profile['website'] as String?,
      followers: _int(stats['followers']),
      following: _int(stats['following']),
      posts: _int(stats['posts']),
      isFollowing: stats['isFollowing'] == true,
      isOwnProfile: isOwnProfile,
    );
  }

  /// Your own profile, from the response the drawer and top bar already hold.
  ///
  /// Saves a second round trip when you open your profile from the app shell:
  /// /profile/me has been read by then, and it carries the same fields.
  factory ProfileModel.fromCurrentUser(CurrentUser user) => ProfileModel(
        id: user.id,
        name: user.name,
        username: user.username,
        did: user.did,
        kyronPoints: user.kyronPoints,
        avatarUrl: user.avatarUrl,
        coverUrl: user.coverUrl,
        bio: user.bio,
        location: user.location,
        website: user.website,
        followers: user.followers,
        following: user.following,
        posts: user.posts,
        isOwnProfile: true,
      );

  ProfileModel copyWith({
    int? followers,
    bool? isFollowing,
    bool? isOwnProfile,
  }) {
    return ProfileModel(
      id: id,
      name: name,
      username: username,
      did: did,
      kyronPoints: kyronPoints,
      avatarUrl: avatarUrl,
      coverUrl: coverUrl,
      bio: bio,
      location: location,
      website: website,
      followers: followers ?? this.followers,
      following: following,
      posts: posts,
      isFollowing: isFollowing ?? this.isFollowing,
      isOwnProfile: isOwnProfile ?? this.isOwnProfile,
    );
  }

  /// What to put above the profile. Falls back through name, then handle --
  /// never to a placeholder, which is what made a real account look like
  /// filler everywhere else in the app.
  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final u = username?.trim();
    if (u != null && u.isNotEmpty) return u;
    return isOwnProfile ? 'Your account' : 'Someone on Kyron';
  }

  /// The @handle, or null when the account has not set one yet.
  String? get handle {
    final u = username?.trim();
    return (u == null || u.isEmpty) ? null : '@$u';
  }

  static Map<String, dynamic> _map(Object? value) =>
      value is Map<String, dynamic> ? value : const <String, dynamic>{};

  static int _int(Object? value) => value is num ? value.toInt() : 0;
}
