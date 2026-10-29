import '../models/insights_report.dart';
import '../services/api_client.dart';

/// The signed-in account's insights. There is no way to ask for anybody
/// else's: the server only ever answers about the account asking.
class InsightsRepository {
  InsightsRepository(this._api);
  final ApiClient _api;

  Future<InsightsReport> report({required int days}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/insights',
      queryParameters: {
        'days': days,
        // So a day on the chart is the reader's day.
        'tzOffset': DateTime.now().timeZoneOffset.inMinutes,
      },
    );
    return InsightsReport.fromJson(res.data ?? const {});
  }
}
