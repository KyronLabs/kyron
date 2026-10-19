// lib/providers/enforcement_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/account_standing.dart';
import '../models/moderation_case.dart';
import '../repositories/enforcement_repository.dart';
import 'api_client_provider.dart';

final enforcementRepositoryProvider = Provider<EnforcementRepository>(
  (ref) => EnforcementRepository(ref.read(apiClientProvider)),
);

/// This account's standing: decisions about it, and its reports' outcomes.
final standingProvider = FutureProvider.autoDispose<AccountStanding>(
  (ref) => ref.read(enforcementRepositoryProvider).standing(),
);

/// The latest refusal the API sent because this account is restricted, or
/// null. Set by ApiClient as the refusal arrives, wherever it arrives from;
/// RestrictionGate is what acts on it.
final restrictionProvider = StateProvider<AccountRestriction?>((ref) => null);

/// The team's queues.
final reportQueueProvider = FutureProvider.autoDispose<List<ReportCase>>(
  (ref) => ref.read(enforcementRepositoryProvider).reportQueue(),
);

final appealQueueProvider = FutureProvider.autoDispose<List<AppealCase>>(
  (ref) => ref.read(enforcementRepositoryProvider).appealQueue(),
);

final accountRecordProvider =
    FutureProvider.autoDispose.family<AccountRecord, String>(
  (ref, id) => ref.read(enforcementRepositoryProvider).account(id),
);
