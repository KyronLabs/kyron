// lib/providers/push_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/devices_repository.dart';
import '../services/push_registrar.dart';
import 'api_client_provider.dart';

/// Where a push token comes from, or null when nothing supplies one.
///
/// Overridden at the root once a source exists -- see `docs/PUSH.md`. Left
/// unimplemented here rather than faked, so the app never behaves as though
/// this install were reachable when it is not.
final pushTokenSourceProvider = Provider<PushTokenSource?>((ref) => null);

final devicesRepositoryProvider = Provider<DevicesRepository>(
  (ref) => DevicesRepository(ref.read(apiClientProvider)),
);

final pushRegistrarProvider = Provider<PushRegistrar>(
  (ref) => PushRegistrar(
    ref.read(devicesRepositoryProvider),
    source: ref.read(pushTokenSourceProvider),
  ),
);
