// lib/repositories/feedback_repository.dart
import '../services/api_client.dart';

/// What somebody is telling us.
enum FeedbackKind {
  bug('BUG', 'A problem'),
  idea('IDEA', 'An idea'),

  /// Somebody asking for help. Contact support opens the form on this.
  question('QUESTION', 'A question'),

  /// An error report from About, with the app's log when its sender chose.
  report('REPORT', 'Error report');

  /// The three the feedback form offers. An error report is its own screen.
  static const offered = [bug, idea, question];

  const FeedbackKind(this.wire, this.label);
  final String wire;
  final String label;
}

/// What the sender is told once it has arrived: the number to quote if they
/// write again.
class FiledReport {
  const FiledReport({required this.number});
  final int number;
}

/// Sending a bug, an idea, a question or an error report to the people who can act on it.
///
/// It goes to the API, which keeps it privately for the Kyron team, tied to
/// the account so somebody can follow up. It used to be filed as a public
/// GitHub issue, which needed a token the server never had -- so the screen
/// told everybody feedback could not be sent.
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
    String? log,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/feedback',
      data: {
        'kind': kind.wire,
        'title': title,
        'body': body,
        if (appVersion != null) 'appVersion': appVersion,
        if (platform != null) 'platform': platform,
        if (log != null) 'log': log,
      },
    );
    return FiledReport(number: (res.data?['number'] as num?)?.toInt() ?? 0);
  }
}
