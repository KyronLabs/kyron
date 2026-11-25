import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/api_client_provider.dart';

final playCoinsRepositoryProvider = Provider<PlayCoinsRepository>(
  (ref) => PlayCoinsRepository(ref.watch(apiClientProvider).dio),
);

class PlayCoinCatalogue {
  const PlayCoinCatalogue(this.accountId, this.coinsByProduct);

  final String accountId;
  final Map<String, int> coinsByProduct;
}

class PlayCoinsRepository {
  PlayCoinsRepository(this._dio);

  final Dio _dio;

  Future<PlayCoinCatalogue?> catalogue(CancelToken cancelToken) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/purchases/google-play/catalogue',
      cancelToken: cancelToken,
    );
    final data = response.data;
    if (data?['enabled'] != true) return null;
    if (data?['packageName'] != 'so.kyron.app') {
      throw const FormatException('Unexpected Google Play package');
    }
    final account = data?['accountObfuscationId'];
    if (account is! String || !RegExp(r'^[a-f0-9]{64}$').hasMatch(account)) {
      throw const FormatException('Invalid Play account binding');
    }
    final products = data?['products'];
    if (products is! List) {
      throw const FormatException('Invalid coin catalogue');
    }
    final coinsByProduct = <String, int>{};
    for (final product in products.whereType<Map<String, dynamic>>()) {
      final id = product['productId'];
      final coins = product['coins'];
      if (id is String && coins is int && coins > 0) {
        coinsByProduct[id] = coins;
      }
    }
    return PlayCoinCatalogue(account, Map.unmodifiable(coinsByProduct));
  }

  /// The server durably credits coins and owns Google Play consumption.
  Future<bool> verify({
    required String productId,
    required String purchaseToken,
    required CancelToken cancelToken,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/purchases/google-play/verify',
      data: {'productId': productId, 'purchaseToken': purchaseToken},
      cancelToken: cancelToken,
    );
    final data = response.data;
    if (data?['productId'] != productId ||
        data?['purchaseId'] is! String ||
        (data?['status'] != 'CONSUMED' && data?['status'] != 'VERIFIED')) {
      throw const FormatException('Invalid Play verification response');
    }
    return data?['consumed'] == true;
  }
}
