// lib/providers/push_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/devices_repository.dart';
import '../services/firebase_push.dart';
import '../services/push_registrar.dart';
import 'api_client_provider.dart';
import 'preferences_provider.dart';

/// How this install gets a push token.
///
/// [FirebasePushTokens.start] answers null rather than throwing on every way
/// this can come to nothing -- no Firebase on this platform, no
/// `google-services.json`, or a reader who declined notifications -- so the
/// app behaves exactly as it did before push existed in each of those cases:
/// it says so once in its log and sends nothing.
///
/// Overridden in tests. Not called until somebody signs in.
final pushTokenSourceProvider = Provider<PushTokenSourceFactory?>(
  (ref) => FirebasePushTokens.start,
);

final devicesRepositoryProvider = Provider<DevicesRepository>(
  (ref) => DevicesRepository(ref.read(apiClientProvider)),
);

final pushRegistrarProvider = Provider<PushRegistrar>((ref) {
  final registrar = PushRegistrar(
    ref.read(devicesRepositoryProvider),
    connect: ref.read(pushTokenSourceProvider),
    locale: () => ref.read(preferencesProvider).language.code,
  );
  // A reader who changes the app's language should get their next push in
  // it, not in the one the phone registered with.
  ref.listen(
    preferencesProvider.select((p) => p.language.code),
    (previous, next) {
      if (previous != next) registrar.languageChanged();
    },
  );
  return registrar;
});
