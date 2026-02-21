class SuggestedUser {
  final String id;
  final String? avatar;
  final String handle;
  final String? bio;
  bool isFollowing;

  SuggestedUser({
    required this.id,
    required this.handle,
    this.avatar,
    this.bio,
    this.isFollowing = false,
  });

  factory SuggestedUser.fromJson(Map<String, dynamic> json) {
    return SuggestedUser(
      id: json['id'],
      avatar: json['avatar'],
      handle: json['handle'],
      bio: json['bio'],
      isFollowing: json['isFollowing'] ?? false,
    );
  }
}
