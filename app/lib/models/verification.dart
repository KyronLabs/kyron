// lib/models/verification.dart

DateTime? _date(Object? value) =>
    value is String ? DateTime.tryParse(value)?.toLocal() : null;

String? _text(Object? value) =>
    value is String && value.trim().isNotEmpty ? value : null;

/// What an account says it is, when it asks for the badge.
enum VerificationCategory {
  creator('CREATOR', 'Creator'),
  publicFigure('PUBLIC_FIGURE', 'Public figure'),
  journalist('JOURNALIST', 'Journalist'),
  organisation('ORGANISATION', 'Organisation or brand'),
  other('OTHER', 'Something else');

  const VerificationCategory(this.wire, this.label);
  final String wire;
  final String label;

  static VerificationCategory fromWire(Object? wire) => values.firstWhere(
        (c) => c.wire == wire,
        orElse: () => VerificationCategory.other,
      );
}

enum VerificationRequestStatus {
  pending,
  approved,
  denied,
  withdrawn;

  static VerificationRequestStatus fromWire(Object? wire) => switch (wire) {
        'APPROVED' => VerificationRequestStatus.approved,
        'DENIED' => VerificationRequestStatus.denied,
        'WITHDRAWN' => VerificationRequestStatus.withdrawn,
        _ => VerificationRequestStatus.pending,
      };
}

/// One thing an account needs before it can ask.
class VerificationRequirement {
  final String key;
  final String label;
  final bool met;

  const VerificationRequirement({
    required this.key,
    required this.label,
    required this.met,
  });

  factory VerificationRequirement.fromJson(Map<String, dynamic> json) =>
      VerificationRequirement(
        key: json['key'] as String? ?? '',
        label: json['label'] as String? ?? '',
        met: json['met'] == true,
      );
}

/// A request for the badge, as the account that made it sees it.
class VerificationRequestView {
  final String id;
  final int number;
  final VerificationCategory category;
  final String about;
  final List<String> links;
  final VerificationRequestStatus status;
  final String? response;
  final DateTime createdAt;
  final DateTime? decidedAt;

  const VerificationRequestView({
    required this.id,
    required this.number,
    required this.category,
    required this.about,
    required this.links,
    required this.status,
    required this.createdAt,
    this.response,
    this.decidedAt,
  });

  factory VerificationRequestView.fromJson(Map<String, dynamic> json) =>
      VerificationRequestView(
        id: json['id'] as String,
        number: (json['number'] as num?)?.toInt() ?? 0,
        category: VerificationCategory.fromWire(json['category']),
        about: json['about'] as String? ?? '',
        links: [
          for (final link in (json['links'] as List<dynamic>? ?? const []))
            if (link is String) link,
        ],
        status: VerificationRequestStatus.fromWire(json['status']),
        response: _text(json['response']),
        createdAt: _date(json['createdAt']) ?? DateTime.now(),
        decidedAt: _date(json['decidedAt']),
      );
}

/// Where this account stands with the badge.
class VerificationState {
  final bool verified;
  final DateTime? verifiedAt;
  final List<VerificationRequirement> requirements;
  final VerificationRequestView? request;
  final bool canApply;

  /// After a "no": when it can ask again.
  final DateTime? nextApplyAt;

  const VerificationState({
    required this.verified,
    required this.requirements,
    required this.canApply,
    this.verifiedAt,
    this.request,
    this.nextApplyAt,
  });

  bool get pending => request?.status == VerificationRequestStatus.pending;

  bool get eligible => requirements.every((r) => r.met);

  factory VerificationState.fromJson(Map<String, dynamic> json) {
    final request = json['request'];
    return VerificationState(
      verified: json['verified'] == true,
      verifiedAt: _date(json['verifiedAt']),
      requirements: [
        for (final row in (json['requirements'] as List<dynamic>? ?? const []))
          if (row is Map<String, dynamic>)
            VerificationRequirement.fromJson(row),
      ],
      request: request is Map<String, dynamic>
          ? VerificationRequestView.fromJson(request)
          : null,
      canApply: json['canApply'] == true,
      nextApplyAt: _date(json['nextApplyAt']),
    );
  }
}

/// A request waiting for the team, with the account behind it.
class VerificationCase {
  final VerificationRequestView request;
  final String accountId;
  final String? name;
  final String? username;
  final String? avatarUrl;
  final String? bio;
  final DateTime? joined;
  final int followers;
  final int posts;
  final List<VerificationRequirement> requirements;

  /// The reader asked for this one themselves: somebody else answers it.
  final bool ownRequest;

  const VerificationCase({
    required this.request,
    required this.accountId,
    required this.requirements,
    this.name,
    this.username,
    this.avatarUrl,
    this.bio,
    this.joined,
    this.followers = 0,
    this.posts = 0,
    this.ownRequest = false,
  });

  String get handle => username == null ? (name ?? 'an account') : '@$username';

  factory VerificationCase.fromJson(Map<String, dynamic> json) {
    final account = json['account'] as Map<String, dynamic>? ?? const {};
    return VerificationCase(
      request: VerificationRequestView.fromJson(
        json['request'] as Map<String, dynamic>,
      ),
      accountId: account['id'] as String? ?? '',
      name: _text(account['name']),
      username: _text(account['username']),
      avatarUrl: _text(account['avatarUrl']),
      bio: _text(account['bio']),
      joined: _date(account['createdAt']),
      followers: (account['followers'] as num?)?.toInt() ?? 0,
      posts: (account['posts'] as num?)?.toInt() ?? 0,
      requirements: [
        for (final row in (json['requirements'] as List<dynamic>? ?? const []))
          if (row is Map<String, dynamic>)
            VerificationRequirement.fromJson(row),
      ],
      ownRequest: json['ownRequest'] == true,
    );
  }
}
