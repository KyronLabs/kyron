// lib/providers/feedback_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/feedback_repository.dart';
import 'api_client_provider.dart';

final feedbackRepositoryProvider = Provider<FeedbackRepository>(
  (ref) => FeedbackRepository(ref.read(apiClientProvider)),
);
