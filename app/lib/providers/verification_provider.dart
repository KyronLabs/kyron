// lib/providers/verification_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/verification.dart';
import '../repositories/verification_repository.dart';
import 'api_client_provider.dart';

final verificationRepositoryProvider = Provider<VerificationRepository>(
  (ref) => VerificationRepository(ref.read(apiClientProvider)),
);

/// This account and the badge: verified, waiting, or what it still needs.
final verificationStatusProvider =
    FutureProvider.autoDispose<VerificationState>(
  (ref) => ref.read(verificationRepositoryProvider).status(),
);

/// Requests waiting for the team.
final verificationQueueProvider =
    FutureProvider.autoDispose<List<VerificationCase>>(
  (ref) => ref.read(verificationRepositoryProvider).queue(),
);
