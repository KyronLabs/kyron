// lib/providers/gifts_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/gifts_repository.dart';
import 'api_client_provider.dart';

final giftsRepositoryProvider = Provider<GiftsRepository>(
  (ref) => GiftsRepository(ref.read(apiClientProvider)),
);
