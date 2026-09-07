// lib/providers/keys_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/keys_repository.dart';
import '../services/message_vault.dart';
import 'api_client_provider.dart';

final keysRepositoryProvider = Provider<KeysRepository>(
  (ref) => KeysRepository(ref.read(apiClientProvider)),
);

/// This install's message keys, for the life of the app.
final messageVaultProvider = Provider<MessageVault>(
  (ref) => MessageVault(ref.read(keysRepositoryProvider)),
);
