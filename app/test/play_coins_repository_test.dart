import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/repositories/play_coins_repository.dart';

void main() {
  Dio respond(
    Map<String, Object?> data,
    void Function(RequestOptions request) check,
  ) {
    final dio = Dio(BaseOptions(baseUrl: 'https://kyron.example'));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      check(request);
      handler.resolve(Response(requestOptions: request, data: data));
    }));
    return dio;
  }

  test('disabled catalogue hides Play purchasing', () async {
    final repository = PlayCoinsRepository(respond(
      {'enabled': false, 'products': []},
      (request) => expect(request.path, '/purchases/google-play/catalogue'),
    ));
    expect(await repository.catalogue(CancelToken()), isNull);
  });

  test('only Kyron’s account-bound server products become purchasable',
      () async {
    final account = List.filled(64, 'a').join();
    final repository = PlayCoinsRepository(respond({
      'enabled': true,
      'packageName': 'so.kyron.app',
      'accountObfuscationId': account,
      'products': [
        {'productId': 'coins.small', 'coins': 100},
        {'productId': 'coins.broken', 'coins': -1},
      ],
    }, (_) {}));
    final catalogue = await repository.catalogue(CancelToken());
    expect(catalogue?.accountId, account);
    expect(catalogue?.coinsByProduct, {'coins.small': 100});
  });

  test('server may commit coins while Play consumption needs a retry',
      () async {
    final repository = PlayCoinsRepository(respond({
      'purchaseId': 'purchase-id',
      'productId': 'coins.small',
      'status': 'VERIFIED',
      'consumed': false,
    }, (request) {
      expect(request.method, 'POST');
      expect(request.path, '/purchases/google-play/verify');
      expect(request.data, {
        'productId': 'coins.small',
        'purchaseToken': 'synthetic-token',
      });
    }));
    expect(
      await repository.verify(
        productId: 'coins.small',
        purchaseToken: 'synthetic-token',
        cancelToken: CancelToken(),
      ),
      isFalse,
    );
  });
}
