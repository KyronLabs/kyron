// lib/models/insights_report.dart

/// A number for this period and the one before it.
class Compared {
  const Compared(this.current, this.previous);

  final int current;
  final int previous;

  /// The change as a fraction (0.25 is a quarter up), or null when there was
  /// nothing before to compare with: "+∞%" says nothing, and "new" does.
  double? get change => previous == 0 ? null : (current - previous) / previous;

  static Compared from(Object? json) {
    final map = json is Map<String, dynamic> ? json : const {};
    return Compared(_int(map['current']), _int(map['previous']));
  }
}

/// One named group in the audience: a topic, or a community.
class AudienceGroup {
  const AudienceGroup(this.slug, this.name, this.count);

  final String slug;
  final String name;
  final int count;
}

class InsightsTopPost {
  const InsightsTopPost({
    required this.id,
    required this.excerpt,
    required this.createdAt,
    required this.reach,
    required this.likes,
    required this.comments,
    required this.reposts,
  });

  final String id;
  final String excerpt;
  final DateTime createdAt;
  final int reach;
  final int likes;
  final int comments;
  final int reposts;
}

/// A tip or a summary line: what to say, and the numbers to say it with.
/// The server decides which apply; the app words them in the reader's
/// language.
class InsightsLine {
  const InsightsLine(this.code, this.params);

  final String code;
  final Map<String, Object> params;

  String text(String key) => '${params[key] ?? ''}';
  int number(String key) => _int(params[key]);
}

/// How the signed-in account is doing. See docs/INSIGHTS.md for what each
/// number counts, and what Kyron does not collect.
class InsightsReport {
  const InsightsReport({
    required this.days,
    required this.reach,
    required this.followersReached,
    required this.opens,
    required this.likes,
    required this.comments,
    required this.reposts,
    required this.saves,
    required this.newFollowers,
    required this.followers,
    required this.timeline,
    required this.audienceEnough,
    required this.ages,
    required this.agesKnown,
    required this.interests,
    required this.communities,
    required this.activeHours,
    required this.topPosts,
    required this.summary,
    required this.tips,
  });

  final int days;
  final Compared reach;
  final int followersReached;
  final Compared opens;
  final Compared likes;
  final Compared comments;
  final Compared reposts;
  final Compared saves;
  final Compared newFollowers;
  final int followers;

  /// People reached each day, oldest first. Dates are the reader's own.
  final List<({DateTime date, int reach})> timeline;

  /// False until enough people were reached for the audience to be shown.
  final bool audienceEnough;
  final List<({String band, int count})> ages;
  final int agesKnown;
  final List<AudienceGroup> interests;
  final List<AudienceGroup> communities;

  /// 168 counts, by hour of the week in UTC, Monday 00:00 first.
  final List<int> activeHours;

  final List<InsightsTopPost> topPosts;
  final List<InsightsLine> summary;
  final List<InsightsLine> tips;

  int get strangersReached => reach.current - followersReached;

  factory InsightsReport.fromJson(Map<String, dynamic> json) {
    final audience = json['audience'] is Map<String, dynamic>
        ? json['audience'] as Map<String, dynamic>
        : const <String, dynamic>{};
    List<Map<String, dynamic>> list(Object? value) => [
          for (final item in (value as List<dynamic>?) ?? const [])
            if (item is Map<String, dynamic>) item,
        ];
    List<AudienceGroup> groups(Object? value) => [
          for (final g in list(value))
            AudienceGroup(
              '${g['slug'] ?? ''}',
              '${g['name'] ?? ''}',
              _int(g['count']),
            ),
        ];
    List<InsightsLine> lines(Object? value) => [
          for (final l in list(value))
            if (l['code'] is String)
              InsightsLine(
                l['code'] as String,
                {
                  for (final e in ((l['params'] as Map<String, dynamic>?) ??
                          const <String, dynamic>{})
                      .entries)
                    if (e.value != null) e.key: e.value as Object,
                },
              ),
        ];
    final hours = [
      for (final h in (audience['activeHours'] as List<dynamic>?) ?? const [])
        _int(h),
    ];

    return InsightsReport(
      days: _int(json['days']),
      reach: Compared.from(json['reach']),
      followersReached: _int(json['followersReached']),
      opens: Compared.from(json['opens']),
      likes: Compared.from(json['likes']),
      comments: Compared.from(json['comments']),
      reposts: Compared.from(json['reposts']),
      saves: Compared.from(json['saves']),
      newFollowers: Compared.from(json['newFollowers']),
      followers: _int(json['followers']),
      timeline: [
        for (final d in list(json['timeline']))
          if (DateTime.tryParse('${d['date']}') case final date?)
            (date: date, reach: _int(d['reach'])),
      ],
      audienceEnough: audience['enough'] == true,
      ages: [
        for (final a in list(audience['ages']))
          (band: '${a['band'] ?? ''}', count: _int(a['count'])),
      ],
      agesKnown: _int(audience['agesKnown']),
      interests: groups(audience['interests']),
      communities: groups(audience['communities']),
      activeHours: hours.length == 168 ? hours : List.filled(168, 0),
      topPosts: [
        for (final p in list(json['topPosts']))
          InsightsTopPost(
            id: '${p['id'] ?? ''}',
            excerpt: '${p['excerpt'] ?? ''}',
            createdAt: DateTime.tryParse('${p['createdAt']}') ?? DateTime(0),
            reach: _int(p['reach']),
            likes: _int(p['likes']),
            comments: _int(p['comments']),
            reposts: _int(p['reposts']),
          ),
      ],
      summary: lines(json['summary']),
      tips: lines(json['tips']),
    );
  }
}

int _int(Object? value) => switch (value) {
      int v => v,
      num v => v.round(),
      String v => int.tryParse(v) ?? 0,
      _ => 0,
    };

/// The busiest three-hour stretches of the week, in the reader's own time
/// zone, from the server's 168 hourly counts in UTC.
///
/// Turned into local time here rather than on the server: the phone knows
/// its zone, including summer time, and the server would only be told an
/// offset.
List<({int weekday, int fromHour, int count})> busiestSlots(
  List<int> utcHours, {
  int limit = 3,
}) {
  final monday = _thisMondayUtc();
  final slots = <(int, int), int>{};
  for (var h = 0; h < utcHours.length && h < 168; h++) {
    if (utcHours[h] <= 0) continue;
    final local = monday.add(Duration(hours: h)).toLocal();
    final key = (local.weekday, local.hour ~/ 3 * 3);
    slots[key] = (slots[key] ?? 0) + utcHours[h];
  }
  final ranked = slots.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return [
    for (final e in ranked.take(limit))
      (weekday: e.key.$1, fromHour: e.key.$2, count: e.value),
  ];
}

/// One UTC hour of the week as a local weekday and hour.
({int weekday, int hour}) localHourOfWeek(int utcHourOfWeek) {
  final local = _thisMondayUtc().add(Duration(hours: utcHourOfWeek)).toLocal();
  return (weekday: local.weekday, hour: local.hour);
}

/// Monday 00:00 UTC of the current week: hour 0 of the server's week.
///
/// This week's, not any Monday's: turned into local time, a Monday in
/// January carries winter's offset, and in summer every slot would read an
/// hour out wherever the clocks change.
DateTime _thisMondayUtc() {
  final now = DateTime.now().toUtc();
  final today = DateTime.utc(now.year, now.month, now.day);
  return today.subtract(Duration(days: today.weekday - 1));
}
