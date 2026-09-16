// lib/models/community.dart

/// What the reader can do in a community.
enum CommunityRole {
  owner,
  moderator,
  member;

  static CommunityRole? fromWire(String? value) => switch (value) {
        'OWNER' => CommunityRole.owner,
        'MODERATOR' => CommunityRole.moderator,
        'MEMBER' => CommunityRole.member,
        _ => null,
      };

  /// What the API calls it.
  String get wire => switch (this) {
        CommunityRole.owner => 'OWNER',
        CommunityRole.moderator => 'MODERATOR',
        CommunityRole.member => 'MEMBER',
      };

  /// What a member list calls it.
  String get label => switch (this) {
        CommunityRole.owner => 'Owner',
        CommunityRole.moderator => 'Moderator',
        CommunityRole.member => 'Member',
      };

  /// Whether this role may change the community itself.
  bool get canEdit => this == CommunityRole.owner;

  /// Whether it may remove people. The owner and its moderators.
  bool get canModerate => this != CommunityRole.member;

  /// Whoever started it cannot leave it: that would leave nobody able to
  /// moderate it. Handing it over is a different thing, and not one this
  /// offers yet.
  bool get canLeave => this != CommunityRole.owner;
}

/// A named place with members, and posts written into it.
class Community {
  final String id;

  /// What it is addressed by, lower-cased. Derived from the name by the
  /// server, so the two cannot drift apart.
  final String slug;

  final String name;
  final String? description;
  final String? avatarUrl;
  final String? bannerUrl;
  final int members;
  final int posts;

  /// Whether the reader is in it.
  final bool joined;

  /// What they are in it, when they are. Null when they are not.
  final CommunityRole? role;

  const Community({
    required this.id,
    required this.slug,
    required this.name,
    this.description,
    this.avatarUrl,
    this.bannerUrl,
    this.members = 0,
    this.posts = 0,
    this.joined = false,
    this.role,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        id: json['id'] as String? ?? '',
        slug: json['slug'] as String? ?? '',
        name: json['name'] as String? ?? '',
        description: json['description'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        bannerUrl: json['bannerUrl'] as String?,
        members: (json['members'] as num?)?.toInt() ?? 0,
        posts: (json['posts'] as num?)?.toInt() ?? 0,
        joined: json['joined'] == true,
        role: CommunityRole.fromWire(json['role'] as String?),
      );

  Community copyWith({bool? joined, int? members, CommunityRole? role}) =>
      Community(
        id: id,
        slug: slug,
        name: name,
        description: description,
        avatarUrl: avatarUrl,
        bannerUrl: bannerUrl,
        members: members ?? this.members,
        posts: posts,
        joined: joined ?? this.joined,
        role: role ?? this.role,
      );

  /// True when the reader may write into it. Members only: a community anybody
  /// can post into is a feed with a name on it.
  bool get canPost => joined;
}

/// One page of communities.
class CommunityPage {
  final List<Community> items;
  final String? nextCursor;

  const CommunityPage({this.items = const [], this.nextCursor});

  factory CommunityPage.fromJson(Map<String, dynamic> json) => CommunityPage(
        items: (json['items'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(Community.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}

/// One person in a community, as the member list shows them.
class CommunityMember {
  final String id;
  final String? name;
  final String? username;
  final String? avatarUrl;

  /// Null on the removed list, where a role no longer means anything.
  final CommunityRole? role;
  final DateTime joinedAt;

  const CommunityMember({
    required this.id,
    required this.joinedAt,
    this.name,
    this.username,
    this.avatarUrl,
    this.role,
  });

  factory CommunityMember.fromJson(Map<String, dynamic> json) =>
      CommunityMember(
        id: json['id'] as String? ?? '',
        name: json['name'] as String?,
        username: json['username'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        role: CommunityRole.fromWire(json['role'] as String?),
        joinedAt:
            DateTime.tryParse(json['joinedAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
      );

  /// What the row calls them, falling through the name to the handle rather
  /// than showing a blank where a name should be.
  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final u = username?.trim();
    if (u != null && u.isNotEmpty) return '@$u';
    return 'Someone';
  }

  String? get handle {
    final u = username?.trim();
    return (u == null || u.isEmpty) ? null : '@$u';
  }

  CommunityMember copyWith({CommunityRole? role}) => CommunityMember(
        id: id,
        name: name,
        username: username,
        avatarUrl: avatarUrl,
        role: role ?? this.role,
        joinedAt: joinedAt,
      );
}

/// One page of a community's roll.
class CommunityMemberPage {
  final List<CommunityMember> items;
  final String? nextCursor;

  const CommunityMemberPage({required this.items, this.nextCursor});

  factory CommunityMemberPage.fromJson(Map<String, dynamic> json) =>
      CommunityMemberPage(
        items: ((json['items'] as List<dynamic>?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(CommunityMember.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}
