// lib/models/profile_summary.dart

/// One person in a list of people: a search result, or a suggestion.
///
/// Enough to render a row and open the profile, and nothing more -- the full
/// profile is read when you get there.
class ProfileSummary {
  final String id;
  final String? name;
  final String? username;
  final String? did;
  final String? avatarUrl;
  final String? bio;
  final int followers;
  final int kyronPoints;

  /// Whether the reader already follows this person. Filled by the endpoints
  /// that return a list of people, so a row can carry a working Follow button
  /// without a request per row.
  final bool isFollowing;

  /// True on the reader's own row, which never gets a Follow button.
  final bool isSelf;

  const ProfileSummary({
    required this.id,
    this.name,
    this.username,
    this.did,
    this.avatarUrl,
    this.bio,
    this.followers = 0,
    this.kyronPoints = 0,
    this.isFollowing = false,
    this.isSelf = false,
  });

  factory ProfileSummary.fromJson(Map<String, dynamic> json) => ProfileSummary(
        id: json['id'] as String? ?? '',
        name: json['name'] as String?,
        username: json['username'] as String?,
        did: json['did'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        bio: json['bio'] as String?,
        followers: (json['followers'] as num?)?.toInt() ?? 0,
        kyronPoints: (json['kyronPoints'] as num?)?.toInt() ?? 0,
        isFollowing: json['isFollowing'] == true,
        isSelf: json['isSelf'] == true,
      );

  ProfileSummary copyWith({bool? isFollowing, int? followers}) =>
      ProfileSummary(
        id: id,
        name: name,
        username: username,
        did: did,
        avatarUrl: avatarUrl,
        bio: bio,
        followers: followers ?? this.followers,
        kyronPoints: kyronPoints,
        isFollowing: isFollowing ?? this.isFollowing,
        isSelf: isSelf,
      );

  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final u = username?.trim();
    if (u != null && u.isNotEmpty) return u;
    return 'Someone on Kyron';
  }

  String? get handle {
    final u = username?.trim();
    return (u == null || u.isEmpty) ? null : '@$u';
  }
}
