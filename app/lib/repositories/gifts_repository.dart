// lib/repositories/gifts_repository.dart
import 'dart:math';

import '../models/gift.dart';
import '../services/api_client.dart';

/// Sending gifts to posts, and the wallet they are sent from.
class GiftsRepository {
  GiftsRepository(this._api);
  final ApiClient _api;

  /// The catalogue and the reader's wallet, refilled if a week has turned.
  Future<GiftSheetData> sheet() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/gifts');
    return GiftSheetData.fromJson(res.data ?? const {});
  }

  /// Sends one. [requestId] is made once per press and reused for any
  /// retry, so a request that reached the server but whose answer was lost
  /// is the same gift when it is sent again -- never a second charge.
  Future<SentGift> send(
    String postId,
    String type, {
    required String requestId,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/feed/posts/$postId/gifts',
      data: {'type': type, 'requestId': requestId},
    );
    return SentGift.fromJson(res.data ?? const {});
  }

  /// A random version 4 UUID, which is what the server accepts as a request
  /// id. From the platform's secure source: a predictable one would let
  /// somebody guess another account's next request.
  static String newRequestId([Random? random]) {
    final source = random ?? Random.secure();
    final bytes = List<int>.generate(16, (_) => source.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // the RFC 4122 variant
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
