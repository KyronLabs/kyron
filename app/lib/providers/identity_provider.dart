// lib/providers/identity_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/identity_repository.dart';
import '../services/identity_vault.dart';
import 'api_client_provider.dart';

final identityRepositoryProvider = Provider<IdentityRepository>(
  (ref) => IdentityRepository(ref.read(apiClientProvider)),
);

/// This account's portable identifier, for the life of the app.
final identityVaultProvider = Provider<IdentityVault>(
  (ref) => IdentityVault(ref.read(identityRepositoryProvider)),
);

/// The identifier, once it has been established.
///
/// Null while it is being worked out and null if it could not be -- which the
/// screen reports as "no identifier yet" rather than inventing one, the way
/// the hardcoded `did:plc:abc…` this replaces did.
final myDidProvider = FutureProvider<String?>(
  (ref) => ref.read(identityVaultProvider).ensure(),
);
