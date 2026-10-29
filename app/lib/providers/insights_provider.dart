// lib/providers/insights_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/insights_report.dart';
import '../repositories/insights_repository.dart';
import 'api_client_provider.dart';

final insightsRepositoryProvider = Provider<InsightsRepository>(
  (ref) => InsightsRepository(ref.read(apiClientProvider)),
);

/// The report for a period of 7, 30 or 90 days. Dropped when the screen
/// closes: insights move, and a report from an hour ago is not worth keeping.
final insightsProvider = FutureProvider.autoDispose.family<InsightsReport, int>(
  (ref, days) => ref.read(insightsRepositoryProvider).report(days: days),
);
