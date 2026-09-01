import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/moderation_repository.dart';
import 'api_client_provider.dart';

final moderationRepositoryProvider = Provider<ModerationRepository>(
  (ref) => ModerationRepository(ref.read(apiClientProvider)),
);
