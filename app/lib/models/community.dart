// lib/models/community.dart
import 'post_media.dart';

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

  /// The newest post in it, for the reader's own list. Null when nobody has
  /// posted, and on every other list.
  final CommunityLastPost? lastPost;

  /// Posts by other people since the reader last opened it.
  final int unread;

  /// Its newest post, or when the reader joined. Null off the reader's list.
  final DateTime? lastActivityAt;

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
    this.lastPost,
    this.unread = 0,
    this.lastActivityAt,
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
        lastPost: json['lastPost'] is Map<String, dynamic>
            ? CommunityLastPost.fromJson(
                json['lastPost'] as Map<String, dynamic>,
              )
            : null,
        unread: (json['unread'] as num?)?.toInt() ?? 0,
        lastActivityAt:
            DateTime.tryParse(json['lastActivityAt'] as String? ?? '')
                ?.toLocal(),
      );

  Community copyWith({
    bool? joined,
    int? members,
    CommunityRole? role,
    int? unread,
  }) =>
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
        lastPost: lastPost,
        unread: unread ?? this.unread,
        lastActivityAt: lastActivityAt,
      );

  /// True when the reader may write into it. Members only: a community anybody
  /// can post into is a feed with a name on it.
  bool get canPost => joined;
}

/// The newest post in a community, as much as a list row shows.
class CommunityLastPost {
  final String id;
  final String authorId;
  final String? authorName;

  /// Its first words; the server sends no more than a row needs.
  final String body;
  final List<MediaKind> media;
  final DateTime createdAt;

  const CommunityLastPost({
    required this.id,
    required this.authorId,
    required this.body,
    required this.createdAt,
    this.authorName,
    this.media = const [],
  });

  factory CommunityLastPost.fromJson(Map<String, dynamic> json) =>
      CommunityLastPost(
        id: json['id'] as String? ?? '',
        authorId: json['authorId'] as String? ?? '',
        authorName: json['authorName'] as String?,
        body: json['body'] as String? ?? '',
        media: [
          for (final kind in json['media'] as List<dynamic>? ?? const [])
            PostMedia.kindFromWire(kind),
        ],
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
      );
}

/// Which of the reader's communities to list.
enum CommunityFilter {
  all,

  /// Only those with posts the reader has not seen.
  unread,

  /// Only those they own or moderate.
  running,
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
