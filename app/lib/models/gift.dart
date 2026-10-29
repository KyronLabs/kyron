// lib/models/gift.dart

/// One gift a reader can send, as GET /gifts lists it.
///
/// The catalogue is the server's: names and prices come from there, so a
/// price change never needs an app release, and the app never shows a price
/// the server would not charge.
class GiftType {
  final String type;
  final String name;
  final String emoji;
  final int coins;

  const GiftType({
    required this.type,
    required this.name,
    required this.emoji,
    required this.coins,
  });

  factory GiftType.fromJson(Map<String, dynamic> json) => GiftType(
        type: json['type'] as String? ?? '',
        name: json['name'] as String? ?? 'Gift',
        emoji: json['emoji'] as String? ?? '🎁',
        coins: (json['coins'] as num?)?.toInt() ?? 0,
      );

  static List<GiftType> listFrom(Object? json) => json is List
      ? json
          .whereType<Map<String, dynamic>>()
          .map(GiftType.fromJson)
          .where((gift) => gift.type.isNotEmpty)
          .toList()
      : const [];
}

/// What the reader has to send gifts with, and what their posts were given.
///
/// Test coins: they come from a weekly refill and cannot be bought, and
/// earnings cannot be withdrawn. The sheet says so, every time it opens.
class GiftWallet {
  /// What can be spent.
  final int coins;

  /// What this account's posts have been given. Never spendable.
  final int earned;

  /// What the refill tops coins up to.
  final int weeklyCoins;
  final DateTime? refillsAt;

  const GiftWallet({
    required this.coins,
    required this.earned,
    required this.weeklyCoins,
    this.refillsAt,
  });

  factory GiftWallet.fromJson(Map<String, dynamic> json) => GiftWallet(
        coins: (json['coins'] as num?)?.toInt() ?? 0,
        earned: (json['earned'] as num?)?.toInt() ?? 0,
        weeklyCoins: (json['weeklyCoins'] as num?)?.toInt() ?? 0,
        refillsAt:
            DateTime.tryParse(json['refillsAt'] as String? ?? '')?.toLocal(),
      );
}

/// Everything the gift sheet needs, in the one call that opens it.
class GiftSheetData {
  final List<GiftType> catalogue;
  final GiftWallet wallet;

  const GiftSheetData({required this.catalogue, required this.wallet});

  factory GiftSheetData.fromJson(Map<String, dynamic> json) => GiftSheetData(
        catalogue: GiftType.listFrom(json['catalogue']),
        wallet: GiftWallet.fromJson(
          (json['wallet'] as Map<String, dynamic>?) ?? const {},
        ),
      );
}

/// What sending one answers with.
class SentGift {
  final String giftId;
  final GiftWallet wallet;

  /// The post's gift count after this one.
  final int gifts;

  const SentGift({
    required this.giftId,
    required this.wallet,
    required this.gifts,
  });

  factory SentGift.fromJson(Map<String, dynamic> json) => SentGift(
        giftId: (json['gift'] as Map<String, dynamic>?)?['id'] as String? ?? '',
        wallet: GiftWallet.fromJson(
          (json['wallet'] as Map<String, dynamic>?) ?? const {},
        ),
        gifts: (json['gifts'] as num?)?.toInt() ?? 0,
      );
}

/// Which gift a notification row is about.
class GiftNote {
  final String type;
  final String name;
  final String emoji;
  final int coins;

  const GiftNote({
    required this.type,
    required this.name,
    required this.emoji,
    required this.coins,
  });

  factory GiftNote.fromJson(Map<String, dynamic> json) => GiftNote(
        type: json['type'] as String? ?? '',
        name: json['name'] as String? ?? 'Gift',
        emoji: json['emoji'] as String? ?? '🎁',
        coins: (json['coins'] as num?)?.toInt() ?? 0,
      );
}
