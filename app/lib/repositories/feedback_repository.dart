// lib/repositories/feedback_repository.dart
import '../services/api_client.dart';

/// What somebody is telling us. Two kinds, because they become two labels.
enum FeedbackKind {
  bug('BUG', 'Something is broken'),
  idea('IDEA', 'An idea');

  const FeedbackKind(this.wire, this.label);
  final String wire;
  final String label;
}

/// Where a report ended up.
class FiledReport {
  const FiledReport({required this.number, required this.url});
  final int number;
  final String url;
}

/// Sending a bug or an idea to the people who can act on it.
///
/// It goes to the API, which files it as an issue on the repository. The
/// GitHub token lives there and not here: a token shipped inside an installed
/// application is a token anybody can read out of it, and it would carry write
/// access to the repository.
class FeedbackRepository {
  FeedbackRepository(this._api);
  final ApiClient _api;

  /// Whether reports can be filed at all.
  ///
  /// Asked before the form is offered, so somebody is told *before* writing
  /// three paragraphs rather than after.
  Future<bool> isAvailable() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/feedback');
    return res.data?['available'] == true;
  }

  Future<FiledReport> send({
    required FeedbackKind kind,
    required String title,
    required String body,
    String? appVersion,
    String? platform,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/feedback',
      data: {
        'kind': kind.wire,
        'title': title,
        'body': body,
        if (appVersion != null) 'appVersion': appVersion,
        if (platform != null) 'platform': platform,
      },
    );
    return FiledReport(
      number: (res.data?['number'] as num?)?.toInt() ?? 0,
      url: res.data?['url'] as String? ?? '',
    );
  }
}
