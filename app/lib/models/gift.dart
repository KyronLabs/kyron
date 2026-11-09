// lib/models/gift.dart
import 'feed_post.dart';

/// The gift types from least to most valuable, as the catalogue prices them.
///
/// Only for ordering the stack on a post's heart when this reader adds to it,
/// before the server has said; the server's order wins on the next read.
const giftRank = [
  'spark',
  'rose',
  'fire',
  'star',
  'gem',
  'cake',
  'crown',
  'rocket',
];

/// [types] with [type] added, most valuable first, three at most.
List<String> withGift(List<String> types, String type) {
  int rank(String t) => giftRank.indexOf(t);
  final all = {...types, type}.toList()
    ..sort((a, b) => rank(b).compareTo(rank(a)));
  return all.take(3).toList();
}

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

  /// Which gift it was, by catalogue type.
  final String type;
  final GiftWallet wallet;

  /// The post's gift count after this one.
  final int gifts;

  const SentGift({
    required this.giftId,
    this.type = '',
    required this.wallet,
    required this.gifts,
  });

  factory SentGift.fromJson(Map<String, dynamic> json) => SentGift(
        giftId: (json['gift'] as Map<String, dynamic>?)?['id'] as String? ?? '',
        type: (json['gift'] as Map<String, dynamic>?)?['type'] as String? ?? '',
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

  /// Sent to the reader's reply rather than their post: the row then says
  /// "to your comment", and quotes it.
  final bool onComment;

  const GiftNote({
    required this.type,
    required this.name,
    required this.emoji,
    required this.coins,
    this.onComment = false,
  });

  factory GiftNote.fromJson(Map<String, dynamic> json) => GiftNote(
        type: json['type'] as String? ?? '',
        name: json['name'] as String? ?? 'Gift',
        emoji: json['emoji'] as String? ?? '🎁',
        coins: (json['coins'] as num?)?.toInt() ?? 0,
        onComment: json['onComment'] == true,
      );
}

/// Who gave a post gifts, and what -- the list the gift pill opens.
class PostGifts {
  /// Every gift the post was given, from anyone.
  final int total;

  /// The people, the biggest giver first.
  final List<GiftGiver> givers;

  const PostGifts({required this.total, required this.givers});

  factory PostGifts.fromJson(Map<String, dynamic> json) => PostGifts(
        total: (json['total'] as num?)?.toInt() ?? 0,
        givers: [
          for (final row in json['senders'] as List? ?? const [])
            if (row is Map<String, dynamic>) GiftGiver.fromJson(row),
        ],
      );
}

/// One person who gave a post gifts, and every gift they gave it.
class GiftGiver {
  final FeedAuthor user;

  /// What they spent on it in all.
  final int coins;

  /// Each kind and how many, most valuable first.
  final List<({String type, String name, int count})> gifts;

  const GiftGiver({
    required this.user,
    required this.coins,
    required this.gifts,
  });

  /// How many gifts in all, of every kind.
  int get count => gifts.fold(0, (sum, g) => sum + g.count);

  factory GiftGiver.fromJson(Map<String, dynamic> json) => GiftGiver(
        user: FeedAuthor.fromJson(
          json['user'] as Map<String, dynamic>? ?? const {},
        ),
        coins: (json['coins'] as num?)?.toInt() ?? 0,
        gifts: [
          for (final g in json['gifts'] as List? ?? const [])
            if (g is Map<String, dynamic> && g['type'] is String)
              (
                type: g['type'] as String,
                name: g['name'] as String? ?? 'Gift',
                count: (g['count'] as num?)?.toInt() ?? 1,
              ),
        ],
      );
}
