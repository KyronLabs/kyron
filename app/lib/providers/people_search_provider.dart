// lib/providers/people_search_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/profile_summary.dart';
import 'api_client_provider.dart';

/// People found by name, for starting a conversation or sending something
/// to them. The same search the Explore tab runs for people, without the
/// reader themselves in it.
final peopleSearchProvider =
    FutureProvider.autoDispose.family<List<ProfileSummary>, String>((
  ref,
  query,
) async {
  // Typing settles before anything is asked for.
  var live = true;
  ref.onDispose(() => live = false);
  await Future<void>.delayed(const Duration(milliseconds: 300));
  if (!live) return const [];

  final res = await ref.read(apiClientProvider).dio.get<Map<String, dynamic>>(
    '/profile/search',
    queryParameters: {'q': query, 'limit': 20},
  );
  return ((res.data?['items'] as List<dynamic>?) ?? const [])
      .whereType<Map<String, dynamic>>()
      .map(ProfileSummary.fromJson)
      .where((p) => !p.isSelf)
      .toList();
});
